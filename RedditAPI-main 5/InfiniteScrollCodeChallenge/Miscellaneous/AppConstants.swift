//
//  AppConstants.swift
//  InfiniteScrollCodeChallenge
//
//

import Foundation

enum AppConstantsURL {
    static let baseURL = "https://www.reddit.com/.json"
    static let after = "$AFTER_KEY"
    static let feedURL = "\(baseURL)?after=\(after)"
}

enum customFontSize {
    
    static let boldFontSize = 16.0
    static let spacingBetweenViews = 6
}
