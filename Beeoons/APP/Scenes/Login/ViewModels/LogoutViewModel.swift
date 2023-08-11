//
//  LogoutViewModel.swift
//  Beeoons
//
//  Created by FCI on 11/08/23.
//

import Foundation

protocol LogoutViewModelDelegate : BaseViewModelProtocol {
    func userLogoutSucess(response : LogoutModel)
}

class LogoutViewModel {
    
    var view: LogoutViewModelDelegate!
    init(_ view: LogoutViewModelDelegate) {
        self.view = view
    }
    
    
    func CALL_USER_LOGOUT_API(dictParam: [String: Any]){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")
        
          self.view?.showLoader()
        
        ServiceManager.postOrPutApiCall(endPoint: ApiEndpoints.authajax_logout, parameters: parms, resultType: LogoutModel.self, p:dictParam) { sucess, result, errorMessage in
            
            DispatchQueue.main.async {
                   self.view?.hideLoader()
                if sucess {
                    guard let response = result else {return}
                    self.view.userLogoutSucess(response: response)
                } else {
                    // Show alert
                    self.view.showToast(message: errorMessage ?? "")
                }
            }
        }
    }
    
    

    
}
