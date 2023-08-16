//
//  AddCheckinBaggageCVCell.swift
//  Beeoons
//
//  Created by FCI on 12/08/23.
//

import UIKit

class AddCheckinBaggageCVCell: UICollectionViewCell {

    @IBOutlet weak var sectorlbl: UILabel!
    @IBOutlet weak var adultlbl: UILabel!
    @IBOutlet weak var childlbl: UILabel!
    @IBOutlet weak var infantlbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        childlbl.isHidden = true
        infantlbl.isHidden = true
    }
    
    

}
