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
    
    
    var dates = String()
    var citys = String()
    var tablerow = [TableRow]()
    var payload = [String:Any]()
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
        if callapibool == true {
            holderView.isHidden = true
            callmobile_pre_process_booking()
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
                                         "TravellerDetailsTVCell",
                                         "ViewFlightDetailsTVCell"])
        setupTV()
    }
    
    
    
    func setupTV() {
        
        tablerow.removeAll()
        
        tablerow.append(TableRow(cellType:.TDetailsLoginTVCell))
        tablerow.append(TableRow(moreData:flightsummary,
                                 cellType:.ViewFlightDetailsTVCell))
        tablerow.append(TableRow(cellType:.TravellerDetailsTVCell))
        tablerow.append(TableRow(cellType:.PromocodeTVCell))
        tablerow.append(TableRow(title:citys,
                                 subTitle: dates,
                                 cellType:.PurchaseSummaryTVCell))
        
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
    
    
    //MARK: - didTapOnBackBtnAction
    @IBAction func didTapOnBackBtnAction(_ sender: Any) {
        dismiss(animated: true)
    }
    
    
    //MARK: - didTapOnPayNowBtnAction
    @IBAction func didTapOnPayNowBtnAction(_ sender: Any) {
        paynowBtnTap()
    }
    
}

extension PayNowVC: PreProcessBookingViewModelDelegate {
    
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
    
    //MARK: - paynowBtnTap
    func paynowBtnTap() {
        print("didTapOnPayNowBtnAction")
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
        callmobile_pre_process_booking()
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
