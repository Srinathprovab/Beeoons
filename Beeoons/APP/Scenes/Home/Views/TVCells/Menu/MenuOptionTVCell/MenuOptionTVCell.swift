//
//  MenuOptionTVCell.swift
//  Beeoons
//
//  Created by FCI on 11/08/23.
//

import UIKit


protocol MenuOptionTVCellDelegate {
    func didTapOnMenuOtptionBtnAction(cell:MenuOptionTVCell)
}

class MenuOptionTVCell: TableViewCell {
    
    
    
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var holderView: UIView!
    
    
    var delegate:MenuOptionTVCellDelegate?
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
        titlelbl.text = cellInfo?.title ?? ""
    }
    
    
    func setupUI() {
        holderView.layer.borderColor = UIColor.AppBorderColor.cgColor
        holderView.layer.borderWidth = 1
        
    }
    
    
    @IBAction func didTapOnMenuOtptionBtnAction(_ sender: Any) {
        delegate?.didTapOnMenuOtptionBtnAction(cell: self)
    }
    
    
}
