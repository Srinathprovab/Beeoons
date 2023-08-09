//
//  ButtonTVCell.swift
//  Beeoons
//
//  Created by FCI on 09/08/23.
//

import UIKit

protocol ButtonTVCellDelegate {
    func didTapOnBnAction(cell:ButtonTVCell)
}

class ButtonTVCell: TableViewCell {

    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var holderView: UIView!
    
    
    var delegate:ButtonTVCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    override func updateUI() {
        titlelbl.text = cellInfo?.title
        holderView.backgroundColor = cellInfo?.bgColor
    }
    
    
    @IBAction func didTapOnBnAction(_ sender: Any) {
        delegate?.didTapOnBnAction(cell: self)
    }
    
    
}
