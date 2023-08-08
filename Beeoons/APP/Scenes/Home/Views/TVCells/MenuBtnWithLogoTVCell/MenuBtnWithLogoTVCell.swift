//
//  MenuBtnWithLogoTVCell.swift
//  Beeoons
//
//  Created by FCI on 08/08/23.
//

import UIKit



protocol MenuBtnWithLogoTVCellDelegate {
    func didTapOnMenuBtnAction(cell:MenuBtnWithLogoTVCell)
    func didTapOnLangBtnAction(cell:MenuBtnWithLogoTVCell)
}

class MenuBtnWithLogoTVCell: TableViewCell {
    
    
    
    @IBOutlet weak var currencylbl: UILabel!
    
    
    var delegate:MenuBtnWithLogoTVCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func updateUI() {
        currencylbl.text = "KWD"
    }
    
    
    @IBAction func didTapOnMenuBtnAction(_ sender: Any) {
        delegate?.didTapOnMenuBtnAction(cell: self)
    }
    
    @IBAction func didTapOnLangBtnAction(_ sender: Any) {
        delegate?.didTapOnMenuBtnAction(cell: self)
    }
}
