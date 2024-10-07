//
//  Menu.swift
//  LittleLemon
//
//  Created by Albert Tang on 10/7/24.
//

import SwiftUI

struct Menu: View {
    var body: some View {
        VStack {
            Text("Little Lemon")
            Text("Chicago")
            Text("We are a family owned Mediterranean restaurant, focused on traditional recipes served with a modern twist.")
                .multilineTextAlignment(.center)
        }
    }
}

#Preview {
    Menu()
}
