//
//  FarBreakdownTVCell.swift
//  Beeoons
//
//  Created by FCI on 12/08/23.
//

import UIKit

class FarBreakdownTVCell: TableViewCell {
    
    
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var passengerTypelbl: UILabel!
    @IBOutlet weak var basefarelbl: UILabel!
    @IBOutlet weak var taxlbl: UILabel!
    @IBOutlet weak var subtotallbl: UILabel!
    @IBOutlet weak var noofpassengerslbl: UILabel!
    @IBOutlet weak var totalBreakdownlbl: UILabel!
    @IBOutlet weak var totalTripCostTitlelbl: UILabel!
    @IBOutlet weak var tripCostValuelbl: UILabel!
    
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
        
        passengerTypelbl.text = cellInfo?.passengerType
        basefarelbl.text = cellInfo?.basefare
        taxlbl.text = cellInfo?.tax
        subtotallbl.text = cellInfo?.totalBreakdown
        noofpassengerslbl.text = cellInfo?.noofpassengers
        totalBreakdownlbl.text = cellInfo?.subtotal
        tripCostValuelbl.text = cellInfo?.tripCost
        
        if cellInfo?.key == "hide"{
            totalTripCostTitlelbl.isHidden = true
            tripCostValuelbl.isHidden = true
        }
        
    }
    
    
    func setupUI(){
        holderView.layer.borderWidth = 1
        holderView.layer.borderColor = UIColor.UnselectedBtnColor.cgColor
    }
    
}
