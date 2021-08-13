//
//  HomeRepository.swift
//  Raja iOS Assignment
//
//  Created by Raja Syahmudin on 14/08/21.
//


import RxSwift

struct HomeRepository {
    // MARK: getPhotos
    func getPhotos(request: PhotoRequest) -> Observable<UnsplashPhotoModel?> {
        let url = AssignmentTestAPI.getPhotos(search: request.search, page: request.page, perPage: request.perPage).urlString()
        return NetworkProvider().get(url).map { response in
            if let data = response as? [AnyHashable: Any] {
                do {
                    let json = try JSONSerialization.data(withJSONObject: data, options: [])
                    let decode = try JSONDecoder().decode(UnsplashPhotoModel.self, from: json)
                    return decode
                } catch let error {
                    Logger.log(error.localizedDescription, logType: .kError)
                }
            }
            return nil
        }
    }
}
