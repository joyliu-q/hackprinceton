//
//  CommitDetailView.swift
//  hackprinceton
//
//  Created by Anthony Li on 3/29/24.
//

import SwiftUI

struct CommitDetailView: View {
    var commit: Commit
    
    var body: some View {
        TabView {
            CommitMetadataView(commit: commit)
                .tabItem {
                    Text("Metadata")
                }
        }
    }
}

struct CommitMetadataView: View {
//    @State var thing = false
    var commit: Commit


    var body: some View {
        HStack {
            Circle()
                .fill(.background)
                .frame(width: 96, height: 96)
            
            VStack(alignment: .leading) {
                Text(commit.title)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                
                Text(commit.sha).monospaced().font(.subheadline)
                
                
                if commit.description != nil {
                    Text(commit.description!)
                }
               
            }
        }
        .padding()
        .background(.black.opacity(0.2))
        .clipShape(.rect(cornerRadius: 16))
        .overlay {
            RoundedRectangle(cornerRadius: 16)
                .stroke(.black)
        }
    }
}

#Preview {
    CommitDetailView(commit: .dummy)
}
