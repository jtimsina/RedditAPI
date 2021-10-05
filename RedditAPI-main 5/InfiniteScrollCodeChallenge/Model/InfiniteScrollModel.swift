//
//  InfiniteScrollModel.swift
//  InfiniteScrollCodeChallenge
//
//

import Foundation

struct Feed: Codable {
    let data: FeedData
}

struct FeedData: Codable {
    let after: String
    let children: [Child]
}

struct Child: Codable {
    let data: ChildData
}

struct ChildData: Codable {
    let title: String?
    let num_comments: Int
    let score: Int
    let thumbnail: String?
    let thumbnail_height: Int?
    let thumbnail_width: Int?
    
}

