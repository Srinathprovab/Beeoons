//
//  ModifySearchVC.swift
//  Beeoons
//
//  Created by FCI on 10/08/23.
//

import UIKit

class ModifySearchVC: BaseTableVC {
    
    
    
    @IBOutlet weak var onewayView: UIView!
    @IBOutlet weak var onewaylbl: UILabel!
    @IBOutlet weak var roundtripview: UIView!
    @IBOutlet weak var roundtriplbl: UILabel!
    @IBOutlet weak var multicityView: UIView!
    @IBOutlet weak var multicitylbl: UILabel!
    
    var payload = [String:Any]()
    var tablerow = [TableRow]()
    static var newInstance: ModifySearchVC? {
        let storyboard = UIStoryboard(name: Storyboard.Flight.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? ModifySearchVC
        return vc
    }
    
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        addObserverCall()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupUI()
        self.view.backgroundColor = .black.withAlphaComponent(0.8)
    }
    
    
    //MARK: -
    func setupUI() {
        
        // multicityView.isHidden = true
        setupOnewayUI()
        commonTableView.registerTVCells(["BookFlightTVCell",
                                         "FlightDealsTVCell"])
        
    }
    
    
    
    func addObserverCall() {
        NotificationCenter.default.addObserver(self, selector: #selector(reload(notification:)), name: NSNotification.Name("reload"), object: nil)
    }
    
    @objc func reload(notification: NSNotification){
        commonTableView.reloadData()
    }
    
    
    
    func setupOnewayUI() {
        onewayView.backgroundColor = .ButtonColor
        roundtripview.backgroundColor = .WhiteColor
        multicityView.backgroundColor = .WhiteColor
        onewaylbl.textColor = .WhiteColor
        roundtriplbl.textColor = .Journytabunselectedcolor
        multicitylbl.textColor = .Journytabunselectedcolor
        defaults.set("oneway", forKey: UserDefaultsKeys.journeyType)
        setupTVCell()
    }
    
    
    func setupRoundtripUI() {
        onewayView.backgroundColor = .WhiteColor
        roundtripview.backgroundColor = .ButtonColor
        multicityView.backgroundColor = .WhiteColor
        onewaylbl.textColor = .Journytabunselectedcolor
        roundtriplbl.textColor = .WhiteColor
        multicitylbl.textColor = .Journytabunselectedcolor
        defaults.set("circle", forKey: UserDefaultsKeys.journeyType)
        setupTVCell()
    }
    
    
    func setupMulticityUI() {
        onewayView.backgroundColor = .WhiteColor
        roundtripview.backgroundColor = .WhiteColor
        multicityView.backgroundColor = .ButtonColor
        onewaylbl.textColor = .Journytabunselectedcolor
        roundtriplbl.textColor = .Journytabunselectedcolor
        multicitylbl.textColor = .WhiteColor
        defaults.set("multicity", forKey: UserDefaultsKeys.journeyType)
        setupTVCell()
    }
    
    //MARK: - setupTVCell
    func setupTVCell() {
        tablerow.removeAll()
        
        tablerow.append(TableRow(cellType: .BookFlightTVCell))
        
        
        commonTVData = tablerow
        commonTableView.reloadData()
    }
    
    
    
    @IBAction func didTapOnBackBtnAction(_ sender: Any) {
        dismiss(animated: true)
    }
    
    
    
    @IBAction func didTapOnOnewayBtnAction(_ sender: Any) {
        setupOnewayUI()
    }
    
    
    @IBAction func didTapOnRoundTripButtonAction(_ sender: Any) {
        setupRoundtripUI()
    }
    
    
    @IBAction func didTapOnMulticityButtonAction(_ sender: Any) {
        setupMulticityUI()
    }
    
    
    
    
    //MARK: - gotoSelectCityVC
    override func didTapOnFromCityBtnAction(cell: BookFlightTVCell) {
        gotoSelectCityVC(str: "From Destination", tokey: "Tooo")
    }
    
    override func didTapOnToCityBtnAction(cell: BookFlightTVCell) {
        gotoSelectCityVC(str: "To Destination", tokey: "frommm")
    }
    
    func gotoSelectCityVC(str:String,tokey:String) {
        guard let vc = SelectCityVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        vc.titleStr = str
        vc.keyStr = "FLIGHT"
        vc.tokey = tokey
        self.present(vc, animated: true)
    }
    
    
    
    //MARK: - didTapOnSelectDepartureDateBtnAction
    override func didTapOnSelectDepartureDateBtnAction(cell: BookFlightTVCell) {
        gotoCalenderVC()
    }
    
    override func didTapOnArrivalDateBtnAction(cell: BookFlightTVCell) {
        gotoCalenderVC()
    }
    
    
    func gotoCalenderVC() {
        guard let vc = CalenderVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: false)
    }
    
    
    //MARK: - didTapOnSelectTravellersBtnAction
    override func didTapOnSelectTravellersBtnAction(cell: BookFlightTVCell) {
        gotoAddTravelerVC()
    }
    
    
    func gotoAddTravelerVC() {
        guard let vc = AddTravellersVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    
    
    //MARK: - didTapOnSelectClassBtnAction
    override func didTapOnSelectClassBtnAction(cell: BookFlightTVCell) {
        print("didTapOnSelectClassBtnAction")
    }
    
    
    
    //MARK: - didTapOnAddAirlineButtonAction
    override func didTapOnAddAirlineButtonAction(cell:BookFlightTVCell){
        commonTableView.reloadData()
    }
    
    
    //MARK: - didTapOnAddAirlineButtonAction
    override func didTapOnSearchFlightBtnAction(cell:BookFlightTVCell) {
        
        
        
        
        if let cell = commonTableView.cellForRow(at: IndexPath(item: 0, section: 0)) as? BookFlightTVCell {
            
            payload.removeAll()
            
            let journyType = defaults.string(forKey: UserDefaultsKeys.journeyType)
            if journyType == "oneway" {
                
                payload["trip_type"] = defaults.string(forKey: UserDefaultsKeys.journeyType)
                payload["adult"] = defaults.string(forKey: UserDefaultsKeys.adultCount)
                payload["child"] = defaults.string(forKey: UserDefaultsKeys.childCount)
                payload["infant"] = defaults.string(forKey: UserDefaultsKeys.infantsCount)
                payload["sector_type"] = "international"
                payload["from"] = defaults.string(forKey: UserDefaultsKeys.fromCity)
                payload["from_loc_id"] = defaults.string(forKey: UserDefaultsKeys.fromlocid)
                payload["to"] = defaults.string(forKey: UserDefaultsKeys.toCity)
                payload["to_loc_id"] = defaults.string(forKey: UserDefaultsKeys.tolocid)
                payload["depature"] = defaults.string(forKey: UserDefaultsKeys.calDepDate)
                payload["return"] = ""
                payload["carrier"] = ""
                payload["psscarrier"] = "ALL"
                payload["v_class"] = defaults.string(forKey: UserDefaultsKeys.selectClass) ?? "Economy"
                payload["search_flight"] = "Search"
                payload["search_source"] = "search"
                payload["user_id"] = defaults.string(forKey: UserDefaultsKeys.userid) ?? "0"
                payload["currency"] = defaults.string(forKey: UserDefaultsKeys.selectedCurrency) ?? "KWD"
                
                
                if defaults.string(forKey:UserDefaultsKeys.fromCity) == nil {
                    showToast(message: "Please Select From City")
                    cell.fromView.layer.borderColor = UIColor.red.cgColor
                }else if defaults.string(forKey:UserDefaultsKeys.toCity) == nil {
                    showToast(message: "Please Select To City")
                    cell.toView.layer.borderColor = UIColor.red.cgColor
                }else if defaults.string(forKey:UserDefaultsKeys.toCity) == defaults.string(forKey:UserDefaultsKeys.fromCity) {
                    showToast(message: "Please Select Different Citys")
                }else if defaults.string(forKey:UserDefaultsKeys.calDepDate) == "" {
                    showToast(message: "Please Select Departure Date")
                }else if defaults.string(forKey:UserDefaultsKeys.travellerDetails) == "Add Details" {
                    showToast(message: "Add Traveller")
                }else if defaults.string(forKey:UserDefaultsKeys.selectClass) == "Add Details" {
                    showToast(message: "Add Class")
                }else if checkDepartureAndReturnDates1(payload, p1: "depature") == false {
                    showToast(message: "Invalid Date")
                }else{
                    gotoSearchFlightResultVC(input: payload)
                }
            }else if journyType == "circle"{
                
                
                payload["trip_type"] = defaults.string(forKey: UserDefaultsKeys.journeyType)
                payload["adult"] = defaults.string(forKey: UserDefaultsKeys.radultCount)
                payload["child"] = defaults.string(forKey: UserDefaultsKeys.rchildCount)
                payload["infant"] = defaults.string(forKey: UserDefaultsKeys.rinfantsCount)
                payload["sector_type"] = "international"
                payload["from"] = defaults.string(forKey: UserDefaultsKeys.rfromCity)
                payload["from_loc_id"] = defaults.string(forKey: UserDefaultsKeys.rfromlocid)
                payload["to"] = defaults.string(forKey: UserDefaultsKeys.rtoCity)
                payload["to_loc_id"] = defaults.string(forKey: UserDefaultsKeys.rtolocid)
                payload["depature"] = defaults.string(forKey: UserDefaultsKeys.rcalDepDate)
                payload["return"] = defaults.string(forKey: UserDefaultsKeys.rcalRetDate)
                payload["carrier"] = ""
                payload["psscarrier"] = "ALL"
                payload["v_class"] = defaults.string(forKey: UserDefaultsKeys.selectClass) ?? "Economy"
                payload["search_flight"] = "Search"
                payload["search_source"] = "search"
                payload["user_id"] = defaults.string(forKey: UserDefaultsKeys.userid) ?? "0"
                payload["currency"] = defaults.string(forKey: UserDefaultsKeys.selectedCurrency) ?? "KWD"
                
                if defaults.string(forKey:UserDefaultsKeys.rfromCity) == "" {
                    showToast(message: "Please Select From City")
                }else if defaults.string(forKey:UserDefaultsKeys.rtoCity) == "" {
                    showToast(message: "Please Select To City")
                }else if defaults.string(forKey:UserDefaultsKeys.rtoCity) == defaults.string(forKey:UserDefaultsKeys.rfromCity) {
                    showToast(message: "Please Select Different Citys")
                }else if defaults.string(forKey:UserDefaultsKeys.rcalDepDate) == "" {
                    showToast(message: "Please Select Departure Date")
                }else if defaults.string(forKey:UserDefaultsKeys.rcalRetDate) == "" {
                    showToast(message: "Please Select Departure Date")
                }else if defaults.string(forKey:UserDefaultsKeys.travellerDetails) == "Add Details" {
                    showToast(message: "Add Traveller")
                }else if defaults.string(forKey:UserDefaultsKeys.selectClass) == "Add Details" {
                    showToast(message: "Add Class")
                }else if checkDepartureAndReturnDates(payload, p1: "depature", p2: "return") == false {
                    showToast(message: "Invalid Date")
                }else{
                    gotoSearchFlightResultVC(input: payload)
                }
            }else {
                
            }
            
            
        }
        
    }
    
    
    func gotoSearchFlightResultVC(input:[String:Any]) {
        guard let vc = FlightResultVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        loderBool = true
        callapibool = true
        vc.payload = input
        self.present(vc, animated: true)
    }
    
    
}
