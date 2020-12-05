//
//  NewsListView.swift
//  HackerNews
//
//  Created by Massimo Omodei on 24.11.20.
//

import SwiftUI

struct NewsListView: View {
    @State private var didAppear = false
    @StateObject var viewModel: NewsListViewModel = NewsListViewModel()

    var body: some View {
        NavigationView {
            Group {
                if viewModel.loadingError {
                    VStack {
                        Text("Something went wrong :(")

                        Button("Retry") {
                            viewModel.fetchTopStories()
                        }
                        .padding()
                    }
                } else if let stories = viewModel.stories {
                    List(stories.indices) { index in
                        Link(destination: stories[index].url, label: {
                            NewsView(position: index + 1, item: stories[index])
                                .padding(.vertical, 4)
                        })
                    }
                } else {
                    LoadingView(message: "Loading news...")
                }
            }
            .navigationTitle("Hacker News")
            .onAppear {
                if !didAppear {
                    viewModel.fetchTopStories()
                    didAppear = true
                }
            }
        }
    }
}

struct NewsListView_Previews: PreviewProvider {
    private class MockNewsListViewModel: NewsListViewModel {
        private let mockStories: [Item]?
        private let mockLoadingError: Bool

        init(mockStories: [Item]? = nil, mockLoadingError: Bool = false) {
            self.mockStories = mockStories
            self.mockLoadingError = mockLoadingError
        }

        override func fetchTopStories() {
            loadingError = mockLoadingError
            stories = mockStories
        }
    }

    static var previews: some View {
        NewsListView(viewModel: MockNewsListViewModel())
        NewsListView(viewModel: MockNewsListViewModel(mockLoadingError: true))
        NewsListView(viewModel: MockNewsListViewModel(mockStories: PreviewData.items))
    }
}
