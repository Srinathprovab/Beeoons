//
//  HotelDetailsViewModel.swift
//  Beeoons
//
//  Created by FCI on 30/09/23.
//

import Foundation


protocol HotelDetailsViewModelDelegate : BaseViewModelProtocol {
    func selectedHotelDetails(response : HotelDetailsModel)
}

class HotelDetailsViewModel {
    
    var view: HotelDetailsViewModelDelegate!
    init(_ view: HotelDetailsViewModelDelegate) {
        self.view = view
    }
    
    
    func CALL_GET_HOTEL_LIST_API(dictParam: [String: Any]){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")
        
        self.view?.showLoader()
        
        ServiceManager.postOrPutApiCall(endPoint: ApiEndpoints.hotel_mobile_details,urlParams: parms as? Dictionary<String, String> , parameters: parms, resultType: HotelDetailsModel.self, p:dictParam) { sucess, result, errorMessage in
            
            DispatchQueue.main.async {
                self.view?.hideLoader()
                if sucess {
                    guard let response = result else {return}
                    self.view.selectedHotelDetails(response: response)
                } else {
                    self.view.showToast(message: errorMessage ?? "")
                }
            }
        }
    }
    
    
}
