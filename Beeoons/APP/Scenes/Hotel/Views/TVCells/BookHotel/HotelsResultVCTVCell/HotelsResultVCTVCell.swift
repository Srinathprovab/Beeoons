//
//  HotelsResultVCTVCell.swift
//  Beeoons
//
//  Created by FCI on 29/09/23.
//

import UIKit

protocol HotelsResultVCTVCellDelegate {
    func didTapOnHotelDetailsBtnAction(cell:HotelsResultVCTVCell)
    func didTapOnCancellationBtnAction(cell:HotelsResultVCTVCell)
}



class HotelsResultVCTVCell: TableViewCell {
    
    @IBOutlet weak var hotelNamelbl: UILabel!
    @IBOutlet weak var hotelImg: UIImageView!
    @IBOutlet weak var pricelbl: UILabel!
    @IBOutlet weak var addresslbl: UILabel!
    @IBOutlet weak var noofAdultslbl: UILabel!
    @IBOutlet weak var refundtypelbl: UILabel!
    @IBOutlet weak var fromlbl: UILabel!
    @IBOutlet weak var tolbl: UILabel!
    
    
    var hotelid = String()
    var delegate:HotelsResultVCTVCellDelegate?
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
        hotelNamelbl.text = cellInfo?.title
        hotelImg.sd_setImage(with: URL(string: cellInfo?.image ?? ""), placeholderImage:UIImage(contentsOfFile:"placeholder.png"))
        pricelbl.text = "\(defaults.string(forKey: UserDefaultsKeys.selectedCurrency) ?? "")\(cellInfo?.price ?? "")"
        refundtypelbl.text = cellInfo?.refundable
        if cellInfo?.refundable == "Refundable"{
            refundtypelbl.textColor = .TitleColor
        }else{
            refundtypelbl.textColor = .red
        }
        addresslbl.text = cellInfo?.subTitle
        noofAdultslbl.text = "\(cellInfo?.buttonTitle ?? "") Nights, \(defaults.string(forKey: UserDefaultsKeys.hoteladultscount) ?? "") Adults"
        fromlbl.text = "From: \(defaults.string(forKey: UserDefaultsKeys.checkin) ?? "")"
        tolbl.text = "To: \(defaults.string(forKey: UserDefaultsKeys.checkout) ?? "")"
        hotelid = cellInfo?.tempText ?? ""
    }
    
    
    func setupUI(){
        hotelImg.layer.cornerRadius = 4
        hotelImg.clipsToBounds = true
    }
    
    
    @IBAction func didTapOnHotelDetailsBtnAction(_ sender: Any) {
        delegate?.didTapOnHotelDetailsBtnAction(cell: self)
    }
    
    
    
    @IBAction func didTapOnCancellationBtnAction(_ sender: Any) {
        delegate?.didTapOnHotelDetailsBtnAction(cell: self)
    }
    
    
    
}
