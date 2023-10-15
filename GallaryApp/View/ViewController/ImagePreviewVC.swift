//
//  ImagePreviewVC.swift
//  GallaryApp
//
//  Created by Umang on 16/10/23.
//

import UIKit

class ImagePreviewVC: UIViewController {

    //    MARK: - OUTLETS
    @IBOutlet weak var imgPreview: UIImageView!
    
    //    MARK: - VARIABLES
    var image: UIImage?
    
    //    MARK: - VIEW LIFECYCLE METHODS
    override func viewDidLoad() {
        super.viewDidLoad()
        imgPreview.image = image
    }
    
    //    MARK: - USER METHODS
    static func initFromStoryboard() -> ImagePreviewVC {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ImagePreviewVC") as! ImagePreviewVC
        return vc
    }

}
