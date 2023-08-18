//
//  BookingConformVC.swift
//  Beeoons
//
//  Created by FCI on 18/08/23.
//

import UIKit

class BookingConformVC: UIViewController {
    
    var voucherURL = String()
    var vm:ShowVoucherViewModel?
    
    static var newInstance: BookingConformVC? {
        let storyboard = UIStoryboard(name: Storyboard.BookingCnf.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? BookingConformVC
        return vc
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        if callapibool == true{
            callVoucherAPI()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        vm = ShowVoucherViewModel(self)
        
    }
    
    
    
    
    func gotoHomeVC() {
        BASE_URL = BASE_URL1
        guard let vc = HomeVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        callapibool = true
        present(vc, animated: true)
    }
    
    
    
    @IBAction func didTapOnBackBtnAction(_ sender: Any) {
        gotoHomeVC()
    }
    
}


extension BookingConformVC:ShowVoucherViewModelDelegate {
    
    func callVoucherAPI() {
        BASE_URL = ""
        vm?.CALL_GET_VOUCHE_DETAILS_API(dictParam: [:], url: voucherURL )
    }
    
    func voucherDetails(response: ShowVoucherModel) {
        BASE_URL = BASE_URL1
       // print(response.data?.booking_details?[0].customer_details as Any)
    }
    
}
