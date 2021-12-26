//
//  FirstCollectionViewHeader.swift
//  MangoPlateCloneApp
//
//  Created by GOngTAE on 2021/12/26.
//

import Foundation
import UIKit
import ImageSlideshow

class FirstCollectionViewHeader: UICollectionReusableView {
    
    @IBOutlet weak var slideShow: ImageSlideshow!
    
   
    
    @IBOutlet weak var locationButton: UIButton!
    @IBOutlet weak var filterButton: UIButton!
    
    override func awakeFromNib() {
        slideShow.contentScaleMode = .scaleAspectFill
        
        filterButton.layer.masksToBounds = true
        filterButton.layer.cornerRadius = 16
        filterButton.layer.borderWidth = 1
        filterButton.layer.borderColor = UIColor.gray.cgColor
        
        locationButton.layer.masksToBounds = true
        locationButton.layer.cornerRadius = 16
    }
}
