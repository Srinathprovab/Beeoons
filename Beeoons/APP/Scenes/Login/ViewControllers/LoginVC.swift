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
    
    
    
    var email = ""
    var password = ""
    static var newInstance: LoginVC? {
        let storyboard = UIStoryboard(name: Storyboard.Login.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? LoginVC
        return vc
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupUI()
    }
    
    
    func setupUI() {
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
    
    
    func gotodashBoardScreen() {
        guard let vc = HomeVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    
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
            showToast(message: "Call Login API")
        }
    }
    
    @IBAction func forgetPasswordBtnAction(_ sender: Any) {
        showToast(message: "forgetPasswordBtnAction")
    }
    
    
    @IBAction func signupBtnAction(_ sender: Any) {
        showToast(message: "signupBtnAction")
    }
    
    
    @IBAction func didTapOnSkipBtnAction(_ sender: Any) {
        gotodashBoardScreen()
    }
    
    
    
}
