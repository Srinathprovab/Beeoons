//
//  GetCountryListViewModel.swift
//  Beeoons
//
//  Created by FCI on 11/08/23.
//

import Foundation

protocol GetCountryListViewModelDelegate : BaseViewModelProtocol {
    func countryList(response : CountryListModel)
}

class GetCountryListViewModel {
    
    var view: GetCountryListViewModelDelegate!
    init(_ view: GetCountryListViewModelDelegate) {
        self.view = view
    }
    
    
    func CALL_GET_COUNTRY_LIST_API(dictParam: [String: Any]){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")
        
        //  self.view?.showLoader()
        
        ServiceManager.postOrPutApiCall(endPoint: ApiEndpoints.countrylist, parameters: parms, resultType: CountryListModel.self, p:dictParam) { sucess, result, errorMessage in
            
            DispatchQueue.main.async {
                //   self.view?.hideLoader()
                if sucess {
                    guard let response = result else {return}
                    self.view.countryList(response: response)
                } else {
                    // Show alert
                    self.view.showToast(message: errorMessage ?? "")
                }
            }
        }
    }
    
    
    
    
}
