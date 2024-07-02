//
//  Common.swift
//  dessert
//
//  Created by Nguyen Vien on 7/2/24.
//

import Foundation

// API fetch status
enum Status {
    case notStarted
    case fetching
    case success
    case failed(error: Error)
}

// API error
enum NetworkError: Error {
    case badURL, badResponse, badData
}
