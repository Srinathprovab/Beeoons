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
    
    
    var payload = [String:Any]()
    var payload1 = [String:Any]()
    var secureapidonebool = false
    var street = String()
    var aprtment = String()
    var countrySelected = String()
    var stateSelected = String()
    var citySelected = String()
    var postalCode = String()
    var passengertypeArray = [String]()
    
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
        travelerArray.removeAll()
        bottomView.addCornerRadiusWithShadow(color: .AppBorderColor, borderColor: .clear, cornerRadius: 4)
        bottomView.layer.borderColor = UIColor.AppBorderColor.cgColor
        bottomView.layer.borderWidth = 1
        totalPricelbl.text = "\(defaults.string(forKey: UserDefaultsKeys.selectedCurrency) ?? ""):\(grandTotal)"
        
        commonTableView.registerTVCells(["TDetailsLoginTVCell",
                                         "PurchaseSummaryTVCell",
                                         "PromocodeTVCell",
                                         "EmptyTVCell",
                                         "AcceptTermsAndConditionTVCell",
                                         "TotalTravellerCountTVCell",
                                         "AddDeatilsOfTravellerTVCell",
                                         "BillingAddressTVCell",
                                         "ViewFlightDetailsTVCell"])
        // setupTV()
    }
    
    
    
    func setupTV() {
        
        tablerow.removeAll()
        passengertypeArray.removeAll()
        
        
        if let loginstatus = defaults.object(forKey: UserDefaultsKeys.loggedInStatus) as? Bool , loginstatus == false {
            tablerow.append(TableRow(cellType:.TDetailsLoginTVCell))
        }
        
        tablerow.append(TableRow(moreData:flightsummary,cellType:.ViewFlightDetailsTVCell))
        tablerow.append(TableRow(height:20,cellType:.EmptyTVCell))
        tablerow.append(TableRow(title:"\(adultsCount)",
                                 subTitle: "\(childCount)",
                                 buttonTitle: "\(infantsCount)",
                                 cellType:.TotalTravellerCountTVCell))
        
        
        
        for i in 1...adultsCount {
            positionsCount += 1
            passengertypeArray.append("Adult")
            let travellerCell = TableRow(title: "Adult \(i)", key: "adult", characterLimit: positionsCount, cellType: .AddDeatilsOfTravellerTVCell)
            tablerow.append(travellerCell)
            
        }
        
        
        if childCount != 0 {
            for i in 1...childCount {
                positionsCount += 1
                passengertypeArray.append("Child")
                tablerow.append(TableRow(title:"Child \(i)",key:"child",characterLimit: positionsCount,cellType:.AddDeatilsOfTravellerTVCell))
            }
        }
        
        if infantsCount != 0 {
            for i in 1...infantsCount {
                positionsCount += 1
                passengertypeArray.append("Infant")
                tablerow.append(TableRow(title:"Infant \(i)",key:"infant",characterLimit: positionsCount,cellType:.AddDeatilsOfTravellerTVCell))
            }
        }
        
        
        tablerow.append(TableRow(height:10,cellType:.EmptyTVCell))
        tablerow.append(TableRow(title:email,
                                 subTitle: mobile,
                                 buttonTitle: countryCode,
                                 cellType:.BillingAddressTVCell))
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
    
    
    //MARK: - didTapOnExpandAdultViewbtnAction AddDeatilsOfTravellerTVCell
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
    
    
    
    
    //MARK: - BillingAddressTVCell didTapOnBillingAddressDropDownBtnAction
    override func didTapOnBillingAddressDropDownBtnAction(cell: BillingAddressTVCell) {
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
    
    
    
    
    override func didTapOnSelectCountryBtnAction(cell: BillingAddressTVCell) {
        print(cell.countryTF.text)
    }
    
    override func didTapOnSelectStateBtnAction(cell: BillingAddressTVCell) {
        print(cell.stateTF.text)
    }
    
    override func didTapOnSelectCityBtnAction(cell: BillingAddressTVCell) {
        print(cell.cityTF.text)
    }
    
    //MARK: - didTapOnTAndCAction AcceptTermsAndConditionTVCell
    override func didTapOnTAndCAction(cell: AcceptTermsAndConditionTVCell) {
        //gotoAboutUsVC(keystr: "terms")
    }
    
    override func didTapOnPrivacyPolicyAction(cell: AcceptTermsAndConditionTVCell) {
        //gotoAboutUsVC(keystr: "aboutus")
    }
    
    //MARK: - didTapOnBackBtnAction
    @IBAction func didTapOnBackBtnAction(_ sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name("reloadTimer"), object: nil)
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
        
      //  flightsummary = response.flight_data?.summary ?? []
        selectedAccesskey = response.access_key_tp ?? ""
        tokenkey1 = response.token_key ?? ""
        tmpFlightPreBookingId = response.tmp_flight_pre_booking_id ?? ""
        
        
        
//        flightsummary.forEach { i in
//            citys = "\(i.origin?.city ?? "")(\(i.origin?.loc ?? "")) to \(i.destination?.city ?? "")(\(i.destination?.loc ?? ""))"
//            dates = "\(i.origin?.date ?? "")"
//        }
        
        DispatchQueue.main.async {[self] in
            setupTV()
        }
        
    }
    
    
}





extension PayNowVC: PreProcessBookingViewModelDelegate{
    
    
    //MARK: - paynowBtnTap
    func paynowBtnTap() {
        
        payload.removeAll()
        payload1.removeAll()
        
        
        var callpaymentbool = true
        var fnameCharBool = true
        var lnameCharBool = true
        var billingaddressBool = true
        
        
        for traveler in travelerArray {
            
            if traveler.firstName == nil  || traveler.firstName?.isEmpty == true{
                callpaymentbool = false
            }
            
            if (traveler.firstName?.count ?? 0) <= 3 {
                fnameCharBool = false
            }
            
            if traveler.lastName == nil || traveler.lastName?.isEmpty == true{
                callpaymentbool = false
            }
            
            if (traveler.lastName?.count ?? 0) <= 3 {
                lnameCharBool = false
            }
            
            if traveler.dob == nil || traveler.dob?.isEmpty == true{
                callpaymentbool = false
            }
            
            if traveler.passportno == nil || traveler.passportno?.isEmpty == true{
                callpaymentbool = false
            }
            
            if traveler.passportIssuingCountry == nil || traveler.passportIssuingCountry?.isEmpty == true{
                callpaymentbool = false
            }
            
            if traveler.passportExpireDate == nil || traveler.passportExpireDate?.isEmpty == true{
                callpaymentbool = false
            }
            
            
            // Continue checking other fields
        }
        
        
        
        // Assuming you have a positionsCount variable that holds the number of cells in the table view
        let positionsCount = commonTableView.numberOfRows(inSection: 0)
        
        for position in 0..<positionsCount {
            // Fetch the cell for the given position
            
            // Fetch the cell for the given position
            if let cell = commonTableView.cellForRow(at: IndexPath(row: position, section: 0)) as? AddDeatilsOfTravellerTVCell {
                
                if cell.titleTF.text?.isEmpty == true {
                    // Textfield is empty
                    cell.titleView.layer.borderColor = UIColor.red.cgColor
                    callpaymentbool = false
                    
                } else {
                    // Textfield is not empty
                }
                
                if cell.fnameTF.text?.isEmpty == true {
                    // Textfield is empty
                    cell.fnameView.layer.borderColor = UIColor.red.cgColor
                    callpaymentbool = false
                }else if (cell.fnameTF.text?.count ?? 0) <= 3{
                    cell.fnameView.layer.borderColor = UIColor.red.cgColor
                    fnameCharBool = false
                }else {
                    fnameCharBool = true
                }
                
                if cell.lnameTF.text?.isEmpty == true {
                    // Textfield is empty
                    cell.lnameView.layer.borderColor = UIColor.red.cgColor
                    callpaymentbool = false
                }else if (cell.lnameTF.text?.count ?? 0) <= 3{
                    cell.lnameView.layer.borderColor = UIColor.red.cgColor
                    lnameCharBool = false
                } else {
                    // Textfield is not empty
                    lnameCharBool = true
                }
                
                
                if cell.dobTF.text?.isEmpty == true {
                    // Textfield is empty
                    cell.dobView.layer.borderColor = UIColor.red.cgColor
                    callpaymentbool = false
                } else {
                    // Textfield is not empty
                }
                
                
                if cell.passportnoTF.text?.isEmpty == true {
                    // Textfield is empty
                    cell.passportnoView.layer.borderColor = UIColor.red.cgColor
                    callpaymentbool = false
                } else {
                    // Textfield is not empty
                }
                
                
                if cell.passportIssuingCountryTF.text?.isEmpty == true {
                    // Textfield is empty
                    cell.issuecountryView.layer.borderColor = UIColor.red.cgColor
                    callpaymentbool = false
                } else {
                    // Textfield is not empty
                }
                
                
                if cell.passportExpireDateTF.text?.isEmpty == true {
                    // Textfield is empty
                    cell.passportexpireView.layer.borderColor = UIColor.red.cgColor
                    callpaymentbool = false
                } else {
                    // Textfield is not empty
                }
                
            }
            
            
            
            
            if let cell = commonTableView.cellForRow(at: IndexPath(row: position, section: 0)) as? BillingAddressTVCell {
                
                if cell.streetTF.text?.isEmpty == true {
                    // Textfield is empty
                    cell.streetView.layer.borderColor = UIColor.red.cgColor
                    billingaddressBool = false
                    
                } else {
                    // Textfield is not empty
                    billingaddressBool = true
                    street = cell.streetTF.text ?? ""
                }
                
                if cell.countryTF.text?.isEmpty == true {
                    // Textfield is empty
                    cell.countryView.layer.borderColor = UIColor.red.cgColor
                    billingaddressBool = false
                    
                } else {
                    // Textfield is not empty
                    billingaddressBool = true
                    countrySelected = cell.countryTF.text ?? ""
                }
                
                
                
                if cell.stateTF.text?.isEmpty == true {
                    // Textfield is empty
                    cell.stateView.layer.borderColor = UIColor.red.cgColor
                    billingaddressBool = false
                    
                } else {
                    // Textfield is not empty
                    billingaddressBool = true
                    stateSelected = cell.stateTF.text ?? ""
                }
                
                
                if cell.cityTF.text?.isEmpty == true {
                    // Textfield is empty
                    cell.cityView.layer.borderColor = UIColor.red.cgColor
                    billingaddressBool = false
                    
                } else {
                    // Textfield is not empty
                    billingaddressBool = true
                    citySelected = cell.cityTF.text ?? ""
                }
                
                if cell.postalcodeTF.text?.isEmpty == true {
                    // Textfield is empty
                    cell.postalcodeView.layer.borderColor = UIColor.red.cgColor
                    billingaddressBool = false
                    
                } else {
                    // Textfield is not empty
                    billingaddressBool = true
                    postalCode = cell.postalcodeTF.text ?? ""
                }
                
                
                if cell.emailTF.text?.isEmpty == true {
                    // Textfield is empty
                    cell.emailView.layer.borderColor = UIColor.red.cgColor
                    billingaddressBool = false
                    
                } else {
                    // Textfield is not empty
                    billingaddressBool = true
                    email = cell.emailTF.text ?? ""
                }
                
                
                if cell.countrycodeTF.text?.isEmpty == true {
                    // Textfield is empty
                    cell.mobileView.layer.borderColor = UIColor.red.cgColor
                    billingaddressBool = false
                    
                } else {
                    // Textfield is not empty
                    billingaddressBool = true
                    countrySelected = cell.countryTF.text ?? ""
                }
                
                
                if cell.mobileTF.text?.isEmpty == true {
                    // Textfield is empty
                    cell.mobileView.layer.borderColor = UIColor.red.cgColor
                    billingaddressBool = false
                    
                } else {
                    // Textfield is not empty
                    billingaddressBool = true
                    mobile = cell.mobileTF.text ?? ""
                }
                
                
                
            }
            
            
            
        }
        
        
        
        let laedpassengerArray = travelerArray.compactMap({$0.laedpassenger})
        let mrtitleArray = travelerArray.compactMap({$0.mrtitle})
        let genderArray = travelerArray.compactMap({$0.gender})
        let firstnameArray = travelerArray.compactMap({$0.firstName})
        let lastNameArray = travelerArray.compactMap({$0.lastName})
        let middlenameArray = travelerArray.compactMap({$0.middlename})
        let dobArray = travelerArray.compactMap({$0.dob})
        let passportnoArray = travelerArray.compactMap({$0.passportno})
        //   let nationalityArray = travelerArray.compactMap({$0.nationality})
        let passportIssuingCountryArray = travelerArray.compactMap({$0.passportIssuingCountry})
        let passportExpireDateArray = travelerArray.compactMap({$0.passportExpireDate})
      //  let passengertypeArray = travelerArray.compactMap({$0.passengertype})
        
        
        // Convert arrays to string representations
        let laedpassengerString = "[\"" + laedpassengerArray.joined(separator: "\",\"") + "\"]"
        let genderString = "[\"" + genderArray.joined(separator: "\",\"") + "\"]"
        let mrtitleString = "[\"" + mrtitleArray.joined(separator: "\",\"") + "\"]"
        let firstnameString = "[\"" + firstnameArray.joined(separator: "\",\"") + "\"]"
        let middlenameString = "[\"" + middlenameArray.joined(separator: "\",\"") + "\"]"
        let lastNameString = "[\"" + lastNameArray.joined(separator: "\",\"") + "\"]"
        let dobString = "[\"" + dobArray.joined(separator: "\",\"") + "\"]"
        let passportnoString = "[\"" + passportnoArray.joined(separator: "\",\"") + "\"]"
        let passportIssuingCountryString = "[\"" + passportIssuingCountryArray.joined(separator: "\",\"") + "\"]"
        let passportExpireDateString = "[\"" + passportExpireDateArray.joined(separator: "\",\"") + "\"]"
        let passengertypeArrayString = "[\"" + passengertypeArray.joined(separator: "\",\"") + "\"]"
        
        
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
        
        payload["passenger_type"] = passengertypeArrayString
        payload["lead_passenger"] = laedpassengerString
        payload["gender"] = genderString
        payload["passenger_nationality"] = passportIssuingCountryString
        payload["name_title"] =  mrtitleString
        payload["first_name"] =  firstnameString
        payload["middle_name"] =  middlenameString
        payload["last_name"] =  lastNameString
        payload["date_of_birth"] =  dobString
        payload["passenger_passport_number"] =  passportnoString
        payload["passenger_passport_issuing_country"] =  passportIssuingCountryString
        payload["passenger_passport_expiry"] =  passportExpireDateString
        
        payload["Frequent"] = "\([["Select"]])"
        payload["ff_no"] = "\([[""]])"
        
        payload["payment_method"] =  "PNHB1"
        payload["address2"] = street
        payload["billing_address_1"] = aprtment
        payload["billing_state"] = stateSelected
        payload["billing_city"] = citySelected
        payload["billing_zipcode"] = postalCode
        payload["billing_email"] = email
        payload["passenger_contact"] = mobile
        payload["billing_country"] = countrySelected
        payload["country_mobile_code"] = countryCode
        payload["insurance"] = "1"
        payload["tc"] = "on"
        payload["booking_step"] = "book"
        payload["selectedCurrency"] = defaults.string(forKey: UserDefaultsKeys.selectedCurrency) ?? "KWD"
        payload["user_id"] = defaults.string(forKey: UserDefaultsKeys.userid) ?? "0"
        
        
        
        
        if callpaymentbool == false {
            showToast(message: "Add Details")
        }else if fnameCharBool == false {
            showToast(message: "First Name Should More Than 3 Chars")
        }else if lnameCharBool == false {
            showToast(message: "Last Name Should More Than 3 Chars")
        }else if checkTermsAndCondationStatus == false {
            showToast(message: "Please Accept T&C and Privacy Policy")
        }else {
            vm?.CALL_PROCESS_PASSENGER_DETAIL_API(dictParam: payload)
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
        DispatchQueue.main.async {
            self.callmobile_pre_process_booking()
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
