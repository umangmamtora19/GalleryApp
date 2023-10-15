//
//  GalleryVC.swift
//  GallaryApp
//
//  Created by Umang on 15/10/23.
//

import UIKit
import Combine
import SDWebImage

class GalleryVC: UIViewController {
    
    //    MARK: - OUTLETS
    @IBOutlet weak var imgUser: UIImageView!
    @IBOutlet weak var cvPhotos: UICollectionView!
    
    //    MARK: - VARIABLES
    var galleryVM = GalleryViewModel()
    var bindings = Set<AnyCancellable>()
    
    //    MARK: - VIEW LIFECYCLE METHODS
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup() {
        imgUser.setCircularCorner()
        imgUser.sd_setImage(with: URL(string: loggedInUser?.profile ?? ""), placeholderImage: UIImage(systemName: "person.fill"))
        galleryVM.fetchImages()
        galleryVM.fetchResult.sink { error in
            CommonUtility.shared.appPrint(error)
        } receiveValue: { [weak self] in
            DispatchQueue.main.async {
                self?.cvPhotos.reloadWithAnimation()
            }
        }.store(in: &bindings)

    }
    
    //    MARK: - USER METHODS
    static func initFromStoryboard() -> GalleryVC {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "GalleryVC") as! GalleryVC
        return vc
    }
    
}

//    MARK: - EVENTS
extension GalleryVC {
    @IBAction func btnProfileAction(_ sender: UIButton) {
        let vc = ProfileVC.initFromStoryboard()
        navigationController?.pushViewController(vc, animated: true)
    }
}


//    MARK: - COLLECTION DATASOURCE, DELEGATE AND FLOWDELEGATE METHODS
extension GalleryVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return NetworkMonitor.shared.isReachable ? galleryVM.arrPhotos.count : galleryVM.arrDBPhotos.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GalleryCell", for: indexPath) as! GalleryCell
        if NetworkMonitor.shared.isReachable {
            let item = galleryVM.arrPhotos[indexPath.item]
            cell.imgGallery.sd_setImage(with: URL(string: item.url ?? ""))
        } else {
            let item = galleryVM.arrDBPhotos[indexPath.item]
            cell.imgGallery.sd_setImage(with: URL(string: item.image_data ?? ""))
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.item == (galleryVM.arrPhotos.count - 1) {
            if galleryVM.isLoadMore {
                galleryVM.fetchImages()
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = ImagePreviewVC.initFromStoryboard()
        let cell = collectionView.cellForItem(at: indexPath) as! GalleryCell
        vc.image = cell.imgGallery.image
        navigationController?.pushViewController(vc, animated: true)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.size.width - 5) / 3
        
        return CGSize(width: width, height: width)
    }
}
