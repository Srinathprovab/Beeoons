//
//  TravellerEconomyTVCell.swift
//  Beeoons
//
//  Created by FCI on 09/08/23.
//

import UIKit


protocol TravellerEconomyTVCellDelegate {
    func didTapOnDecrementButton(cell:TravellerEconomyTVCell)
    func didTapOnIncrementButton(cell:TravellerEconomyTVCell)
}

class TravellerEconomyTVCell: TableViewCell {
    
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var subTitlelbl: UILabel!
    @IBOutlet weak var countlbl: UILabel!
    
    var delegate: TravellerEconomyTVCellDelegate?
    var count = 0
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
        titlelbl.text = cellInfo?.title
        subTitlelbl.text = cellInfo?.subTitle
        
        
        
        if titlelbl.text == "Adults" {
            count = Int(cellInfo?.text ?? "1") ?? 1
        }else {
            count = Int(cellInfo?.text ?? "0") ?? 0
        }
        countlbl.text = cellInfo?.text
    }
    
    
    func setupUI() {
        
        
    }
    
    
    @IBAction func didTapOnDecrementButton(_ sender: Any) {
        delegate?.didTapOnDecrementButton(cell: self)
    }
    
    @IBAction func didTapOnIncrementButton(_ sender: Any) {
        delegate?.didTapOnIncrementButton(cell: self)
    }
    
    
}
