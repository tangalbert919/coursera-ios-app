//
//  UserProfile.swift
//  LittleLemon
//
//  Created by Albert Tang on 10/7/24.
//

import SwiftUI

struct UserProfile: View {
    @State var firstName: String = UserDefaults.standard.string(forKey: "firstName") ?? ""
    @State var lastName: String = UserDefaults.standard.string(forKey: "lastName") ?? ""
    @State var email: String = UserDefaults.standard.string(forKey: "email") ?? ""
    @Environment(\.presentationMode) var presentation
    var body: some View {
        VStack {
            Text("Personal information")
            Image("profile-image-placeholder")
            Text(firstName)
            Text(lastName)
            Text(email)
            Button("Logout") {
                UserDefaults.standard.set(false, forKey: "kisLoggedIn")
                self.presentation.wrappedValue.dismiss()
            }
            Spacer()
        }
    }
}

#Preview {
    UserProfile()
}
