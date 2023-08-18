//
//  AddTravellersVC.swift
//  Beeoons
//
//  Created by FCI on 09/08/23.
//

import UIKit

class AddTravellersVC: BaseTableVC {
    
    
    
    @IBOutlet weak var titlelbl: UILabel!
    
    
    var tableRow = [TableRow]()
    var count = 1
    var keyString = String()
    var adultsCount = 1
    var childCount = 0
    var infantsCount = 0
    var roomCountArray = [Int]()
    
    static var newInstance: AddTravellersVC? {
        let storyboard = UIStoryboard(name: Storyboard.Flight.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? AddTravellersVC
        return vc
    }
    
    
    @objc func offline(){
        //        guard let vc = NoInternetConnectionVC.newInstance.self else {return}
        //        vc.modalPresentationStyle = .fullScreen
        //        callapibool = true
        //        present(vc, animated: false)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        NotificationCenter.default.addObserver(self, selector: #selector(offline), name: NSNotification.Name("offline"), object: nil)
        
        if let selectedTab = defaults.string(forKey: UserDefaultsKeys.tabselect){
            if selectedTab == "FLIGHT" {
                
                if let journeyType = defaults.string(forKey: UserDefaultsKeys.journeyType) {
                    if journeyType == "oneway" {
                        adultsCount = Int(defaults.string(forKey: UserDefaultsKeys.adultCount) ?? "1") ?? 0
                        childCount = Int(defaults.string(forKey: UserDefaultsKeys.childCount) ?? "0") ?? 0
                        infantsCount = Int(defaults.string(forKey: UserDefaultsKeys.infantsCount) ?? "0") ?? 0
                    }else if journeyType == "circle" {
                        adultsCount = Int(defaults.string(forKey: UserDefaultsKeys.radultCount) ?? "1") ?? 0
                        childCount = Int(defaults.string(forKey: UserDefaultsKeys.rchildCount) ?? "0") ?? 0
                        infantsCount = Int(defaults.string(forKey: UserDefaultsKeys.rinfantsCount) ?? "0") ?? 0
                    }else {
                        adultsCount = Int(defaults.string(forKey: UserDefaultsKeys.madultCount) ?? "1") ?? 0
                        childCount = Int(defaults.string(forKey: UserDefaultsKeys.mchildCount) ?? "0") ?? 0
                        infantsCount = Int(defaults.string(forKey: UserDefaultsKeys.minfantsCount) ?? "0") ?? 0
                    }
                }
                
                
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        titlelbl.text = "Choose a passenger"
        commonTableView.backgroundColor = .WhiteColor
        commonTableView.registerTVCells(["RadioButtonTVCell",
                                         "TravellerEconomyTVCell",
                                         "TitleLblTVCell",
                                         "EmptyTVCell",
                                         "ButtonTVCell",
                                         "CommonTVCell",
                                         "checkOptionsTVCell"])
        
        setupSearchFlightEconomyTVCells()
        
        
    }
    
    func setupSearchFlightEconomyTVCells(){
        
        tableRow.removeAll()
        
        
        
        
        if let journeyType = defaults.string(forKey: UserDefaultsKeys.journeyType) {
            if journeyType == "oneway" {
                tableRow.append(TableRow(title:"Adult",subTitle: "+12 yrs",text: "\(defaults.string(forKey: UserDefaultsKeys.adultCount) ?? "1")",cellType:.TravellerEconomyTVCell))
                tableRow.append(TableRow(title:"Children",subTitle: "+2-12 yrs",text: "\(defaults.string(forKey: UserDefaultsKeys.childCount) ?? "0")",cellType:.TravellerEconomyTVCell))
                tableRow.append(TableRow(title:"Infant",subTitle: "Under 2",text: "\(defaults.string(forKey: UserDefaultsKeys.infantsCount) ?? "0")",cellType:.TravellerEconomyTVCell))
            }else if journeyType == "circle" {
                tableRow.append(TableRow(title:"Adult",subTitle: "+12 yrs",text: "\(defaults.string(forKey: UserDefaultsKeys.radultCount) ?? "1")",cellType:.TravellerEconomyTVCell))
                tableRow.append(TableRow(title:"Children",subTitle: "+2-12 yrs",text: "\(defaults.string(forKey: UserDefaultsKeys.rchildCount) ?? "0")",cellType:.TravellerEconomyTVCell))
                tableRow.append(TableRow(title:"Infant",subTitle: "Under 2",text: "\(defaults.string(forKey: UserDefaultsKeys.rinfantsCount) ?? "0")",cellType:.TravellerEconomyTVCell))
            }else {
                tableRow.append(TableRow(title:"Adult",subTitle: "+12 yrs",text: "\(defaults.string(forKey: UserDefaultsKeys.madultCount) ?? "1")",cellType:.TravellerEconomyTVCell))
                tableRow.append(TableRow(title:"Children",subTitle: "+2-12 yrs",text: "\(defaults.string(forKey: UserDefaultsKeys.mchildCount) ?? "0")",cellType:.TravellerEconomyTVCell))
                tableRow.append(TableRow(title:"Infant",subTitle: "Under 2",text: "\(defaults.string(forKey: UserDefaultsKeys.minfantsCount) ?? "0")",cellType:.TravellerEconomyTVCell))
            }
        }
        
        
        
        
        //        tableRow.append(TableRow(height:20,cellType:.EmptyTVCell))
        //        tableRow.append(TableRow(title:"Select Class",cellType:.TitleLblTVCell))
        //        tableRow.append(TableRow(cellType:.CommonTVCell))
        
        tableRow.append(TableRow(height:100,cellType:.EmptyTVCell))
        tableRow.append(TableRow(title:"Done",bgColor: .ButtonColor,cellType:.ButtonTVCell))
        tableRow.append(TableRow(height:50,cellType:.EmptyTVCell))
        
        
        commonTVData = tableRow
        commonTableView.reloadData()
        
    }
    
    
    @objc func gotoBackScreen() {
        self.dismiss(animated: true)
    }
    
    
    
    override func didTapOnIncrementButton(cell: TravellerEconomyTVCell) {
        if cell.titlelbl.text == "Infant" && cell.count >= adultsCount {
            //            showToast(message: "Infant count cannot exceed the number of adults")
            //            showAlertOnWindow(title: "", message: "Infants Cannot Exceed Adults", titles: ["OK"], completionHanlder: nil)
        } else if (adultsCount + childCount) > 8 {
            //            showToast(message: "Total travelers cannot be more than 9")
            //            showAlertOnWindow(title: "", message: "Total Travelers Not More Than 9", titles: ["OK"], completionHanlder: nil)
        } else  {
            if cell.count >= 0 {
                cell.count += 1
                cell.countlbl.text = "\(cell.count)"
            }
            
            if cell.titlelbl.text == "Adult" {
                adultsCount = cell.count
            } else if cell.titlelbl.text == "Children" {
                childCount = cell.count
            } else if cell.titlelbl.text == "Infant" {
                infantsCount = cell.count
            }
        }
        
        print("Total Count === \(adultsCount + childCount + infantsCount)")
        defaults.set((adultsCount + childCount + infantsCount), forKey: UserDefaultsKeys.totalTravellerCount)
    }
    
    
    override func didTapOnDecrementButton(cell: TravellerEconomyTVCell) {
        if cell.titlelbl.text == "Infant" {
            // Decrement the infant count if it's greater than or equal to 0
            if cell.count > 0 {
                cell.count -= 1
            }
            infantsCount = cell.count
        } else {
            if cell.count > 0 {
                cell.count -= 1
            }
            
            if cell.titlelbl.text == "Adult" {
                if cell.count == 0 {
                    cell.count = 1
                }
                adultsCount = cell.count
            } else if cell.titlelbl.text == "Children" {
                childCount = cell.count
            } else {
                infantsCount = cell.count
            }
        }
        
        cell.countlbl.text = "\(cell.count)"
        print("Total Count === \(adultsCount + childCount + infantsCount)")
        defaults.set((adultsCount + childCount + infantsCount), forKey: UserDefaultsKeys.totalTravellerCount)
    }
    
    
    //    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    //        if let cell = tableView.cellForRow(at: indexPath) as? RadioButtonTVCell {
    //            cell.radioImg.image = UIImage(named: "radioSelected")?.withRenderingMode(.alwaysOriginal).withTintColor(.AppBackgroundColor)
    //
    //
    //            if let journeyType = defaults.string(forKey: UserDefaultsKeys.journeyType) {
    //                if journeyType == "oneway" {
    //                    defaults.set(cell.titlelbl.text ?? "", forKey: UserDefaultsKeys.selectClass)
    //                }else if journeyType == "circle" {
    //                    defaults.set(cell.titlelbl.text ?? "", forKey: UserDefaultsKeys.rselectClass)
    //                }else {
    //                    defaults.set(cell.titlelbl.text ?? "", forKey: UserDefaultsKeys.mselectClass)
    //                }
    //            }
    //
    //        }
    //    }
    
    //    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
    //        if let cell = tableView.cellForRow(at: indexPath) as? RadioButtonTVCell {
    //            cell.radioImg.image = UIImage(named: "radioUnselected")
    //        }
    //    }
    
    func gotoBookFlightVC() {
        
        if let journeyType = defaults.string(forKey: UserDefaultsKeys.journeyType) {
            if journeyType == "oneway" {
                
                
                let totaltraverlers = "\(defaults.string(forKey: UserDefaultsKeys.totalTravellerCount) ?? "1") Traveller"
                defaults.set(totaltraverlers, forKey: UserDefaultsKeys.travellerDetails)
                
                
            }else if journeyType == "circle" {
                let totaltraverlers = "\(defaults.string(forKey: UserDefaultsKeys.totalTravellerCount) ?? "1") Traveller"
                defaults.set(totaltraverlers, forKey: UserDefaultsKeys.rtravellerDetails)
            }else{
                let totaltraverlers = "\(defaults.string(forKey: UserDefaultsKeys.totalTravellerCount) ?? "1") Traveller"
                defaults.set(totaltraverlers, forKey: UserDefaultsKeys.mtravellerDetails)
            }
        }
        
        
        
        NotificationCenter.default.post(name: NSNotification.Name("reload"), object: nil)
        self.dismiss(animated: true)
    }
    
    
    
    override func didTapOnBnAction(cell: ButtonTVCell) {
        print("button tap ...")
        print("adultsCount \(adultsCount)")
        print("childCount \(childCount)")
        print("infantsCount \(infantsCount)")
        if cell.titlelbl.text == "Done" {
            if let selectedTab = defaults.string(forKey: UserDefaultsKeys.tabselect){
                if selectedTab == "FLIGHT" {
                    
                    if let journeyType = defaults.string(forKey: UserDefaultsKeys.journeyType) {
                        if journeyType == "oneway" {
                            defaults.set(adultsCount, forKey: UserDefaultsKeys.adultCount)
                            defaults.set(childCount, forKey: UserDefaultsKeys.childCount)
                            defaults.set(infantsCount, forKey: UserDefaultsKeys.infantsCount)
                        }else if journeyType == "circle" {
                            defaults.set(adultsCount, forKey: UserDefaultsKeys.radultCount)
                            defaults.set(childCount, forKey: UserDefaultsKeys.rchildCount)
                            defaults.set(infantsCount, forKey: UserDefaultsKeys.rinfantsCount)
                        }else {
                            defaults.set(adultsCount, forKey: UserDefaultsKeys.madultCount)
                            defaults.set(childCount, forKey: UserDefaultsKeys.mchildCount)
                            defaults.set(infantsCount, forKey: UserDefaultsKeys.minfantsCount)
                        }
                    }
                    
                    gotoBookFlightVC()
                }
            }
        }
    }
    
    
    
    
  
    
    @IBAction func backBtnAction(_ sender: Any) {
        dismiss(animated: true)
    }
    
    
}


