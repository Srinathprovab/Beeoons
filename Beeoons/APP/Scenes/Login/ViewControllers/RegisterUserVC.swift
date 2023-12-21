//
//  RegisterUserVC.swift
//  Beeoons
//
//  Created by FCI on 11/08/23.
//

import UIKit

class RegisterUserVC: BaseTableVC {
    
    
    static var newInstance: RegisterUserVC? {
        let storyboard = UIStoryboard(name: Storyboard.Login.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? RegisterUserVC
        return vc
    }
    var tablerow = [TableRow]()
    var fname = String()
    var lname = String()
    var email = String()
    var mobile = String()
    var countryCode = String()
    var password = String()
    var payload = [String:Any]()
    var vm :RegisterUserViewModel?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupUI()
        vm = RegisterUserViewModel(self)
    }
    
    
    func setupUI() {
        commonTableView.bounces = false
        commonTableView.registerTVCells(["RegisterUserTVCell",
                                         "EmptyTVCell"])
        setupTV()
    }
    
    
    func setupTV() {
        tablerow.removeAll()
        tablerow.append(TableRow(height:50,bgColor: .WhiteColor,cellType:.EmptyTVCell))
        tablerow.append(TableRow(cellType:.RegisterUserTVCell))
        commonTVData = tablerow
        commonTableView.reloadData()
    }
    
    override func editingText(tf: UITextField) {
        switch tf.tag {
        case 1:
            fname = tf.text ?? ""
            break
            
        case 2:
            lname = tf.text ?? ""
            break
            
        case 3:
            email = tf.text ?? ""
            break
            
        case 4:
            mobile = tf.text ?? ""
            break
            
        case 5:
            password = tf.text ?? ""
            break
            
            
            
        default:
            break
        }
    }
    
    override func didTapOnRegisterBtnAction(cell: RegisterUserTVCell) {
        
        
        
        if let cell = commonTableView.cellForRow(at: IndexPath(item: 1, section: 0)) as? RegisterUserTVCell {
            if fname.isEmpty == true {
                showToast(message: "Enter First Name")
                cell.fnameerrorlbl.text = "Enter First Name"
            }else if fname.count < 3 {
                showToast(message: "Enter minimum 3 Chars")
                cell.fnameerrorlbl.text = "Enter minimum 3 Chars"
            }else if lname.isEmpty == true {
                cell.lnameerrorlbl.text = "Enter Last Name"
                showToast(message: "Enter Last Name")
            }else if lname.count < 3 {
                cell.lnameerrorlbl.text = "Enter minimum 3 Chars"
                showToast(message: "Enter minimum 3 Chars")
            }else if email.isEmpty == true {
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
            }else if password.isEmpty == true {
                cell.passworderrorlbl.text = "Enter Password"
                showToast(message: "Enter Password")
            }else {
                CallAPI()
            }
        }
    }
   
    
    override func didTapOnLoginBtnAction(cell: RegisterUserTVCell) {
        guard let vc = LoginVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        vc.isvcFrom = "menu"
        present(vc, animated: true)
    }
    
    
    override func didTapOnCountryCodeBtnAction(cell: RegisterUserTVCell) {
        print(cell.countryCode)
    }
    
    
    @IBAction func didTapOnBackBtnAction(_ sender: Any) {
        dismiss(animated: true)
    }
    
    
}


extension RegisterUserVC:RegisterUserViewModelDelegate {
    
    
    func CallAPI() {
        payload["first_name"] = fname
        payload["last_name"] = lname
        payload["email"] = email
        payload["phone"] = "\(mobile)"
        payload["password"] = password
        payload["about_us"] = "Postman"
        payload["tc"] = "on"
        payload["register_subscription"] = "on"
                        
        vm?.CALL_USER_REGISTER_API(dictParam: payload)
    }
    
    func userRegisterationSucess(response: RegisterUserModel) {
        
        if response.data?.status == 0 {
            showToast(message: "User Register Sucess")
            dismiss(animated: true)
        }else {
            showToast(message: response.msg ?? "")
        }
    }
    
    
}
