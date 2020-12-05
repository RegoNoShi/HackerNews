//
//  NewsViewModel.swift
//  HackerNews
//
//  Created by Massimo Omodei on 24.11.20.
//

import Foundation

class NewsListViewModel: ObservableObject {
    @Published var stories: [Item]?
    @Published var loadingError = false

    private let storiesToFetch = 10

    func fetchTopStories() {
        stories = nil
        loadingError = false
        NetworkRequest(url: URL(string: "https://hacker-news.firebaseio.com/v0/beststories.json")!)
            .perform(onSuccess: { [weak self] (ids: [Int]) -> Void in
                guard let self = self else { return }
                self.fetchStories(withIDs: Array(ids.prefix(self.storiesToFetch)))
            }, onError: { [weak self] in
                print("Error fetching beststories ids")
                self?.loadingError = true
            })
    }

    private func fetchStories(withIDs ids: [Int]) {
        let group = DispatchGroup()
        var stories: [Item?] = Array(repeating: nil, count: ids.count)
        ids.indices.forEach { index in
            group.enter()
            fetchStory(withID: ids[index], onSuccess: { story in
                stories[index] = story
                group.leave()
            }, onError: {
                print("Error fetching story: \(ids[index])")
                group.leave()
            })
        }

        group.notify(queue: .main) { [weak self] in
            self?.checkStoriesFetchResult(result: stories)
        }
    }

    private func checkStoriesFetchResult(result: [Item?]) {
        let retrievedStories = result.compactMap { $0 }
        if retrievedStories.count != storiesToFetch {
            loadingError = true
        } else {
            stories = retrievedStories
        }
    }

    private func fetchStory(withID id: Int, onSuccess: @escaping (Item) -> Void, onError: @escaping () -> Void) {
        NetworkRequest(url: URL(string: "https://hacker-news.firebaseio.com/v0/item/\(id).json")!)
            .perform(onSuccess: onSuccess, onError: onError)
    }
}
