//
//  TotalTravellerCountTVCell.swift
//  Beeoons
//
//  Created by FCI on 20/08/23.
//

import UIKit

class TotalTravellerCountTVCell: TableViewCell {
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var adultvaluelbl: UILabel!
    @IBOutlet weak var childvaluelbl: UILabel!
    @IBOutlet weak var infantvaluelbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    override func updateUI() {
        adultvaluelbl.text = cellInfo?.title ?? ""
        childvaluelbl.text = cellInfo?.subTitle ?? ""
        infantvaluelbl.text = cellInfo?.buttonTitle ?? ""
    }
    
    
    func setupUI() {
        holderView.layer.borderWidth = 1
        holderView.layer.borderColor = UIColor.AppBorderColor.cgColor
    }
    
}
