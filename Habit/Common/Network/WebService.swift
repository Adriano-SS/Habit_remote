//
//  WebService.swift
//  Habit
//
//  Created by user246507 on 10/10/23.
//

import Foundation

enum WebService {
    
    enum Endpoint: String {
        case base = "https://habitplus-api.tiagoaguiar.co"
        case postuser = "/users"
    }
    
    private static func completeUrl(path: Endpoint) -> URLRequest? {
        guard let url = URL(string: "\(Endpoint.base.rawValue)\(path.rawValue)") else {return nil}
        return URLRequest(url: url)
    }
    
    static func postUser(request: SignUpRequest) {
        
        guard let jsonData = try? JSONEncoder().encode(request) else { return }
        
        guard var urlRequest = completeUrl(path: .postuser) else { return}
        
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("aplication/json", forHTTPHeaderField: "accept")
        urlRequest.setValue("aplication/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpBody = jsonData
        
        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            guard let data = data, error == nil else {
                print(error)
                return
            }
            
            print(String(data: data, encoding: .utf8))
            print("Response:\n")
            print(response)
            if let r = response as? HTTPURLResponse {
                print(r.statusCode)
            }
        }
        
        task.resume()
    }
    
}
