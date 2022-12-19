//
//  Requester.swift
//  CodeGen
//
//  Created by Matt Thomas on 18/12/2022.
//

import Foundation
import OpenAISwift

enum APIResult {
   case success(String)
   case failure(Error)
}

final class Requester {
    
    private static let authToken = "replace_with_your_auth_token"
    private let openAPI = OpenAISwift(authToken: authToken)
    
    func sendRequest(query: String, completion: @escaping (APIResult) -> ()) {
        
        openAPI.sendCompletion(with: query, maxTokens: 256) { result in
            
            switch result {
            case .success(let openApi):

                let response = openApi.choices
                var returnString: String = ""

                DispatchQueue.main.async {
                    for choice in response {
                        returnString.append(choice.text)
                    }
                    completion(.success(returnString))
                }

            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
