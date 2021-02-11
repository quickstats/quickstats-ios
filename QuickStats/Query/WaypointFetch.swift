//
//  WaypointFetch.swift
//  QuickStats
//
//  Created by Paul Traylor on 2021/02/11.
//

import Combine
import SwiftUI

struct WaypointFetch<Content: View>: View {
    var widget: Widget
    var content: (Binding<[Waypoint]>) -> Content

    @EnvironmentObject var api: API
    @EnvironmentObject var settings: UserSettings

    @State private var subscriptions = Set<AnyCancellable>()
    @State private var waypoints = [Waypoint]()

    var body: some View {
        content($waypoints)
            .onAppear(perform: load)
    }

    private func onReceive(completion: Subscribers.Completion<Error>) {
        switch completion {
        case .finished:
            break
        case .failure(let error):
            print(error.localizedDescription)
        }
    }

    private func onRecieve(_ data: Waypoint.List) {
        waypoints = data.results.sorted { $0.timestamp > $1.timestamp }
    }

    func load() {
        guard let login = settings.login else { return }
        var request = api.request(login: login, path: "/api/widget/\(widget.id)/waypoints", qs: [])
        request.addBasicAuth(username: login.username, password: settings.password)
        URLSession.shared.dataTaskPublisher(for: request)
            .print()
            .map { $0.data }
            .decode(type: Waypoint.List.self, decoder: JSONDecoder.djangoDecoder)
            .subscribe(on: DispatchQueue.main)
            .sink(receiveCompletion: onReceive, receiveValue: onRecieve)
            .store(in: &subscriptions)
    }
}
