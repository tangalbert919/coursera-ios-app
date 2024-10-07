//
//  Onboarding.swift
//  LittleLemon
//
//  Created by Albert Tang on 10/7/24.
//

import SwiftUI

struct Onboarding: View {
    @State var firstName = ""
    @State var lastName = ""
    @State var email = ""
    var body: some View {
        VStack {
            TextField("First Name", text: $firstName)
            TextField("Last Name", text: $lastName)
            TextField("Email", text: $email)
            Button("Register") {
                if (!firstName.isEmpty && !lastName.isEmpty && email.isEmpty) {
                    UserDefaults.standard.set(firstName, forKey: "firstName")
                    UserDefaults.standard.set(lastName, forKey: "lastName")
                    UserDefaults.standard.set(email, forKey: "email")
                }
            }
        }
    }
}

#Preview {
    Onboarding()
}
