//
//  FlightDetailsVC.swift
//  Beeoons
//
//  Created by FCI on 10/08/23.
//

import UIKit

class FlightDetailsVC: BaseTableVC {
    
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var cityHolderView: UIView!
    @IBOutlet weak var cityslbl: UILabel!
    @IBOutlet weak var hourlbl: UILabel!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var totalPricelbl: UILabel!
    
    
    
    
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
        cityHolderView.addCornerRadiusWithShadow(color: .clear, borderColor: .AppBorderColor, cornerRadius: 0)
        commonTableView.registerTVCells(["AddItineraryTVCell",
                                         "EmptyTVCell",
                                         "LabelTVCell",
                                         "FarBreakdownTVCell",
                                         "BaggageInfoTVCell",
                                         "FareRulesTVCell"])
        
    }
    
    
    
    @IBAction func didTapOnCloseBtnAction(_ sender: Any) {
        dismiss(animated: true)
    }
    
    
    
    
    @IBAction func didTapOnBookNowBtnAction(_ sender: Any) {
        guard let vc = PayNowVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        callapibool = true
        vc.grandTotal = self.totalPricelbl.text ?? ""
        self.present(vc, animated: false)
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
        bggAllowance = response.baggageAllowance ?? []
        
        totalPricelbl.text = response.priceDetails?.grand_total ?? "0"
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
        if adultsCount > 0 && childCount == 0 && infantsCount == 0 {
            tablerow.append(TableRow(passengerType:"Adult",
                                     basefare: farepricedetails?.adultsBasePrice,
                                     tax:farepricedetails?.adultsTaxPrice,
                                     subtotal: farepricedetails?.sub_total_adult,
                                     noofpassengers: "\(adultsCount)",
                                     totalBreakdown:farepricedetails?.adultsTotalPrice,
                                     tripCost:farepricedetails?.grand_total,
                                     cellType: .FarBreakdownTVCell))
            
        }else if adultsCount > 0 && childCount > 0 && infantsCount == 0 {
            
            tablerow.append(TableRow(passengerType:"Adult",
                                     basefare: farepricedetails?.adultsBasePrice,
                                     tax:farepricedetails?.adultsTaxPrice,
                                     subtotal: farepricedetails?.sub_total_adult,
                                     noofpassengers: "\(adultsCount)",
                                     totalBreakdown:farepricedetails?.adultsTotalPrice,
                                     tripCost:farepricedetails?.grand_total,
                                     key: "hide",
                                     cellType: .FarBreakdownTVCell))
            
            tablerow.append(TableRow(passengerType:"Child",
                                     basefare: farepricedetails?.childBasePrice,
                                     tax:farepricedetails?.childTaxPrice,
                                     subtotal: farepricedetails?.sub_total_child,
                                     noofpassengers: "\(childCount)",
                                     totalBreakdown:farepricedetails?.childTotalPrice,
                                     tripCost:farepricedetails?.grand_total,
                                     cellType: .FarBreakdownTVCell))
            
        }else if adultsCount > 0 && childCount == 0 && infantsCount > 0 {
            
            tablerow.append(TableRow(passengerType:"Adult",
                                     basefare: farepricedetails?.adultsBasePrice,
                                     tax:farepricedetails?.adultsTaxPrice,
                                     subtotal: farepricedetails?.sub_total_adult,
                                     noofpassengers: "\(adultsCount)",
                                     totalBreakdown:farepricedetails?.adultsTotalPrice,
                                     tripCost:farepricedetails?.grand_total,
                                     key: "hide",
                                     cellType: .FarBreakdownTVCell))
            
            tablerow.append(TableRow(passengerType:"Infant",
                                     basefare: farepricedetails?.infantBasePrice,
                                     tax:farepricedetails?.infantTaxPrice,
                                     subtotal: farepricedetails?.sub_total_infant,
                                     noofpassengers: "\(infantsCount)",
                                     totalBreakdown:farepricedetails?.infantTotalPrice,
                                     tripCost:farepricedetails?.grand_total,
                                     cellType: .FarBreakdownTVCell))
        }else {
            tablerow.append(TableRow(passengerType:"Adult",
                                     basefare: farepricedetails?.adultsBasePrice,
                                     tax:farepricedetails?.adultsTaxPrice,
                                     subtotal: farepricedetails?.sub_total_adult,
                                     noofpassengers: "\(adultsCount)",
                                     totalBreakdown:farepricedetails?.adultsTotalPrice,
                                     tripCost:farepricedetails?.grand_total,
                                     key: "hide",
                                     cellType: .FarBreakdownTVCell))
            
            tablerow.append(TableRow(passengerType:"Child",
                                     basefare: farepricedetails?.childBasePrice,
                                     tax:farepricedetails?.childTaxPrice,
                                     subtotal: farepricedetails?.sub_total_child,
                                     noofpassengers: "\(childCount)",
                                     totalBreakdown:farepricedetails?.childTotalPrice,
                                     tripCost:farepricedetails?.grand_total,
                                     key: "hide",
                                     cellType: .FarBreakdownTVCell))
            
            tablerow.append(TableRow(passengerType:"Infant",
                                     basefare: farepricedetails?.infantBasePrice,
                                     tax:farepricedetails?.infantTaxPrice,
                                     subtotal: farepricedetails?.sub_total_infant,
                                     noofpassengers: "\(infantsCount)",
                                     totalBreakdown:farepricedetails?.infantTotalPrice,
                                     tripCost:farepricedetails?.grand_total,
                                     cellType: .FarBreakdownTVCell))
            
            
        }
        
        tablerow.append(TableRow(title:"Fare Rules",cellType:.LabelTVCell))
        if fareRulesData.count != 0 {
            fareRulesData.forEach { i in
                tablerow.append(TableRow(title:i.rule_heading,subTitle: i.rule_content?.htmlToString,cellType:.FareRulesTVCell))
            }
        }
        tablerow.append(TableRow(height:20,bgColor: .WhiteColor,cellType:.EmptyTVCell))
        tablerow.append(TableRow(title:"Baggage Info",cellType:.LabelTVCell))
        tablerow.append(TableRow(cellType:.BaggageInfoTVCell))
        tablerow.append(TableRow(height:20,bgColor: .WhiteColor,cellType:.EmptyTVCell))
        
        
        
        commonTVData = tablerow
        commonTableView.reloadData()
    }
    
    
    
}


extension FlightDetailsVC {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? FareRulesTVCell {
            if cell.showBool == true {
                cell.show()
                cell.showBool = false
            }else {
                cell.hide()
                cell.showBool = true
            }
        }
        
        commonTableView.beginUpdates()
        commonTableView.endUpdates()
    }
    
}
