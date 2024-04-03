//
//  UserDataService.swift
//  Github Users
//
//  Created by jmmanoza on 4/3/24.
//

import Foundation

class UserDataService: UserProtocol {
    func getAllUser() async throws -> [User] {
        let url = "https://api.github.com/users"
        
        guard let url = URL(string: url) else {
            throw APIError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse,
              response.statusCode == 200 else {
            throw APIError.invalidResponse
        }
        
        do {
            let users = try JSONDecoder().decode([User].self, from: data)
            return users
        } catch {
            throw APIError.invalidData
        }
    }
}

class UserMockService: UserProtocol {
    func getAllUser() async throws -> [User] {
        guard let url = Bundle.main.url(forResource: "UserResponse", withExtension: "json") else {
            throw APIError.invalidURL
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        
        do {
            return try JSONDecoder().decode([User].self, from: data)
        } catch {
            throw APIError.invalidData
        }
    }
}
