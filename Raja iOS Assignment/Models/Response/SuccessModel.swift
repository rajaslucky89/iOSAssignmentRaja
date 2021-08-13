//
//  SuccessModel.swift
//  Raja iOS Assignment
//
//  Created by Raja Syahmudin on 14/08/21.
//

import Foundation

// MARK: - SuccessModel
struct SuccessModel: Codable {
    var meta: SuccessMeta?
}

// MARK: - Meta
struct SuccessMeta: Codable {
    var message: String?
    
    enum CodingKeys: String, CodingKey {
        case message
    }
}
