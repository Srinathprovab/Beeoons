//
//  StarRatingCVCell.swift
//  Beeoons
//
//  Created by FCI on 10/08/23.
//

import UIKit

class StarRatingCVCell: UICollectionViewCell {

    @IBOutlet weak var holderview: UIView!
    @IBOutlet weak var titlelbl: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        holderview.backgroundColor = .white
        holderview.layer.cornerRadius = 14
        holderview.clipsToBounds = true
        holderview.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.4).cgColor
        holderview.layer.borderWidth = 1
        
        titlelbl.textColor = .TitleColor
        titlelbl.font = UIFont.OswaldBold(size: 16)
    }

}
