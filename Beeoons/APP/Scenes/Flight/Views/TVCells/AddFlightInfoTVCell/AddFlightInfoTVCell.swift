//
//  AddFlightInfoTVCell.swift
//  Beeoons
//
//  Created by FCI on 10/08/23.
//

import UIKit

class AddFlightInfoTVCell: UITableViewCell {
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var operatorImg: UIImageView!
    @IBOutlet weak var flightnamelbl: UILabel!
    @IBOutlet weak var fromCityTimelbl: UILabel!
    @IBOutlet weak var fromCityNamelbl: UILabel!
    @IBOutlet weak var toCityTimelbl: UILabel!
    @IBOutlet weak var toCityNamelbl: UILabel!
    @IBOutlet weak var hourslbl: UILabel!
    @IBOutlet weak var noOfStopslbl: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
