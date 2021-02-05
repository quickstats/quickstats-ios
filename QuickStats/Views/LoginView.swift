//
//  LoginView.swift
//  QuickStats
//
//  Created by Paul Traylor on 2021/02/05.
//

import SwiftUI

struct LoginView: View {
    @State var username = ""
    @State var password = ""

    var isEnabled: Bool {
        return [
            username.contains("@"),
            username.contains("."),
            password.count > 0,
        ].allSatisfy { $0 }
    }

    var body: some View {
        List {
            TextField("Login", text: $username)
            SecureField("Password", text: $password)
            Button("Login", action: actionLogin)
                .disabled(!isEnabled)
        }.padding()
    }

    func actionLogin() {
        print(username)
        print(password)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
