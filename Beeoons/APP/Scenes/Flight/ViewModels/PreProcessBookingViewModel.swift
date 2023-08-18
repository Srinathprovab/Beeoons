//
//  PreProcessBookingViewModel.swift
//  Beeoons
//
//  Created by FCI on 13/08/23.
//

import Foundation


protocol PreProcessBookingViewModelDelegate : BaseViewModelProtocol {
    func mobilePreprocessBookingDetails(response : PreProcessBookingModel)
    func processPassengerDetails(response : ProcessPassangerDetailModel)
    func preFlightBookingDetails(response : ProcessPassangerDetailModel)
    func flightPrePaymentDetails(response : PrePaymentConfModel)
    func sendtoPaymentDetails(response : sendToPaymentModel)
    func secureBookingDetails(response : sendToPaymentModel)
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
    
    

    
    
    
    
    func CALL_PROCESS_PASSENGER_DETAIL_API(dictParam: [String: Any]){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")
        
        self.view?.showLoader()
        
        ServiceManager.postOrPutApiCall(endPoint: ApiEndpoints.processpassengerdetail,parameters: parms, resultType: ProcessPassangerDetailModel.self, p:dictParam) { sucess, result, errorMessage in
            
            DispatchQueue.main.async {
                self.view?.hideLoader()
                if sucess {
                    guard let response = result else {return}
                    self.view.processPassengerDetails(response: response)
                } else {
                    self.view.showToast(message: errorMessage ?? "")
                }
            }
        }
    }
    
    
    
    
    func CALL_PRE_FLIGHT_BOOKING_API(dictParam: [String: Any],key:String){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")
        
        //   self.view?.showLoader()
        
        ServiceManager.postOrPutApiCall(endPoint: ApiEndpoints.prebooking + key,parameters: parms, resultType: ProcessPassangerDetailModel.self, p:dictParam) { sucess, result, errorMessage in
            
            DispatchQueue.main.async {
                //     self.view?.hideLoader()
                if sucess {
                    guard let response = result else {return}
                    self.view.preFlightBookingDetails(response: response)
                } else {
                    self.view.showToast(message: errorMessage ?? "")
                }
            }
        }
    }
    
    
    
    
    
    
    func CALL_FLIGHT_PRE_CONF_PAYMENT_API(dictParam: [String: Any],key:String){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")
        
        //  self.view?.showLoader()
        
        ServiceManager.postOrPutApiCall(endPoint: ApiEndpoints.prepaymentconfirmation + key,parameters: parms, resultType: PrePaymentConfModel.self, p:dictParam) { sucess, result, errorMessage in
            
            DispatchQueue.main.async {
                //  self.view?.hideLoader()
                if sucess {
                    guard let response = result else {return}
                    self.view.flightPrePaymentDetails(response: response)
                } else {
                    self.view.showToast(message: errorMessage ?? "")
                }
            }
        }
    }
    
    
    
    
    
    func CALL_SENDTO_PAYMENT_API(dictParam: [String: Any],key:String){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")
        
        //  self.view?.showLoader()
        
        ServiceManager.postOrPutApiCall(endPoint: ApiEndpoints.sendtopayment + key,parameters: parms, resultType: sendToPaymentModel.self, p:dictParam) { sucess, result, errorMessage in
            
            DispatchQueue.main.async {
                //  self.view?.hideLoader()
                if sucess {
                    guard let response = result else {return}
                    self.view.sendtoPaymentDetails(response: response)
                } else {
                    self.view.showToast(message: errorMessage ?? "")
                }
            }
        }
    }
    
    
    
    
    func CALL_SECURE_BOOKING_API(dictParam: [String: Any],key:String){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")
        
     //   self.view?.showLoader()
        
        ServiceManager.postOrPutApiCall(endPoint: ApiEndpoints.securebooking + key,parameters: parms, resultType: sendToPaymentModel.self, p:dictParam) { sucess, result, errorMessage in
            
            DispatchQueue.main.async {
                self.view?.hideLoader()
                if sucess {
                    guard let response = result else {return}
                    self.view.secureBookingDetails(response: response)
                } else {
                    self.view.showToast(message: errorMessage ?? "")
                }
            }
        }
    }
    
    
    
}
