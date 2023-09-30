//
//  HotelImageCVCell.swift
//  Beeoons
//
//  Created by FCI on 30/09/23.
//

import UIKit

class HotelImageCVCell: UICollectionViewCell {

    
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var holderView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        holderView.layer.cornerRadius = 6
        holderView.clipsToBounds = true
        
        img.layer.cornerRadius = 6
        img.clipsToBounds = true
    }

}
