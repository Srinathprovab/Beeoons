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
    
    @IBOutlet weak var citylbl: UILabel!
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var bgimg: UIImageView!
    @IBOutlet weak var bookBtn: UIButton!
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var depratureDatelbl: UILabel!
    @IBOutlet weak var returnDatelbl: UILabel!
    @IBOutlet weak var operatorImg: UIImageView!
    @IBOutlet weak var onwwayimg: UIImageView!
    @IBOutlet weak var flytolbl: UILabel!
    @IBOutlet weak var kwdpricelbl: UILabel!
    
    
    var trip_type = String()
    var fromcity = String()
    var from_loc_id = String()
    var tocity = String()
    var to_loc_id = String()
    var v_class = String()
    var currency = String()
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
