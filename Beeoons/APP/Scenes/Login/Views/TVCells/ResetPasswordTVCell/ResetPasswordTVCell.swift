//
//  ResetPasswordTVCell.swift
//  Beeoons
//
//  Created by FCI on 19/08/23.
//

import UIKit
import DropDown

protocol ResetPasswordTVCellDelegate {
    
    func editingText(tf:UITextField)
    func didTapOnResetPassswordBtnAction(cell:ResetPasswordTVCell)
    func didTapOnCountryCodeBtnAction(cell:ResetPasswordTVCell)
    
}


class ResetPasswordTVCell: TableViewCell {
    
    
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var mobileTF: UITextField!
    @IBOutlet weak var emailerrorlbl: UILabel!
    @IBOutlet weak var mobileErrorlbl: UILabel!
    @IBOutlet weak var countryCodeTF: UITextField!
    
    
    var showPassBool = true
    var dropDown = DropDown()
    var maxLength = 8
    var cname = String()
    var countryCode = String()
    var countryNames = [String]()
    var countrycodesArray = [String]()
    var originArray = [String]()
    var isocountrycodeArray = [String]()
    var filterdcountrylist = [Country_list]()
    var delegate: ResetPasswordTVCellDelegate?
    
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
        filterdcountrylist = countrylist
        loadCountryNamesAndCode()
    }
    
    
    func setupUI() {
        
        
        emailTF.addTarget(self, action: #selector(editingText(textField:)), for: .editingChanged)
        emailTF.delegate = self
        mobileTF.addTarget(self, action: #selector(editingText(textField:)), for: .editingChanged)
        mobileTF.delegate = self
        
        setupDropDown()
    }
    
    @objc func editingText(textField:UITextField) {
        
        
        if textField == mobileTF {
            if let text = textField.text {
                let length = text.count
                if length != maxLength {
                    mobilenoMaxLengthBool = false
                }else{
                    mobilenoMaxLengthBool = true
                }
                
            } else {
                mobilenoMaxLengthBool = false
            }
        }
        
        
        
        switch textField.tag {
            
            
        case 1:
            emailerrorlbl.text = ""
            break
            
        case 2:
            mobileErrorlbl.text = ""
            break
            
            
            
        default:
            break
        }
        delegate?.editingText(tf: textField)
    }
    
    
    
    
    func setupDropDown() {
        
        dropDown.direction = .bottom
        dropDown.backgroundColor = .WhiteColor
        dropDown.anchorView = self.countryCodeTF
        dropDown.bottomOffset = CGPoint(x: 0, y: countryCodeTF.frame.size.height + 10)
        dropDown.selectionAction = { [weak self] (index: Int, item: String) in
            
            
            self?.countryCodeTF.text = self?.countrycodesArray[index] ?? ""
            self?.countryCodeTF.resignFirstResponder()
            self?.countryCode = self?.countrycodesArray[index] ?? ""
            self?.cname = self?.countryNames[index] ?? ""
            self?.mobileTF.text = ""
            self?.mobileTF.becomeFirstResponder()
            
            self?.delegate?.didTapOnCountryCodeBtnAction(cell: self!)
            
        }
    }
    
    
    func loadCountryNamesAndCode(){
        countryNames.removeAll()
        countrycodesArray.removeAll()
        isocountrycodeArray.removeAll()
        originArray.removeAll()
        
        filterdcountrylist.forEach { i in
            countryNames.append(i.name ?? "")
            countrycodesArray.append(i.country_code ?? "")
            isocountrycodeArray.append(i.iso_country_code ?? "")
            originArray.append(i.origin ?? "")
            print(i.name ?? "")
        }
        
        DispatchQueue.main.async {[self] in
            dropDown.dataSource = countryNames
        }
    }
    
    
    @IBAction func didTapOnResetPassswordBtnAction(_ sender: Any) {
        delegate?.didTapOnResetPassswordBtnAction(cell: self)
    }
    
    
    @IBAction func didTapOnCountryCodeBtnAction(_ sender: Any) {
        dropDown.show()
    }
    
    
}



extension ResetPasswordTVCell {
    
    //MARK - UITextField Delegates
    override func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        //For mobile numer validation
        if textField == mobileTF {
            
            maxLength = self.cname.getMobileNumberMaxLength() ?? 8
            
            let currentString: NSString = textField.text! as NSString
            let newString: NSString =  currentString.replacingCharacters(in: range, with: string) as NSString
            
            let allowedCharacters = CharacterSet(charactersIn:"+0123456789 ")//Here change this characters based on your requirement
            let characterSet = CharacterSet(charactersIn: string)
            return allowedCharacters.isSuperset(of: characterSet) && newString.length <= maxLength
            
        }else {
            maxLength = 50
            let currentString: NSString = textField.text! as NSString
            let newString: NSString =  currentString.replacingCharacters(in: range, with: string) as NSString
            return newString.length <= maxLength
        }
        //  return true
    }
    
    
}
