//
//  FirstCollectionViewCell.swift
//  MangoPlateCloneApp
//
//  Created by GOngTAE on 2021/12/24.
//

import UIKit

class FirstCollectionViewCell: UICollectionViewCell {
    
    
    
    var restInfo: RestInfo? = nil
    
    @IBOutlet weak var evaluationLabel: UILabel!
    @IBOutlet weak var reviewCountLabel: UILabel!
    @IBOutlet weak var viewCountLabel: UILabel!
    @IBOutlet weak var imageView1: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }
    
    
    
    override func prepareForReuse() {
        imageView1.image = UIImage(named: "mango")
 
    }
}



