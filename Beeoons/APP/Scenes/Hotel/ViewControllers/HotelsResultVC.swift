//
//  HotelsResultVC.swift
//  Beeoons
//
//  Created by FCI on 29/09/23.
//

import UIKit
import DropDown

class HotelsResultVC: BaseTableVC, HotelSearchViewModelDelegate {
    
    @IBOutlet weak var citylbl: UILabel!
    @IBOutlet weak var dateslbl: UILabel!
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var priceView: UIView!
    @IBOutlet weak var starView: UIView!
    @IBOutlet weak var atozView: UIView!
    @IBOutlet weak var bottomView: UIView!
    
    static var newInstance: HotelsResultVC? {
        let storyboard = UIStoryboard(name: Storyboard.Hotel.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? HotelsResultVC
        return vc
    }
    
    
    var atozdropDown = DropDown()
    var stardropDown = DropDown()
    var pricedropDown = DropDown()
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
        setupDropDown()
        setupstarDropDown()
        setupatozDropDown()
        commonTableView.bounces = false
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
    
    
    @IBAction func didTapOnAtoZFilterBtnAction(_ sender: Any) {
        atozdropDown.show()
    }
    
    
    @IBAction func didTapOnstarFilterBtnAction(_ sender: Any) {
        stardropDown.show()
    }
    
    
    @IBAction func didTapOnPriceFilterBtnAction(_ sender: Any) {
        pricedropDown.show()
    }
    
    @IBAction func didTapOnFilterBtnAction(_ sender: Any) {
        print("didTapOnFilterBtnAction")
    }
    
    
    
    
    override func didTapOnHotelDetailsBtnAction(cell: HotelsResultVCTVCell) {
        hotel_id = cell.hotelid
        gotoSelectedHotelDetailsVC()
    }
    
    
    
    override func didTapOnCancellationBtnAction(cell: HotelsResultVCTVCell) {
        print("didTapOnCancellationBtnAction")
    }
    
    
}



extension HotelsResultVC {
    
    func callSearchAPI() {
        vm?.CALL_GET_HOTEL_LIST_API(dictParam: payload)
    }
    
    func hotelList(response: HotelSearchModel) {
        holderView.isHidden = false
        citylbl.text = defaults.string(forKey: UserDefaultsKeys.locationcity)
        dateslbl.text = "\(convertDateFormat(inputDate: defaults.string(forKey: UserDefaultsKeys.checkin) ?? "", f1: "dd-MM-yyyy", f2: "dd MMM yyyy")) - \(convertDateFormat(inputDate: defaults.string(forKey: UserDefaultsKeys.checkout) ?? "", f1: "dd-MM-yyyy", f2: "dd MMM yyyy")), \(defaults.string(forKey: UserDefaultsKeys.hoteladultscount) ?? "") Adults,\(defaults.string(forKey: UserDefaultsKeys.roomcount) ?? "") Room"
        
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
    
    
    
    func gotoSelectedHotelDetailsVC(){
        guard let vc = SelectedHotelDetailsVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: false)
    }
    
    
    
    func setupDropDown() {

        pricedropDown.dataSource = ["Price Low","Price Heigh"]
        pricedropDown.textFont = .OswaldLight(size: 16)
        pricedropDown.direction = .top
        pricedropDown.backgroundColor = .WhiteColor
        pricedropDown.anchorView = self.priceView
        pricedropDown.bottomOffset = CGPoint(x: 0, y: priceView.frame.size.height + 100)
        pricedropDown.selectionAction = { [weak self] (index: Int, item: String) in

            print(item)

        }
    }
    
    
    
    func setupstarDropDown() {
        
        stardropDown.dataSource = ["1 Star","2 Star","3 Star","4 Star","5 Star"]
        stardropDown.textFont = .OswaldLight(size: 16)
        stardropDown.direction = .top
        stardropDown.backgroundColor = .WhiteColor
        stardropDown.anchorView = self.starView
        stardropDown.bottomOffset = CGPoint(x: 0, y: starView.frame.size.height + 100)
        stardropDown.selectionAction = { [weak self] (index: Int, item: String) in
            
            print(item)
            
        }
    }
    
    
    func setupatozDropDown() {
        
        atozdropDown.dataSource = ["A to Z","Z to A"]
        atozdropDown.textFont = .OswaldLight(size: 16)
        atozdropDown.direction = .top
        atozdropDown.backgroundColor = .WhiteColor
        atozdropDown.anchorView = self.atozView
        atozdropDown.bottomOffset = CGPoint(x: 0, y: atozView.frame.size.height + 100)
        atozdropDown.selectionAction = { [weak self] (index: Int, item: String) in
            
            print(item)
            
        }
    }
    
    
}
