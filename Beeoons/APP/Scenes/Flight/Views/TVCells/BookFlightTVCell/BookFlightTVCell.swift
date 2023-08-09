//
//  BookFlightTVCell.swift
//  Beeoons
//
//  Created by FCI on 09/08/23.
//

import UIKit

protocol BookFlightTVCellDelegate {
    func didTapOnFromCityBtnAction(cell:BookFlightTVCell)
    func didTapOnToCityBtnAction(cell:BookFlightTVCell)
    func didTapOnSelectDepartureDateBtnAction(cell:BookFlightTVCell)
    func didTapOnArrivalDateBtnAction(cell:BookFlightTVCell)
    func didTapOnSelectTravellersBtnAction(cell:BookFlightTVCell)
    func didTapOnSelectClassBtnAction(cell:BookFlightTVCell)
    func didTapOnAddAirlineButtonAction(cell:BookFlightTVCell)

}

class BookFlightTVCell: TableViewCell {
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var fromlbl: UILabel!
    @IBOutlet weak var tocitylbl: UILabel!
    @IBOutlet weak var departureDatelbl: UILabel!
    @IBOutlet weak var arrivalDatelbl: UILabel!
    @IBOutlet weak var travellerlbl: UILabel!
    @IBOutlet weak var classlbl: UILabel!
    @IBOutlet weak var addairlineView: UIView!
    @IBOutlet weak var airlineViewHeight: NSLayoutConstraint!
    @IBOutlet weak var addairlinelbl: UILabel!
    @IBOutlet weak var arrivalDateView: UIView!
    
    
    var tapairlinebool = true
    var delegate:BookFlightTVCellDelegate?
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
        let jt = defaults.string(forKey: UserDefaultsKeys.journeyType)
        if jt == "oneway" {
            arrivalDateView.isHidden = true
            
            if let fromstr = defaults.string(forKey: UserDefaultsKeys.fromCity) {
                if fromstr.isEmpty == true {
                    self.fromlbl.text = "From"
                    self.tocitylbl.text =  "To"
                }else {
                    self.fromlbl.text = defaults.string(forKey: UserDefaultsKeys.fromCity) ?? "From"
                    self.tocitylbl.text = defaults.string(forKey: UserDefaultsKeys.toCity) ?? "To"
                }
            }
            
            
            if let datestr1 = defaults.string(forKey: UserDefaultsKeys.calDepDate){
                if datestr1.isEmpty == true {
                    self.departureDatelbl.text =  "Departure Date"
                }
                if datestr1.isEmpty == false &&  datestr1.isEmpty == false{
                    self.departureDatelbl.text = defaults.string(forKey: UserDefaultsKeys.calDepDate) ?? ""
                }
            }
            
        }else {
            arrivalDateView.isHidden = false
            
            if let fromstr = defaults.string(forKey: UserDefaultsKeys.rfromCity) {
                if fromstr.isEmpty == true {
                    self.fromlbl.text = "From"
                    self.tocitylbl.text =  "To"
                }else {
                    self.fromlbl.text = defaults.string(forKey: UserDefaultsKeys.rfromCity) ?? "From"
                    self.tocitylbl.text = defaults.string(forKey: UserDefaultsKeys.rtoCity) ?? "To"
                }
            }
            
            
           
            
            if let datestr1 = defaults.string(forKey: UserDefaultsKeys.rcalDepDate), let datestr2 = defaults.string(forKey: UserDefaultsKeys.rcalRetDate){
                if datestr1.isEmpty == true {
                    self.departureDatelbl.text =  "Departure Date"
                    //cell.returnlbl.text =  "Select Date"
                }
                
                if datestr2.isEmpty == true{
                    //cell.deplbl.text =  "Select Date"
                    arrivalDatelbl.text =  "Arrival Date"
                }
                
                if datestr1.isEmpty == false &&  datestr1.isEmpty == false{
                    self.departureDatelbl.text = defaults.string(forKey: UserDefaultsKeys.rcalDepDate) ?? ""
                    self.arrivalDatelbl.text = defaults.string(forKey: UserDefaultsKeys.rcalRetDate) ?? ""
                }
            }
            
            
            
        }
        
        
        
    }
    
    
    func setupUI() {
        holderView.layer.borderWidth = 1
        holderView.layer.borderColor = UIColor.WhiteColor.cgColor
        airlineViewHeight.constant = 40
        addairlineView.isHidden = true
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
    
    @IBAction func didTapOnArrivalDateBtnAction(_ sender: Any) {
        delegate?.didTapOnArrivalDateBtnAction(cell: self)
    }
    
    @IBAction func didTapOnSelectTravellersBtnAction(_ sender: Any) {
        delegate?.didTapOnSelectTravellersBtnAction(cell: self)
    }
    
    @IBAction func didTapOnSelectClassBtnAction(_ sender: Any) {
        delegate?.didTapOnSelectClassBtnAction(cell: self)
    }
    
    
    @IBAction func didTapOnAddAirlineButtonAction(_ sender: Any) {
        if tapairlinebool == true {
            airlineViewHeight.constant = 100
            addairlineView.isHidden = false
            addairlinelbl.text = "- Add Airline"
            tapairlinebool = false
        }else {
            airlineViewHeight.constant = 40
            addairlineView.isHidden = true
            addairlinelbl.text = "+ Add Airline"
            tapairlinebool = true
        }
        delegate?.didTapOnAddAirlineButtonAction(cell: self)
    }
    
    
}
