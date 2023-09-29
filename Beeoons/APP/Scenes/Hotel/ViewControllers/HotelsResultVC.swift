//
//  HotelsResultVC.swift
//  Beeoons
//
//  Created by FCI on 29/09/23.
//

import UIKit

class HotelsResultVC: BaseTableVC, HotelSearchViewModelDelegate {
    
    @IBOutlet weak var citylbl: UILabel!
    @IBOutlet weak var dateslbl: UILabel!
    @IBOutlet weak var holderView: UIView!
    
    static var newInstance: HotelsResultVC? {
        let storyboard = UIStoryboard(name: Storyboard.Hotel.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? HotelsResultVC
        return vc
    }
    var tablerow = [TableRow]()
    var payload = [String:Any]()
    var vm:HotelSearchViewModel?
    var hotelSearchResult = [HotelSearchResult]()
    
    override func viewWillAppear(_ animated: Bool) {
        addObserver()
        
        if callapibool == true {
            holderView.isHidden = true
            callSearchAPI()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupUI()
        vm = HotelSearchViewModel(self)
    }
    
    
    func setupUI() {
        commonTableView.registerTVCells(["HotelsResultVCTVCell"])
    }
    
    
 
    
    @IBAction func didTapOnBackButtonAction(_ sender: Any) {
        dismiss(animated: true)
    }
    
    
    @IBAction func didTapOnModifySearchBtnAction(_ sender: Any) {
        guard let vc = ModifyHotelsResultVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: false)
    }
    
    
    
    override func didTapOnHotelDetailsBtnAction(cell: HotelsResultVCTVCell) {
        hotel_id = cell.hotelid
        print("search id \(hotelsearchid)")
        print("booking source \(hotelbookingsource)")
        print("hotel id \(hotel_id)")
    }
    
    override func didTapOnCancellationBtnAction(cell: HotelsResultVCTVCell) {
        print("didTapOnCancellationBtnAction")
    }
    

}



extension HotelsResultVC {
    
    func callSearchAPI() {
        loderBool = true
        vm?.CALL_GET_HOTEL_LIST_API(dictParam: payload)
    }
    
    func hotelList(response: HotelSearchModel) {
        loderBool = false
        holderView.isHidden = false
        citylbl.text = defaults.string(forKey: UserDefaultsKeys.locationcity)
        dateslbl.text = "\(convertDateFormat(inputDate: defaults.string(forKey: UserDefaultsKeys.checkin) ?? "", f1: "dd-MM-yyyy", f2: "dd MMM yyyy")) - \(convertDateFormat(inputDate: defaults.string(forKey: UserDefaultsKeys.checkin) ?? "", f1: "dd-MM-yyyy", f2: "dd MMM yyyy")), \(defaults.string(forKey: UserDefaultsKeys.hoteladultscount) ?? "") Adults,\(defaults.string(forKey: UserDefaultsKeys.roomcount) ?? "") Room"
        
        hotelsearchid = response.search_id ?? ""
        hotelbookingsource = response.booking_source ?? ""
        hotelSearchResult = response.data?.hotelSearchResult ?? []
        
        DispatchQueue.main.async {[self] in
            self.setuTVCells()
        }
    }
    

    
    
    func setuTVCells() {
        tablerow.removeAll()
        
        
        
        hotelSearchResult.forEach { i in
            tablerow.append(TableRow(title:i.name,
                                     subTitle: i.address,
                                     refundable: i.refund,
                                     price: i.price,
                                     buttonTitle: "000",
                                     image: i.image,
                                     tempText: i.hotel_code,
                                     cellType:.HotelsResultVCTVCell))
            
        }
       
        
        commonTVData = tablerow
        commonTableView.reloadData()
    }
    
    
    
    
}



extension HotelsResultVC {
    
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
