//
//  UserNameTextFieldTVCell.swift
//  Beeoons
//
//  Created by FCI on 12/08/23.
//

import UIKit
import DropDown


protocol UserNameTextFieldTVCellDelegate {
    func editingTextField(tf:UITextField)
    func didTapOnCountryCodeBtnAction(cell:UserNameTextFieldTVCell)
    func donedatePicker(cell:UserNameTextFieldTVCell)
    func cancelDatePicker(cell:UserNameTextFieldTVCell)
}

class UserNameTextFieldTVCell: TableViewCell {
    
    
    @IBOutlet weak var countryCodeView: UIView!
    @IBOutlet weak var countryCodelbl: UILabel!
    @IBOutlet weak var txtField: UITextField!
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var textFieldHolderView: UIStackView!
    
    
    var maxLength = 8
    var cname = String()
    var countryCode = String()
    var countryNames = [String]()
    var countrycodesArray = [String]()
    var originArray = [String]()
    var isocountrycodeArray = [String]()
    var filterdcountrylist = [Country_list]()
    
    var dropDown = DropDown()
    let datePicker = UIDatePicker()
    var delegate:UserNameTextFieldTVCellDelegate?
    
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
        txtField.text = cellInfo?.subTitle
        countryCodeView.isHidden = true
        dropDown.hide()
        datePicker.isHidden = true
    }
    
    
    
    override func updateUI() {
        titlelbl.text = cellInfo?.title ?? ""
        txtField.text = cellInfo?.subTitle ?? ""
        txtField.placeholder = cellInfo?.buttonTitle
        txtField.tag = cellInfo?.characterLimit ?? 0
        txtField.setLeftPaddingPoints(12)
        
        
        switch cellInfo?.key {
            
        case "mobile":
            countryCodeView.isHidden = false
           // setupDropDown()
            break
            
        case "dob":
            datePicker.isHidden = false
            break
            
       
            
        default:
            break
        }
        
        if cellInfo?.key1 == "noedit" {
            textFieldHolderView.isUserInteractionEnabled = false
            textFieldHolderView.alpha = 0.5
        }else {
            textFieldHolderView.isUserInteractionEnabled = true
            textFieldHolderView.alpha = 1
        }
        
        if cellInfo?.title == "Email Address" || cellInfo?.title == "Mobile Number"{
            textFieldHolderView.isUserInteractionEnabled = false
            textFieldHolderView.alpha = 0.5
        }
        
        if txtField.tag == 5 {
            showDatePicker()
        }
        
    }
    
    
    func setupUI() {
        textFieldHolderView.layer.borderWidth = 1
        textFieldHolderView.layer.borderColor = UIColor.AppBorderColor.cgColor
        countryCodeView.layer.borderWidth = 1
        countryCodeView.layer.borderColor = UIColor.AppBorderColor.cgColor
        datePicker.isHidden = true
        countryCodeView.isHidden = true
        txtField.addTarget(self, action: #selector(editingTextField(_:)), for: .editingChanged)
       
    }
    
    
    
    @objc func editingTextField(_ textfield:UITextField) {
        delegate?.editingTextField(tf: textfield)
    }
    
//    func setupDropDown() {
//
//        dropDown.direction = .bottom
//        dropDown.backgroundColor = .WhiteColor
//        dropDown.anchorView = self.countryCodeView
//        dropDown.bottomOffset = CGPoint(x: 0, y: countryCodeView.frame.size.height + 10)
//        dropDown.selectionAction = { [weak self] (index: Int, item: String) in
//
//
//            self?.countryCodelbl.text = self?.countrycodesArray[index] ?? ""
//            self?.cname = self?.countryNames[index] ?? ""
//            self?.txtField.text = ""
//            self?.txtField.becomeFirstResponder()
//            self?.delegate?.didTapOnCountryCodeBtnAction(cell: self!)
//
//        }
//    }
//
//
//    func loadCountryNamesAndCode(){
//        countryNames.removeAll()
//        countrycodesArray.removeAll()
//        isocountrycodeArray.removeAll()
//        originArray.removeAll()
//
//        filterdcountrylist.forEach { i in
//            countryNames.append(i.name ?? "")
//            countrycodesArray.append(i.country_code ?? "")
//            isocountrycodeArray.append(i.iso_country_code ?? "")
//            originArray.append(i.origin ?? "")
//            print(i.name ?? "")
//        }
//
//        DispatchQueue.main.async {[self] in
//            dropDown.dataSource = countryNames
//        }
//    }
//
    
    
    
    func showDatePicker(){
        //Formate Date
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        
        //ToolBar
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donedatePicker));
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker));
        
        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
        
        
        if txtField.tag == 5 {
            txtField.inputAccessoryView = toolbar
            txtField.inputView = datePicker
        }
        
        
    }
    
    
    @objc func donedatePicker(){
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        txtField.text = formatter.string(from: datePicker.date)
        delegate?.donedatePicker(cell: self)
    }
    
    @objc func cancelDatePicker(){
        delegate?.cancelDatePicker(cell: self)
    }
    
    @IBAction func didTapOnCountryCodeBtnAction(_ sender: Any) {
        dropDown.show()
    }
    
    
}




extension UserNameTextFieldTVCell {
    override func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        
        maxLength = 50
        
        let currentString: NSString = (textField.text ?? "") as NSString
        let newString: NSString =  currentString.replacingCharacters(in: range, with: string) as NSString
        
        return newString.length <= maxLength
    }
}
