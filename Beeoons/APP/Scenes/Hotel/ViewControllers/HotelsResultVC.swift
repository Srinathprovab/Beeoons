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
        commonTableView.registerTVCells(["BookHotelTVCell"])
    }
    
    
    
    
    func setuTVCells() {
        tablerow.removeAll()
        
       
        
        commonTVData = tablerow
        commonTableView.reloadData()
    }
    
    
    @IBAction func didTapOnBackButtonAction(_ sender: Any) {
        dismiss(animated: true)
    }
    
    
    @IBAction func didTapOnModifySearchBtnAction(_ sender: Any) {
        guard let vc = ModifyHotelsResultVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: false)
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
        
        DispatchQueue.main.async {[self] in
            self.setuTVCells()
        }
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
