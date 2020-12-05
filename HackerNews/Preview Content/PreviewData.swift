//
//  TestItem.swift
//  HackerNews
//
//  Created by Massimo Omodei on 24.11.20.
//

import Foundation

class PreviewData {
    static var items: [Item] = {
        guard let itemUrl = Bundle.main.url(forResource: "PreviewItems", withExtension: "json"), let itemData = try? Data(contentsOf: itemUrl) else {
            fatalError("Unable to load PreviewItems.json")
        }

        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970

        guard let items = try? decoder.decode([Item].self, from: itemData) else {
            fatalError("Unable to decode PreviewItems")
        }

        return items
    }()

    static var item: Item {
        items[0]
    }
}
