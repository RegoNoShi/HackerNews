//
//  NewsView.swift
//  HackerNews
//
//  Created by Massimo Omodei on 24.11.20.
//

import SwiftUI

struct NewsView: View {
    let position: Int
    let title: String
    let footnote: String
    let score: String
    let commentCount: String

    var body: some View {
        HStack(alignment: .top, spacing: 16.0) {
            Position(position: position)
            VStack(alignment: .leading, spacing: 8.0) {
                Text(title)
                    .font(.headline)
                Text(footnote)
                    .font(.footnote)
                    .foregroundColor(.secondary)
                ZStack(alignment: Alignment(horizontal: .leading, vertical: .center)) {
                    Badge(text: score, imageName: "arrowtriangle.up.circle")
                        .foregroundColor(.teal)
                    Badge(text: commentCount, imageName: "ellipses.bubble")
                        .padding(.leading, 96.0)
                        .foregroundColor(.orange)
                }
                .font(.callout)
            }
        }
    }
}

struct Badge: View {
    let text: String
    let imageName: String

    var body: some View {
        HStack {
            Image(systemName: imageName)
            Text(text)
        }
    }
}

struct Position: View {
    let position: Int

    var body: some View {
        ZStack {
            Circle()
                .frame(width: 32.0, height: 32.0)
                .foregroundColor(.teal)
            Text("\(position)")
                .font(.callout)
                .bold()
                .foregroundColor(.white)
        }
    }
}

struct NewsView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NewsView(position: 12, item: PreviewData.item)
            Position(position: 99)
            Badge(text: "1.234", imageName: "paperplane")
        }
        .previewLayout(.sizeThatFits)
    }
}
