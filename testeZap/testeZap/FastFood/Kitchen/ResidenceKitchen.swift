//
//  ZapKitchen.swift
//  testeZap
//
//  Created by Cleber Reis on 24/02/21.
//

import Foundation

internal class ResidenceKitchen {
    
    internal func retrieveResidence(completionHandler: @escaping(Result<[ResidenceModel]?, NetworkError>) -> Void) {

        let request: Resource = Resource(
            url: URL(string: "http://grupozap-code-challenge.s3-website-us-east-1.amazonaws.com/sources/source-1.json") ?? URL(string: "https:www.google.com.br")!,
            httpMethod: .get,
            body: nil)
        
        HttpService.load(resouce: request) { (result) in
            switch result {
                case .success(let response):
                    if let data = response {
                        let result = try? JSONDecoder().decode([ResidenceModel].self, from: data)
                        completionHandler(.success(result))
                    }
                case .failure(let error):
                    completionHandler(.failure(error))
            }
        }
        
    }
}
