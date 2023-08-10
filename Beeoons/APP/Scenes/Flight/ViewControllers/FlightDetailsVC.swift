//
//  FlightDetailsVC.swift
//  Beeoons
//
//  Created by FCI on 10/08/23.
//

import UIKit

class FlightDetailsVC: UIViewController {
    
    
    
    
    @IBOutlet weak var cityHolderView: UIView!
    @IBOutlet weak var cityslbl: UILabel!
    @IBOutlet weak var hourlbl: UILabel!
    
    
    var payload = [String:Any]()
    static var newInstance: FlightDetailsVC? {
        let storyboard = UIStoryboard(name: Storyboard.Flight.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? FlightDetailsVC
        return vc
    }
    
    
    
    //MARK: - LOADING FUNCTIONS
    
    override func viewWillAppear(_ animated: Bool) {
        if callapibool == true {
            callAPI()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.view.backgroundColor = .WhiteColor
        setupUI()
    }
    
    
    
    func setupUI() {
        cityHolderView.addCornerRadiusWithShadow(color: .clear, borderColor: .AppBorderColor, cornerRadius: 0)
    }
    
    
    
    
    @IBAction func didTapOnCloseBtnAction(_ sender: Any) {
        dismiss(animated: true)
    }
    
}



extension FlightDetailsVC {
    func callAPI(){
        self.view.backgroundColor = .black.withAlphaComponent(0.6)
        payload["search_id"] = searchid
        payload["selectedResult"] = selectedResult
        payload["booking_source"] = bookingsource
        payload["user_id"] = defaults.string(forKey: UserDefaultsKeys.userid) ?? "0"
        
        print(payload)
    }
}
