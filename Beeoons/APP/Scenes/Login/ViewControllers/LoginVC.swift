//
//  LoginVC.swift
//  Beeoons
//
//  Created by FCI on 08/08/23.
//

import UIKit

class LoginVC: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var passwordView: UIView!
    @IBOutlet weak var emailerrorlbl: UILabel!
    @IBOutlet weak var passwordErrorlbl: UILabel!
    @IBOutlet weak var skipbtn: UIButton!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var hidePassImg: UIImageView!
    
    
    var payload = [String:Any]()
    var showPassBool = true
    var isvcFrom = String()
    var email = ""
    var password = ""
    var vm:GetCountryListViewModel?
    var vm1:LoginViewModel?
    static var newInstance: LoginVC? {
        let storyboard = UIStoryboard(name: Storyboard.Login.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? LoginVC
        return vc
    }
    
    
    
    //MARK: - viewWillAppear viewDidLoad setupUI
    
    override func viewWillAppear(_ animated: Bool) {
        if isvcFrom == "menu" {
            skipbtn.isHidden = true
        }else {
            backBtn.isHidden = false
        }
        
        DispatchQueue.main.async {[self] in
            callCourencyListApi()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupUI()
        vm = GetCountryListViewModel(self)
        vm1 = LoginViewModel(self)
    }
    
    
    func setupUI() {
        backBtn.isHidden = false
        emailTF.addTarget(self, action: #selector(editingText(textField:)), for: .editingChanged)
        passwordTF.addTarget(self, action: #selector(editingText(textField:)), for: .editingChanged)
        passwordTF.isSecureTextEntry = true
    }
    
    @objc func editingText(textField:UITextField) {
        if textField.tag == 1 {
            email = textField.text ?? ""
            emailerrorlbl.text = ""
        }else {
            password = textField.text ?? ""
            passwordErrorlbl.text = ""
        }
    }
    
    
    //MARK: - gotodashBoardScreen
    func gotodashBoardScreen() {
        guard let vc = HomeVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    
    //MARK: - loginBtnAction
    @IBAction func loginBtnAction(_ sender: Any) {
        
        if email.isEmpty == true {
            emailerrorlbl.text = "Enter Email Address"
        }else if email.isValidEmail() == false {
            emailerrorlbl.text = "Enter Valid Email Address"
        }else if password.isEmpty == true {
            passwordErrorlbl.text = "Enter Password"
        }else {
            emailerrorlbl.text = ""
            passwordErrorlbl.text = ""
            callLoginAPI()
        }
    }
    
    
    //MARK: - forgetPasswordBtnAction
    @IBAction func forgetPasswordBtnAction(_ sender: Any) {
        showToast(message: "forgetPasswordBtnAction")
    }
    
    
    //MARK: - signupBtnAction
    @IBAction func signupBtnAction(_ sender: Any) {
        guard let vc = RegisterUserVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    
    //MARK: - didTapOnSkipBtnAction
    @IBAction func didTapOnSkipBtnAction(_ sender: Any) {
        defaults.set(false, forKey: UserDefaultsKeys.loggedInStatus)
        gotodashBoardScreen()
    }
    
    
    //MARK: - backBtnAction
    @IBAction func backBtnAction(_ sender: Any) {
        dismiss(animated: true)
    }
    
    
    //MARK: - didTapOnShowPassBtnAction
    @IBAction func didTapOnShowPassBtnAction(_ sender: Any) {
        if showPassBool == true {
            hidePassImg.image = UIImage(named: "showpass")?.withRenderingMode(.alwaysOriginal)
            passwordTF.isSecureTextEntry = false
            showPassBool = false
        }else {
            hidePassImg.image = UIImage(named: "hidepass")?.withRenderingMode(.alwaysOriginal)
            passwordTF.isSecureTextEntry = true
            showPassBool = true
        }
    }
    
}


//MARK: - callCourencyListApi
extension LoginVC:GetCountryListViewModelDelegate {
    
    
    func callCourencyListApi() {
        vm?.CALL_GET_COUNTRY_LIST_API(dictParam: [:])
    }
    
    func countryList(response: CountryListModel) {
        countrylist = response.country_list ?? []
    }
    
    
}




//MARK: - callLoginAPI
extension LoginVC:LoginViewModelDelegate {
    
    func callLoginAPI() {
        payload.removeAll()
        payload["username"] = email
        payload["password"] = password
        vm1?.CALL_USER_LOGIN_API(dictParam: payload)
    }
    
    func userLoginSucess(response: LoginModel) {
        if response.status == true {
            
            showToast(message: "Login Sucess")
            defaults.set(true, forKey: UserDefaultsKeys.loggedInStatus)
            defaults.set(response.user_id, forKey: UserDefaultsKeys.userid)
            defaults.set(response.image, forKey: UserDefaultsKeys.userimg)
            defaults.set("\(response.first_name ?? "") \(response.last_name ?? "")", forKey: UserDefaultsKeys.username)
            let seconds = 1.0
            DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {[self] in
                if isvcFrom == "vc" {
                    gotodashBoardScreen()
                }else {
                    
                    NotificationCenter.default.post(name: NSNotification.Name("callprofile"), object: true)
                    dismiss(animated: true)
                }
            }
        }else {
            
        }
    }
    
    
    
}
