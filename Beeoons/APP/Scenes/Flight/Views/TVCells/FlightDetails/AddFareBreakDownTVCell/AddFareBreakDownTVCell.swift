//
//  AddFareBreakDownTVCell.swift
//  Beeoons
//
//  Created by FCI on 04/10/23.
//

import UIKit

class AddFareBreakDownTVCell: TableViewCell {

    @IBOutlet weak var addinfoTV: UITableView!
    @IBOutlet weak var tvHeight: NSLayoutConstraint!
    
    var adultsCount = Int()
    var childCount = Int()
    var infantsCount = Int()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func setupUI(){
        
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
        
        
        if adultsCount > 0 && childCount == 0 && infantsCount == 0 {
            updateHeight(height: 240, count: 1)
        }else if adultsCount > 0 && childCount > 0 && infantsCount == 0 {
            updateHeight(height: 240, count: 2)
        }else if adultsCount > 0 && childCount == 0 && infantsCount > 0 {
            updateHeight(height: 240, count: 2)
        }else {
            updateHeight(height: 240, count: 3)
        }
        
        setupTV()
    }
    
    
    func updateHeight(height:Int,count:Int) {
        tvHeight.constant = CGFloat(height * count)
        addinfoTV.reloadData()
    }
    
}


extension AddFareBreakDownTVCell:UITableViewDelegate,UITableViewDataSource {
    
    
    func setupTV() {
        addinfoTV.register(UINib(nibName: "FarBreakdownTVCell", bundle: nil), forCellReuseIdentifier: "cell")
        addinfoTV.delegate = self
        addinfoTV.dataSource = self
        addinfoTV.tableFooterView = UIView()
        addinfoTV.separatorStyle = .none
        addinfoTV.isScrollEnabled = false
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if adultsCount > 0 && childCount == 0 && infantsCount == 0 {
            return 1
        }else if adultsCount > 0 && childCount > 0 && infantsCount == 0 {
            return 2
        }else if adultsCount > 0 && childCount == 0 && infantsCount > 0 {
            return 2
        }else {
            return 3
        }
        
        
    }
    

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var commonCell = UITableViewCell()
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? FarBreakdownTVCell {
            cell.selectionStyle = .none
            
            if adultsCount > 0 && childCount == 0 && infantsCount == 0 {
                
                cell.passengerTypelbl.text = "Adult"
                cell.basefarelbl.text = farepricedetails?.adultsBasePrice
                cell.taxlbl.text = farepricedetails?.adultsTaxPrice
                cell.subtotallbl.text = farepricedetails?.sub_total_adult
                cell.noofpassengerslbl.text = "\(adultsCount)"
                cell.totalBreakdownlbl.text = farepricedetails?.adultsTotalPrice
                
                cell.tripCostValuelbl.isHidden = false
                cell.totalTripCostTitlelbl.isHidden = false
                cell.tripCostValuelbl.text = "\(farepricedetails?.api_currency ?? ""):\(farepricedetails?.grand_total ?? "")"
                
            }else if adultsCount > 0 && childCount > 0 && infantsCount == 0 {
                cell.tripCostValuelbl.isHidden = true
                cell.totalTripCostTitlelbl.isHidden = true
                if indexPath.row == 0 {
                    cell.passengerTypelbl.text = "Adult"
                    cell.basefarelbl.text = farepricedetails?.adultsBasePrice
                    cell.taxlbl.text = farepricedetails?.adultsTaxPrice
                    cell.subtotallbl.text = farepricedetails?.sub_total_adult
                    cell.noofpassengerslbl.text = "\(adultsCount)"
                    cell.totalBreakdownlbl.text = farepricedetails?.adultsTotalPrice
                    
                    cell.tripCostValuelbl.text = ""
                    cell.totalTripCostTitlelbl.text = ""
                }else {
                    cell.passengerTypelbl.text = "Child"
                    cell.basefarelbl.text = farepricedetails?.childBasePrice
                    cell.taxlbl.text = farepricedetails?.childTaxPrice
                    cell.subtotallbl.text = farepricedetails?.sub_total_child
                    cell.noofpassengerslbl.text = "\(childCount)"
                    cell.totalBreakdownlbl.text = farepricedetails?.childTotalPrice
                    
                    cell.tripCostValuelbl.isHidden = false
                    cell.totalTripCostTitlelbl.isHidden = false
                    cell.tripCostValuelbl.text = "\(farepricedetails?.api_currency ?? ""):\(farepricedetails?.grand_total ?? "")"
                }
                
               
            }else if adultsCount > 0 && childCount == 0 && infantsCount > 0 {
                cell.tripCostValuelbl.isHidden = true
                cell.totalTripCostTitlelbl.isHidden = true
                if indexPath.row == 0 {
                    cell.passengerTypelbl.text = "Adult"
                    cell.basefarelbl.text = farepricedetails?.adultsBasePrice
                    cell.taxlbl.text = farepricedetails?.adultsTaxPrice
                    cell.subtotallbl.text = farepricedetails?.sub_total_adult
                    cell.noofpassengerslbl.text = "\(adultsCount)"
                    cell.totalBreakdownlbl.text = farepricedetails?.adultsTotalPrice
                    
                    cell.tripCostValuelbl.text = ""
                    cell.totalTripCostTitlelbl.text = ""
                }else {
                    cell.passengerTypelbl.text = "Infant"
                    cell.basefarelbl.text = farepricedetails?.infantBasePrice
                    cell.taxlbl.text = farepricedetails?.infantTaxPrice
                    cell.subtotallbl.text = farepricedetails?.sub_total_infant
                    cell.noofpassengerslbl.text = "\(infantsCount)"
                    cell.totalBreakdownlbl.text = farepricedetails?.infantTotalPrice
                    
                    
                    
                    cell.tripCostValuelbl.isHidden = false
                    cell.totalTripCostTitlelbl.isHidden = false
                    cell.tripCostValuelbl.text = "\(farepricedetails?.api_currency ?? ""):\(farepricedetails?.grand_total ?? "")"
                }
                
                
            }else {
                
                cell.tripCostValuelbl.isHidden = true
                cell.totalTripCostTitlelbl.isHidden = true
                if indexPath.row == 0 {
                    
                    cell.passengerTypelbl.text = "Adult"
                    cell.basefarelbl.text = farepricedetails?.adultsBasePrice
                    cell.taxlbl.text = farepricedetails?.adultsTaxPrice
                    cell.subtotallbl.text = farepricedetails?.sub_total_adult
                    cell.noofpassengerslbl.text = "\(adultsCount)"
                    cell.totalBreakdownlbl.text = farepricedetails?.adultsTotalPrice
                    
                    cell.tripCostValuelbl.text = ""
                    cell.totalTripCostTitlelbl.text = ""
                   
                }else if indexPath.row == 1{
                    
                    cell.passengerTypelbl.text = "Child"
                    cell.basefarelbl.text = farepricedetails?.childBasePrice
                    cell.taxlbl.text = farepricedetails?.childTaxPrice
                    cell.subtotallbl.text = farepricedetails?.sub_total_child
                    cell.noofpassengerslbl.text = "\(childCount)"
                    cell.totalBreakdownlbl.text = farepricedetails?.childTotalPrice
                    
                    cell.tripCostValuelbl.text = ""
                    cell.totalTripCostTitlelbl.text = ""
                    
                }else {
                    cell.passengerTypelbl.text = "Infant"
                    cell.basefarelbl.text = farepricedetails?.infantBasePrice
                    cell.taxlbl.text = farepricedetails?.infantTaxPrice
                    cell.subtotallbl.text = farepricedetails?.sub_total_infant
                    cell.noofpassengerslbl.text = "\(infantsCount)"
                    cell.totalBreakdownlbl.text = farepricedetails?.infantTotalPrice
                    
                  
                    cell.tripCostValuelbl.isHidden = false
                    cell.totalTripCostTitlelbl.isHidden = false
                    cell.tripCostValuelbl.text = "\(farepricedetails?.api_currency ?? ""):\(farepricedetails?.grand_total ?? "")"
                }
                
               
            }
            
            
            commonCell = cell
        }
        return commonCell
    }
    
}
