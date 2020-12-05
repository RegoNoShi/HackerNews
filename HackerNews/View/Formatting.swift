//
//  Formatting.swift
//  HackerNews
//
//  Created by Massimo Omodei on 24.11.20.
//

import UIKit
import SwiftUI

extension Color {
    static var teal: Color {
        Color(UIColor.systemTeal)
    }
}

extension URL {
    var formatted: String {
        (host ?? "").replacingOccurrences(of: "www.", with: "")
    }
}

extension Int {
    var formatted: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter.string(from: NSNumber(value: self)) ?? ""
    }
}

extension Date {
    var timeAgo: String {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .short
        return formatter.localizedString(for: self, relativeTo: Date())
    }
}

extension NewsView {
    init(position: Int, item: Item) {
        self.position = position
        title = item.title
        score = item.score.formatted
        commentCount = item.commentCount.formatted
        footnote = "\(item.url.formatted) - \(item.date.timeAgo) - by \(item.author)"
    }
}
