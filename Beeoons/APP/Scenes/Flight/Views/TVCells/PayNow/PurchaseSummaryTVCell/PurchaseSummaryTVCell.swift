//
//  PurchaseSummaryTVCell.swift
//  Beeoons
//
//  Created by FCI on 13/08/23.
//

import UIKit

class PurchaseSummaryTVCell: TableViewCell {
    @IBOutlet weak var holderView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupUI() {
        holderView.layer.borderWidth = 1
        holderView.layer.borderColor = UIColor.AppBorderColor.cgColor
    }
    
}
