//
//  PayNowVC.swift
//  Beeoons
//
//  Created by FCI on 12/08/23.
//

import UIKit

class PayNowVC: BaseTableVC {
    
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var totalPricelbl: UILabel!
    
    var tablerow = [TableRow]()
    var grandTotal = String()
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
        
        commonTableView.registerTVCells(["PurchaseSummaryTVCell",
                                         "PromocodeTVCell",
                                         "TravellerDetailsTVCell",
                                         "ViewFlightDetailsTVCell"])
        setupTV()
    }
    
    
    
    func setupTV() {
        
        tablerow.removeAll()
        
        tablerow.append(TableRow(moreData:flightsummary,cellType:.ViewFlightDetailsTVCell))
        tablerow.append(TableRow(cellType:.TravellerDetailsTVCell))
        tablerow.append(TableRow(cellType:.PromocodeTVCell))
        tablerow.append(TableRow(cellType:.PurchaseSummaryTVCell))
        
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
