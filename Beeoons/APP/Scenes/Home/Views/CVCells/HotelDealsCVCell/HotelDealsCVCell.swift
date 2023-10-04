//
//  HotelDealsCVCell.swift
//  Beeoons
//
//  Created by FCI on 08/08/23.
//

import UIKit

protocol HotelDealsCVCellDelegate {
    func didTapOnBookHoteltBtn(cell:HotelDealsCVCell)
}

class HotelDealsCVCell: UICollectionViewCell {

    @IBOutlet weak var bookBtn: UIButton!
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var hotelImg: UIImageView!
    @IBOutlet weak var hotelNamelbl: UILabel!
    @IBOutlet weak var citylbl: UILabel!
    @IBOutlet weak var pricelbl: UILabel!
    @IBOutlet weak var checkinValuelbl: UILabel!
    @IBOutlet weak var checkoutValuelbl: UILabel!
    @IBOutlet weak var hotetextlbl: UILabel!
    
    
    var citycode = String()
    var delegate:HotelDealsCVCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        holderView.layer.borderWidth = 1
        holderView.layer.borderColor = UIColor.AppBorderColor.cgColor
    }

    @IBAction func didTapOnBookHoteltBtn(_ sender: Any) {
        delegate?.didTapOnBookHoteltBtn(cell: self)
    }

}
