//
//  ModifyHotelsResultVC.swift
//  Beeoons
//
//  Created by FCI on 29/09/23.
//

import UIKit

class ModifyHotelsResultVC: BaseTableVC {
    
    
    static var newInstance: ModifyHotelsResultVC? {
        let storyboard = UIStoryboard(name: Storyboard.Hotel.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? ModifyHotelsResultVC
        return vc
    }
    var tablerow = [TableRow]()
    var payload = [String:Any]()
    var payload1 = [String:Any]()
    
    override func viewWillAppear(_ animated: Bool) {
        addObserver()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupUI()
        setInitalValues()
    }
    
    
    func setupUI() {
        self.view.backgroundColor = .black.withAlphaComponent(0.6)
        commonTableView.registerTVCells(["BookHotelTVCell"])
        setuTVCells()
    }
    
    
    
    
    func setuTVCells() {
        tablerow.removeAll()
        
        tablerow.append(TableRow(cellType:.BookHotelTVCell))
        
        
        commonTVData = tablerow
        commonTableView.reloadData()
    }
    
    func setInitalValues() {
        
        adtArray.removeAll()
        chArray.removeAll()
        
        adtArray.append("2")
        chArray.append("0")
        
        defaults.set("1", forKey: UserDefaultsKeys.roomcount)
        defaults.set("2", forKey: UserDefaultsKeys.hoteladultscount)
        defaults.set("0", forKey: UserDefaultsKeys.hotelchildcount)
        
        defaults.set("Rooms \(defaults.string(forKey: UserDefaultsKeys.roomcount) ?? ""),Adults \(defaults.string(forKey: UserDefaultsKeys.hoteladultscount) ?? "")", forKey: UserDefaultsKeys.selectPersons)
        
    }
    
    
    @IBAction func didTapOnBackButtonAction(_ sender: Any) {
        dismiss(animated: true)
    }
    
    
    //MARK: - BookHotelTVCell
    override func didTapOnSelectHotelCityBtnAction(cell: BookHotelTVCell) {
        gotoSelectCityVC(str: "", tokey: "")
    }
    
    override func didTapOnCheckInBtnAction(cell: BookHotelTVCell) {
        gotoCalenderVC()
    }
    
    override func didTapOnCheckOutBtnAction(cell: BookHotelTVCell) {
        gotoCalenderVC()
    }
    
    override func didTapOnAddRoomBtnAction(cell: BookHotelTVCell) {
        guard let vc = AddRoomsVCViewController.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: false)
    }
    
    func gotoSelectCityVC(str:String,tokey:String) {
        guard let vc = SelectCityVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        vc.titleStr = str
        vc.keyStr = "Hotel"
        vc.tokey = tokey
        self.present(vc, animated: true)
    }
    
    
    func gotoCalenderVC() {
        guard let vc = CalenderVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: false)
    }
    
    
    
    override func didTapOnSearchHotelBtnAction(cell: BookHotelTVCell) {
        
        payload.removeAll()
        
        
        defaults.set("Kuwait (Kuwait)", forKey: UserDefaultsKeys.locationcity)
        defaults.set("248", forKey: UserDefaultsKeys.locationid)
        
        payload["city"] = defaults.string(forKey: UserDefaultsKeys.locationcity)
        payload["hotel_destination"] = defaults.string(forKey: UserDefaultsKeys.locationid)
        
        payload["hotel_checkin"] = defaults.string(forKey: UserDefaultsKeys.checkin)
        payload["hotel_checkout"] = defaults.string(forKey: UserDefaultsKeys.checkout)
        
        payload["rooms"] = "\(defaults.string(forKey: UserDefaultsKeys.roomcount) ?? "1")"
        payload["adult"] = adtArray
        payload["child"] = chArray
        
        
        for roomIndex in 0..<totalRooms {
            
            
            if let numChildren = Int(chArray[roomIndex]), numChildren > 0 {
                var childAges: [String] = Array(repeating: "0", count: numChildren)
                
                if numChildren > 2 {
                    childAges.append("0")
                }
                
                payload["childAge_\(roomIndex + 1)"] = childAges
            }
        }
        
        
        payload["nationality"] = "IN"
        payload["language"] = "english"
        payload["search_source"] = "postman"
        payload["currency"] = defaults.string(forKey: UserDefaultsKeys.selectedCurrency) ?? "KWD"
        payload["user_id"] = defaults.string(forKey: UserDefaultsKeys.userid) ?? "0"
        
        
        
        //        if defaults.string(forKey: UserDefaultsKeys.locationcity) == "Add City" || defaults.string(forKey: UserDefaultsKeys.locationcity) == nil{
        //            showToast(message: "Enter Hotel or City ")
        //        }else
        
        if defaults.string(forKey: UserDefaultsKeys.checkin) == "Add Check In Date" || defaults.string(forKey: UserDefaultsKeys.checkin) == nil{
            showToast(message: "Enter Checkin Date")
        }else if defaults.string(forKey: UserDefaultsKeys.checkout) == "Add Check Out Date" || defaults.string(forKey: UserDefaultsKeys.checkout) == nil{
            showToast(message: "Enter Checkout Date")
        }else if defaults.string(forKey: UserDefaultsKeys.checkout) == defaults.string(forKey: UserDefaultsKeys.checkin) {
            showToast(message: "Enter Different Dates")
        }else if defaults.string(forKey: UserDefaultsKeys.roomcount) == "" {
            showToast(message: "Add Rooms For Booking")
        }else if checkDepartureAndReturnDates(payload, p1: "hotel_checkin", p2: "hotel_checkout") == false {
            showToast(message: "Invalid Date")
        }else {
            
            
            do{
                
                let jsonData = try JSONSerialization.data(withJSONObject: payload, options: JSONSerialization.WritingOptions.prettyPrinted)
                let jsonStringData =  NSString(data: jsonData as Data, encoding: NSUTF8StringEncoding)! as String
                
                print(jsonStringData)
                payload1["search_params"] = jsonStringData
                gotoHotelsResultVC()
                
            }catch{
                print(error.localizedDescription)
            }
            
            
        }
    }
    
    func gotoHotelsResultVC() {
        callapibool = true
        guard let vc = HotelsResultVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        vc.payload = self.payload1
        self.present(vc, animated: false)
    }
    
}




extension ModifyHotelsResultVC {
    
    func addObserver() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(nointernet), name: Notification.Name("offline"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(reload), name: NSNotification.Name("reloadTV"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(resultnil), name: NSNotification.Name("resultnil"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(reload), name: NSNotification.Name("hotelrooms"), object: nil)
        
    }
    
    
    @objc func nointernet(){
        gotoNoInternetConnectionVC(key: "nointernet", titleStr: "")
    }
    
    @objc func resultnil(){
        gotoNoInternetConnectionVC(key: "noresult", titleStr: "NO AVAILABILITY FOR THIS REQUEST")
    }
    
    @objc func reload(){
        DispatchQueue.main.async {
            self.commonTableView.reloadData()
        }
    }
    
    
    
    func gotoNoInternetConnectionVC(key:String,titleStr:String) {
        guard let vc = NoInternetConnectionVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        vc.key = key
        vc.titleStr = titleStr
        self.present(vc, animated: false)
    }
    
    
}
