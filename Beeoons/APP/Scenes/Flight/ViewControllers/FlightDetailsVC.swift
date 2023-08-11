//
//  FlightDetailsVC.swift
//  Beeoons
//
//  Created by FCI on 10/08/23.
//

import UIKit

class FlightDetailsVC: BaseTableVC {
   
    
    @IBOutlet weak var cityHolderView: UIView!
    @IBOutlet weak var cityslbl: UILabel!
    @IBOutlet weak var hourlbl: UILabel!
    
    
    
    var tablerow = [TableRow]()
    var vm : FlightDetailsViewModel?
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
        vm = FlightDetailsViewModel(self)
    }
    
    
    
    func setupUI() {
        cityHolderView.addCornerRadiusWithShadow(color: .clear, borderColor: .AppBorderColor, cornerRadius: 0)
        commonTableView.registerTVCells(["AddItineraryTVCell"])
        
    }
    
    
    
    @IBAction func didTapOnCloseBtnAction(_ sender: Any) {
        dismiss(animated: true)
    }
    
}



extension FlightDetailsVC:FlightDetailsViewModelDelegate {
    func callAPI(){
        self.view.backgroundColor = .black.withAlphaComponent(0.6)
        payload["search_id"] = searchid
        payload["booking_source"] = bookingsource
        payload["user_id"] = defaults.string(forKey: UserDefaultsKeys.userid) ?? "0"
        payload["access_key"] = selectedAccesskey

        
        vm?.CALL_GET_FLIGHT_DETAILS_API(dictParam: payload)
    }
    
    func flightDetails(response: FlightDetailsModel) {
        print(response.priceDetails)
        
        DispatchQueue.main.async {
            self.setupItineraryTVCells()
        }
    }
    
    
    func setupItineraryTVCells() {
        tablerow.removeAll()
        
        fd.forEach { i in
            tablerow.append(TableRow(moreData:i,cellType:.AddItineraryTVCell))
        }
        
        
        commonTVData = tablerow
        commonTableView.reloadData()
    }
    
    
}
