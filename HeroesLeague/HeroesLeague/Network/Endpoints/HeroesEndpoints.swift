//
//  HeroesEndpoints.swift
//  HeroesLeague
//
//  Created by Guilherme Antunes Ferreira on 19/07/2020.
//  Copyright © 2020 Guihsoft. All rights reserved.
//

import Foundation

enum HeroesEndpoints: Endpoint {
    
    case list(lastIndex: Int)
    case heroDetail(heroId: Int)
    
    var path: String {
        switch self {
        case .list:
            return baseURL + "v1/public/characters"
            
        case .heroDetail(let heroId):
            return baseURL + "/v1/public/characters/" + String(heroId)
        }
    }
    
    var headers: [String: String]? {
        switch self {
        default:
            return nil
        }
    }
    
    var body: Data? {
        switch self {
        default:
            return nil
        }
    }
    
    var httpMethod: String {
        switch self {
        case .list:
            return "GET"
            
        case .heroDetail:
            return "GET"
        }
    }
    
    var queryItems: [URLQueryItem]? {
        let ts = Date().timeIntervalSince1970.description
        let timeStamp = URLQueryItem(name: "ts", value: ts)
        let hashValue = URLQueryItem(name: "hash", value: "\(ts)\(privateKey)\(publicKey)".md5())
        let apiKey = URLQueryItem(name: "apikey", value: publicKey)
        var items = [timeStamp, apiKey, hashValue]
        switch self {
        case .list(let lastIndex):
            let lastIndexQueryItem = URLQueryItem(name: "offset", value: String(lastIndex))
            let limit = URLQueryItem(name: "limit", value: String(20))
            items.append(limit)
            items.append(lastIndexQueryItem)
            
        default:
            break
        }
        
        return items
    }
    
    var request: URLRequest {
        switch self {
        default:
            guard var components = URLComponents(string: path) else { fatalError() }
            components.queryItems = queryItems
            guard let url = components.url else { fatalError() }
            var request = URLRequest(url: url)
            request.allHTTPHeaderFields = headers
            request.httpMethod = httpMethod
            request.httpBody = body
            return request
        }
    }
    
}
