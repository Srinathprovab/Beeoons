//
//  DashboardVC.swift
//  Beeoons
//
//  Created by FCI on 08/08/23.
//

import UIKit

class DashboardVC: BaseTableVC {
    
    
    var tablerow = [TableRow]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.view.backgroundColor = .WhiteColor
        setupUI()
    }
    
    
    func setupUI() {
        commonTableView.registerTVCells(["EmptyTVCell",
                                         "MenuBtnWithLogoTVCell",
                                         "SelectTabTVCell",
                                         "DearMemberTVCell",
                                         "FlightDealsTVCell"])
        setupTVCell()
    }
    
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
    
    
    override func didTapOnDashboardTab(cell: SelectTabTVCell) {
        switch cell.selectedTitle {
            
        case "FLIGHT":
            print("FLIGHT")
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
    
    
    
    override func didTapOnMenuBtnAction(cell: MenuBtnWithLogoTVCell) {
        print("didTapOnMenuBtnAction")
    }
    
    override func didTapOnLangBtnAction(cell: MenuBtnWithLogoTVCell) {
        print("didTapOnLangBtnAction")
    }
    
    override func didTapOnBookFlightBtn(cell: DealsCVCell) {
        print(cell.bookBtn.tag)
    }
    
    override func didTapOnBookHoteltBtn(cell:HotelDealsCVCell){
        print(cell.bookBtn.tag)
    }
    
    
}
