//
//  APIError.swift
//  Github Users
//
//  Created by jmmanoza on 4/3/24.
//

import Foundation

enum APIError: LocalizedError {
    
    case invalidURL
    case invalidResponse
    case invalidData
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid URL found."
        case .invalidResponse:
            return "Invalid response found."
        case .invalidData:
            return "Invalid parsing data."
        }
    }
}
