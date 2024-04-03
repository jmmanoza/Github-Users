//
//  UserProtocol.swift
//  Github Users
//
//  Created by jmmanoza on 4/3/24.
//

import Foundation

protocol UserProtocol {
   func getAllUser() async throws -> [User]
}
