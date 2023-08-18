//
//  ConrtactInfoVC.swift
//  Beeoons
//
//  Created by FCI on 17/08/23.
//

import UIKit

class ContactInfoVC: BaseTableVC {
    
    
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var totalPricelbl: UILabel!
    
    var tablerow = [TableRow]()
    static var newInstance: ContactInfoVC? {
        let storyboard = UIStoryboard(name: Storyboard.Flight.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? ContactInfoVC
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupUI()
    }
    
    
    
    
    func setupUI() {
        totalPricelbl.text = grandTotal
        bottomView.layer.borderWidth = 0.2
        bottomView.layer.borderColor = UIColor.UnselectedBtnColor.cgColor
        commonTableView.registerTVCells(["PrimaryContactInfoTVCell",
                                         "EmptyTVCell"])
        setupItineraryTVCells()
    }
    
    
    
    func setupItineraryTVCells() {
        tablerow.removeAll()
        
        tablerow.append(TableRow(height:10,cellType:.EmptyTVCell))
        tablerow.append(TableRow(cellType:.PrimaryContactInfoTVCell))
        tablerow.append(TableRow(height:50,cellType:.EmptyTVCell))
        
        commonTVData = tablerow
        commonTableView.reloadData()
    }
    
    
    
    //MARK: - PrimaryContactInfoTVCell
    override func didTapOnCountryCodeBtn(cell: PrimaryContactInfoTVCell) {
        billingCountryCode = cell.billingCountryCode
        billingCountryName = cell.billingCountryName
        countryCode = cell.countryCodeLbl.text ?? ""
    }
    
    
    override func didTapOnDropDownBtn(cell: PrimaryContactInfoTVCell) {
        billingCountryCode = cell.billingCountryCode
        billingCountryName = cell.billingCountryName
        countryCode = cell.countryCodeLbl.text ?? ""
    }
    
    
    @objc func didTapOnBackBtnAction(_ sender:UIButton) {
        callapibool = false
        dismiss(animated: true)
    }
    
    
    override func editingTextField(tf:UITextField){
        
        
        switch tf.tag {
        case 111:
            email = tf.text ?? ""
            break
            
        case 222:
            mobile = tf.text ?? ""
            break
            
        default:
            break
        }
    }
    
    
    
    
    //MARK: - didTapOnBackBtnAction
    @IBAction func didTapOnCloseBtnAction(_ sender: Any) {
        callapibool = false
        dismiss(animated: true)
    }
    
    
    @IBAction func didTapOnBookNowBtnAction(_ sender: Any) {
        
        
        if let cell = commonTableView.cellForRow(at: IndexPath(item: 1, section: 0)) as? PrimaryContactInfoTVCell {
            
            if email == "" {
                showToast(message: "Enter Email Address")
                cell.emailerrorlbl.text = "Enter Email Address"
            }else if email.isValidEmail() == false {
                showToast(message: "Enter Valid Email Addreess")
                cell.emailerrorlbl.text = "Enter Valid Email Addreess"
            }else if mobile == "" {
                showToast(message: "Enter Mobile No")
                cell.mobileerrorlbl.text = "Enter Mobile No"
            }else if mobile.isValidMobileNumber() == false {
                showToast(message: "Enter Valid Mobile No")
                cell.mobileerrorlbl.text = "Enter Valid Mobile No"
            }else if billingCountryCode == "" {
                showToast(message: "Enter Country Code")
                cell.mobileerrorlbl.text = "Enter Country Code"
            }else if mobilenoMaxLengthBool == false {
                showToast(message: "Enter Valid Mobile No")
                cell.mobileerrorlbl.text = "Enter Valid Mobile No"
            }else {
                guard let vc = PayNowVC.newInstance.self else {return}
                vc.modalPresentationStyle = .overCurrentContext
                callapibool = true
                self.present(vc, animated: true)
            }
            
            
        }
    }
    
    
}
