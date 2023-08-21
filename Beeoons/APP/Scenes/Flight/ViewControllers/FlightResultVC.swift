//
//  FlightResultVC.swift
//  Beeoons
//
//  Created by FCI on 10/08/23.
//

import UIKit

class FlightResultVC: BaseTableVC, TimerManagerDelegate {
    
    
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var cityslbl: UILabel!
    @IBOutlet weak var datelbl: UILabel!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var nonStopView: UIView!
    @IBOutlet weak var oneStopView: UIView!
    @IBOutlet weak var moreStopView: UIView!
    @IBOutlet weak var nonStopBtn: UIButton!
    @IBOutlet weak var oneStopBtn: UIButton!
    @IBOutlet weak var moreStopBtn: UIButton!
    @IBOutlet weak var sessionlbl: UILabel!
    @IBOutlet weak var flightscountlbl: UILabel!
    
    let refreshControl = UIRefreshControl()
    var tablerow = [TableRow]()
    var vm:OnewayViewModel?
    var payload = [String:Any]()
    var oneWayFlights = [[J_flight_list]]()
    static var newInstance: FlightResultVC? {
        let storyboard = UIStoryboard(name: Storyboard.Flight.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? FlightResultVC
        return vc
    }
    
    
    
    //MARK: - Loading Functions
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        TimerManager.shared.delegate = self
        
        addObserver()
        if callapibool == true {
            loderBool = true
            holderView.isHidden = true
            callAPI()
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        vm = OnewayViewModel(self)
        setupUI()
    }
    
    
    
    //MARK: - setupUI
    func setupUI() {
        bottomView.addCornerRadiusWithShadow(color: .AppBorderColor, borderColor: .clear, cornerRadius: 4)
        nonStopView.addCornerRadiusWithShadow(color: .clear, borderColor: HexColor("#E0DDDD"), cornerRadius: 4)
        oneStopView.addCornerRadiusWithShadow(color: .clear, borderColor: HexColor("#E0DDDD"), cornerRadius: 4)
        moreStopView.addCornerRadiusWithShadow(color: .clear, borderColor: HexColor("#E0DDDD"), cornerRadius: 4)
        nonStopBtn.addTarget(self, action: #selector(didTapOnStopsFilter(_:)), for: .touchUpInside)
        oneStopBtn.addTarget(self, action: #selector(didTapOnStopsFilter(_:)), for: .touchUpInside)
        moreStopBtn.addTarget(self, action: #selector(didTapOnStopsFilter(_:)), for: .touchUpInside)
        setupRefreshControl()
        commonTableView.registerTVCells(["FlightResultTVCell"])
    }
    
    
    //MARK: - setupRefreshControl
    func setupRefreshControl(){
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        commonTableView.addSubview(refreshControl) // not required when using UITableViewController
    }
    
    
    @objc func refresh(_ sender: AnyObject) {
        // Code to refresh table view
        setupTVCells(jfl: oneWayFlights)
        
        let seconds = 2.0
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            // Put your code which should be executed with a delay here
            self.refreshControl.endRefreshing()
        }
    }
    
    
    
    
    //MARK: - didTapOnFlightDetails
    override func didTapOnFlightDetails(cell:FlightResultTVCell){
        selectedAccesskey = cell.accesskey
        //print(selectedAccesskey)
        goToFlightInfoVC()
    }
    
    
    
    func goToFlightInfoVC() {
        guard let vc = FlightDetailsVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        callapibool = true
        self.present(vc, animated: false)
    }
    
    //MARK: -didTapOnBackBtnAction
    @IBAction func didTapOnBackBtnAction(_ sender: Any) {
        TimerManager.shared.sessionStop()
        guard let vc = BookFlightVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: false)
    }
    
    
    func gotoModifySearchVC() {
        guard let vc = ModifySearchVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: true)
    }
    
    
    //MARK: - didTapOnEditFlightSearchBtnAction
    @IBAction func didTapOnEditFlightSearchBtnAction(_ sender: Any) {
        gotoModifySearchVC()
    }
    
    
    
    @IBAction func disTapOnFilterBtnAction(_ sender: Any) {
        guard let vc = FilterSearchVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        vc.delegate = self
        vc.filterTapKey = "sort"
        self.present(vc, animated: false)
    }
    
    
}

extension FlightResultVC:OnewayViewModelDelegate {
    
    
    //MARK: - CALL_GET_FLIGHT_LIST_API
    func callAPI() {
        
        let journyType = defaults.string(forKey: UserDefaultsKeys.journeyType)
        if journyType == "multicity" {
            
            vm?.CALL_GET_MULTICITY_FLIGHT_LIST_API(dictParam: payload)
        }else {
            vm?.CALL_GET_FLIGHT_LIST_API(dictParam: payload)
        }
    }
    
    func flightList(response: OnewayModel) {
        
        if response.status == 1 {
            holderView.isHidden = false
            loderBool = false
            
            searchid = "\(response.data?.search_id ?? 0)"
            bookingsource = "\(response.data?.booking_source_key ?? "")"
            oneWayFlights = response.data?.j_flight_list ?? [[]]
            cityCodes = "\(response.data?.search_params?.from_loc ?? "")"
            flightscountlbl.text = "\(response.data?.j_flight_list?.count ?? 0) Flights Found"
            
            TimerManager.shared.totalTime = 900
            TimerManager.shared.startTimer()
            
            let journyType = defaults.string(forKey: UserDefaultsKeys.journeyType)
            if journyType == "oneway" {
                cityslbl.text = "\(defaults.string(forKey: UserDefaultsKeys.fromcityname) ?? "")(\(response.data?.search_params?.from_loc ?? "")) - \(defaults.string(forKey: UserDefaultsKeys.tocityname) ?? "")(\(response.data?.search_params?.to_loc ?? ""))"
                datelbl.text = "\(response.data?.search_params?.depature ?? ""),\(response.data?.search_params?.trip_type_label ?? ""),\(response.data?.search_params?.v_class ?? ""),\(defaults.string(forKey: UserDefaultsKeys.travellerDetails) ?? "")"
                
            }else {
                cityslbl.text = "\(defaults.string(forKey: UserDefaultsKeys.rfromcityname) ?? "")(\(response.data?.search_params?.from_loc ?? "")) - \(defaults.string(forKey: UserDefaultsKeys.rtocityname) ?? "")(\(response.data?.search_params?.to_loc ?? ""))"
                datelbl.text = "\(response.data?.search_params?.depature ?? "") - \(response.data?.search_params?.depature ?? ""),\(response.data?.search_params?.trip_type_label ?? ""),\(response.data?.search_params?.v_class ?? ""),\(defaults.string(forKey: UserDefaultsKeys.rtravellerDetails) ?? "")"
                
            }
            
            
            
            appendPriceValuesIntoArray(jfl: oneWayFlights)
            
            DispatchQueue.main.async {
                self.setupTVCells(jfl: self.oneWayFlights)
            }
            
        }else {
            gotoNoInternetConnectionVC(key: "noresult", titleStr: "NO AVAILABILITY FOR THIS REQUEST")
        }
    }
    
    
    
    
    
    
    func appendPriceValuesIntoArray(jfl:[[J_flight_list]]) {
        jfl.forEach { i in
            i.forEach { j in
                
                prices.append("\(j.price?.api_total_display_fare ?? 0.0)")
                fareTypeA.append(j.fareType ?? "")
                
                j.flight_details?.summary?.forEach({ k in
                    
                    airlinesA.append(k.operator_name ?? "")
                    connectingFlightsA.append(k.destination?.loc ?? "")
                    connectingAirportA.append(k.origin?.loc ?? "")
                    
                })
                
                
            }
        }
        
        
        prices = Array(Set(prices))
        noofStopsA = Array(Set(noofStopsA))
        fareTypeA = Array(Set(fareTypeA))
        airlinesA = Array(Set(airlinesA.compactMap { $0 }))
        connectingFlightsA = Array(Set(connectingFlightsA))
        connectingAirportA = Array(Set(connectingAirportA))
    }
    
    
    func setupTVCells(jfl:[[J_flight_list]]) {
        tablerow.removeAll()
        TableViewHelper.EmptyMessage(message: "", tableview: commonTableView, vc: self)
        
        jfl.forEach { i in
            i.forEach { j in
                print(j.access_key)
                tablerow.append(TableRow(title:j.access_key,
                                         kwdprice:"\(j.price?.api_currency ?? ""):\(j.price?.api_total_display_fare ?? 0.0)",
                                         refundable:j.fareType,
                                         moreData: j.flight_details?.summary,
                                         cellType:.FlightResultTVCell))
                
                
            }
            
        }
        
        commonTVData = tablerow
        commonTableView.reloadData()
    }
    
    
    
    
    //MARK: - MULTICITY RESPONSE
    func multicityFlightList(response: MulticityModel) {
        
        if response.status == 1 {
            
            holderView.isHidden = false
            loderBool = false
            searchid = "\(response.data?.search_id ?? 0)"
            bookingsource = "\(response.data?.booking_source_key ?? "")"
            oneWayFlights = response.data?.j_flight_list ?? [[]]
            flightscountlbl.text = "\(response.data?.j_flight_list?.count ?? 0) Flights Found"
            
            appendPriceValuesIntoArray(jfl: oneWayFlights)
            
            DispatchQueue.main.async {
                self.setupTVCells(jfl: self.oneWayFlights)
            }
        }else {
            gotoNoInternetConnectionVC(key: "noresult", titleStr: "NO AVAILABILITY FOR THIS REQUEST")
        }
        
    }
    
    
    
}


extension FlightResultVC:AppliedFilters{
    
    //MARK: - Filters didTapOnStopsFilter
    @objc func didTapOnStopsFilter(_ sender:UIButton){
        
        var filterStr = String()
        var count = 0
        if sender.tag == 1 {
            filterStr = "0"
        }else if sender.tag == 2 {
            filterStr = "1"
        }else {
            filterStr = "2"
        }
        
        let filteredArray = oneWayFlights.map { $0.filter { flight in
            if let segmentSummary = flight.flight_details?.summary {
                return segmentSummary.contains { "\($0.no_of_stops ?? 0)".lowercased().contains(filterStr.lowercased()) }
            } else {
                return false
            }
        }}
        
        
        filteredArray.forEach { i in
            count = i.count
        }
        
        if count == 0 {
            showTableViewHelperMessage()
        }else {
            setupTVCells(jfl: filteredArray)
        }
        
        
        
    }
    
    
    func showTableViewHelperMessage() {
        tablerow.removeAll()
        TableViewHelper.EmptyMessage(message: "No Data Avaliable", tableview: commonTableView, vc: self)
        commonTVData = tablerow
        commonTableView.reloadData()
    }
    
    
    //MARK: - Filters filtersSortByApplied
    func filtersSortByApplied(sortBy: SortParameter) {
        
        
        switch sortBy {
        case .PriceLow:
            
            let sortedFlights = oneWayFlights.sorted { (flights1, flights2) -> Bool in
                let totalPrice1 = flights1.reduce(0.0) { $0 + (Double($1.price?.api_total_display_fare ?? 0.0) ) }
                let totalPrice2 = flights2.reduce(0.0) { $0 + (Double($1.price?.api_total_display_fare ?? 0.0) ) }
                return totalPrice1 < totalPrice2
            }
            
            setupTVCells(jfl: sortedFlights)
            
            break
            
        case .PriceHigh:
            let sortedFlights = oneWayFlights.sorted { (flights1, flights2) -> Bool in
                let totalPrice1 = flights1.reduce(0.0) { $0 + (Double($1.price?.api_total_display_fare ?? 0.0) ) }
                let totalPrice2 = flights2.reduce(0.0) { $0 + (Double($1.price?.api_total_display_fare ?? 0.0) ) }
                return totalPrice1 > totalPrice2
            }
            setupTVCells(jfl: sortedFlights)
            break
            
            
            
        case .DepartureLow:
            let sortedArray = oneWayFlights.sorted(by: { j1, j2 in
                let time1 = j1.first?.flight_details?.summary?.first?.origin?.time ?? "0"
                let time2 = j2.first?.flight_details?.summary?.first?.origin?.time ?? "0"
                return time1 < time2
            })
            
            setupTVCells(jfl: sortedArray)
            break
            
        case .DepartureHigh:
            let sortedArray = oneWayFlights.sorted(by: { j1, j2 in
                let time1 = j1.first?.flight_details?.summary?.first?.origin?.time ?? "0"
                let time2 = j2.first?.flight_details?.summary?.first?.origin?.time ?? "0"
                return time1 > time2
            })
            
            setupTVCells(jfl: sortedArray)
            break
            
            
            
        case .ArrivalLow:
            let sortedArray = oneWayFlights.sorted(by: { j1, j2 in
                let time1 = j1.first?.flight_details?.summary?.first?.destination?.time ?? "0"
                let time2 = j2.first?.flight_details?.summary?.first?.destination?.time ?? "0"
                return time1 < time2
            })
            
            setupTVCells(jfl: sortedArray)
            break
            
        case .ArrivalHigh:
            let sortedArray = oneWayFlights.sorted(by: { j1, j2 in
                let time1 = j1.first?.flight_details?.summary?.first?.destination?.time ?? "0"
                let time2 = j2.first?.flight_details?.summary?.first?.destination?.time ?? "0"
                return time1 > time2
            })
            
            setupTVCells(jfl: sortedArray)
            break
            
            
            
            
        case .DurationLow:
            let sortedArray = oneWayFlights.sorted(by: { j1, j2 in
                let durationseconds1 = j1.first?.flight_details?.summary?.first?.duration_seconds ?? 0
                let durationseconds2 = j2.first?.flight_details?.summary?.first?.duration_seconds ?? 0
                return durationseconds1 < durationseconds2
            })
            
            setupTVCells(jfl: sortedArray)
            
            break
            
        case .DurationHigh:
            
            let sortedArray = oneWayFlights.sorted(by: { j1, j2 in
                let durationseconds1 = j1.first?.flight_details?.summary?.first?.duration_seconds ?? 0
                let durationseconds2 = j2.first?.flight_details?.summary?.first?.duration_seconds ?? 0
                return durationseconds1 > durationseconds2
            })
            
            setupTVCells(jfl: sortedArray)
            break
            
            
        case .airlineaz:
            let sortedArray = oneWayFlights.sorted(by: { j1, j2 in
                let operatorCode1 = j1.first?.flight_details?.summary?.first?.operator_code ?? ""
                let operatorCode2 = j2.first?.flight_details?.summary?.first?.operator_code ?? ""
                return operatorCode1 < operatorCode2
            })
            
            setupTVCells(jfl: sortedArray)
            break
            
        case .airlineza:
            let sortedArray = oneWayFlights.sorted(by: { j1, j2 in
                let operatorCode1 = j1.first?.flight_details?.summary?.first?.operator_code ?? ""
                let operatorCode2 = j2.first?.flight_details?.summary?.first?.operator_code ?? ""
                return operatorCode1 > operatorCode2
            })
            
            setupTVCells(jfl: sortedArray)
            
            break
            
            
        case .nothing:
            setupTVCells(jfl: oneWayFlights)
            break
            
            
        default:
            break
        }
        
        DispatchQueue.main.async {[self] in
            // commonTableView.scrollToRow(at: IndexPath(item: 0, section: 0), at: .top, animated: true)
        }
        
    }
    
    
    //MARK: - Filters filterByApplied
    func filterByApplied(minpricerange: Double, maxpricerange: Double, noofstopsFA: [String], departureTimeFilter: [String], arrivalTimeFilter: [String], airlinesFA: [String], cancellationTypeFA: [String], connectingFlightsFA: [String], connectingAirportsFA: [String]) {
        
        
        print("====minpricerange ==== \(minpricerange)")
        print("====maxpricerange ==== \(maxpricerange)")
        print("==== noofstopsFA ==== \(noofstopsFA)")
        print("==== departureTimeFilter ==== \(departureTimeFilter)")
        print("==== arrivalTimeFilter ==== \(arrivalTimeFilter)")
        print("==== airlinesFA ==== \(airlinesFA)")
        print("==== cancellationTypeFA ==== \(cancellationTypeFA)")
        print("==== connectingFlightsFA ==== \(connectingFlightsFA)")
        print("==== connectingAirportsFA ==== \(connectingAirportsFA)")
        
        
        if let journyType = defaults.string(forKey: UserDefaultsKeys.journeyType) {
            
            let sortedArray = oneWayFlights.filter { flightList in
                
                
                // Calculate the total price for each flight in the flight list
                let totalPrice = flightList.reduce(0.0) { result, flight in
                    result + (Double(flight.price?.api_total_display_fare ?? 0.0) )
                }
                
                // Check if the flight list has at least one flight with the specified number of stops
                let noOfStopsMatch = noofstopsFA.isEmpty || flightList.contains(where: { $0.flight_details?.summary?.contains(where: { noofstopsFA.contains("\($0.no_of_stops ?? 0)") }) ?? false })
                
                // Check if the flight list has at least one flight with the specified airline
                let airlinesMatch = airlinesFA.isEmpty || flightList.contains(where: { $0.flight_details?.summary?.contains(where: { airlinesFA.contains($0.operator_name ?? "") }) ?? false })
                
                // Check if the flight list has at least one flight with the specified cancellation type
                let refundableMatch = cancellationTypeFA.isEmpty || flightList.contains(where: { $0.fareType == cancellationTypeFA.first })
                
                // Check if the flight list has at least one flight with the specified connecting flights
                let connectingFlightsMatch = connectingFlightsFA.isEmpty || flightList.contains(where: { $0.flight_details?.summary?.contains(where: { connectingFlightsFA.contains($0.destination?.loc ?? "") }) ?? false })
                
                // Check if the flight list has at least one flight with the specified connecting airports
                let connectingAirportsMatch = connectingAirportsFA.isEmpty || flightList.contains(where: { $0.flight_details?.summary?.contains(where: { $0.operator_name == connectingAirportsFA.first }) ?? false })
                
                
                
                // Check if the total price is within the specified range
                return totalPrice >= minpricerange && totalPrice <= maxpricerange && noOfStopsMatch && airlinesMatch && refundableMatch && connectingFlightsMatch && connectingAirportsMatch
            }
            
            
            setupTVCells(jfl: sortedArray)
            
        }
        
        
        
    }
    
    
    //MARK: - hotelFilterByApplied
    func hotelFilterByApplied(minpricerange: Double, maxpricerange: Double, starRating: String) {
        
    }
    
}



extension FlightResultVC {
    
    func addObserver() {
        
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
    
    
    
    func  refreshTimerDisplay(){
        // TimerManager.shared.startTimer()
    }
    
    //MARK: - timerDidFinish
    
    func timerDidFinish() {
        guard let vc = PopupVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: false)
    }
    
    func updateTimer() {
        let totalTime = TimerManager.shared.totalTime
        let minutes =  totalTime / 60
        let seconds = totalTime % 60
        let formattedTime = String(format: "%02d:%02d", minutes, seconds)
        sessionlbl.text = "Your Session Expires In: \(formattedTime)"
    }
    
}
