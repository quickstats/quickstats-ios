//
//  LoginView.swift
//  QuickStats
//
//  Created by Paul Traylor on 2021/02/05.
//

import Combine
import SwiftUI

struct LoginView: View {
    @EnvironmentObject var api: API
    @State private var subscriptions = Set<AnyCancellable>()

    @State private var login: Login = ""
    @State private var password = ""

    var isEnabled: Bool {
        return [
            login.contains("@"),
            login.contains("."),
            password.count > 0,
        ].allSatisfy { $0 }
    }

    var body: some View {
        List {
            TextField("Login", text: $login)
            SecureField("Password", text: $password)
            Button("Login", action: actionLogin)
                .disabled(!isEnabled)
        }.padding()
    }

    private func onReceive(completion: Subscribers.Completion<Error>) {
        switch completion {
        case .finished:
            break
        case .failure(let error):
            print(error.localizedDescription)
        }
    }

    private func onRecieve(_ data: Widget.List) {
        print(data)
    }

    func actionLogin() {
        var request = api.request(login: login, path: "/api/widget", qs: [])
        request.addBasicAuth(username: login.username, password: password)
        URLSession.shared.dataTaskPublisher(for: request)
            .map { $0.data }
            .decode(type: Widget.List.self, decoder: JSONDecoder.init())
            .subscribe(on: DispatchQueue.main)
            .sink(receiveCompletion: onReceive, receiveValue: onRecieve)
            .store(in: &subscriptions)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
