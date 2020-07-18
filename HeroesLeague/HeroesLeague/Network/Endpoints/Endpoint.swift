//
//  Endpoint.swift
//  HeroesLeague
//
//  Created by Guilherme Antunes Ferreira on 18/07/2020.
//  Copyright © 2020 Guihsoft. All rights reserved.
//

import Foundation

protocol Endpoint {
    var path: String { get }
    var headers: [String: String]? { get }
    var body: Data? { get }
    var httpMethod: String { get }
    var request: URLRequest { get }
    var queryItems: [URLQueryItem]? { get }
}
