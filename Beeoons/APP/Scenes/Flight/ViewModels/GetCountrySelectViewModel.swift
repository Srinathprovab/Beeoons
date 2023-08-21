//
//  GetCountrySelectViewModel.swift
//  Beeoons
//
//  Created by FCI on 21/08/23.
//

import Foundation


protocol GetCountryListViewModelProtocal : BaseViewModelProtocol {
    func countryList(response : [GetCountrySelectModel])
    func stateList(response : GetStatesListModel)
    func cityList(response : [GetCityListModel])
}

class GetCountrySelectViewModel {
    
    var view: GetCountryListViewModelProtocal!
    init(_ view: GetCountryListViewModelProtocal) {
        self.view = view
    }
    
    
    func CALL_GET_COUNTRY_SELECT_API(dictParam: [String: Any]){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")
        
        //  self.view?.showLoader()
        
        ServiceManager.postOrPutApiCall(endPoint: ApiEndpoints.flight_get_country , parameters: parms, resultType: [GetCountrySelectModel].self, p:dictParam) { sucess, result, errorMessage in
            
            DispatchQueue.main.async {
                //     self.view?.hideLoader()
                if sucess {
                    guard let response = result else {return}
                    self.view.countryList(response: response)
                } else {
                    self.view.showToast(message: errorMessage ?? "")
                }
            }
        }
    }
    
    
    
    func CALL_GET_STATE_SELECT_API(dictParam: [String: Any]){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")
        
        //  self.view?.showLoader()
        
        ServiceManager.postOrPutApiCall(endPoint: ApiEndpoints.get_state_list_by_country_iso ,urlParams: parms as? Dictionary<String, String>, parameters: parms, resultType: GetStatesListModel.self, p:dictParam) { sucess, result, errorMessage in
            
            DispatchQueue.main.async {
                //    self.view?.hideLoader()
                if sucess {
                    guard let response = result else {return}
                    self.view.stateList(response: response)
                } else {
                    self.view.showToast(message: errorMessage ?? "")
                }
            }
        }
    }
    
    
    
    func CALL_GET_CITY_SELECT_API(dictParam: [String: Any]){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")
        
        // self.view?.showLoader()
        
        ServiceManager.postOrPutApiCall(endPoint: ApiEndpoints.get_city_list_by_state_name ,urlParams: parms as? Dictionary<String, String>, parameters: parms, resultType: [GetCityListModel].self, p:dictParam) { sucess, result, errorMessage in
            
            DispatchQueue.main.async {
                //  self.view?.hideLoader()
                if sucess {
                    guard let response = result else {return}
                    self.view.cityList(response: response)
                } else {
                    self.view.showToast(message: errorMessage ?? "")
                }
            }
        }
    }
    
    
}
