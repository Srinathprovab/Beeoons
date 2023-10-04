//
//  HotelDetailsTabCVCell.swift
//  Beeoons
//
//  Created by FCI on 30/09/23.
//

import UIKit

class HotelDetailsTabCVCell: UICollectionViewCell {

    
    @IBOutlet weak var holderView: BorderedView!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var imgHeight: NSLayoutConstraint!
    @IBOutlet weak var imgWidth: NSLayoutConstraint!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    func setupImage(image:String,width:CGFloat,height:CGFloat) {
        img.image = UIImage(named: image)
        imgWidth.constant = width
        imgHeight.constant = height
    }
    
    
    func selected() {
        holderView.layer.borderColor = UIColor.ButtonColor.cgColor
        titlelbl.textColor = .ButtonColor
    }
    
    
    
    func unSelected() {
        holderView.layer.borderColor = UIColor.CalenderRangeColor.cgColor
        titlelbl.textColor = .SubtitleColor
    }

}
