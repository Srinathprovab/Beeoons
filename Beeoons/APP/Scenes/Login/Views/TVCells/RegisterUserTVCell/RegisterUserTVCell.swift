//
//  RegisterUserTVCell.swift
//  Beeoons
//
//  Created by FCI on 11/08/23.
//

import UIKit
import DropDown

protocol RegisterUserTVCellDelegate {
    
    func editingText(tf:UITextField)
    func didTapOnRegisterBtnAction(cell:RegisterUserTVCell)
    func didTapOnLoginBtnAction(cell:RegisterUserTVCell)
    func didTapOnCountryCodeBtnAction(cell:RegisterUserTVCell)
    
}

class RegisterUserTVCell: TableViewCell {
    
    
    @IBOutlet weak var fnameTF: UITextField!
    @IBOutlet weak var lnameTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var mobileTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var countryCodeTF: UITextField!
    @IBOutlet weak var fnameerrorlbl: UILabel!
    @IBOutlet weak var lnameerrorlbl: UILabel!
    @IBOutlet weak var emailerrorlbl: UILabel!
    @IBOutlet weak var mobileErrorlbl: UILabel!
    @IBOutlet weak var passworderrorlbl: UILabel!
    @IBOutlet weak var hidepassImg: UIImageView!
    
    
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
    var delegate: RegisterUserTVCellDelegate?
    
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
        
        fnameTF.addTarget(self, action: #selector(editingText(textField:)), for: .editingChanged)
        fnameTF.delegate = self
        lnameTF.addTarget(self, action: #selector(editingText(textField:)), for: .editingChanged)
        lnameTF.delegate = self
        emailTF.addTarget(self, action: #selector(editingText(textField:)), for: .editingChanged)
        emailTF.delegate = self
        mobileTF.addTarget(self, action: #selector(editingText(textField:)), for: .editingChanged)
        mobileTF.delegate = self
        passwordTF.addTarget(self, action: #selector(editingText(textField:)), for: .editingChanged)
        passwordTF.delegate = self
        passwordTF.isSecureTextEntry = true
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
            fnameerrorlbl.text = ""
            break
            
        case 2:
            lnameerrorlbl.text = ""
            break
            
        case 3:
            emailerrorlbl.text = ""
            break
            
        case 4:
            mobileErrorlbl.text = ""
            break
            
        case 5:
            passworderrorlbl.text = ""
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
    
    
    @IBAction func didTapOnRegisterBtnAction(_ sender: Any) {
        delegate?.didTapOnRegisterBtnAction(cell: self)
    }
    
    @IBAction func didTapOnLoginBtnAction(_ sender: Any) {
        delegate?.didTapOnLoginBtnAction(cell: self)
    }
    
    @IBAction func didTapOnCountryCodeBtnAction(_ sender: Any) {
        dropDown.show()
    }
    
    
    @IBAction func didTapOnShowPassBtnAction(_ sender: Any) {
        if showPassBool == true {
            hidepassImg.image = UIImage(named: "showpass")?.withRenderingMode(.alwaysOriginal)
            passwordTF.isSecureTextEntry = false
            showPassBool = false
        }else {
            hidepassImg.image = UIImage(named: "hidepass")?.withRenderingMode(.alwaysOriginal)
            passwordTF.isSecureTextEntry = true
            showPassBool = true
        }
    }
    
    
}



extension RegisterUserTVCell {
    
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
            maxLength = 25
            let currentString: NSString = textField.text! as NSString
            let newString: NSString =  currentString.replacingCharacters(in: range, with: string) as NSString
            return newString.length <= maxLength
        }
        //  return true
    }
    
    
}
