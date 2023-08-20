//
//  BillingAddressTVCell.swift
//  Beeoons
//
//  Created by FCI on 18/08/23.
//

import UIKit


protocol BillingAddressTVCellDelegate {
    func didTapOnBillingAddressDropDownBtnAction(cell:BillingAddressTVCell)
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
    
    
    var countryname = String()
    var expandViewBool = true
    var delegate:BillingAddressTVCellDelegate?
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
        collapsView()
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
        txtField.addTarget(self, action: #selector(editingTextField1(textField:)), for: .editingChanged)
        txtField.textColor = .SubtitleColor
    }
    
    func setupView(v:UIView) {
        v.layer.borderWidth = 1
        v.layer.borderColor = UIColor.AppBorderColor.cgColor
    }
    
    
    
    @objc func editingTextField1(textField: UITextField) {
        switch textField.tag {
        case 1:
            print(textField.text)
            break
            
        case 6:
            print(textField.text)
            break
        default:
            break
        }
    }
    
    
    @IBAction func didTapOnBillingAddressDropDownBtnAction(_ sender: Any) {
        delegate?.didTapOnBillingAddressDropDownBtnAction(cell: self)
    }
    
    @IBAction func didTapOnCountryBtnAction(_ sender: Any) {
        print("didTapOnCountryBtnAction")
    }
    
    
    @IBAction func didTapOnStateBtnAction(_ sender: Any) {
        print("didTapOnStateBtnAction")
        
    }
    
    @IBAction func didTapOnCityBtnAction(_ sender: Any) {
        print("didTapOnCityBtnAction")
    }
    
    
    @IBAction func didTapOnCountryCodeBtn(_ sender: Any) {
        print("didTapOnCountryCodeBtn")
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
