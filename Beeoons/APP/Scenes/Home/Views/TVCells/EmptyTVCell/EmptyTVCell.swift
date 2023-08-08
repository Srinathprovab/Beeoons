//
//  EmptyTVCell.swift
//  Beeoons
//
//  Created by FCI on 08/08/23.
//

import UIKit

class EmptyTVCell: TableViewCell {
    
    @IBOutlet weak var viewHeight: NSLayoutConstraint!
    @IBOutlet weak var holderView: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    override func updateUI() {
        viewHeight.constant = cellInfo?.height ?? 44.0
        holderView.backgroundColor = cellInfo?.bgColor
    }
    
}
