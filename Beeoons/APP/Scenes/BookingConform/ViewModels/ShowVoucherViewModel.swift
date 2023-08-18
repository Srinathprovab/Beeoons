//
//  ShowVoucherViewModel.swift
//  Beeoons
//
//  Created by FCI on 18/08/23.
//

import Foundation



protocol ShowVoucherViewModelDelegate : BaseViewModelProtocol {
    func voucherDetails(response : ShowVoucherModel)
}

class ShowVoucherViewModel {
    
    var view: ShowVoucherViewModelDelegate!
    init(_ view: ShowVoucherViewModelDelegate) {
        self.view = view
    }
    
    
    func CALL_GET_VOUCHE_DETAILS_API(dictParam: [String: Any],url:String){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")
        
        self.view?.showLoader()
        
        ServiceManager.postOrPutApiCall(endPoint: url , parameters: parms, resultType: ShowVoucherModel.self, p:dictParam) { sucess, result, errorMessage in
            
            DispatchQueue.main.async {
                self.view?.hideLoader()
                if sucess {
                    guard let response = result else {return}
                    self.view.voucherDetails(response: response)
                } else {
                    self.view.showToast(message: errorMessage ?? "")
                }
            }
        }
    }
    
    
}
