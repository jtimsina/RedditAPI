//
//  InfiniteScrollService.swift
//  InfiniteScrollCodeChallenge
//
//

import Foundation
import Combine


protocol InfiniteScrollServiceCollection {
    var networkManager: NetworkService { get }
    func getFeeds(from urlS: String) -> AnyPublisher<Feed, Error>
    func getImage(from urlS: String) -> AnyPublisher<Data, Error>
    
}


class RedditService: InfiniteScrollServiceCollection {
    
    let networkManager: NetworkService
    
    init(networkManager: NetworkService = NetworkManager()) {
        self.networkManager = networkManager
    }
    
    func getFeeds(from urlS: String) -> AnyPublisher<Feed, Error> {
        
        guard let url = URL(string: urlS) else {
            let error = NSError(domain: URLError.errorDomain, code: 0, userInfo: [NSLocalizedDescriptionKey: "URL error"])
            return Fail(error: error).eraseToAnyPublisher()
        }
        
        return networkManager
            .get(from: url)
            .decode(type: Feed.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
    func getImage(from urlS: String) -> AnyPublisher<Data, Error> {
        
        guard let url = URL(string: urlS) else {
            let error = NSError(domain: URLError.errorDomain, code: 0, userInfo: [NSLocalizedDescriptionKey: "URL error"])
            return Fail(error: error).eraseToAnyPublisher()
        }
        
        return networkManager
            .get(from: url)
            .eraseToAnyPublisher()
    }
    
}
