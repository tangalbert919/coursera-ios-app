//
//  Menu.swift
//  LittleLemon
//
//  Created by Albert Tang on 10/7/24.
//

import SwiftUI

struct Menu: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State var searchText: String = ""

    var body: some View {
        VStack {
            Text("Little Lemon")
            Text("Chicago")
            Text("We are a family owned Mediterranean restaurant, focused on traditional recipes served with a modern twist.")
                .multilineTextAlignment(.center)
            TextField("Search menu", text: $searchText)
            FetchedObjects(predicate: buildPredicate(), sortDescriptors: buildSortDescriptors()) { (dishes: [Dish]) in
                List {
                    ForEach(dishes) { dish in
                        HStack {
                            Text(dish.title!)
                            Spacer()
                            Text(dish.price!)
                            AsyncImage(url: URL(string: dish.image!))
                                .frame(width: 32, height: 32)
                                .aspectRatio(contentMode: .fit)
                        }
                    }
                }
            }
        }.onAppear{getMenuData()}
    }
    
    func buildPredicate() -> NSPredicate {
        if (searchText.isEmpty) {
            return NSPredicate(value: true)
        }
        else {
            return NSPredicate(format: "title CONTAINS[cd] %@", searchText)
        }
    }
    
    func buildSortDescriptors() -> [NSSortDescriptor] {
        return [NSSortDescriptor(key: "title", ascending: true, selector: #selector(NSString.localizedStandardCompare(_:)))]
    }
    
    func getMenuData() {
        PersistenceController.shared.clear()
        let url: String = "https://raw.githubusercontent.com/Meta-Mobile-Developer-PC/Working-With-Data-API/main/menu.json"
        let request = URLRequest(url: URL(string: url)!)
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data else { return }
            do {
                let menu = try JSONDecoder().decode(MenuList.self, from: data)
                print(menu)
                var menuItems = menu.menu
                for item in menuItems {
                    let newItem = Dish(context: viewContext)
                    newItem.title = item.title
                    newItem.price = item.price
                    newItem.image = item.image
                }
                try? viewContext.save()
            } catch {
                print(error)
            }
        }.resume()
    }
}

#Preview {
    Menu()
}
