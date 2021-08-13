//
//  PhotoRequest.swift
//  Raja iOS Assignment
//
//  Created by Raja Syahmudin on 14/08/21.
//

import Foundation

// MARK: - PhotoRequest
struct PhotoRequest {
    static var shared = PhotoRequest()
    var state = DataLoadState.newest
    var page: Int = 1
    var perPage: Int = 10
    var search: String = ""
}

extension PhotoRequest {
    func toParameters() -> [String: Any] {
        var dictionary: [String: Any] = [:]
        dictionary["query"] = search
        dictionary["page"] = page
        dictionary["per_page"] = perPage
        return dictionary
    }
}
