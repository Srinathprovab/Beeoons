//
//  PurchaseSummaryTVCell.swift
//  Beeoons
//
//  Created by FCI on 13/08/23.
//

import UIKit

class PurchaseSummaryTVCell: TableViewCell {
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var cityslbl: UILabel!
    @IBOutlet weak var datelbl: UILabel!
    @IBOutlet weak var journytypelbl: UILabel!
    @IBOutlet weak var tripcostlbl: UILabel!
    
    
    
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
        cityslbl.text = cellInfo?.title ?? ""
        datelbl.text = cellInfo?.subTitle ?? ""
        tripcostlbl.text = "\(farepricedetails?.api_currency ?? ""):\(farepricedetails?.grand_total ?? "")"
        journytypelbl.text = "\(defaults.string(forKey: UserDefaultsKeys.journeyType) ?? ""), \(farepricedetails?.cabin_class ?? ""), \(farepricedetails?.fareType ?? "")"
    }
    
    func setupUI() {
        holderView.layer.borderWidth = 1
        holderView.layer.borderColor = UIColor.AppBorderColor.cgColor
    }
    
}
