//
//  AddcityTVCell.swift
//  Beeoons
//
//  Created by FCI on 15/08/23.
//

import UIKit

protocol AddcityTVCellDelegate {
    func didTapOnFromCityBtnAction(cell:AddcityTVCell)
    func didTapOnToCityBtnAction(cell:AddcityTVCell)
    func didTapOnSelectDepartureDateBtnAction(cell:AddcityTVCell )
    func didTapOnDeleteCityBtn(cell: AddcityTVCell)
    
}

class AddcityTVCell: UITableViewCell {
    
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var fromlbl: UILabel!
    @IBOutlet weak var tocitylbl: UILabel!
    @IBOutlet weak var departureDatelbl: UILabel!
    @IBOutlet weak var fromView: UIView!
    @IBOutlet weak var toView: UIView!
    @IBOutlet weak var depView: UIView!
    @IBOutlet weak var fromCityBtn: UIButton!
    @IBOutlet weak var toCityBtn: UIButton!
    @IBOutlet weak var depDateBtn: UIButton!
    @IBOutlet weak var deleteView: UIView!
    @IBOutlet weak var deleteBtn: UIButton!
    @IBOutlet weak var deleteBtnwidth: NSLayoutConstraint!
    
    
    var delegate:AddcityTVCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    override func prepareForReuse() {
        hideDeleteBtnView()
    }
    
    
    func setupUI(){
        hideDeleteBtnView()
    }
    
    func hideDeleteBtnView() {
        self.deleteView.isHidden = true
        deleteBtnwidth.constant = 0
    }
    
    func showDeleteBtnView() {
        self.deleteView.isHidden = false
        deleteBtnwidth.constant = 30
    }
    
    
    @IBAction func didTapOnFromCityBtnAction(_ sender: Any) {
        delegate?.didTapOnFromCityBtnAction(cell: self)
    }
    
    @IBAction func didTapOnToCityBtnAction(_ sender: Any) {
        delegate?.didTapOnToCityBtnAction(cell: self)
    }
    
    @IBAction func didTapOnSelectDepartureDateBtnAction(_ sender: Any) {
        delegate?.didTapOnSelectDepartureDateBtnAction(cell: self)
    }
    
    @IBAction func didTapOnDeleteCityBtn(_ sender: Any) {
        delegate?.didTapOnDeleteCityBtn(cell: self)
    }
    
    
    
}
