//
//  FilterSearchVC.swift
//  Beeoons
//
//  Created by FCI on 10/08/23.
//

import UIKit

enum SortParameter {
    case PriceHigh
    case PriceLow
    case DurationHigh
    case DurationLow
    case DepartureHigh
    case DepartureLow
    case ArrivalHigh
    case ArrivalLow
    case starLow
    case starHeigh
    case airlineaz
    case airlineza
    case nothing
}

protocol AppliedFilters:AnyObject {
    
    func filtersSortByApplied(sortBy: SortParameter)
    func filterByApplied(minpricerange:Double,
                         maxpricerange:Double,
                         noofstopsFA:[String],
                         departureTimeFilter:[String],
                         arrivalTimeFilter:[String],
                         airlinesFA:[String],
                         cancellationTypeFA:[String],
                         connectingFlightsFA:[String],
                         connectingAirportsFA:[String])
    
    func hotelFilterByApplied(minpricerange:Double,
                              maxpricerange:Double,
                              starRating: String)
    
}



class FilterSearchVC: BaseTableVC {
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var closeBtn: UIButton!
    @IBOutlet weak var buttonsView: UIView!
    @IBOutlet weak var sortview: UIView!
    @IBOutlet weak var sortlbl: UILabel!
    @IBOutlet weak var sortul: UIView!
    @IBOutlet weak var sortbtn: UIButton!
    @IBOutlet weak var filterview: UIView!
    @IBOutlet weak var filterlbl: UILabel!
    @IBOutlet weak var filterul: UIView!
    @IBOutlet weak var filterbtn: UIButton!
    @IBOutlet weak var buttonsViewHeight: NSLayoutConstraint!
    
    
    static var newInstance: FilterSearchVC? {
        let storyboard = UIStoryboard(name: Storyboard.Flight.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? FilterSearchVC
        return vc
    }
    
    var sortBy: SortParameter = .nothing
    weak var delegate: AppliedFilters?
    var tablerow = [TableRow]()
    var departurnTimeArray = ["12 am - 6 am","06 am - 12 pm","12 pm - 06 pm","06 pm - 12 am"]
    var hpricesArray = ["Deal","Name"," Star"]
    var amenitiesArray = ["Wi-Fi","Breakfast","Parking","Swimming Pool"]
    var amenitiesArray1 = ["Others(379)","Others(379)"]
    
    var filterTapKey = String()
    var minpricerangefilter = Double()
    var maxpricerangefilter = Double()
    
    var noOfStopsFilterArray = [String]()
    var refundablerTypeFilteArray = [String]()
    var departureTimeFilter = [String]()
    var arrivalTimeFilter = [String]()
    var airlinesFilterArray = [String]()
    var connectingFlightsFilterArray = [String]()
    var ConnectingAirportsFilterArray = [String]()
    
    var starRatingFilter = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupUI()
        
    }
    
    
    func setupUI() {
        self.view.backgroundColor = .clear
        holderView.backgroundColor = .black.withAlphaComponent(0.3)
        commonTableView.backgroundColor = .WhiteColor
        closeBtn.setTitle("", for: .normal)
        
        
        
        sortview.backgroundColor = .WhiteColor
        sortul.backgroundColor = .ButtonColor
        sortbtn.setTitle("", for: .normal)
        sortbtn.addTarget(self, action: #selector(didTapOnSortBtnAction(_:)), for: .touchUpInside)
        
        
        filterview.backgroundColor = .WhiteColor
        filterul.backgroundColor = .WhiteColor
        filterbtn.setTitle("", for: .normal)
        filterbtn.addTarget(self, action: #selector(didTapOnFilterBtnAction(_:)), for: .touchUpInside)
        
        commonTableView.registerTVCells(["EmptyTVCell",
                                         "CheckBoxTVCell",
                                         "SliderTVCell",
                                         "ButtonTVCell",
                                         "SortByPriceTVCell",
                                         "StarRatingTVCell"])
        if let tabSelected = defaults.string(forKey: UserDefaultsKeys.tabselect) {
            if tabSelected == "FLIGHT" {
                buttonsView.layer.cornerRadius = 8
                buttonsView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
                buttonsView.clipsToBounds = true
                buttonsViewHeight.constant = 50
                if filterTapKey == "filter" {
                    setupFilterTVCells()
                }else {
                    setupSortTVCells()
                }
                
            }else {
                commonTableView.layer.cornerRadius = 8
                commonTableView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
                commonTableView.clipsToBounds = true
                buttonsViewHeight.constant = 0
              //  setupHotelFilterTVCells()
            }
        }
    }
    
    
    
    @objc func didTapOnSortBtnAction(_ sender:UIButton) {
        filterTapKey = "sort"
        sortul.backgroundColor = .NavBackColor
        filterul.backgroundColor = .WhiteColor
        setupSortTVCells()
    }
    
    @objc func didTapOnFilterBtnAction(_ sender:UIButton) {
        filterTapKey = "filter"
        sortul.backgroundColor = .WhiteColor
        filterul.backgroundColor = .NavBackColor
        setupFilterTVCells()
    }
    
    func setupFilterTVCells() {
        tablerow.removeAll()
        
        //  tablerow.append(TableRow(height:20,cellType:.EmptyTVCell))
        tablerow.append(TableRow(title:"Prices",cellType:.SliderTVCell))
    //    tablerow.append(TableRow(title:"No Of Stops",data: noofStopsA,cellType:.CheckBoxTVCell))
        tablerow.append(TableRow(title:"Outbound Departurn Time",key:"time", data: departurnTimeArray,cellType:.CheckBoxTVCell))
        tablerow.append(TableRow(title:"Inbound Departurn Time",key:"time", data: departurnTimeArray,cellType:.CheckBoxTVCell))
        tablerow.append(TableRow(title:"Airlines",data: airlinesA,cellType:.CheckBoxTVCell))
        tablerow.append(TableRow(title:"Cancellations Type",data: fareTypeA,cellType:.CheckBoxTVCell))
        tablerow.append(TableRow(title:"Connecting Flights",data: connectingFlightsA,cellType:.CheckBoxTVCell))
        tablerow.append(TableRow(title:"Connecting Airports",data: connectingAirportA,cellType:.CheckBoxTVCell))
        
        
        tablerow.append(TableRow(height:50,cellType:.EmptyTVCell))
        tablerow.append(TableRow(title:"Apply",key: "hotel",bgColor: .ButtonColor,cellType:.ButtonTVCell))
        tablerow.append(TableRow(height:50,cellType:.EmptyTVCell))
        
        
        commonTVData = tablerow
        commonTableView.reloadData()
        
    }
    
    
    
    func setupSortTVCells() {
        tablerow.removeAll()
        
        // tablerow.append(TableRow(height:20,cellType:.EmptyTVCell))
        tablerow.append(TableRow(title:"PRICE",subTitle: "Low to high",buttonTitle: "High to low",cellType:.SortByPriceTVCell))
        tablerow.append(TableRow(title:"Departure Time",subTitle: "Earlist  flight",buttonTitle: "Latest flight",cellType:.SortByPriceTVCell))
        tablerow.append(TableRow(title:"Arrival Time",subTitle: "Earlist  flight",buttonTitle: "Latest flight",cellType:.SortByPriceTVCell))
        tablerow.append(TableRow(title:"Duration",subTitle: "Low to high",buttonTitle: "High to low",cellType:.SortByPriceTVCell))
        tablerow.append(TableRow(title:"AIRLINE",subTitle: "A-Z",buttonTitle: "Z-A",cellType:.SortByPriceTVCell))
        
        
        tablerow.append((TableRow(height:30,cellType: .EmptyTVCell)))
        tablerow.append((TableRow(title:"Apply",key: "btn",bgColor: .ButtonColor,cellType: .ButtonTVCell)))
        tablerow.append((TableRow(height:50,cellType: .EmptyTVCell)))
        
        
        commonTVData = tablerow
        commonTableView.reloadData()
    }
    
    
    
//    func setupHotelFilterTVCells() {
//        buttonsView.isHidden = true
//        tablerow.removeAll()
//
//        tablerow.append(TableRow(height:10,cellType:.EmptyTVCell))
//        tablerow.append(TableRow(title:"Prices",key: "hotel",cellType:.SliderTVCell))
//        tablerow.append(TableRow(title:"Star Rating",cellType:.StarRatingTVCell))
//        //        tablerow.append(TableRow(title:"Amenities",key: "hotel",data: amenitiesArray,cellType:.CheckBoxTVCell))
//        //        tablerow.append(TableRow(title:"Amenities",key: "hotel",data: amenitiesArray1,cellType:.CheckBoxTVCell))
//        if facilityArray.count != 0 {
//            tablerow.append(TableRow(title:"Facilities",key: "hotel",data: facilityArray,cellType:.CheckBoxTVCell))
//        }
//        tablerow.append(TableRow(height:50,cellType:.EmptyTVCell))
//        tablerow.append(TableRow(title:"Apply",key: "hotel",cellType:.ButtonTVCell))
//        tablerow.append(TableRow(height:50,cellType:.EmptyTVCell))
//
//
//        commonTVData = tablerow
//        commonTableView.reloadData()
//
//    }
    
    
    
    override func didTapOnShowSliderBtn(cell: SliderTVCell) {
        
        
        print("Selected minimum value: \(cell.minValue1)")
        print("Selected maximum value: \(cell.maxValue1)")
        
        minpricerangefilter = cell.minValue1
        maxpricerangefilter = cell.maxValue1
    }
    
    
    
    override func didTapOnLowToHeighBtnAction(cell: SortByPriceTVCell) {
        
        if cell.titlelbl.text == "PRICE" {
            sortBy = .PriceLow
            
            if let cell2 = commonTableView.cellForRow(at: IndexPath(item: 1, section: 0)) as? SortByPriceTVCell {
                resetSortBy(cell: cell2)
            }
            
            if let cell3 = commonTableView.cellForRow(at: IndexPath(item: 2, section: 0)) as? SortByPriceTVCell {
                resetSortBy(cell: cell3)
            }
            if let cell4 = commonTableView.cellForRow(at: IndexPath(item: 3, section: 0)) as? SortByPriceTVCell {
                resetSortBy(cell: cell4)
            }
            
            if let cell5 = commonTableView.cellForRow(at: IndexPath(item: 4, section: 0)) as? SortByPriceTVCell {
                resetSortBy(cell: cell5)
            }
        }else if cell.titlelbl.text == "Departure Time" {
            sortBy = .DepartureLow
            
            if let cell1 = commonTableView.cellForRow(at: IndexPath(item: 0, section: 0)) as? SortByPriceTVCell {
                resetSortBy(cell: cell1)
            }
            
            if let cell3 = commonTableView.cellForRow(at: IndexPath(item: 2, section: 0)) as? SortByPriceTVCell {
                resetSortBy(cell: cell3)
            }
            if let cell4 = commonTableView.cellForRow(at: IndexPath(item: 3, section: 0)) as? SortByPriceTVCell {
                resetSortBy(cell: cell4)
            }
            
            if let cell5 = commonTableView.cellForRow(at: IndexPath(item: 4, section: 0)) as? SortByPriceTVCell {
                resetSortBy(cell: cell5)
            }
        }else if cell.titlelbl.text == "Arrival Time" {
            sortBy = .ArrivalLow
            if let cell1 = commonTableView.cellForRow(at: IndexPath(item: 0, section: 0)) as? SortByPriceTVCell {
                resetSortBy(cell: cell1)
            }
            if let cell2 = commonTableView.cellForRow(at: IndexPath(item: 1, section: 0)) as? SortByPriceTVCell {
                resetSortBy(cell: cell2)
            }
            
            
            if let cell4 = commonTableView.cellForRow(at: IndexPath(item: 3, section: 0)) as? SortByPriceTVCell {
                resetSortBy(cell: cell4)
            }
            
            if let cell5 = commonTableView.cellForRow(at: IndexPath(item: 4, section: 0)) as? SortByPriceTVCell {
                resetSortBy(cell: cell5)
            }
        }else if cell.titlelbl.text == "Duration" {
            sortBy = .DurationLow
            
            if let cell1 = commonTableView.cellForRow(at: IndexPath(item: 0, section: 0)) as? SortByPriceTVCell {
                resetSortBy(cell: cell1)
            }
            if let cell2 = commonTableView.cellForRow(at: IndexPath(item: 1, section: 0)) as? SortByPriceTVCell {
                resetSortBy(cell: cell2)
            }
            
            if let cell3 = commonTableView.cellForRow(at: IndexPath(item: 2, section: 0)) as? SortByPriceTVCell {
                resetSortBy(cell: cell3)
            }
            
            if let cell5 = commonTableView.cellForRow(at: IndexPath(item: 4, section: 0)) as? SortByPriceTVCell {
                resetSortBy(cell: cell5)
            }
            
        }else {
            sortBy = .airlineaz
            if let cell1 = commonTableView.cellForRow(at: IndexPath(item: 0, section: 0)) as? SortByPriceTVCell {
                resetSortBy(cell: cell1)
            }
            if let cell2 = commonTableView.cellForRow(at: IndexPath(item: 1, section: 0)) as? SortByPriceTVCell {
                resetSortBy(cell: cell2)
            }
            
            if let cell3 = commonTableView.cellForRow(at: IndexPath(item: 2, section: 0)) as? SortByPriceTVCell {
                resetSortBy(cell: cell3)
            }
            if let cell4 = commonTableView.cellForRow(at: IndexPath(item: 3, section: 0)) as? SortByPriceTVCell {
                resetSortBy(cell: cell4)
            }
            
        }
        
        
    }
    
    override func didTapOnHeighToLowBtnAction(cell: SortByPriceTVCell) {
        
        if cell.titlelbl.text == "PRICE" {
            sortBy = .PriceHigh
            
            
            if let cell2 = commonTableView.cellForRow(at: IndexPath(item: 1, section: 0)) as? SortByPriceTVCell {
                resetSortBy(cell: cell2)
            }
            
            if let cell3 = commonTableView.cellForRow(at: IndexPath(item: 2, section: 0)) as? SortByPriceTVCell {
                resetSortBy(cell: cell3)
            }
            if let cell4 = commonTableView.cellForRow(at: IndexPath(item: 3, section: 0)) as? SortByPriceTVCell {
                resetSortBy(cell: cell4)
            }
            
            if let cell5 = commonTableView.cellForRow(at: IndexPath(item: 4, section: 0)) as? SortByPriceTVCell {
                resetSortBy(cell: cell5)
            }
        }else if cell.titlelbl.text == "Departure Time" {
            sortBy = .DepartureHigh
            
            if let cell1 = commonTableView.cellForRow(at: IndexPath(item: 0, section: 0)) as? SortByPriceTVCell {
                resetSortBy(cell: cell1)
            }
            
            if let cell3 = commonTableView.cellForRow(at: IndexPath(item: 2, section: 0)) as? SortByPriceTVCell {
                resetSortBy(cell: cell3)
            }
            if let cell4 = commonTableView.cellForRow(at: IndexPath(item: 3, section: 0)) as? SortByPriceTVCell {
                resetSortBy(cell: cell4)
            }
            
            if let cell5 = commonTableView.cellForRow(at: IndexPath(item: 4, section: 0)) as? SortByPriceTVCell {
                resetSortBy(cell: cell5)
            }
        }else if cell.titlelbl.text == "Arrival Time" {
            sortBy = .ArrivalHigh
            if let cell1 = commonTableView.cellForRow(at: IndexPath(item: 0, section: 0)) as? SortByPriceTVCell {
                resetSortBy(cell: cell1)
            }
            if let cell2 = commonTableView.cellForRow(at: IndexPath(item: 1, section: 0)) as? SortByPriceTVCell {
                resetSortBy(cell: cell2)
            }
            
            
            if let cell4 = commonTableView.cellForRow(at: IndexPath(item: 3, section: 0)) as? SortByPriceTVCell {
                resetSortBy(cell: cell4)
            }
            
            if let cell5 = commonTableView.cellForRow(at: IndexPath(item: 4, section: 0)) as? SortByPriceTVCell {
                resetSortBy(cell: cell5)
            }
        }else if cell.titlelbl.text == "Duration" {
            sortBy = .DurationHigh
            
            if let cell1 = commonTableView.cellForRow(at: IndexPath(item: 0, section: 0)) as? SortByPriceTVCell {
                resetSortBy(cell: cell1)
            }
            if let cell2 = commonTableView.cellForRow(at: IndexPath(item: 1, section: 0)) as? SortByPriceTVCell {
                resetSortBy(cell: cell2)
            }
            
            if let cell3 = commonTableView.cellForRow(at: IndexPath(item: 2, section: 0)) as? SortByPriceTVCell {
                resetSortBy(cell: cell3)
            }
            
            if let cell5 = commonTableView.cellForRow(at: IndexPath(item: 4, section: 0)) as? SortByPriceTVCell {
                resetSortBy(cell: cell5)
            }
            
        }else {
            sortBy = .airlineza
            if let cell1 = commonTableView.cellForRow(at: IndexPath(item: 0, section: 0)) as? SortByPriceTVCell {
                resetSortBy(cell: cell1)
            }
            if let cell2 = commonTableView.cellForRow(at: IndexPath(item: 1, section: 0)) as? SortByPriceTVCell {
                resetSortBy(cell: cell2)
            }
            
            if let cell3 = commonTableView.cellForRow(at: IndexPath(item: 2, section: 0)) as? SortByPriceTVCell {
                resetSortBy(cell: cell3)
            }
            if let cell4 = commonTableView.cellForRow(at: IndexPath(item: 3, section: 0)) as? SortByPriceTVCell {
                resetSortBy(cell: cell4)
            }
            
        }
        
        
    }
    
    
    func resetSortBy(cell:SortByPriceTVCell) {
        cell.lowlbl.textColor = .TitleColor
        cell.lowView.backgroundColor = .WhiteColor
        cell.heighlbl.textColor = .TitleColor
        cell.heightView.backgroundColor = .WhiteColor
    }
    
    
    override func didTapOnCheckBoxDropDownBtn(cell:CheckBoxTVCell){
        print("didTapOnCheckBoxDropDownBtn")
    }
    
    
    override func didTapOnShowMoreBtn(cell:CheckBoxTVCell){
        print("didTapOnShowMoreBtn")
    }
    
    
//    override func didTapOnStarRatingCell(cell: StarRatingCVCell) {
//        starRatingFilter = cell.titlelbl.text ?? ""
//    }
    
    
    
    @IBAction func didTapOnCloseBtn(_ sender: Any) {
        dismiss(animated: true)
    }
    
    
    
    override func didTapOnCheckBox(cell:checkOptionsTVCell){
        
        switch cell.filtertitle {
        
        case "Outbound Departurn Time":
            departureTimeFilter.append(cell.titlelbl.text ?? "")
            break
            
        case "Inbound Departurn Time":
            arrivalTimeFilter.append(cell.titlelbl.text ?? "")
            break
            
        case "Cancellations Type":
            
            if cell.titlelbl.text == "Refundable" {
                refundablerTypeFilteArray.append("Refundable")
            }else {
                refundablerTypeFilteArray.append("Non Refundable")
            }
            print(refundablerTypeFilteArray.joined(separator: "---"))
            break
            
        case "Airlines":
            airlinesFilterArray.append(cell.titlelbl.text ?? "")
            print(airlinesFilterArray.joined(separator: "---"))
            break
            
            
            
        case "Connecting Flights":
            connectingFlightsFilterArray.append(cell.titlelbl.text ?? "")
            print(connectingFlightsFilterArray.joined(separator: "---"))
            break
            
            
        case "Connecting Airports":
            ConnectingAirportsFilterArray.append(cell.titlelbl.text ?? "")
            print(ConnectingAirportsFilterArray.joined(separator: "---"))
            break
            
            
            
        default:
            break
        }
        
    }
    
    
    override func didTapOnDeselectCheckBox(cell:checkOptionsTVCell){
        
        
        switch cell.filtertitle {
       
            
            
        case "Outbound Departurn Time":
            if let index = departureTimeFilter.firstIndex(of: cell.titlelbl.text ?? "") {
                departureTimeFilter.remove(at: index)
            }
            break
            
        case "Inbound Departurn Time":
            if let index = arrivalTimeFilter.firstIndex(of: cell.titlelbl.text ?? "") {
                arrivalTimeFilter.remove(at: index)
            }
            break
            
        case "Cancellations Type":
            
            if cell.titlelbl.text == "Refundable" {
                if let index = refundablerTypeFilteArray.firstIndex(of: "Refundable") {
                    refundablerTypeFilteArray.remove(at: index)
                }
            }else {
                if let index = refundablerTypeFilteArray.firstIndex(of: "Non Refundable") {
                    refundablerTypeFilteArray.remove(at: index)
                }
            }
            print(refundablerTypeFilteArray)
            break
            
            
        case "Airlines":
            if let index = airlinesFilterArray.firstIndex(of: cell.titlelbl.text ?? "") {
                airlinesFilterArray.remove(at: index)
            }
            print(airlinesFilterArray.joined(separator: "---"))
            break
            
            
        case "Connecting Flights":
            if let index = connectingFlightsFilterArray.firstIndex(of: cell.titlelbl.text ?? "") {
                connectingFlightsFilterArray.remove(at: index)
            }
            print(connectingFlightsFilterArray.joined(separator: "---"))
            break
            
            
        case "Connecting Airports":
            if let index = ConnectingAirportsFilterArray.firstIndex(of: cell.titlelbl.text ?? "") {
                ConnectingAirportsFilterArray.remove(at: index)
            }
            print(ConnectingAirportsFilterArray.joined(separator: "---"))
            break
            
            
            
        default:
            break
        }
    }
    
    
    
    override func didTapOnBnAction(cell: ButtonTVCell) {
        
        
        if let tabSelected = defaults.string(forKey: UserDefaultsKeys.tabselect) {
            if tabSelected == "FLIGHT" {
                if filterTapKey == "sort" {
                    delegate?.filtersSortByApplied(sortBy: sortBy)
                }else {
                    
                    if minpricerangefilter.isZero == true && maxpricerangefilter.isZero == true{
                        let pricesFloat = prices.compactMap { Float($0) }
                        minpricerangefilter = Double(pricesFloat.min() ?? 0.0)
                        maxpricerangefilter = Double(pricesFloat.max() ?? 0.0)
                    }
                    
                    delegate?.filterByApplied(minpricerange: minpricerangefilter, maxpricerange: maxpricerangefilter, noofstopsFA: noOfStopsFilterArray,departureTimeFilter: departureTimeFilter,arrivalTimeFilter: arrivalTimeFilter, airlinesFA: airlinesFilterArray, cancellationTypeFA: refundablerTypeFilteArray, connectingFlightsFA: connectingFlightsFilterArray, connectingAirportsFA: ConnectingAirportsFilterArray)
                }
            }else {
                
                if minpricerangefilter.isZero == true && maxpricerangefilter.isZero == true{
                    let pricesFloat = prices.compactMap { Float($0) }
                    minpricerangefilter = Double(pricesFloat.min() ?? 0.0)
                    maxpricerangefilter = Double(pricesFloat.max() ?? 0.0)
                }
                
                delegate?.hotelFilterByApplied(minpricerange: minpricerangefilter,
                                               maxpricerange: maxpricerangefilter,
                                               starRating: starRatingFilter)
            }
        }
        
        callapibool = false
        dismiss(animated: true)
    }
    
    
    
}


extension FilterSearchVC {
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let cell = tableView.cellForRow(at: indexPath) as? CheckBoxTVCell {
            
            if cell.showbool == true {
                cell.expand()
                cell.showbool = false
            }else {
                cell.hide()
                cell.showbool = true
            }
            
        }else if let cell = tableView.cellForRow(at: indexPath) as? SliderTVCell {
            if cell.showbool == true {
                cell.expand()
                cell.showbool = false
            }else {
                cell.hide()
                cell.showbool = true
            }
        }
        
        UIView.animate(withDuration: 0.3) {
            tableView.performBatchUpdates(nil)
        }
    }
    
}

