//
//  IndexPageViewModel.swift
//  Beeoons
//
//  Created by FCI on 14/08/23.
//

import Foundation


protocol IndexPageViewModelDelegate : BaseViewModelProtocol {
    func indexPageDetails(response : IndexPageModel)
}

class IndexPageViewModel {
    
    var view: IndexPageViewModelDelegate!
    init(_ view: IndexPageViewModelDelegate) {
        self.view = view
    }
    
    
    func CALL_INDEXPAGE_API(dictParam: [String: Any]){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")
        
        self.view?.showLoader()
        
        ServiceManager.postOrPutApiCall(endPoint: ApiEndpoints.indexpageapi, urlParams: parms as? Dictionary<String, String>,parameters: parms, resultType: IndexPageModel.self, p:dictParam) { sucess, result, errorMessage in
            
            DispatchQueue.main.async {
                self.view?.hideLoader()
                if sucess {
                    guard let response = result else {return}
                    self.view.indexPageDetails(response: response)
                } else {
                    self.view.showToast(message: errorMessage ?? "")
                }
            }
        }
    }
    
    
}
