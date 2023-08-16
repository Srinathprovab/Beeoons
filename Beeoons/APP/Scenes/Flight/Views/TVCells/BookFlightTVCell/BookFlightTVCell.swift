//
//  BookFlightTVCell.swift
//  Beeoons
//
//  Created by FCI on 09/08/23.
//

import UIKit
import DropDown

protocol BookFlightTVCellDelegate {
    func didTapOnFromCityBtnAction(cell:BookFlightTVCell)
    func didTapOnToCityBtnAction(cell:BookFlightTVCell)
    func didTapOnSelectDepartureDateBtnAction(cell:BookFlightTVCell)
    func didTapOnArrivalDateBtnAction(cell:BookFlightTVCell)
    func didTapOnSelectTravellersBtnAction(cell:BookFlightTVCell)
    func didTapOnSelectClassBtnAction(cell:BookFlightTVCell)
    func didTapOnAddAirlineButtonAction(cell:BookFlightTVCell)
    func didTapOnSearchFlightBtnAction(cell:BookFlightTVCell)
    func didTapOnAirLineDropDownBtn(cell:BookFlightTVCell)
    
    func editingTextField(tf:UITextField)
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
    @IBOutlet weak var classView: UIView!
    @IBOutlet weak var fromView: UIView!
    @IBOutlet weak var toView: UIView!
    @IBOutlet weak var depView: UIView!
    @IBOutlet weak var retView: UIView!
    @IBOutlet weak var airlinelbl: UILabel!
    @IBOutlet weak var airlineTF: UITextField!
    
    
    
    var cname = String()
    var countryCode = String()
    var countryNames = [String]()
    var isSearchBool = Bool()
    var searchText = String()
    var filterdcountrylist = [Airline_list]()
    let dropDown = DropDown()
    let airlinedropDown = DropDown()
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
        filterdcountrylist = airlinelist1
        loadCountryNamesAndCode()
        
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
            
            self.travellerlbl.text = "\(defaults.string(forKey: UserDefaultsKeys.travellerDetails) ?? "Traveller(s)")"
            self.classlbl.text = "\(defaults.string(forKey: UserDefaultsKeys.selectClass) ?? "Class")"
            
            
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
            
            
            self.travellerlbl.text = "\(defaults.string(forKey: UserDefaultsKeys.rtravellerDetails) ?? "Traveller(s)")"
            self.classlbl.text = "\(defaults.string(forKey: UserDefaultsKeys.rselectClass) ?? "Class")"
            
            
        }
        
        
        
    }
    
    func loadCountryNamesAndCode(){
        countryNames.removeAll()
        
        filterdcountrylist.forEach { i in
            countryNames.append(i.name ?? "")
        }
        
        DispatchQueue.main.async {[self] in
            airlinedropDown.dataSource = countryNames
        }
    }
    
    
    func setupUI() {
        holderView.layer.borderWidth = 1
        holderView.layer.borderColor = UIColor.WhiteColor.cgColor
        airlineViewHeight.constant = 40
        addairlineView.isHidden = true
        setupAirlineDropDown()
        setupDropDown()
        
        setuptf(tf: airlineTF, tag1: 333, leftpadding: 0, font: .OswaldRegular(size: 16), placeholder: "Kuwait")
        airlineTF.addTarget(self, action: #selector(searchTextChanged(textField:)), for: .editingChanged)
        airlineTF.addTarget(self, action: #selector(searchTextBegin(textField:)), for: .editingDidBegin)
       
    }
    
    
    
   
    
    
    
    func setupDropDown() {
        
        dropDown.dataSource = ["Economy","PremimumEconomy","Business","First"]
        dropDown.textFont = .OswaldLight(size: 16)
        dropDown.direction = .bottom
        dropDown.backgroundColor = .WhiteColor
        dropDown.anchorView = self.classView
        dropDown.bottomOffset = CGPoint(x: 0, y: classView.frame.size.height + 10)
        dropDown.selectionAction = { [weak self] (index: Int, item: String) in
            
            let jt = defaults.string(forKey: UserDefaultsKeys.journeyType)
            if jt == "oneway" {
                self?.classlbl.text = item
                defaults.set(self?.classlbl.text, forKey: UserDefaultsKeys.selectClass)
            }else {
                self?.classlbl.text = item
                defaults.set(self?.classlbl.text, forKey: UserDefaultsKeys.rselectClass)
            }
            
        }
    }
    
    
    
    func setupAirlineDropDown() {
        
        airlinedropDown.direction = .bottom
       
        airlinedropDown.backgroundColor = .WhiteColor
        airlinedropDown.anchorView = self.addairlineView
        airlinedropDown.bottomOffset = CGPoint(x: 0, y: self.addairlineView.frame.size.height + 10)
        airlinedropDown.selectionAction = { [weak self] (index: Int, item: String) in
            
            self?.airlinelbl.text = self?.countryNames[index] ?? ""
            self?.airlineTF.text = ""
            self?.airlineTF.resignFirstResponder()
            self?.delegate?.didTapOnAirLineDropDownBtn(cell: self!)
            
        }
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
        //delegate?.didTapOnSelectClassBtnAction(cell: self)
        dropDown.show()
    }
    
    
    @IBAction func didTapOnAddAirlineButtonAction(_ sender: Any) {
        if tapairlinebool == true {
            airlineViewHeight.constant = 100
            addairlineView.isHidden = false
            addairlinelbl.text = "- Add Airline"
            tapairlinebool = false
            airlineTF.becomeFirstResponder()
        }else {
            airlineViewHeight.constant = 40
            addairlineView.isHidden = true
            addairlinelbl.text = "+ Add Airline"
            tapairlinebool = true
            airlineTF.resignFirstResponder()
        }
        delegate?.didTapOnAddAirlineButtonAction(cell: self)
    }
    
    
    
    @IBAction func didTapOnSearchFlightBtnAction(_ sender: Any) {
        delegate?.didTapOnSearchFlightBtnAction(cell: self)
    }
    
    
    
    @IBAction func didTapOnAirLineDropDownBtn(_ sender: Any) {
        airlinedropDown.show()
    }
    
    
    
    
    func setuptf(tf:UITextField,tag1:Int,leftpadding:Int,font:UIFont,placeholder:String){
        tf.backgroundColor = .clear
        tf.placeholder = ""
        tf.setLeftPaddingPoints(CGFloat(leftpadding))
        tf.font = font
        tf.tag = tag1
        tf.delegate = self
        tf.addTarget(self, action: #selector(editingText(textField:)), for: .editingChanged)
    }
    
    @objc func editingText(textField:UITextField) {
        self.airlinelbl.text = ""
        delegate?.editingTextField(tf: textField)
    }
    
    
    
    @objc func searchTextBegin(textField: UITextField) {
        textField.text = ""
        filterdcountrylist.removeAll()
        filterdcountrylist = airlinelist1
        loadCountryNamesAndCode()
        airlinedropDown.show()
    }
    
    
    @objc func searchTextChanged(textField: UITextField) {
        searchText = textField.text ?? ""
        if searchText == "" {
            isSearchBool = false
            filterContentForSearchText(searchText)
        }else {
            isSearchBool = true
            filterContentForSearchText(searchText)
        }
        
        
    }
    
    func filterContentForSearchText(_ searchText: String) {
        print("Filterin with:", searchText)
        
        filterdcountrylist.removeAll()
        filterdcountrylist = airlinelist1.filter { thing in
            return "\(thing.name?.lowercased() ?? "")".contains(searchText.lowercased())
        }
        
        loadCountryNamesAndCode()
        airlinedropDown.show()
        
    }
    
    
}


extension BookFlightTVCell {
    
    //MARK - UITextField Delegates
    override func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        var maxLength = 50
        let currentString: NSString = textField.text! as NSString
        let newString: NSString =  currentString.replacingCharacters(in: range, with: string) as NSString
        return newString.length <= maxLength
        
    }
    
    
}
