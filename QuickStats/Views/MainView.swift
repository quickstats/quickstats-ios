//
//  MainView.swift
//  QuickStats
//
//  Created by Paul Traylor on 2021/02/05.
//

import Combine
import SwiftUI

struct MainView: View {
    @EnvironmentObject var api: API
    @EnvironmentObject var settings: UserSettings
    @State private var subscriptions = Set<AnyCancellable>()

    @State var widgets = [Widget]()

    var body: some View {
        List {
            ForEach(widgets) { widget in
                Text(widget.title)
            }
        }.onAppear(perform: load)
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
        widgets = data.results
    }

    func load() {
        guard let login = settings.login else { return }
        var request = api.request(login: login, path: "/api/widget", qs: [])
        request.addBasicAuth(username: login.username, password: settings.password)
        URLSession.shared.dataTaskPublisher(for: request)
            .map { $0.data }
            .decode(type: Widget.List.self, decoder: JSONDecoder.init())
            .subscribe(on: DispatchQueue.main)
            .sink(receiveCompletion: onReceive, receiveValue: onRecieve)
            .store(in: &subscriptions)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
