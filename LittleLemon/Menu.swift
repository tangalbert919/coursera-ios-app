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
            Section {
                Text("Little Lemon")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .fontDesign(.serif)
                    .frame(maxWidth: .infinity, alignment: .leading)
                HStack {
                    VStack {
                        Text("Chicago")
                            .font(.title)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Text("We are a family owned Mediterranean restaurant, focused on traditional recipes served with a modern twist.")
                            .multilineTextAlignment(.leading)
                            .fontWeight(.medium)
                    }
                    // image goes here
                    Image("profile-image-placeholder")
                        .frame(width: 100, height: 100)
                }
                TextField("Search menu", text: $searchText)
                    .border(Color.black, width: 1)
                    .background(Color.white)
            }
            .padding(10)
            .background(in: Rectangle())
            .backgroundStyle(.green)
            Section {
                VStack {
                    Text("Order for Delivery!")
                        .fontWeight(.bold)
                        .font(.headline)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    HStack {
                        Button("Starters") {
                            // placeholder
                        }
                        Button("Mains") {
                            // placeholder
                        }
                        Button("Desserts") {
                            // placeholder
                        }
                        Button("Sides") {
                            //placeholder
                        }
                    }.padding(5)
                }
            }
            .padding(10)
            FetchedObjects(predicate: buildPredicate(), sortDescriptors: buildSortDescriptors()) { (dishes: [Dish]) in
                List {
                    ForEach(dishes) { dish in
                        HStack {
                            VStack {
                                Text(dish.title!)
                                    .multilineTextAlignment(.leading)
                                Text(dish.price!)
                                    .multilineTextAlignment(.leading)
                            }
                            Spacer()
                            AsyncImage(url: URL(string: dish.image!)) { image in
                                image.image?.resizable().aspectRatio(contentMode: .fit)
                            }.frame(width: 64, height: 64, alignment: .trailing)
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
