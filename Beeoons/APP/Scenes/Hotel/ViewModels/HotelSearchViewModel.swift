//
//  HotelSearchViewModel.swift
//  Beeoons
//
//  Created by FCI on 29/09/23.
//

import Foundation



protocol HotelSearchViewModelDelegate : BaseViewModelProtocol {
    func hotelList(response : HotelSearchModel)
}

class HotelSearchViewModel {
    
    var view: HotelSearchViewModelDelegate!
    init(_ view: HotelSearchViewModelDelegate) {
        self.view = view
    }
    
    
    func CALL_GET_HOTEL_LIST_API(dictParam: [String: Any]){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")
        
        self.view?.showLoader()
        
        ServiceManager.postOrPutApiCall(endPoint: ApiEndpoints.general_mobile_pre_hotel_search , parameters: parms, resultType: HotelSearchModel.self, p:dictParam) { sucess, result, errorMessage in
            
            DispatchQueue.main.async {
                self.view?.hideLoader()
                if sucess {
                    guard let response = result else {return}
                    self.view.hotelList(response: response)
                } else {
                    self.view.showToast(message: errorMessage ?? "")
                }
            }
        }
    }
    
    
}
