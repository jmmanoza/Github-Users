//
//  MainView.swift
//  Github Users
//
//  Created by jmmanoza on 4/3/24.
//

import SwiftUI

struct MainView: View {
    
    @StateObject private var viewModel = UserViewModel(service: UserDataService())
    let columns = Array(repeating: GridItem(.flexible()), count: 3)
    
    var body: some View {
        NavigationStack {
            VStack {
                if viewModel.isLoading {
                    ProgressView()
                } else {
                    ScrollView {
                        LazyVGrid(columns: columns) {
                            ForEach(viewModel.users, id: \.self) { user in
                                setUpRow(with: user)
                            }
                        }
                    }
                }
            }
            .task {
                await viewModel.getAllGithubUsers()
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Text("Github Users")
                        .font(.title)
                        .fontWeight(.bold)
                }
            }
        }
    }
}

private extension MainView {
    @ViewBuilder
    func setUpRow(with user: User) -> some View {
        VStack(alignment: .center, spacing: 8) {
            AsyncImage(url: URL(string: user.avatar_url)) { avatarImg in
                avatarImg
                    .resizable()
                    .frame(width: 100, height: 100)
                    .clipShape(Circle())
            } placeholder: {
                Circle()
                    .background(Color(.systemGray5))
            }

            Text(user.login)
                .font(.headline)
                .fontWeight(.semibold)
        }
    }
}


struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
