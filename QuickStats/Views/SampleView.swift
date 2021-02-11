//
//  SampleView.swift
//  QuickStats
//
//  Created by Paul Traylor on 2021/02/06.
//

import Combine
import SwiftUI
import SwiftUICharts

struct SampleFetch<Content: View>: View {
    var widget: Widget
    var content: (Binding<[Sample]>) -> Content

    @EnvironmentObject var api: API
    @EnvironmentObject var settings: UserSettings

    @State private var subscriptions = Set<AnyCancellable>()
    @State private var samples = [Sample]()

    var body: some View {
        content($samples)
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

    private func onRecieve(_ data: Sample.List) {
        samples = data.results.sorted { $0.timestamp > $1.timestamp }
    }

    func load() {
        guard let login = settings.login else { return }
        var request = api.request(login: login, path: "/api/widget/\(widget.id)/samples", qs: [])
        request.addBasicAuth(username: login.username, password: settings.password)
        URLSession.shared.dataTaskPublisher(for: request)
            .map { $0.data }
            .decode(type: Sample.List.self, decoder: JSONDecoder.djangoDecoder)
            .subscribe(on: DispatchQueue.main)
            .sink(receiveCompletion: onReceive, receiveValue: onRecieve)
            .store(in: &subscriptions)
    }
}

struct SampleView: View {
    var widget: Widget

    var body: some View {
        VStack {
            Spacer()
            SampleFetch(widget: widget) { samples in
                TimelineChart(data: ChartData(from: samples.wrappedValue))
            }
            Spacer()
        }
    }
}

#if DEBUG
    struct SampleView_Previews: PreviewProvider {
        static var previews: some View {
            SampleView(widget: PreviewData.chart)
        }
    }
#endif

extension ChartData {
    public convenience init(from data: [Sample]) {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short

        let values =
            data
            .sorted { $0.timestamp < $1.timestamp }
            .map { (formatter.string(from: $0.timestamp), $0.value) }

        self.init(values: values)
    }
}
