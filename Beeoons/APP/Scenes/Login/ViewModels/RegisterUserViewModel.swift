//
//  RegisterUserViewModel.swift
//  Beeoons
//
//  Created by FCI on 11/08/23.
//

import Foundation

protocol RegisterUserViewModelDelegate : BaseViewModelProtocol {
    func userRegisterationSucess(response : RegisterUserModel)
}

class RegisterUserViewModel {
    
    var view: RegisterUserViewModelDelegate!
    init(_ view: RegisterUserViewModelDelegate) {
        self.view = view
    }
    
    
    func CALL_USER_REGISTER_API(dictParam: [String: Any]){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")
        
          self.view?.showLoader()
        
        ServiceManager.postOrPutApiCall(endPoint: ApiEndpoints.mobile_register_on_light_box, parameters: parms, resultType: RegisterUserModel.self, p:dictParam) { sucess, result, errorMessage in
            
            DispatchQueue.main.async {
                   self.view?.hideLoader()
                if sucess {
                    guard let response = result else {return}
                    self.view.userRegisterationSucess(response: response)
                } else {
                    // Show alert
                    self.view.showToast(message: errorMessage ?? "")
                }
            }
        }
    }
    
    

    
}
