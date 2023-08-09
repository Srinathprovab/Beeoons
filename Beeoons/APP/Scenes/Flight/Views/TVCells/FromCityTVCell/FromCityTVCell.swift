//
//  FromCityTVCell.swift
//  Beeoons
//
//  Created by FCI on 09/08/23.
//

import UIKit

class FromCityTVCell: UITableViewCell {
    
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var subtitlelbl: UILabel!
    
    
    var cityname = String()
    var id = String()
    var label = String()
    var citycode = String()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
