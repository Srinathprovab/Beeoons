//
//  ResetPasswordVC.swift
//  Beeoons
//
//  Created by FCI on 19/08/23.
//

import UIKit

class ResetPasswordVC: BaseTableVC {
    
    
    
    static var newInstance: ResetPasswordVC? {
        let storyboard = UIStoryboard(name: Storyboard.Login.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? ResetPasswordVC
        return vc
    }
    var tablerow = [TableRow]()
    
    var email = String()
    var mobile = String()
    var countryCode = String()
    var payload = [String:Any]()
    var vm :ResetPasswordViewModel?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupUI()
        vm = ResetPasswordViewModel(self)
    }
    
    
    func setupUI() {
        commonTableView.bounces = false
        commonTableView.registerTVCells(["ResetPasswordTVCell",
                                         "EmptyTVCell"])
        setupTV()
    }
    
    
    func setupTV() {
        tablerow.removeAll()
        tablerow.append(TableRow(height:50,bgColor: .WhiteColor,cellType:.EmptyTVCell))
        tablerow.append(TableRow(cellType:.ResetPasswordTVCell))
        commonTVData = tablerow
        commonTableView.reloadData()
    }
    
    override func editingText(tf: UITextField) {
        switch tf.tag {
            
            
        case 1:
            email = tf.text ?? ""
            break
            
        case 2:
            mobile = tf.text ?? ""
            break
            
            
            
        default:
            break
        }
    }
    
    
    
    override func didTapOnCountryCodeBtnAction(cell: RegisterUserTVCell) {
        print(cell.countryCode)
    }
    
    
    override func didTapOnResetPassswordBtnAction(cell:ResetPasswordTVCell){
        if let cell = commonTableView.cellForRow(at: IndexPath(item: 1, section: 0)) as? ResetPasswordTVCell {
            if email.isEmpty == true {
                cell.emailerrorlbl.text = "Enter Email Id"
                showToast(message: "Enter Email Id")
            }else if email.isValidEmail() == false {
                cell.emailerrorlbl.text = "Enter Valid Email Id"
                showToast(message: "Enter Valid Email Id")
            }else if mobile.isEmpty == true {
                cell.mobileErrorlbl.text = "Enter Mobile Number"
                showToast(message: "Enter Mobile Number")
            }else if mobilenoMaxLengthBool == false {
                cell.mobileErrorlbl.text = "Enter Valid Mobile Number"
                showToast(message: "Enter Valid Mobile Number")
            }else {
                CallAPI()
            }
        }
    }
    
    @IBAction func didTapOnBackBtnAction(_ sender: Any) {
        dismiss(animated: true)
    }
    
}


extension ResetPasswordVC:ResetPasswordViewModelDelegate {
    
    
    func CallAPI() {
        payload["email"] = email
        payload["phone"] = "\(mobile)"
        vm?.CALL_RESETPASSWORD_API(dictParam: payload)
    }
    

    func passwordResetSucess(response: ResetPasswordModel) {
        if response.status == true {
            showToast(message: response.data ?? "")
            let seconds = 1.5
            DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
                self.dismiss(animated: true)
            }
        }else {
            showToast(message: response.data ?? "")
        }
    }
    
    
}
