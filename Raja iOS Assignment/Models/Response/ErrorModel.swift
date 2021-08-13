//
//  ErrorModel.swift
//  Raja iOS Assignment
//
//  Created by Raja Syahmudin on 14/08/21.
//

import Foundation

// MARK: - ErrorModel
struct ErrorModel: Codable {
    var status: Int?
    var error: String?
    
    init(_ error: String?) {
        self.error = error
    }
    
}
