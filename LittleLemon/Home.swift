//
//  Home.swift
//  LittleLemon
//
//  Created by Albert Tang on 10/7/24.
//

import SwiftUI

struct Home: View {
    var persistence = PersistenceController.shared
    var body: some View {
        TabView {
            Menu()
                .tabItem {
                    Label("Menu", systemImage: "list.dash")
                }
                .environment(\.managedObjectContext, persistence.container.viewContext)
            UserProfile()
                .tabItem {
                    Label("Profile", systemImage: "person.crop.circle")
                }
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    Home()
}
