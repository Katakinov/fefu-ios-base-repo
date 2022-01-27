//
//  AuthorizationController.swift
//  fefuactivity
//
//  Created by wsr3 on 28.01.2022.
//

import Foundation

class Auth{
    static private let regLink = "https://fefu.t.feip.co/api/auth/register"
    static private let logLink = "https://fefu.t.feip.co/api/auth/login"
    
    static let decoder = JSONDecoder()
    static let encoder = JSONEncoder()
    
    init() {
        Auth.decoder.keyDecodingStrategy = .convertFromSnakeCase
        Auth.encoder.keyEncodingStrategy = .convertToSnakeCase
    }
    
    static func register(_ body: Data, User: @escaping ((UserModelToken) -> Void), errors: @escaping ((ErrorModel) -> Void)){
        guard let url = URL(string: regLink) else {
            print("URL error")
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.httpBody = body
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: urlRequest) { data, response, error in
            guard let data = data else {
                return
            }
            
            if let response = response as? HTTPURLResponse {
                switch response.statusCode {
                
                case 422:
                    do {
                        let errorData = try Auth.decoder.decode(ErrorModel.self, from: data)
                        errors(errorData)
                        return
                    } catch let err {
                        print("Error #422 \(err)")
                    }
                case 200:
                    do {
                        let userData = try Auth.decoder.decode(UserModelToken.self, from: data)
                        User(userData)
                        return
                    } catch let err {
                        print("Error: Decode failed \(err)")
                    }
                default:
                    return
                }
            }
        }
        task.resume()
        }
    
    static func login(_ body: Data, User: @escaping ((UserModelToken) -> Void), errors: @escaping ((ErrorModel) -> Void)){
        guard let url = URL(string: logLink) else {
            print("URL error")
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.httpBody = body
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: urlRequest) { data, response, error in
            guard let data = data else {
                return
            }
            
            if let response = response as? HTTPURLResponse {
                switch response.statusCode {
                
                case 422:
                    do {
                        let errorData = try Auth.decoder.decode(ErrorModel.self, from: data)
                        errors(errorData)
                        return
                    } catch let err {
                        print("Error #422 \(err)")
                    }
                case 200:
                    do {
                        let userData = try Auth.decoder.decode(UserModelToken.self, from: data)
                        User(userData)
                        return
                    } catch let err {
                        print("Error: Decode failed \(err)")
                    }
                default:
                    return
                }
            }
        }
        task.resume()
        }
}
