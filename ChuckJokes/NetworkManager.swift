//
//  NetworkManager.swift
//  ChuckJokes
//
//  Created by Иван on 9/1/21.
//

import Foundation

struct NetworkManager {
    
    private let headers = [
        "accept": "application/json",
        "x-rapidapi-host": "matchilling-chuck-norris-jokes-v1.p.rapidapi.com",
        "x-rapidapi-key": "ba14580f68msh06638a18d05aad4p11c9e7jsnfa5e77550c8f"
    ]
    
    func makeUrlRequest(with url: String, returned value: @escaping (Joke) -> Void) {
        var joke = Joke(icon_url: "", value: "")
        guard let url = URL(string: url) else {
            print("Error creating url")
            return
        }
        var request = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10)
        request.allHTTPHeaderFields = headers
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let data = data {
                let jsonDecoder = JSONDecoder()
                do {
                    joke = try jsonDecoder.decode(Joke.self, from: data)
                    value(joke)
                } catch let error {
                    print(error.localizedDescription)
                }
            }
            if let error = error {
                print(error.localizedDescription)
            }
        }.resume()
    }
}
