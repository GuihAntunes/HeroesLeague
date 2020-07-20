//
//  Requester.swift
//  HeroesLeague
//
//  Created by Guilherme Antunes Ferreira on 18/07/2020.
//  Copyright © 2020 Guihsoft. All rights reserved.
//

import Foundation

typealias RequesterCompletion<C:Codable> = (C?, Error?) -> Void

enum CustomError: Error {
    case connectionError(String)
    case mappingError(String)
    case APIError(String)
    case generalError(String)
    case deallocatedClass(String)
}

class Requester {
    
    let connectionChecker: Reachability
    let decoder: JSONDecoder
    let session: URLSession
    
    init(connectionChecker: Reachability = .init(), decoder: JSONDecoder = .init(), session: URLSession = URLSession.shared) {
        self.decoder = decoder
        self.session = session
        self.connectionChecker = connectionChecker
    }
    
    func request<T: Codable>(model: T.Type, _ request: URLRequest, completion: @escaping RequesterCompletion<T>) {
            
            session.dataTask(with: request, completionHandler: { [weak self] (data, response, error) in
                
                guard let _self = self else {
                    completion(nil, CustomError.deallocatedClass("Class deinitialized!"))
                    return
                }
                
                guard _self.connectionChecker.isConnected else {
                    completion(nil, CustomError.connectionError("Por favor, verifique sua conexão com a internet!"))
                    return
                }
                
                guard let data = data else {
                    completion(nil, CustomError.APIError(error?.localizedDescription ?? "Ocorreu um erro inesperado, por favor, tente novamente!"))
                    return
                }
                
                guard error == nil else {
                    completion(nil, CustomError.APIError(error?.localizedDescription ?? "Ocorreu um erro inesperado, por favor, tente novamente!"))
                    return
                }
                
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    completion(nil, CustomError.APIError(error?.localizedDescription ?? "Ocorreu um erro inesperado, por favor, tente novamente!"))
                    return
                }
                
                guard let model = try? _self.decoder.decode(T.self, from: data) else {
                    completion(nil, CustomError.mappingError("Error on parsing model \(T.self)!"))
                    return
                }
                
                completion(model, nil)
            }).resume()
    }
}
