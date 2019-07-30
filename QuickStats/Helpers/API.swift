//
//  API.swift
//  QuickStats
//
//  Created by Paul Traylor on 2019/07/28.
//  Copyright © 2019 Paul Traylor. All rights reserved.
//

import Foundation

typealias AuthedRequestResponse = ((HTTPURLResponse, Data) -> Void)

func authedRequest(path: String, method: String, queryItems: [URLQueryItem], completionHandler: @escaping AuthedRequestResponse) {
    guard let user = Settings.shared.string(forKey: .username) else { return }
    guard let pass = Settings.keychain.string(forKey: .server) else { return }
    guard let host = Settings.shared.string(forKey: .server) else { return }
    
    var components = URLComponents()
    components.scheme = "https"
    components.host = host
    components.path = path
    components.queryItems = queryItems
    
    authedRequest(url: components.url!, method: method, body: nil, username: user, password: pass, completionHandler: completionHandler)
}

func authedRequest(path: String, method: String, body: Data?, username: String, password: String, completionHandler: @escaping AuthedRequestResponse) {
    var components = URLComponents()
    components.scheme = "https"
    components.host = "tsundere.co"
    components.path = path

    authedRequest(url: components.url!, method: method, body: body, username: username, password: password, completionHandler: completionHandler)
}

func authedRequest(url: URL, method: String, body: Data?, username: String, password: String, completionHandler: @escaping AuthedRequestResponse) {
    var request = URLRequest(url: url)

    let loginString = "\(username):\(password)"
    guard let loginData = loginString.data(using: String.Encoding.utf8) else {
        return
    }
    let base64LoginString = loginData.base64EncodedString()
    request.setValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    request.addValue("application/json", forHTTPHeaderField: "Accept")

    request.httpMethod = method
    request.httpBody = body

    let task = URLSession.shared.dataTask(with: request, completionHandler: {data, response, _ -> Void in
        if let httpResponse = response as? HTTPURLResponse {
            completionHandler(httpResponse, data!)
        }
    })

    task.resume()
}

func checkLogin(username: String, password: String, completionHandler: @escaping (HTTPURLResponse) -> Void) {
    authedRequest(path: "/api/subscription", method: "GET", body: nil, username: username, password: password) { (response, _) in
        completionHandler(response)
    }
}
