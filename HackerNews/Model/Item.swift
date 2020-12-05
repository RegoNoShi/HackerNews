//
//  Item.swift
//  HackerNews
//
//  Created by Massimo Omodei on 24.11.20.
//

import Foundation

struct Item: Identifiable {
    let id: Int
    let commentCount: Int
    let score: Int
    let author: String
    let title: String
    let date: Date
    let url: URL
}

extension Item: Decodable {
    enum CodingKeys: String, CodingKey {
        case id, title, score, url
        case author = "by"
        case date = "time"
        case commentCount = "descendants"
    }
}
