//
//  LoadingView.swift
//  HackerNews
//
//  Created by Massimo Omodei on 24.11.20.
//

import SwiftUI

struct LoadingView: View {
    var message: String? = nil

    var body: some View {
        VStack {
            ProgressView()
            if let message = message {
                Text(message)
                    .padding()
                    .foregroundColor(.gray)
            }
        }
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
        LoadingView(message: "Loading...")
    }
}
