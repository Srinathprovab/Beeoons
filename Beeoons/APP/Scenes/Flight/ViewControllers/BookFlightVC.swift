//
//  BookFlightVC.swift
//  Beeoons
//
//  Created by FCI on 09/08/23.
//

import UIKit

class BookFlightVC: BaseTableVC {
    
    
    @IBOutlet weak var onewayView: UIView!
    @IBOutlet weak var onewaylbl: UILabel!
    @IBOutlet weak var roundtripview: UIView!
    @IBOutlet weak var roundtriplbl: UILabel!
    @IBOutlet weak var multicityView: UIView!
    @IBOutlet weak var multicitylbl: UILabel!
    
    
    var selectedAirlineName = String()
    var payload = [String:Any]()
    var payload1 = [String:Any]()
    var payload2 = [String:Any]()
    var fromdataArray = [[String:Any]]()
    var tablerow = [TableRow]()
    
    static var newInstance: BookFlightVC? {
        let storyboard = UIStoryboard(name: Storyboard.Flight.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? BookFlightVC
        return vc
    }
    
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        addObserverCall()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupUI()
    }
    
    
    //MARK: -
    func setupUI() {
        
        multicityView.isHidden = true
        
        let journyType = defaults.string(forKey: UserDefaultsKeys.journeyType)
        if journyType == "oneway" {
            setupOnewayUI()
        }else if journyType == "circle" {
            setupRoundtripUI()
        }else{
            setupMulticityUI()
        }
        commonTableView.registerTVCells(["BookFlightTVCell",
                                         "FlightDealsTVCell",
                                         "BookFlightMCTVCell"])
        
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
        setupMulticityTVCell()
    }
    
    //MARK: - setupTVCell
    func setupTVCell() {
        tablerow.removeAll()
        
        tablerow.append(TableRow(cellType: .BookFlightTVCell))
        tablerow.append(TableRow(title:"FLIGHT",cellType: .FlightDealsTVCell))
        
        
        commonTVData = tablerow
        commonTableView.reloadData()
    }
    
    
    
    @IBAction func didTapOnBackBtnAction(_ sender: Any) {
        // dismiss(animated: true)
        gotoHomeVC()
    }
    
    func gotoHomeVC() {
        loderBool = false
        guard let vc = HomeVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        callapibool = true
        self.present(vc, animated: false)
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
    
    
    //MARK: - didTapOnAirLineDropDownBtn
    override func didTapOnAirLineDropDownBtn(cell:BookFlightTVCell){
        selectedAirlineName = cell.airlinelbl.text ?? ""
    }
    
    
    override func editingTextField(tf: UITextField) {
        //commonTableView.scrollToRow(at: IndexPath(item: 1, section: 0), at: .none, animated: true)
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
                payload["psscarrier"] = selectedAirlineName
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
                payload["psscarrier"] = selectedAirlineName
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
    
    
    
    //MARK: - setupMulticityTVCell
    func setupMulticityTVCell() {
        tablerow.removeAll()
        
        tablerow.append(TableRow(cellType: .BookFlightMCTVCell))
        //        tablerow.append(TableRow(title:"FLIGHT",cellType: .FlightDealsTVCell))
        
        
        commonTVData = tablerow
        commonTableView.reloadData()
    }
    
    
    override func didTapOnFromCityBtn(cell: BookFlightMCTVCell) {
        gotoSelectCityVC(str: "From Destination", tokey: "")
    }
    
    override func didTapOnToCityBtn(cell: BookFlightMCTVCell) {
        gotoSelectCityVC(str: "To Destination", tokey: "")
    }
    
    override func didTapOnDateBtn(cell: BookFlightMCTVCell) {
        gotoCalenderVC()
    }
    
    override func didTapOnSelectTravellersBtnAction(cell: BookFlightMCTVCell) {
        gotoAddTravelerVC()
    }
    
    override func didTapOnSelectClassBtnAction(cell: BookFlightMCTVCell) {
        
    }
    
    override func didTapOnSearchFlightBtnAction(cell: BookFlightMCTVCell) {
        loderBool = true
        payload.removeAll()
        payload1.removeAll()
        payload2.removeAll()
        fromdataArray.removeAll()
        
        for (index,_) in fromCityShortNameArray.enumerated() {
            
            payload2["from"] = fromCityNameArray[index]
            payload2["from_loc_id"] = fromlocidArray[index]
            payload2["to"] = toCityNameArray[index]
            payload2["to_loc_id"] = tolocidArray[index]
            payload2["depature"] = depatureDatesArray[index]
            
            fromdataArray.append(payload2)
        }
        
        
        payload["sector_type"] = "international"
        payload["trip_type"] = defaults.string(forKey: UserDefaultsKeys.journeyType)
        payload["adult"] = defaults.string(forKey: UserDefaultsKeys.madultCount)
        payload["child"] = defaults.string(forKey: UserDefaultsKeys.mchildCount)
        payload["infant"] = defaults.string(forKey: UserDefaultsKeys.minfantsCount)
        payload["carrier"] = ""
        payload["psscarrier"] = ""
        payload["v_class"] = defaults.string(forKey: UserDefaultsKeys.selectClass) ?? "Economy"
        payload["search_flight"] = "Search"
        payload["search_source"] = "search"
        payload["user_id"] = defaults.string(forKey: UserDefaultsKeys.userid) ?? "0"
        payload["currency"] = defaults.string(forKey: UserDefaultsKeys.selectedCurrency) ?? "KWD"
        payload["placeDetails"] = fromdataArray
        
        
        
        
        var showToastMessage: String? = nil
        
        for cityName in fromCityNameArray {
            if cityName == "" {
                showToastMessage = "Please Select Origin"
                break
            }
        }
        
        if showToastMessage == nil {
            for cityName in toCityNameArray {
                if cityName == "" {
                    showToastMessage = "Please Select Destination"
                    break
                }
            }
        }
        
        if showToastMessage == nil {
            for date in depatureDatesArray {
                if date == "Date" {
                    showToastMessage = "Please Select Date"
                    break
                }
            }
        }
        
        
        
        if showToastMessage == nil {
            if depatureDatesArray != depatureDatesArray.sorted() {
                showToastMessage = "Please Select Dates in Ascending Order"
            } else if depatureDatesArray.count == 2 && depatureDatesArray[0] == depatureDatesArray[1] {
                showToastMessage = "Please Select Different Dates"
            }
        }
        
        
        if let message = showToastMessage {
            showToast(message: message)
        } else {
            do {
                let arrJson = try JSONSerialization.data(withJSONObject: payload, options: JSONSerialization.WritingOptions.prettyPrinted)
                let theJSONText = NSString(data: arrJson, encoding: String.Encoding.utf8.rawValue)
                print(theJSONText ?? "")
                
                payload1["search_params"] = theJSONText
                payload1["user_id"] = defaults.string(forKey: UserDefaultsKeys.userid) ?? "0"
                
                gotoSearchFlightResultVC(input: payload1)
                
            }catch let error as NSError{
                print(error.description)
            }
            
            
        }
        
        
        
    }
    
    
    //MARK: - didTapOnBookFlightBtn
    override func didTapOnBookFlightBtn(cell: DealsCVCell) {
        payload["trip_type"] = cell.trip_type
        payload["adult"] = "1"
        payload["child"] = "0"
        payload["infant"] = "0"
        payload["sector_type"] = "international"
        payload["from"] = cell.fromcity
        payload["from_loc_id"] = cell.from_loc_id
        payload["to"] = cell.tocity
        payload["to_loc_id"] = cell.to_loc_id
        payload["depature"] = cell.depratureDatelbl.text ?? ""
        payload["return"] = cell.returnDatelbl.text ?? ""
        payload["carrier"] = ""
        payload["psscarrier"] = ""
        payload["v_class"] = cell.v_class
        payload["search_flight"] = "Search"
        payload["search_source"] = "search"
        payload["user_id"] = defaults.string(forKey: UserDefaultsKeys.userid) ?? "0"
        payload["currency"] = cell.currency
        
        gotoSearchFlightResultVC(input: payload)
        
    }
    
    
}


extension BookFlightVC {
    
    func addObserverCall() {
        TimerManager.shared.sessionStop()
        NotificationCenter.default.addObserver(self, selector: #selector(reload(notification:)), name: NSNotification.Name("reload"), object: nil)
    }
    
    @objc func reload(notification: NSNotification){
        commonTableView.reloadData()
    }
    
}
