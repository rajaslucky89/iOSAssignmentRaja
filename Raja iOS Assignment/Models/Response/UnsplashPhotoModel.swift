//
//  UnsplashPhotoModel.swift
//  Raja iOS Assignment
//
//  Created by Raja Syahmudin on 14/08/21.
//

import Foundation

// MARK: - UnsplashPhotoModel
struct UnsplashPhotoModel : Codable {
    let results : [UnsplashPhotos]?
    let total : Int?
    let totalPages : Int?
    
    enum CodingKeys: String, CodingKey {
        case results = "results"
        case total = "total"
        case totalPages = "total_pages"
    }
    
}

// MARK: - UnsplashPhotos
struct UnsplashPhotos : Codable {
    let description : String?
    let id : String?
    let urls : Url?
    let user : User?
    
    enum CodingKeys: String, CodingKey {
        case description = "description"
        case id = "id"
        case urls = "urls"
        case user = "user"
    }
    
}

// MARK: - Url
struct Url : Codable {
    let full : String?
    let raw : String?
    let regular : String?
    let small : String?
    let thumb : String?
    
    enum CodingKeys: String, CodingKey {
        case full = "full"
        case raw = "raw"
        case regular = "regular"
        case small = "small"
        case thumb = "thumb"
    }
    
}

// MARK: - User
struct User : Codable {
    let name : String?
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
    }
    
    
}
