//
//  AddViewFlightDataTVCell.swift
//  Beeoons
//
//  Created by FCI on 13/08/23.
//

import UIKit

class AddViewFlightDataTVCell: UITableViewCell {
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var operatorImg: UIImageView!
    @IBOutlet weak var flightnamelbl: UILabel!
    @IBOutlet weak var cityslbl: UILabel!
    @IBOutlet weak var fromCityTimelbl: UILabel!
    @IBOutlet weak var fromCityNamelbl: UILabel!
    @IBOutlet weak var toCityTimelbl: UILabel!
    @IBOutlet weak var toCityNamelbl: UILabel!
    @IBOutlet weak var hourstopslbl: UILabel!
    @IBOutlet weak var economylbl: UILabel!
    @IBOutlet weak var fromdatalbl: UILabel!
    @IBOutlet weak var todatelbl: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
