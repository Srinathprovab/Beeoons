//
//  BillingAddressTVCell.swift
//  Beeoons
//
//  Created by FCI on 18/08/23.
//

import UIKit
import DropDown


protocol BillingAddressTVCellDelegate {
    func didTapOnBillingAddressDropDownBtnAction(cell:BillingAddressTVCell)
    func didTapOnSelectCountryBtnAction(cell:BillingAddressTVCell)
    func didTapOnSelectStateBtnAction(cell:BillingAddressTVCell)
    func didTapOnSelectCityBtnAction(cell:BillingAddressTVCell)
    func didTapOnMobileCountryCodeBtnAction(cell:BillingAddressTVCell)
    func editingTextField(tf:UITextField)
}

class BillingAddressTVCell: TableViewCell {
    
    
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var tfholderView: UIView!
    @IBOutlet weak var viewHeight: NSLayoutConstraint!
    @IBOutlet weak var dropdownimg: UIImageView!
    @IBOutlet weak var streetView: UIView!
    @IBOutlet weak var streetTF: UITextField!
    @IBOutlet weak var apartmentView: UIView!
    @IBOutlet weak var apartmentTF: UITextField!
    @IBOutlet weak var countryView: UIView!
    @IBOutlet weak var countryTF: UITextField!
    @IBOutlet weak var stateView: UIView!
    @IBOutlet weak var stateTF: UITextField!
    @IBOutlet weak var cityView: UIView!
    @IBOutlet weak var cityTF: UITextField!
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var mobileView: UIView!
    @IBOutlet weak var mobileTF: UITextField!
    @IBOutlet weak var countrycodeTF: UITextField!
    @IBOutlet weak var postalcodeView: UIView!
    @IBOutlet weak var postalcodeTF: UITextField!
    
    
    var countrycodesArray = [String]()
    var originArray = [String]()
    var isocountrycodeArray = [String]()
    var countryNames = [String]()
    var countryCodes = [String]()
    var stateNames = [String]()
    var citynames = [String]()
    var countryname = String()
    var expandViewBool = true
    var payload = [String:Any]()
    var countryDropdown = DropDown()
    var statesDropdown = DropDown()
    var citysDropdown = DropDown()
    var mobileCountryCodeDropDown = DropDown()
    var vm:GetCountrySelectViewModel?
    var delegate:BillingAddressTVCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
        vm = GetCountrySelectViewModel(self)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    override func prepareForReuse() {
        collapsView()
    }
    
    override func updateUI() {
        
      
        DispatchQueue.main.async {
            self.callCountryListAPI()
        }
        
        DispatchQueue.main.async {
            self.loadCountryNamesAndCode()
        }
        
        emailTF.text = cellInfo?.title ?? ""
        mobileTF.text = cellInfo?.subTitle ?? ""
        countrycodeTF.text = cellInfo?.buttonTitle ?? ""
        
    }
    
    func setupUI() {
        
        setupView(v: holderView)
        setupView(v: streetView)
        setupView(v: apartmentView)
        setupView(v: countryView)
        setupView(v: stateView)
        setupView(v: cityView)
        setupView(v: mobileView)
        setupView(v: postalcodeView)
        setupView(v: emailView)
        
        setupTextField(txtField: streetTF)
        setupTextField(txtField: apartmentTF)
        setupTextField(txtField: countryTF)
        setupTextField(txtField: stateTF)
        setupTextField(txtField: cityTF)
        setupTextField(txtField: emailTF)
        setupTextField(txtField: countrycodeTF)
        setupTextField(txtField: mobileTF)
        setupTextField(txtField: postalcodeTF)
        setupTextField(txtField: emailTF)
        
        
        collapsView()
        
        setupCountryDropdown()
        setupStatesDropdown()
        setupCitysDropdown()
        setupMobileCodeDropdown()
    }
    
    
    func expandView() {
        dropdownimg.image = UIImage(named: "dropup")?.withRenderingMode(.alwaysOriginal).withTintColor(.TitleColor)
        tfholderView.isHidden = false
        viewHeight.constant = 260
    }
    
    
    func collapsView() {
        dropdownimg.image = UIImage(named: "down")?.withRenderingMode(.alwaysOriginal).withTintColor(.TitleColor)
        tfholderView.isHidden = true
        viewHeight.constant = 0
    }
    
    
    func setupTextField(txtField:UITextField) {
        txtField.setLeftPaddingPoints(15)
        txtField.delegate = self
        txtField.backgroundColor = .clear
        txtField.font = UIFont.OswaldRegular(size: 14)
        txtField.addTarget(self, action: #selector(editingTextField(textField:)), for: .editingChanged)
        txtField.textColor = .SubtitleColor
    }
    
    func setupView(v:UIView) {
        v.layer.borderWidth = 1
        v.layer.borderColor = UIColor.UnselectedBtnColor.cgColor
    }
    
    
    
    @objc func editingTextField(textField: UITextField) {
        switch textField {
        case streetTF:
            streetView.layer.borderColor = UIColor.UnselectedBtnColor.cgColor
            break
            
        case streetTF:
            streetView.layer.borderColor = UIColor.UnselectedBtnColor.cgColor
            break
            
        case apartmentTF:
            apartmentView.layer.borderColor = UIColor.UnselectedBtnColor.cgColor
            break
            
        case countryTF:
            countryView.layer.borderColor = UIColor.UnselectedBtnColor.cgColor
            break
            
        case stateTF:
            stateView.layer.borderColor = UIColor.UnselectedBtnColor.cgColor
            break
            
        case cityTF:
            cityView.layer.borderColor = UIColor.UnselectedBtnColor.cgColor
            break
            
        case postalcodeTF:
            postalcodeView.layer.borderColor = UIColor.UnselectedBtnColor.cgColor
            break
            
            
        case emailTF:
            emailView.layer.borderColor = UIColor.UnselectedBtnColor.cgColor
            break
            
            
        case mobileTF:
            mobileView.layer.borderColor = UIColor.UnselectedBtnColor.cgColor
            break
            
            
        case countryTF:
            mobileView.layer.borderColor = UIColor.UnselectedBtnColor.cgColor
            break
            
            
        default:
            break
        }
        
        
        delegate?.editingTextField(tf: textField)
    }
    
    
    @IBAction func didTapOnBillingAddressDropDownBtnAction(_ sender: Any) {
        delegate?.didTapOnBillingAddressDropDownBtnAction(cell: self)
    }
    
    @IBAction func didTapOnCountryBtnAction(_ sender: Any) {
        countryDropdown.show()
    }
    
    
    @IBAction func didTapOnStateBtnAction(_ sender: Any) {
        statesDropdown.show()
    }
    
    @IBAction func didTapOnCityBtnAction(_ sender: Any) {
        citysDropdown.show()
    }
    
    
    @IBAction func didTapOnCountryCodeBtn(_ sender: Any) {
        mobileCountryCodeDropDown.show()
    }
    
}





extension BillingAddressTVCell : GetCountryListViewModelProtocal{
    
    
    //MARK: - loadCountryNamesAndCode
    
    func loadCountryNamesAndCode(){
        countryNames.removeAll()
        countrycodesArray.removeAll()
        isocountrycodeArray.removeAll()
        originArray.removeAll()
        
        countrylist.forEach { i in
            countryNames.append(i.name ?? "")
            countrycodesArray.append(i.country_code ?? "")
            isocountrycodeArray.append(i.iso_country_code ?? "")
            originArray.append(i.origin ?? "")
            
        }
        
        DispatchQueue.main.async {[self] in
            mobileCountryCodeDropDown.dataSource = countryNames
        }
    }
    
    
    
    func setupMobileCodeDropdown() {
        mobileCountryCodeDropDown.direction = .bottom
        mobileCountryCodeDropDown.backgroundColor = .WhiteColor
        mobileCountryCodeDropDown.anchorView = self.countrycodeTF
        mobileCountryCodeDropDown.bottomOffset = CGPoint(x: 0, y: countrycodeTF.frame.size.height + 10)
        mobileCountryCodeDropDown.selectionAction = { [weak self] (index: Int, item: String) in
            self?.countrycodeTF.text = self?.countrycodesArray[index]
            self?.delegate?.didTapOnMobileCountryCodeBtnAction(cell: self!)
            
        }
        
    }
    
    //MARK: - callCountryListAPI countryList setupCountryDropdown
    func callCountryListAPI() {
        vm?.CALL_GET_COUNTRY_SELECT_API(dictParam: [:])
    }
    
    func countryList(response: [GetCountrySelectModel]) {
        countryCodes.removeAll()
        countryNames.removeAll()
        response.forEach { i in
            countryCodes.append(i.country_ISO ?? "")
            countryNames.append(i.country_Name_EN ?? "")
        }
        countryDropdown.dataSource = countryNames
    }
    
    
    func setupCountryDropdown() {
        countryDropdown.direction = .bottom
        countryDropdown.backgroundColor = .WhiteColor
        countryDropdown.anchorView = self.countryView
        countryDropdown.bottomOffset = CGPoint(x: 0, y: countryView.frame.size.height + 10)
        countryDropdown.selectionAction = { [weak self] (index: Int, item: String) in
            self?.countryTF.text = self?.countryNames[index]
           
            
            DispatchQueue.main.async {
                self?.callSatesListAPI(inputStr: (self?.countryCodes[index])!)
            }
            
            self?.delegate?.didTapOnSelectCountryBtnAction(cell: self!)
        }
        
    }
    
    
    //MARK: - callSatesListAPI stateList setupStatesDropdown
    
    
    func callSatesListAPI(inputStr:String) {
        payload.removeAll()
        payload["country_ISO"] = inputStr
        vm?.CALL_GET_STATE_SELECT_API(dictParam: payload)
    }
    
    func stateList(response: GetStatesListModel) {
        response.data?.forEach({ i in
            stateNames.append(i.name ?? "")
        })
        
        statesDropdown.dataSource = stateNames
    }
    
    
    func setupStatesDropdown() {
        statesDropdown.direction = .bottom
        statesDropdown.backgroundColor = .WhiteColor
        statesDropdown.anchorView = self.stateView
        statesDropdown.bottomOffset = CGPoint(x: 0, y: stateView.frame.size.height + 10)
        statesDropdown.selectionAction = { [weak self] (index: Int, item: String) in
            self?.stateTF.text = self?.stateNames[index]
            self?.delegate?.didTapOnSelectStateBtnAction(cell: self!)
            
            DispatchQueue.main.async {
                self?.callCityListAPI(inputStr: (self?.stateNames[index])!)
            }
        }
        
    }
    
    
    
    
    //MARK: - callCityListAPI cityList setupCitysDropdown
    
    func callCityListAPI(inputStr:String) {
        payload.removeAll()
        payload["state_name"] = inputStr
        vm?.CALL_GET_CITY_SELECT_API(dictParam: payload)
    }
    
    
    func cityList(response: [GetCityListModel]) {
        response.forEach { i in
            citynames.append(i.city_Name_EN ?? "")
        }
        citysDropdown.dataSource = citynames
    }
    
    func setupCitysDropdown() {
        citysDropdown.direction = .bottom
        citysDropdown.backgroundColor = .WhiteColor
        citysDropdown.anchorView = self.cityView
        citysDropdown.bottomOffset = CGPoint(x: 0, y: cityView.frame.size.height + 10)
        citysDropdown.selectionAction = { [weak self] (index: Int, item: String) in
            self?.cityTF.text = self?.citynames[index]
            self?.delegate?.didTapOnSelectCityBtnAction(cell: self!)
        }
        
    }
    
    
    
}


extension BillingAddressTVCell {
    
    //MARK - UITextField Delegates
    override func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        //For mobile numer validation
        
        var maxLength = 50
        if textField == mobileTF {
            
            maxLength = self.countryname.getMobileNumberMaxLength() ?? 8
            
            let currentString: NSString = textField.text! as NSString
            let newString: NSString =  currentString.replacingCharacters(in: range, with: string) as NSString
            
            let allowedCharacters = CharacterSet(charactersIn:"+0123456789 ")//Here change this characters based on your requirement
            let characterSet = CharacterSet(charactersIn: string)
            return allowedCharacters.isSuperset(of: characterSet) && newString.length <= maxLength
            
        }else {
            
            let currentString: NSString = textField.text! as NSString
            let newString: NSString =  currentString.replacingCharacters(in: range, with: string) as NSString
            return newString.length <= maxLength
        }
        
    }
    
    
}
