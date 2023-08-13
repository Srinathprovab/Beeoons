//
//  PreProcessBookingViewModel.swift
//  Beeoons
//
//  Created by FCI on 13/08/23.
//

import Foundation


protocol PreProcessBookingViewModelDelegate : BaseViewModelProtocol {
    func mobilePreprocessBookingDetails(response : PreProcessBookingModel)
}

class PreProcessBookingViewModel {
    
    var view: PreProcessBookingViewModelDelegate!
    init(_ view: PreProcessBookingViewModelDelegate) {
        self.view = view
    }
    
    
    func CALL_MOBILE_PREPROCESS_BOOKING_API(dictParam: [String: Any]){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")
        
        self.view?.showLoader()
        
        ServiceManager.postOrPutApiCall(endPoint: ApiEndpoints.flight_mobile_pre_process_booking , parameters: parms, resultType: PreProcessBookingModel.self, p:dictParam) { sucess, result, errorMessage in
            
            DispatchQueue.main.async {
                self.view?.hideLoader()
                if sucess {
                    guard let response = result else {return}
                    self.view.mobilePreprocessBookingDetails(response: response)
                } else {
                    self.view.showToast(message: errorMessage ?? "")
                }
            }
        }
    }
    
    
}
