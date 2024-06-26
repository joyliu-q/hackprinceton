//
//  OnboardView.swift
//  hackprinceton
//
//  Created by Joy Liu on 3/30/24.
//

import SwiftUI


let COMMON_URLS = [
    "https://github.com/joyliu-q/hackprinceton",
    "https://github.com/pennlabs/infrastructure",
    "https://github.com/pennlabs/penn-mobile",
    "https://github.com/pennlabs/penn-mobile-ios",
    "https://github.com/kubernetes/kubernetes"
]

struct OnboardView: View {
    
    @Binding var githubAPI: GitHubAPI
    @State var repositoryURL: String = ""
    var onSubmit: () -> Void = {}
    
    var body: some View {
        VStack() {
            HStack() {
                Image("icon")
                    .resizable()
                    .scaledToFill()
                    .frame(
                        width: 64,
                        height: 64
                    )
                    .clipShape(.circle)
                Text(Project.title).font(.title).bold()
            }
            .padding(.top, 20)
            
            VStack() {
                VStack(alignment: .leading) {
                    Text("GitHub Repository").font(.headline)
                    TextField("", text: $repositoryURL, prompt: Text("Enter Repository URL")).onSubmit {
                        if repositoryURL != githubAPI.repositoryURL, let res = GitHubAPI(repositoryURL: repositoryURL) {
                            githubAPI = res
                            onSubmit()
                        }
                    }
                    .textFieldStyle(.roundedBorder)
                    .controlSize(.large)
                    .keyboardType(.URL)
                    .padding(.bottom)
                }
                VStack(spacing: 8) {
                    ForEach(COMMON_URLS, content: {url in
                        Button(action: {
                            repositoryURL = url
                            if repositoryURL != githubAPI.repositoryURL, let res = GitHubAPI(repositoryURL: repositoryURL) {
                                githubAPI = res
                                onSubmit()
                            }
                        }) {
                            Text(removeHttps(urlString: url))
                            .frame(maxWidth: .infinity)
                        }
                        .buttonStyle(.bordered)
                    })
                }.frame(maxWidth: .infinity)
            }.padding(24)
        }
    }
    
    private func removeHttps(urlString: String) -> String {
        return urlString
            .replacingOccurrences(of: "http://", with: "")
            .replacingOccurrences(of: "https://", with: "")
    }
}

#Preview {
    OnboardView(githubAPI: .constant(
        GitHubAPI(repositoryURL: "https://github.com/joyliu-q/hackprinceton")!), repositoryURL: "https://github.com/joyliu-q/hackprinceton")
}
