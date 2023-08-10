//
//  DashboardVC.swift
//  Beeoons
//
//  Created by FCI on 08/08/23.
//

import UIKit

class DashboardVC: BaseTableVC {
    
    
    var tablerow = [TableRow]()
    
    
    
    //MARK: - viewDidLoad
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        if !UserDefaults.standard.bool(forKey: "ExecuteOnce") {
            
            
            defaults.set("FLIGHTS", forKey: UserDefaultsKeys.tabselect)
            defaults.set("oneway", forKey: UserDefaultsKeys.journeyType)
            defaults.set("KWD", forKey: UserDefaultsKeys.selectedCurrency)
            
            defaults.set("", forKey: UserDefaultsKeys.fromCity)
            defaults.set("", forKey: UserDefaultsKeys.toCity)
            defaults.set("", forKey: UserDefaultsKeys.rfromCity)
            defaults.set("", forKey: UserDefaultsKeys.rtoCity)
            defaults.set("", forKey: UserDefaultsKeys.calDepDate)
            defaults.set("", forKey: UserDefaultsKeys.rcalDepDate)
            
            defaults.set("Economy", forKey: UserDefaultsKeys.selectClass)
            defaults.set("1", forKey: UserDefaultsKeys.adultCount)
            defaults.set("0", forKey: UserDefaultsKeys.childCount)
            defaults.set("0", forKey: UserDefaultsKeys.infantsCount)
            
            defaults.set("Economy", forKey: UserDefaultsKeys.rselectClass)
            defaults.set("1", forKey: UserDefaultsKeys.radultCount)
            defaults.set("0", forKey: UserDefaultsKeys.rchildCount)
            defaults.set("0", forKey: UserDefaultsKeys.rinfantsCount)
            
            
            defaults.set("1", forKey: UserDefaultsKeys.totalTravellerCount)
            let totaltraverlers = "\(defaults.string(forKey: UserDefaultsKeys.totalTravellerCount) ?? "1") Traveller"
            defaults.set(totaltraverlers, forKey: UserDefaultsKeys.travellerDetails)
            
            let totaltraverlers1 = "\(defaults.string(forKey: UserDefaultsKeys.totalTravellerCount) ?? "1") Traveller"
            defaults.set(totaltraverlers1, forKey: UserDefaultsKeys.rtravellerDetails)
            
            
            let totaltraverlers2 = "\(defaults.string(forKey: UserDefaultsKeys.totalTravellerCount) ?? "1") Traveller"
            defaults.set(totaltraverlers2, forKey: UserDefaultsKeys.mtravellerDetails)
            
            
            
            
            UserDefaults.standard.set(true, forKey: "ExecuteOnce")
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.view.backgroundColor = .WhiteColor
        setupUI()
    }
    
    //MARK: -
    func setupUI() {
        commonTableView.registerTVCells(["EmptyTVCell",
                                         "MenuBtnWithLogoTVCell",
                                         "SelectTabTVCell",
                                         "DearMemberTVCell",
                                         "FlightDealsTVCell"])
        setupTVCell()
    }
    
    
    
    //MARK: - setupTVCell
    func setupTVCell() {
        tablerow.removeAll()
        tablerow.append(TableRow(height:50,bgColor: .WhiteColor,cellType: .EmptyTVCell))
        tablerow.append(TableRow(cellType: .MenuBtnWithLogoTVCell))
        tablerow.append(TableRow(cellType: .SelectTabTVCell))
        tablerow.append(TableRow(title:"FLIGHT",cellType: .FlightDealsTVCell))
        tablerow.append(TableRow(title:"Dear Members,",
                                 subTitle: "As of 20 September 2022, Miles & Smiles award ticket issuance and profile updates will be made with verification code to be sent your phone",
                                 cellType: .DearMemberTVCell))
        tablerow.append(TableRow(title:"Dear Passengers,",
                                 subTitle: "You can Access the Announcement regarding our flights to Ukraine, Belarus and Russia and the rights granted to our passengers for our flights to these countries",
                                 cellType: .DearMemberTVCell))
      
        tablerow.append(TableRow(title:"HOTEL",cellType: .FlightDealsTVCell))
        
        tablerow.append(TableRow(height:80,bgColor: .WhiteColor,cellType: .EmptyTVCell))
        commonTVData = tablerow
        commonTableView.reloadData()
    }
    
    
    
    //MARK: - didTapOnDashboardTab
    override func didTapOnDashboardTab(cell: SelectTabTVCell) {
        switch cell.selectedTitle {
            
        case "FLIGHT":
            gotoBookFlightVC()
            break
            
        case "HOTEL":
            print("HOTEL")
            break
            
        case "RENT A CAR":
            print("RENT A CAR")
            break
            
        case "HOLIDAYS":
            print("HOLIDAYS")
            break
            
            
        default:
            break
        }
    }
    
    
    
    //MARK: -
    func gotoBookFlightVC(){
        guard let vc = BookFlightVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    //MARK: -
    func gotoBookHotelVC(){
       
    }
    
    //MARK: -
    func goto(){
        
    }
    
    
    
    //MARK: -
    override func didTapOnMenuBtnAction(cell: MenuBtnWithLogoTVCell) {
        print("didTapOnMenuBtnAction")
    }
    
    
    //MARK: -
    override func didTapOnLangBtnAction(cell: MenuBtnWithLogoTVCell) {
        print("didTapOnLangBtnAction")
    }
    
    
    //MARK: -
    override func didTapOnBookFlightBtn(cell: DealsCVCell) {
        print(cell.bookBtn.tag)
    }
    
    
    
    //MARK: -
    override func didTapOnBookHoteltBtn(cell:HotelDealsCVCell){
        print(cell.bookBtn.tag)
    }
    
    
}
