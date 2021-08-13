//
//  NetworkConfiguration.swift
//  Raja iOS Assignment
//
//  Created by Raja Syahmudin on 14/08/21.
//


import Foundation

enum AssignmentTestAPI {
    case getPhotos(search: String, page: Int, perPage: Int)

    func urlString() -> String {
        return NetworkConfiguration.api(self)
    }
    
    fileprivate func apiString() -> String {
        switch self {
        case .getPhotos(let search, let page, let perPage):
            return "search/photos/?query=\(search)&page=\(page)&per_page=\(perPage)&client_id=\(Constants.accessKey)"
        }
    }
}

struct NetworkConfiguration {
    fileprivate static let apiPath = ""
    fileprivate static let kClientID = "iOS"
    fileprivate static let kClientSecret = ""
    
    static let kTokenExpiredErrorCode = 405
    static let kGatewayTimeoutErrorCode = 503
    static let kMissingPhoneNumberErrorCode = 403
    
    static func api(_ apiType: AssignmentTestAPI) -> String {
        return Environment.baseApiURL + apiPath + apiType.apiString()
    }
    
}
