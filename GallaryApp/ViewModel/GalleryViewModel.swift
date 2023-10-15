//
//  GalleryViewModel.swift
//  GallaryApp
//
//  Created by Umang on 15/10/23.
//

import Foundation
import Combine

class GalleryViewModel {
    //    MARK: - VARIABLES
    private let galleryService: GalleryService
    private let galleryDBService: GalleryDBService
    private var offset = 0
    var isLoadMore = false
    var arrPhotos = [Photo]()
    var arrDBPhotos = [ManagedImage]()
    
    var fetchResult = PassthroughSubject<Void, Error>()
    
    //    MARK: - init
    init(galleryService: GalleryService = GalleryService(), galleryDBService: GalleryDBService = GalleryDBService()) {
        self.galleryService = galleryService
        self.galleryDBService = galleryDBService
    }
    
    // This method used to fetch remote images
    func fetchImages() {
        let params: [String: Any] = [
            "offset": offset,
            "limit": 10,
        ]
        if NetworkMonitor.shared.isReachable {
            CommonUtility.shared.showLoadingIndicator()
            galleryService.getGalleryImages(method: .get, params: params) { [weak self] result in
                CommonUtility.shared.hideLoadingIndicator()
                switch result {
                case .success(let model):
                    if self?.offset == 0 {
                        self?.deleteLocalImages()
                    }
                    if (model.totalPhotos ?? 0) >= (self?.arrPhotos.count ?? 0) {
                        self?.isLoadMore = true
                        self?.offset += 1
                    } else {
                        self?.isLoadMore = false
                    }
                    self?.arrPhotos.append(contentsOf: model.photos ?? [])
                    self?.fetchResult.send(())
                    
                    let entity = CoreDataManager.getEntityDescription(entityName: .ManagedImage)

                    model.photos?.forEach({ photo in
                        let obj = CoreDataManager.insertData(in: entity!) as! ManagedImage
                        obj.image_data = photo.url
                    })
                    CoreDataManager.saveToMainContext()
                case .failure(let failure):
                    self?.fetchResult.send(completion: .failure(failure))
                }
            }
        } else {
            galleryDBService.getGalleryImages(entity: .ManagedImage) { [weak self] result in
                switch result {
                case .success(let res):
                    self?.arrDBPhotos.append(contentsOf: res)
                    self?.fetchResult.send(())
                case .failure(let failure):
                    self?.fetchResult.send(completion: .failure(failure))
                }
            }
        }
    }
    
    func deleteLocalImages() {
        galleryDBService.deleteAllImages(entiry: .ManagedImage) { result in
            switch result {
            case .success(_):
                break
            case .failure(_):
                break
            }
        }
    }
}
