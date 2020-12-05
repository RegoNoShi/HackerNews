//
//  NetworkRequest.swift
//  HackerNews
//
//  Created by Massimo Omodei on 24.11.20.
//

import Foundation

class NetworkRequest {
    let url: URL

    init(url: URL) {
        self.url = url
    }

    func perform<T: Decodable>(onSuccess: @escaping (T) -> Void, onError: @escaping () -> Void) {
        let session = URLSession(configuration: urlSessionConfig, delegate: nil, delegateQueue: .main)
        let task = session.dataTask(with: url) { data, response, error in
            guard error == nil, let data = data, let result = try? self.decoder.decode(T.self, from: data) else {
                print(response.debugDescription)
                print(error.debugDescription)
                onError()
                return
            }

            onSuccess(result)
        }
        task.resume()
    }

    private var decoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970
        return decoder
    }

    private var urlSessionConfig: URLSessionConfiguration {
        let urlconfig = URLSessionConfiguration.default
        urlconfig.timeoutIntervalForRequest = 5
        urlconfig.timeoutIntervalForResource = 30
        return urlconfig
    }
}
