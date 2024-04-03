//
//  UserViewModel.swift
//  Github Users
//
//  Created by jmmanoza on 4/3/24.
//

import Foundation

class UserViewModel: ObservableObject {
    let service: UserProtocol
    @Published var users: [User] = []
    @Published var isLoading: Bool = false
    @Published var errrorMessage: String = ""
    
    init(service: UserProtocol) {
        self.service = service
    }
    
    @MainActor
    func getAllGithubUsers() async {
        do {
            let users = try await service.getAllUser()
            self.users = users
            print("get all users: \(self.users)")
        } catch(let error) {
            self.errrorMessage = error.localizedDescription
        }
    }
}
