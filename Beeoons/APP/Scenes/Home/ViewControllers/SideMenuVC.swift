//
//  SideMenuVC.swift
//  Beeoons
//
//  Created by FCI on 11/08/23.
//

import UIKit

class SideMenuVC: BaseTableVC {
    
    
    var tablerow = [TableRow]()
    var vm:LogoutViewModel?
    
    
    //MARK: - viewDidLoad
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(reload), name: NSNotification.Name("callprofile"), object: nil)
    }
    
    
    @objc func reload() {
        setupTV()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupUI()
        vm = LogoutViewModel(self)
    }
    
    
    func setupUI() {
        commonTableView.registerTVCells(["MenuBGTVCell",
                                         "MenuOptionTVCell",
                                         "EmptyTVCell",
                                         "ButtonTVCell"])
        setupTV()
    }
    
    
    func setupTV() {
        tablerow.removeAll()
        tablerow.append(TableRow(cellType:.MenuBGTVCell))
        if let userstatusObject = defaults.object(forKey: UserDefaultsKeys.loggedInStatus) as? Bool, userstatusObject == true {
            tablerow.append(TableRow(title:"My Bookings",cellType:.MenuOptionTVCell))
        }
        tablerow.append(TableRow(title:"Contact us",cellType:.MenuOptionTVCell))
        tablerow.append(TableRow(title:"Register Property",cellType:.MenuOptionTVCell))
        tablerow.append(TableRow(title:"Discover Beeoons",cellType:.MenuOptionTVCell))
        tablerow.append(TableRow(height:200,bgColor: .WhiteColor,cellType:.EmptyTVCell))
        
        
        
        
        if let userstatusObject = defaults.object(forKey: UserDefaultsKeys.loggedInStatus) as? Bool, userstatusObject == true {
            tablerow.append(TableRow(title: "Log out", bgColor: .ButtonColor, cellType: .ButtonTVCell))
        }
        
        
        
        commonTVData = tablerow
        commonTableView.reloadData()
    }
    
    
    
    
    
    //MARK: - didTapOnMenuOtptionBtnAction
    override func didTapOnMenuOtptionBtnAction(cell: MenuOptionTVCell) {
        switch cell.titlelbl.text {
        case "Contact us":
            print("Contact us")
            break
            
        case "Register Property":
            print("Register Property")
            break
            
        case "Discover Beeoons":
            print("Discover Beeoons")
            break
            
            
        case "My Bookings":
            print("Discover Beeoons")
            break
            
            
        default:
            break
        }
    }
    
    
    //MARK: - Login Btn Action
    override func didTapOnLoginBtnAction(cell:MenuBGTVCell){
        guard let vc = LoginVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        vc.isvcFrom = "menu"
        present(vc, animated: true)
    }
    
    //MARK: - Logout Action
    override func didTapOnBnAction(cell:ButtonTVCell){
        DispatchQueue.main.async {
            self.callLogoutAPI()
        }
    }
    
    
}


extension SideMenuVC:LogoutViewModelDelegate {
    
    
    func callLogoutAPI() {
        vm?.CALL_USER_LOGOUT_API(dictParam: [:])
    }
    
    func userLogoutSucess(response: LogoutModel) {
        
        
        if response.status == true {
            defaults.set(false, forKey: UserDefaultsKeys.loggedInStatus)
            defaults.set("", forKey: UserDefaultsKeys.userid)
            defaults.set("", forKey: UserDefaultsKeys.username)
            defaults.set("", forKey: UserDefaultsKeys.userimg)
            showToast(message: response.data ?? "")
            
            let seconds = 1.0
            DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {[self] in
                setupTV()
            }
        }
        
    }
    
    
    
}