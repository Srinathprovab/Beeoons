//
//  BookHotelTVCell.swift
//  Beeoons
//
//  Created by FCI on 29/09/23.
//

import UIKit

protocol BookHotelTVCellDelegate {
    func didTapOnSelectHotelCityBtnAction(cell:BookHotelTVCell)
    func didTapOnCheckInBtnAction(cell:BookHotelTVCell)
    func didTapOnCheckOutBtnAction(cell:BookHotelTVCell)
    func didTapOnAddRoomBtnAction(cell:BookHotelTVCell)
    func didTapOnSearchHotelBtnAction(cell:BookHotelTVCell)
}

class BookHotelTVCell: TableViewCell {
    
    
    @IBOutlet weak var cityhotelNamelbl: UILabel!
    @IBOutlet weak var checkinlbl: UILabel!
    @IBOutlet weak var checkoutlbl: UILabel!
    @IBOutlet weak var roomlbl: UILabel!
    
    
    
    
    var delegate:BookHotelTVCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    override func updateUI() {
        cityhotelNamelbl.text = defaults.string(forKey: UserDefaultsKeys.locationcity) ?? "Enter destination, city Hotel name"
        checkinlbl.text = defaults.string(forKey: UserDefaultsKeys.checkin) ?? "Check in"
        checkoutlbl.text = defaults.string(forKey: UserDefaultsKeys.checkout) ?? "Check out"
        roomlbl.text = defaults.string(forKey: UserDefaultsKeys.selectPersons) ?? ""
    }
    
    
    
    
    @IBAction func didTapOnSelectHotelCityBtnAction(_ sender: Any) {
        delegate?.didTapOnSelectHotelCityBtnAction(cell: self)
    }
    
    
    @IBAction func didTapOnCheckInBtnAction(_ sender: Any) {
        delegate?.didTapOnCheckInBtnAction(cell: self)
    }
    
    
    
    @IBAction func didTapOnCheckOutBtnAction(_ sender: Any) {
        delegate?.didTapOnCheckOutBtnAction(cell: self)
    }
    
    
    
    @IBAction func didTapOnAddRoomBtnAction(_ sender: Any) {
        delegate?.didTapOnAddRoomBtnAction(cell: self)
    }
    
    
    @IBAction func didTapOnSearchHotelBtnAction(_ sender: Any) {
        delegate?.didTapOnSearchHotelBtnAction(cell: self)
    }
    
    
}



