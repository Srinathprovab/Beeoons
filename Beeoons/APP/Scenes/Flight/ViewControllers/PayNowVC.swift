//
//  PayNowVC.swift
//  Beeoons
//
//  Created by FCI on 12/08/23.
//

import UIKit

class PayNowVC: BaseTableVC, TimerManagerDelegate {
    
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var totalPricelbl: UILabel!
    @IBOutlet weak var sessionlbl: UILabel!
    
    
    var adultsCount = Int()
    var childCount = Int()
    var infantsCount = Int()
    var positionsCount = 0
    var searchTextArray = [String]()
    var tmpFlightPreBookingId = String()
    var tokenkey1 = String()
    var callpaymentbool = true
    var payload = [String:Any]()
    var payload1 = [String:Any]()
    var secureapidonebool = false
    
    var dates = String()
    var citys = String()
    var tablerow = [TableRow]()
    var flightsummary = [Summary]()
    var vm:PreProcessBookingViewModel?
    static var newInstance: PayNowVC? {
        let storyboard = UIStoryboard(name: Storyboard.Flight.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? PayNowVC
        return vc
    }
    
    
    
    
    //MARK: -Loading Functions
    
    override func viewWillAppear(_ animated: Bool) {
        
        TimerManager.shared.delegate = self
        addObserver()
        
        
        DispatchQueue.main.async {
            self.getTravellrcount()
        }
        
        if callapibool == true {
            holderView.isHidden = true
            callmobile_pre_process_booking()
        }
    }
    
    
    func getTravellrcount(){
        
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
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupUI()
        vm = PreProcessBookingViewModel(self)
    }
    
    
    //MARK: - setupUI
    func setupUI() {
        bottomView.addCornerRadiusWithShadow(color: .AppBorderColor, borderColor: .clear, cornerRadius: 4)
        bottomView.layer.borderColor = UIColor.AppBorderColor.cgColor
        bottomView.layer.borderWidth = 1
        totalPricelbl.text = grandTotal
        
        commonTableView.registerTVCells(["TDetailsLoginTVCell",
                                         "PurchaseSummaryTVCell",
                                         "PromocodeTVCell",
                                         "EmptyTVCell",
                                         "AcceptTermsAndConditionTVCell",
                                         "AddDeatilsOfTravellerTVCell",
                                         "TravellerDetailsTVCell",
                                         "ViewFlightDetailsTVCell"])
        // setupTV()
    }
    
    
    
    func setupTV() {
        
        tablerow.removeAll()
        
        if let loginstatus = defaults.object(forKey: UserDefaultsKeys.loggedInStatus) as? Bool , loginstatus == false {
            tablerow.append(TableRow(cellType:.TDetailsLoginTVCell))
            positionsCount = 2
        }
        
        tablerow.append(TableRow(moreData:flightsummary,cellType:.ViewFlightDetailsTVCell))
        
        
        
        tablerow.append(TableRow(height:20,cellType:.EmptyTVCell))
        for i in 1...adultsCount {
            positionsCount += 1
            let travellerCell = TableRow(title: "Adult \(i)", key: "adult", characterLimit: positionsCount, cellType: .AddDeatilsOfTravellerTVCell)
            searchTextArray.append("Adult \(i)")
            tablerow.append(travellerCell)
            
        }
        
        
        if childCount != 0 {
            for i in 1...childCount {
                positionsCount += 1
                tablerow.append(TableRow(title:"Child \(i)",key:"child",characterLimit: positionsCount,cellType:.AddDeatilsOfTravellerTVCell))
                searchTextArray.append("Child \(i)")
            }
        }
        
        if infantsCount != 0 {
            for i in 1...infantsCount {
                positionsCount += 1
                tablerow.append(TableRow(title:"Infant \(i)",key:"infant",characterLimit: positionsCount,cellType:.AddDeatilsOfTravellerTVCell))
                searchTextArray.append("Infant \(i)")
            }
        }
        
        
        
    //    tablerow.append(TableRow(cellType:.TravellerDetailsTVCell))
        tablerow.append(TableRow(cellType:.PromocodeTVCell))
        tablerow.append(TableRow(title:citys,
                                 subTitle: dates,
                                 cellType:.PurchaseSummaryTVCell))
        
        
        tablerow.append(TableRow(title:"I Accept T&C and Privacy Policy",cellType:.AcceptTermsAndConditionTVCell))
        tablerow.append(TableRow(height:30,cellType:.EmptyTVCell))
        
        commonTVData = tablerow
        commonTableView.reloadData()
    }
    
    
    
    //MARK: - didTapOnViewFlightDetails
    override func didTapOnViewFlightDetails(cell: ViewFlightDetailsTVCell) {
        guard let vc = ViewFlightDetailsVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        callapibool = true
        self.present(vc, animated: false)
    }
    
    
    
    //MARK: - didTapOnApplyPromocodeBtnAction
    override func didTapOnApplyPromocodeBtnAction(cell: PromocodeTVCell) {
        print("didTapOnApplyPromocodeBtnAction")
    }
    
    
    override func editingTextField(tf: UITextField) {
        print(tf.text)
    }
    
    
    
    
    //MARK: - didTapOnLoginBtn
    override func didTapOnLoginBtn(cell: TDetailsLoginTVCell) {
        guard let vc = LoginVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        callapibool = true
        vc.isvcFrom = "menu"
        self.present(vc, animated: false)
    }
    
    
    //MARK: - AddDeatilsOfTravellerTVCell
    override func didTapOnExpandAdultViewbtnAction(cell: AddDeatilsOfTravellerTVCell) {
        if cell.expandViewBool == true {
            
            cell.expandView()
            cell.expandViewBool = false
        }else {
            
            cell.collapsView()
            cell.expandViewBool = true
        }
        
        commonTableView.beginUpdates()
        commonTableView.endUpdates()
    }
    
    
    override func tfeditingChanged(tf:UITextField) {
        print(tf.tag)
    }
    
    
    
    override func donedatePicker(cell:AddDeatilsOfTravellerTVCell){
        self.view.endEditing(true)
    }
    
    override func cancelDatePicker(cell:AddDeatilsOfTravellerTVCell){
        self.view.endEditing(true)
    }
    
    
    
    //MARK: - AcceptTermsAndConditionTVCell
    override func didTapOnTAndCAction(cell: AcceptTermsAndConditionTVCell) {
        //gotoAboutUsVC(keystr: "terms")
    }
    
    override func didTapOnPrivacyPolicyAction(cell: AcceptTermsAndConditionTVCell) {
        //gotoAboutUsVC(keystr: "aboutus")
    }
    
    
    //MARK: - didTapOnBackBtnAction
    @IBAction func didTapOnBackBtnAction(_ sender: Any) {
        dismiss(animated: true)
    }
    
    
    //MARK: - didTapOnPayNowBtnAction
    @IBAction func didTapOnPayNowBtnAction(_ sender: Any) {
        paynowBtnTap()
    }
    
}

extension PayNowVC {
    
    func callmobile_pre_process_booking() {
        payload["search_id"] = searchid
        payload["booking_source"] = bookingsource
        payload["user_id"] = defaults.string(forKey: UserDefaultsKeys.userid) ?? "0"
        payload["access_key"] = selectedAccesskey
        payload["promocode_val"] = ""
        
        vm?.CALL_MOBILE_PREPROCESS_BOOKING_API(dictParam: payload)
    }
    
    
    func mobilePreprocessBookingDetails(response: PreProcessBookingModel) {
        
        
        holderView.isHidden = false
        tmpFlightPreBookingId = response.pre_booking_params?.transaction_id ?? ""
        tokenkey1 = response.pre_booking_params?.token_key ?? ""
        flightsummary = response.flight_data?.summary ?? []
        
        
        flightsummary.forEach { i in
            citys = "\(i.origin?.city ?? "")(\(i.origin?.loc ?? "")) to \(i.destination?.city ?? "")(\(i.destination?.loc ?? ""))"
            dates = "\(i.origin?.date ?? "")"
        }
        
        DispatchQueue.main.async {[self] in
            setupTV()
        }
        
    }
    
    
}

extension PayNowVC {
    
    //MARK: - addObserver
    func addObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(nointernet), name: Notification.Name("offline"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(reload), name: NSNotification.Name("reloadTV"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(resultnil), name: NSNotification.Name("resultnil"), object: nil)
        
    }
    
    @objc func nointernet(){
        gotoNoInternetConnectionVC(key: "nointernet", titleStr: "")
    }
    
    @objc func resultnil(){
        gotoNoInternetConnectionVC(key: "noresult", titleStr: "NO AVAILABILITY FOR THIS REQUEST")
    }
    
    @objc func reload(){
        DispatchQueue.main.async {[self] in
            setupTV()
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
        let totalTime = TimerManager.shared.totalTime
        let minutes =  totalTime / 60
        let seconds = totalTime % 60
        let formattedTime = String(format: "%02d:%02d", minutes, seconds)
        sessionlbl.text = "Your Session Expires In: \(formattedTime)"
    }
    
    
    
}




extension PayNowVC: PreProcessBookingViewModelDelegate{
    
    
    //MARK: - paynowBtnTap
    func paynowBtnTap() {
        
        payload.removeAll()
        payload1.removeAll()
        
        var textfilldshouldmorethan3lettersBool = true
        // Assuming you have a positionsCount variable that holds the number of cells in the table view
        let positionsCount = commonTableView.numberOfRows(inSection: 0)
        
        for position in 0..<positionsCount {
            // Fetch the cell for the given position
            if let cell = commonTableView.cellForRow(at: IndexPath(row: position, section: 0)) as? AddDeatilsOfTravellerTVCell {
                
                if cell.titleTF.text?.isEmpty == true {
                    // Textfield is empty
                    cell.titleView.layer.borderColor = UIColor.red.cgColor
                    callpaymentbool = false
                    
                } else {
                    // Textfield is not empty
                    callpaymentbool = true
                }
                
                if cell.fnameTF.text?.isEmpty == true{
                    // Textfield is empty
                    cell.fnameView.layer.borderColor = UIColor.red.cgColor
                    cell.callpaymentbool = false
                }else if ((cell.fnameTF.text?.count ?? 0) <= 3) {
                    // Textfield is empty
                    showToast(message: "Enter More Than 3 Chars")
                    cell.fnameView.layer.borderColor = UIColor.red.cgColor
                    textfilldshouldmorethan3lettersBool = false
                    callpaymentbool = false
                }else {
                    // Textfield is not empty
                    callpaymentbool = true
                }
                
                if cell.lnameTF.text?.isEmpty == true {
                    // Textfield is empty
                    cell.lnameView.layer.borderColor = UIColor.red.cgColor
                    callpaymentbool = false
                } else if ((cell.lnameTF.text?.count ?? 0) <= 3) {
                    // Textfield is empty
                    showToast(message: "Enter More Than 3 Chars")
                    cell.lnameView.layer.borderColor = UIColor.red.cgColor
                    textfilldshouldmorethan3lettersBool = false
                    cell.callpaymentbool = false
                }else {
                    // Textfield is not empty
                    callpaymentbool = true
                }
                
                
                if cell.dobTF.text?.isEmpty == true {
                    // Textfield is empty
                    cell.dobView.layer.borderColor = UIColor.red.cgColor
                    callpaymentbool = false
                } else {
                    // Textfield is not empty
                    callpaymentbool = true
                }
                
                
                
                
                
                if cell.passportnoTF.text?.isEmpty == true {
                    // Textfield is empty
                    cell.passportnoView.layer.borderColor = UIColor.red.cgColor
                    callpaymentbool = false
                } else {
                    // Textfield is not empty
                    callpaymentbool = true
                }
                
                
                if cell.passportIssuingCountryTF.text?.isEmpty == true {
                    // Textfield is empty
                    cell.issuecountryView.layer.borderColor = UIColor.red.cgColor
                    callpaymentbool = false
                } else {
                    // Textfield is not empty
                    callpaymentbool = true
                }
                
                
                if cell.passportExpireDateTF.text?.isEmpty == true {
                    // Textfield is empty
                    cell.passportexpireView.layer.borderColor = UIColor.red.cgColor
                    callpaymentbool = false
                } else {
                    // Textfield is not empty
                    callpaymentbool = true
                }
                
                
            }
        }
        
        
        let mrtitleArray = travelerArray.compactMap({$0.mrtitle})
        let laedpassengerArray = travelerArray.compactMap({$0.laedpassenger})
        let middlenameArray = travelerArray.compactMap({$0.middlename})
        let passengertypeArray = travelerArray.compactMap({$0.passengertype})
        let firstnameArray = travelerArray.compactMap({$0.firstName})
        let lastNameArray = travelerArray.compactMap({$0.lastName})
        let dobArray = travelerArray.compactMap({$0.dob})
        let passportnoArray = travelerArray.compactMap({$0.passportno})
        let passportIssuingCountryArray = travelerArray.compactMap({$0.passportIssuingCountry})
        let passportExpireDateArray = travelerArray.compactMap({$0.passportExpireDate})
        //        let frequentFlyrNoArray = travelerArray.compactMap({$0.frequentFlyrNo})
        //        let mealNameArray = travelerArray.compactMap({$0.meal})
        //        let specialAssicintenceArray = travelerArray.compactMap({$0.specialAssicintence})
        //        let genderArray = travelerArray.compactMap({$0.gender})
        //        let nationalityArray = travelerArray.compactMap({$0.nationality})
        
        
        //    passenger_request:{"search_id":"3277","tmp_flight_pre_booking_id":"BNS-F-TP-0809-3867","token_key":"7c6a32408f7c16f5006b9355cd7ab854","access_key_tp":"e6275b7b2fcb3c06571642105077bdc8*_*1*_*iZn7MG7hRvqVylME","access_key":"e6275b7b2fcb3c06571642105077bdc8*_*1*_*iZn7MG7hRvqVylME","insurance_policy_type":"0","insurance_policy_option":"0","insurance_policy_cover_type":"0","insurance_policy_duration":"0","isInsurance":"0","redeem_points_post":"1","booking_source":"YToxOntpOjA7czoxNjoiUFRCU0lEMDAwMDAwMDAxNiI7fQ==","promocode_val":"","promocode_code":"","mealsAmount":"0","baggageAmount":"0","passenger_type":["Adult"],"lead_passenger":["1"],"gender":["2"],"passenger_nationality":["92"],"name_title":["1"],"first_name":["Aman"],"middle_name":[""],"last_name":["jain"],"date_of_birth":["13-04-1996"],"passenger_passport_number":["POIL7675"],"passenger_passport_issuing_country":["92"],"passenger_passport_expiry":["04-12-2028"],"Frequent":[["Select"]],"ff_no":[[""]],"address2":"ECITY","billing_address_1":"hjfggh","billing_state":"Karnataka","billing_city":"Bangalore","billing_zipcode":"560100","billing_email":"ghfgh@ghhj.hjhj","passenger_contact":"8965231470","billing_country":"IN","country_mobile_code":"+91","insurance":"1","tc":"on","booking_step":"book","payment_method":"PNHB1","selectedCurrency":"AED","user_id":"0"}
        
        payload["search_id"] = searchid
        payload["tmp_flight_pre_booking_id"] = tmpFlightPreBookingId
        payload["access_key_tp"] =  selectedAccesskey
        payload["token_key"] = tokenkey1
        payload["access_key"] =  selectedAccesskey
        payload["insurance_policy_type"] = "0"
        payload["insurance_policy_option"] = "0"
        payload["insurance_policy_cover_type"] = "0"
        payload["insurance_policy_duration"] = "0"
        payload["isInsurance"] = "0"
        payload["redeem_points_post"] = "1"
        payload["booking_source"] = bookingsource
        payload["promocode_val"] = ""
        payload["promocode_code"] = ""
        payload["mealsAmount"] = "0"
        payload["baggageAmount"] = "0"
        
        payload["passenger_type"] = passengertypeArray
        payload["lead_passenger"] = laedpassengerArray
        payload["gender"] = ["2"]
        payload["passenger_nationality"] = ["92"]
        payload["name_title"] =  mrtitleArray
        payload["first_name"] =  firstnameArray
        payload["middle_name"] =  middlenameArray
        payload["last_name"] =  lastNameArray
        payload["date_of_birth"] =  dobArray
        payload["passenger_passport_number"] =  passportnoArray
        payload["passenger_passport_issuing_country"] =  passportIssuingCountryArray
        payload["passenger_passport_expiry"] =  passportExpireDateArray
        payload["Frequent"] = [["Select"]]
        payload["ff_no"] = [[""]]
        payload["payment_method"] =  "PNHB1"
        
        payload["address2"] = ""
        payload["billing_address_1"] = ""
        payload["billing_state"] = ""
        payload["billing_city"] = ""
        payload["billing_zipcode"] = ""
        payload["billing_email"] = email
        payload["passenger_contact"] = mobile
        payload["billing_country"] = billingCountryName
        payload["country_mobile_code"] = billingCountryCode
        payload["insurance"] = "1"
        payload["tc"] = "on"
        payload["booking_step"] = "book"
        payload["selectedCurrency"] = defaults.string(forKey: UserDefaultsKeys.selectedCurrency) ?? "KWD"
        payload["user_id"] = defaults.string(forKey: UserDefaultsKeys.userid) ?? "0"
        
        
        
        do{
            
            let jsonData = try JSONSerialization.data(withJSONObject: payload, options: JSONSerialization.WritingOptions.prettyPrinted)
            let jsonStringData =  NSString(data: jsonData as Data, encoding: NSUTF8StringEncoding)! as String
            
            if textfilldshouldmorethan3lettersBool == false {
                showToast(message: "Enter More Than 3 Chars")
            }else if callpaymentbool == false {
                showToast(message: "Add Details")
                
            }else if checkTermsAndCondationStatus == false {
                showToast(message: "Please Accept T&C and Privacy Policy")
            }else {
                print(jsonStringData)
                //  payload1["passenger_request"] = jsonStringData
                vm?.CALL_PROCESS_PASSENGER_DETAIL_API(dictParam: payload)
                
            }
            
        }catch{
            print(error.localizedDescription)
        }
        
    }
    
    
    func processPassengerDetails(response: ProcessPassangerDetailModel) {
        secureapidonebool = true
        
        gotoLoadWebViewVC(url: response.payment_url ?? "")
        //        DispatchQueue.main.async {[self] in
        //            payload.removeAll()
        //            payload["app_reference"] = tmpFlightPreBookingId
        //            payload["search_id"] = searchid
        //            payload["promocode_val"] = ""
        //            vm?.CALL_PRE_FLIGHT_BOOKING_API(dictParam: payload, key: searchid)
        //        }
    }
    
    
    func preFlightBookingDetails(response: ProcessPassangerDetailModel) {
        
        DispatchQueue.main.async {[self] in
            payload.removeAll()
            payload["app_reference"] = tmpFlightPreBookingId
            payload["user_id"] = defaults.string(forKey: UserDefaultsKeys.userid) ?? "0"
            
            vm?.CALL_FLIGHT_PRE_CONF_PAYMENT_API(dictParam: payload, key: "\(searchid)")
        }
    }
    
    
    func flightPrePaymentDetails(response: PrePaymentConfModel) {
        
        DispatchQueue.main.async {[self] in
            payload.removeAll()
            payload["extra_price"] = "0"
            payload["promocode_val"] = "0"
            vm?.CALL_SENDTO_PAYMENT_API(dictParam: payload, key: "\(tmpFlightPreBookingId)/\(searchid)")
        }
    }
    
    
    
    func sendtoPaymentDetails(response: sendToPaymentModel) {
        
        DispatchQueue.main.async {[self] in
            payload.removeAll()
            vm?.CALL_SECURE_BOOKING_API(dictParam: [:], key: "\(tmpFlightPreBookingId)")
        }
    }
    
    
    func secureBookingDetails(response: sendToPaymentModel) {
        
        if response.status == true {
            gotoLoadWebViewVC(url: response.form_url ?? "")
        }else {
            showToast(message: response.msg ?? "")
        }
        
    }
    
    func gotoLoadWebViewVC(url:String) {
        guard let vc = LoadWebViewVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        vc.urlString = url
        present(vc, animated: true)
    }
}
