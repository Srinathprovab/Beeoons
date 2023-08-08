//
//  DealsCVCell.swift
//  Beeoons
//
//  Created by FCI on 08/08/23.
//

import UIKit

protocol DealsCVCellDelegate {
    func didTapOnBookFlightBtn(cell:DealsCVCell)
}

class DealsCVCell: UICollectionViewCell {

    @IBOutlet weak var bookBtn: UIButton!
    @IBOutlet weak var holderView: UIView!
    
    var delegate:DealsCVCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        holderView.layer.borderWidth = 1
        holderView.layer.borderColor = UIColor.AppBorderColor.cgColor
    }

    @IBAction func didTapOnBookFlightBtn(_ sender: Any) {
        delegate?.didTapOnBookFlightBtn(cell: self)
    }
}
