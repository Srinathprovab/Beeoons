//
//  ItineraryTVCell.swift
//  Beeoons
//
//  Created by FCI on 11/08/23.
//

import UIKit

class ItineraryTVCell: UITableViewCell {
    
    
    
    
    @IBOutlet weak var operatorImg: UIImageView!
    @IBOutlet weak var flightnolbl: UILabel!
    @IBOutlet weak var cityscodelbl: UILabel!
    @IBOutlet weak var hourslbl: UILabel!
    @IBOutlet weak var stopslbl: UILabel!
    @IBOutlet weak var fromcitytimelbl: UILabel!
    @IBOutlet weak var fromDatelbl: UILabel!
    @IBOutlet weak var fromCitylbl: UILabel!
    @IBOutlet weak var tocitytimelbl: UILabel!
    @IBOutlet weak var toDatelbl: UILabel!
    @IBOutlet weak var toCitylbl: UILabel!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var layoverCitylbl: UILabel!

    
    
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
        // bottomView.isHidden = true
    }
    
}
