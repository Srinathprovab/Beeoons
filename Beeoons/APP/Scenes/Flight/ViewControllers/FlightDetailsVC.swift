//
//  FlightDetailsVC.swift
//  Beeoons
//
//  Created by FCI on 10/08/23.
//

import UIKit


struct FareRuleData {
    var rule_heading: String?
    var rule_content: String?
    var isExpanded: Bool = false // Initially, all cells are collapsed
}

class FlightDetailsVC: BaseTableVC, TimerManagerDelegate {
    
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var totalPricelbl: UILabel!
    @IBOutlet weak var cityslbl: UILabel!
    @IBOutlet weak var datelbl: UILabel!
    
    var citysArray = [String]()
    var citysString = String()
    var datesString = String()
    var tablerow = [TableRow]()
    var vm : FlightDetailsViewModel?
    var payload = [String:Any]()
    var adultsCount = Int()
    var childCount = Int()
    var infantsCount = Int()
    
    static var newInstance: FlightDetailsVC? {
        let storyboard = UIStoryboard(name: Storyboard.Flight.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? FlightDetailsVC
        return vc
    }
    
    
    
    //MARK: - LOADING FUNCTIONS
    
    override func viewWillAppear(_ animated: Bool) {
        addObserver()
        
        if let journeyType = defaults.string(forKey: UserDefaultsKeys.journeyType) {
            if journeyType == "oneway" {
                adultsCount = Int(defaults.string(forKey: UserDefaultsKeys.adultCount) ?? "1") ?? 0
                childCount = Int(defaults.string(forKey: UserDefaultsKeys.childCount) ?? "0") ?? 0
                infantsCount = Int(defaults.string(forKey: UserDefaultsKeys.infantsCount) ?? "0") ?? 0
                
                
            }else if journeyType == "circle"{
                adultsCount = Int(defaults.string(forKey: UserDefaultsKeys.radultCount) ?? "1") ?? 0
                childCount = Int(defaults.string(forKey: UserDefaultsKeys.rchildCount) ?? "0") ?? 0
                infantsCount = Int(defaults.string(forKey: UserDefaultsKeys.rinfantsCount) ?? "0") ?? 0
            }else {
                
                adultsCount = Int(defaults.string(forKey: UserDefaultsKeys.madultCount) ?? "1") ?? 0
                childCount = Int(defaults.string(forKey: UserDefaultsKeys.mchildCount) ?? "0") ?? 0
                infantsCount = Int(defaults.string(forKey: UserDefaultsKeys.minfantsCount) ?? "0") ?? 0
            }
        }
        
        if callapibool == true {
            holderView.isHidden = true
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
        bottomView.addCornerRadiusWithShadow(color: .AppBorderColor, borderColor: .clear, cornerRadius: 4)
        commonTableView.bounces = false
        commonTableView.registerTVCells(["AddItineraryTVCell",
                                         "EmptyTVCell",
                                         "LabelTVCell",
                                         "FarBreakdownTVCell",
                                         "AddFareBreakDownTVCell",
                                         "BaggageInfoTVCell",
                                         "AddFareRulesTVCell",
                                         "FareRulesTVCell"])
        
    }
    
    
    
    //MARK: -didTapOnBackBtnAction
    @IBAction func didTapOnBackBtnAction(_ sender: Any) {
        dismiss(animated: true)
    }
    
    
    
    
    
    @IBAction func didTapOnBookNowBtnAction(_ sender: Any) {
        guard let vc = ContactInfoVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        callapibool = true
        self.present(vc, animated: false)
    }
    
    
    
    
    override func didTapOnFareRulesBtnAction(cell: AddFareRulesTVCell) {
        commonTableView.reloadData()
    }
    
    
    override func showContentBtnAction(cell:FareRulesTVCell){
        if cell.showBool == true {
            cell.show()
            cell.showBool = false
        }else {
            cell.hide()
            cell.showBool = true
        }
        
        
        commonTableView.reloadData()
    }
    
    
}



extension FlightDetailsVC:FlightDetailsViewModelDelegate {
    func callAPI(){
        payload["search_id"] = searchid
        payload["booking_source"] = bookingsource
        payload["user_id"] = defaults.string(forKey: UserDefaultsKeys.userid) ?? "0"
        payload["access_key"] = selectedAccesskey
        
        vm?.CALL_GET_FLIGHT_DETAILS_API(dictParam: payload)
    }
    
    func flightDetails(response: FlightDetailsModel) {
        self.view.backgroundColor = .black.withAlphaComponent(0.6)
        holderView.isHidden = false
        fd = response.flightDetails ?? [[]]
        fareRulesData = response.fareRulehtml ?? []
        farepricedetails = response.priceDetails
        grandTotal = response.priceDetails?.grand_total ?? ""
        bggAllowance = response.baggageAllowance ?? []
        totalPricelbl.text = "\(response.priceDetails?.api_currency ?? "") : \(response.priceDetails?.grand_total ?? "")"
        
        
        bggAllowance.forEach { i in
            citysArray.append("\(i.journeySummary ?? "")")
        }
        
        
       
        if let fareRulehtmlArray = response.fareRulehtml {
            for item in fareRulehtmlArray {
                let rule_heading = item.rule_heading
                let rule_content = item.rule_content

                // Now you can use rule_heading and rule_content for each item
                let fareRule = FareRuleData(rule_heading: rule_heading, rule_content: rule_content)
                fareRulesData1.append(fareRule)
            }
        }

        
        DispatchQueue.main.async {
            self.setupItineraryTVCells()
        }
    }
    
    
    
    func setupItineraryTVCells() {
        tablerow.removeAll()
        
        tablerow.append(TableRow(title:"Flight Itinerary",cellType:.LabelTVCell))
        fd.forEach { i in
            tablerow.append(TableRow(moreData:i,cellType:.AddItineraryTVCell))
        }
        
        tablerow.append(TableRow(title:"Fare Breakdown",cellType:.LabelTVCell))
        tablerow.append(TableRow(cellType:.AddFareBreakDownTVCell))
        if fareRulesData.count != 0 {
            tablerow.append(TableRow(cellType:.AddFareRulesTVCell))
        }

        tablerow.append(TableRow(title:"Baggage Info",cellType:.LabelTVCell))
        tablerow.append(TableRow(cellType:.BaggageInfoTVCell))
        tablerow.append(TableRow(height:20,bgColor: .WhiteColor,cellType:.EmptyTVCell))
        
        
        
        commonTVData = tablerow
        commonTableView.reloadData()
    }
    
    
    
}


extension FlightDetailsVC {
    
    func addObserver() {
        TimerManager.shared.delegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(nointernet), name: Notification.Name("offline"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(reload), name: NSNotification.Name("reloadTV"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(resultnil), name: NSNotification.Name("resultnil"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(reloadTimer), name: NSNotification.Name("reloadTimer"), object: nil)
        
    }
    
    
    
    @objc func reloadTimer(){
        DispatchQueue.main.async {
            TimerManager.shared.delegate = self
        }
    }
    
    @objc func nointernet(){
        gotoNoInternetConnectionVC(key: "nointernet", titleStr: "")
    }
    
    @objc func resultnil(){
        gotoNoInternetConnectionVC(key: "noresult", titleStr: "NO AVAILABILITY FOR THIS REQUEST")
    }
    
    @objc func reload(){
        DispatchQueue.main.async {
            self.callAPI()
        }
    }
    
    
    func gotoNoInternetConnectionVC(key:String,titleStr:String) {
        guard let vc = NoInternetConnectionVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        vc.key = key
        vc.titleStr = titleStr
        self.present(vc, animated: false)
    }
    
    //MARK: - timerDidFinish
    
    func timerDidFinish() {
        guard let vc = PopupVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: false)
    }
    
    func updateTimer() {
        
    }
    
    
}
