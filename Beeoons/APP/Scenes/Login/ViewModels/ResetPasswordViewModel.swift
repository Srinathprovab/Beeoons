//
//  ResetPasswordViewModel.swift
//  Beeoons
//
//  Created by FCI on 19/08/23.
//

import Foundation

protocol ResetPasswordViewModelDelegate : BaseViewModelProtocol {
    func passwordResetSucess(response : ResetPasswordModel)
}

class ResetPasswordViewModel {
    
    var view: ResetPasswordViewModelDelegate!
    init(_ view: ResetPasswordViewModelDelegate) {
        self.view = view
    }
    
    
    func CALL_RESETPASSWORD_API(dictParam: [String: Any]){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")
        
          self.view?.showLoader()
        
        ServiceManager.postOrPutApiCall(endPoint: ApiEndpoints.auth_forgot_password, parameters: parms, resultType: ResetPasswordModel.self, p:dictParam) { sucess, result, errorMessage in
            
            DispatchQueue.main.async {
                   self.view?.hideLoader()
                if sucess {
                    guard let response = result else {return}
                    self.view.passwordResetSucess(response: response)
                } else {
                    // Show alert
                    self.view.showToast(message: errorMessage ?? "")
                }
            }
        }
    }
    
    

    
}
