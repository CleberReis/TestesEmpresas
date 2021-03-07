//
//  HttpService.swift
//  testeZap
//
//  Created by Cleber Reis on 24/02/21.
//

import Foundation

enum NetworkError: Error {
    case decodingError
    case domainError
    case urlError
}

enum HttpMethod: String {
    case get = "GET"
    case post = "POST"
}

struct Resource {
    let url: URL
    var httpMethod: HttpMethod = .get
    var body: Data? = nil
}

extension Resource {
    init(url: URL) {
        self.url = url
    }
}

class HttpService {
    static func load(resouce: Resource, completion: @escaping (Result<Data?, NetworkError>) -> Void) {
        
        var request = URLRequest(url: resouce.url)
        request.httpMethod = resouce.httpMethod.rawValue
        request.httpBody = resouce.body
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data, error == nil else {
                completion(.failure(.domainError))
                return
            }
            DispatchQueue.main.async {
                completion(.success(data))
            }
            
        }.resume()
    }
}
