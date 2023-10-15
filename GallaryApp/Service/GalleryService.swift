//
//  GalleryService.swift
//  GallaryApp
//
//  Created by Umang on 15/10/23.
//

import Foundation

protocol GalleryDelegate: AnyObject {
    func getGalleryImages(method: HTTPMethod, params: [String: Any], completion: @escaping(Result<PhotoModel, APIError>) -> Void)
}

protocol GalleryDBDelegate {
    func getGalleryImages(entity: Entity, completion: @escaping(Result<[ManagedImage], APIError>) -> Void)
    func deleteAllImages(entiry: Entity, completion: @escaping(Result<Void, APIError>) -> Void)
}

class GalleryService: GalleryDelegate {
    func getGalleryImages(method: HTTPMethod, params: [String: Any], completion: @escaping (Result<PhotoModel, APIError>) -> Void) {
        NetworkManager().fetchRequest(method: method, endpoint: .photos, params: params, type: PhotoModel.self, completion: completion)
    }
}

class GalleryDBService: GalleryDBDelegate {
    func getGalleryImages(entity: Entity, completion: @escaping (Result<[ManagedImage], APIError>) -> Void) {
        CoreDataManager.fetchAll(entity: entity, completion: completion)
    }
    
    func deleteAllImages(entiry: Entity, completion: @escaping (Result<Void, APIError>) -> Void) {
        CoreDataManager.deleteAll(.ManagedImage, completion: completion)
    }
}
