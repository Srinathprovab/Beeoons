//
//  LoginViewModel.swift
//  Beeoons
//
//  Created by FCI on 11/08/23.
//

import Foundation

protocol LoginViewModelDelegate : BaseViewModelProtocol {
    func userLoginSucess(response : LoginModel)
}

class LoginViewModel {
    
    var view: LoginViewModelDelegate!
    init(_ view: LoginViewModelDelegate) {
        self.view = view
    }
    
    
    func CALL_USER_LOGIN_API(dictParam: [String: Any]){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")
        
          self.view?.showLoader()
        
        ServiceManager.postOrPutApiCall(endPoint: ApiEndpoints.authmobile_login, parameters: parms, resultType: LoginModel.self, p:dictParam) { sucess, result, errorMessage in
            
            DispatchQueue.main.async {
                   self.view?.hideLoader()
                if sucess {
                    guard let response = result else {return}
                    self.view.userLoginSucess(response: response)
                } else {
                    // Show alert
                    self.view.showToast(message: errorMessage ?? "")
                }
            }
        }
    }
    
    

    
}
