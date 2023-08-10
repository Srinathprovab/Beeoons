//
//  SortByPriceTVCell.swift
//  Beeoons
//
//  Created by FCI on 10/08/23.
//

import UIKit


protocol SortByPriceTVCellDelegate {
    func didTapOnLowToHeighBtnAction(cell:SortByPriceTVCell)
    func didTapOnHeighToLowBtnAction(cell:SortByPriceTVCell)
}

class SortByPriceTVCell: TableViewCell {

    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var lowView: UIView!
    @IBOutlet weak var lowlbl: UILabel!
    @IBOutlet weak var lowBtn: UIButton!
    @IBOutlet weak var heightView: UIView!
    @IBOutlet weak var heighlbl: UILabel!
    @IBOutlet weak var heighBtn: UIButton!
    
    
    var delegate:SortByPriceTVCellDelegate?
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
        lowlbl.text = cellInfo?.subTitle
        heighlbl.text = cellInfo?.buttonTitle
        
    }
    
    
    func setupUI() {
        holderView.backgroundColor = .WhiteColor
        setuplabels(lbl: titlelbl, text: "", textcolor: .TitleColor, font: .OswaldRegular(size: 16), align: .left)
        setuplabels(lbl: lowlbl, text: "", textcolor: .TitleColor, font: .OswaldRegular(size: 14), align: .center)
        setuplabels(lbl: heighlbl, text: "", textcolor: .TitleColor, font: .OswaldRegular(size: 14), align: .center)
        lowBtn.setTitle("", for: .normal)
        heighBtn.setTitle("", for: .normal)
        lowView.backgroundColor = .WhiteColor
        lowView.addCornerRadiusWithShadow(color: .clear, borderColor: .AppBorderColor, cornerRadius: 16)
        heightView.backgroundColor = .WhiteColor
        heightView.addCornerRadiusWithShadow(color: .clear, borderColor: .AppBorderColor, cornerRadius: 16)
        
    }
    
    
    
    @IBAction func didTapOnLowToHeighBtnAction(_ sender: Any) {
        lowView.backgroundColor = .NavBackColor
        lowlbl.textColor = .WhiteColor
        heightView.backgroundColor = .WhiteColor
        heighlbl.textColor = HexColor("#27272A")
        
        delegate?.didTapOnLowToHeighBtnAction(cell: self)
    }
    
    
    
    @IBAction func didTapOnHeighToLowBtnAction(_ sender: Any) {
        
        heightView.backgroundColor = .NavBackColor
        heighlbl.textColor = .WhiteColor
        lowView.backgroundColor = .WhiteColor
        lowlbl.textColor = HexColor("#27272A")
        
        delegate?.didTapOnHeighToLowBtnAction(cell: self)
    }
    
    
}

