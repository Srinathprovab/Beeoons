//
//  SelectedHotelDetailsTVCell.swift
//  Beeoons
//
//  Created by FCI on 30/09/23.
//

import UIKit

class SelectedHotelDetailsVC: BaseTableVC, HotelDetailsViewModelDelegate {
    
    
    @IBOutlet weak var citylbl: UILabel!
    @IBOutlet weak var dateslbl: UILabel!
    @IBOutlet weak var holderView: UIView!
    
    static var newInstance: SelectedHotelDetailsVC? {
        let storyboard = UIStoryboard(name: Storyboard.Hotel.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? SelectedHotelDetailsVC
        return vc
    }
    var tablerow = [TableRow]()
    var payload = [String:Any]()
    var vm:HotelDetailsViewModel?
    var hotel_details:Hotel_details?
    
    override func viewWillAppear(_ animated: Bool) {
        addObserver()
        
        if callapibool == true {
            holderView.isHidden = true
            callAPI()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupUI()
        vm = HotelDetailsViewModel(self)
    }
    
    
    func setupUI() {
        commonTableView.registerTVCells(["HotelImagesTVCell",
                                        "SelectRoomsTVCell"])
    }
    
    
    
    @IBAction func didTapOnBackButtonAction(_ sender: Any) {
        dismiss(animated: true)
    }
}




extension SelectedHotelDetailsVC {
    
    func callAPI() {
        payload.removeAll()
        
        payload["booking_source"] = hotelbookingsource
        payload["hotel_id"] = hotel_id
        payload["search_id"] = hotelsearchid
        payload["user_id"] = defaults.string(forKey: UserDefaultsKeys.userid) ?? "0"
        vm?.CALL_GET_HOTEL_LIST_API(dictParam: payload)
    }
    
    
    func selectedHotelDetails(response: HotelDetailsModel) {
        loderBool = false
        holderView.isHidden = false
        citylbl.text = defaults.string(forKey: UserDefaultsKeys.locationcity)
        dateslbl.text = "\(convertDateFormat(inputDate: defaults.string(forKey: UserDefaultsKeys.checkin) ?? "", f1: "dd-MM-yyyy", f2: "dd MMM yyyy")) - \(convertDateFormat(inputDate: defaults.string(forKey: UserDefaultsKeys.checkout) ?? "", f1: "dd-MM-yyyy", f2: "dd MMM yyyy")), \(defaults.string(forKey: UserDefaultsKeys.hoteladultscount) ?? "") Adults,\(defaults.string(forKey: UserDefaultsKeys.roomcount) ?? "") Room"
        
        hotelsearchid = response.params?.search_id ?? ""
        hotelbookingsource = response.params?.booking_source ?? ""
        hotel_id = response.params?.hotel_id ?? ""
        hotel_details = response.hotel_details
        
        DispatchQueue.main.async {[self] in
            self.setuTVCells()
        }
    }
    
    
    
    func setuTVCells() {
        tablerow.removeAll()
        
        tablerow.append(TableRow(title:hotel_details?.name,
                                 subTitle: hotel_details?.address,
                                 image: hotel_details?.image,
                                 cellType:.HotelImagesTVCell))
        
        
        tablerow.append(TableRow(moreData: hotel_details?.rooms,
                                  cellType:.SelectRoomsTVCell))
        
        
        
        commonTVData = tablerow
        commonTableView.reloadData()
    }
    
    
}



extension SelectedHotelDetailsVC {
    
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
