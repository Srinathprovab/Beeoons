//
//  FlightDetailsViewModel.swift
//  Beeoons
//
//  Created by FCI on 10/08/23.
//

import Foundation


protocol FlightDetailsViewModelDelegate : BaseViewModelProtocol {
    func flightDetails(response : FlightDetailsModel)
}

class FlightDetailsViewModel {
    
    var view: FlightDetailsViewModelDelegate!
    init(_ view: FlightDetailsViewModelDelegate) {
        self.view = view
    }
    
    
    func CALL_GET_FLIGHT_DETAILS_API(dictParam: [String: Any]){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")
        
        self.view?.showLoader()
        
        ServiceManager.postOrPutApiCall(endPoint: ApiEndpoints.getFlightDetails , parameters: parms, resultType: FlightDetailsModel.self, p:dictParam) { sucess, result, errorMessage in
            
            DispatchQueue.main.async {
                self.view?.hideLoader()
                if sucess {
                    guard let response = result else {return}
                    self.view.flightDetails(response: response)
                } else {
                    self.view.showToast(message: errorMessage ?? "")
                }
            }
        }
    }
    
    
}
