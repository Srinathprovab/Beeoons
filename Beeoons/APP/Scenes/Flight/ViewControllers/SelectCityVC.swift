//
//  SelectCityVC.swift
//  Beeoons
//
//  Created by FCI on 09/08/23.
//

import UIKit

class SelectCityVC: BaseTableVC, SelectCityViewModelProtocal {
    
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var searchTextfieldHolderView: UIView!
    @IBOutlet weak var searchImg: UIImageView!
    @IBOutlet weak var searchTF: UITextField!
    
    
    //    var filtered1:[CityOrHotelListModel] = []
    //    var cityList1:[CityOrHotelListModel] = []
    var keyStr = String()
    var filtered:[SelectCityModel] = []
    var cityList:[SelectCityModel] = []
    var cityViewModel: SelectCityViewModel?
    var tablerow = [TableRow]()
    var titleStr = String()
    var payload = [String:Any]()
    var isSearchBool = Bool()
    var searchText = String()
    var celltag = Int()
    var tokey = String()
    
    static var newInstance: SelectCityVC? {
        let storyboard = UIStoryboard(name: Storyboard.Flight.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? SelectCityVC
        return vc
    }
    
    @objc func offline(){
        //        guard let vc = NoInternetConnectionVC.newInstance.self else {return}
        //        vc.modalPresentationStyle = .fullScreen
        //        callapibool = true
        //        present(vc, animated: false)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        NotificationCenter.default.addObserver(self, selector: #selector(offline), name: NSNotification.Name("offline"), object: nil)
        searchTF.becomeFirstResponder()
        self.celltag = Int(defaults.string(forKey: UserDefaultsKeys.cellTag) ?? "0") ?? 0
        
        
        //        if keyStr == "hotel" {
        //            CallShowHotelorCityListAPI(str: "")
        //        }else {
        //            CallShowCityListAPI(str: "")
        //        }
        
        CallShowCityListAPI(str: "")
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(reloadTV(notification:)), name: NSNotification.Name("reloadTV"), object: nil)
    }
    
    
    
    @objc func reloadTV(notification:NSNotification) {
        CallShowCityListAPI(str: "")
    }
    
    
    func CallShowCityListAPI(str:String) {
        payload["term"] = str
        cityViewModel?.CallShowCityListAPI(dictParam: payload)
    }
    
    //    func CallShowHotelorCityListAPI(str:String) {
    //        payload["term"] = str
    //        cityViewModel?.CALL_GET_HOTEL_CITY_LIST_API(dictParam: payload)
    //    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupUI()
        cityViewModel = SelectCityViewModel(self)
        
    }
    
    func setupUI() {
        
        titlelbl.text = titleStr
        if keyStr == "HOTEL" {
           
            searchTF.placeholder = "search hotel/city"
        }else {
        
            searchTF.placeholder = "search airport /city"
        }
        

        searchTextfieldHolderView.layer.borderColor = UIColor.AppBorderColor.cgColor
        searchTextfieldHolderView.layer.borderWidth = 1
        
        searchImg.image = UIImage(named: "search")?.withRenderingMode(.alwaysOriginal).withTintColor(.NavBackColor)
        searchTF.backgroundColor = .clear
        searchTF.setLeftPaddingPoints(14)
        searchTF.font = UIFont.OswaldRegular(size: 16)
        searchTF.addTarget(self, action: #selector(searchTextChanged(_:)), for: .editingChanged)
        commonTableView.register(UINib(nibName: "FromCityTVCell", bundle: nil), forCellReuseIdentifier: "cell")
        commonTableView.separatorStyle = .singleLine
        commonTableView.separatorColor = .lightGray
    }
    
    
    
    @IBAction func backBtnAction(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    
    @objc func searchTextChanged(_ sender: UITextField) {
        searchText = sender.text ?? ""
        
        if searchText == "" {
            isSearchBool = false
            filterContentForSearchText(searchText)
        }else {
            isSearchBool = true
            filterContentForSearchText(searchText)
        }
        
        CallShowCityListAPI(str: searchText)
        
        //        if keyStr == "hotel" {
        //
        //            if searchText == "" {
        //                isSearchBool = false
        //                filterContentForSearchText(searchText)
        //            }else {
        //                isSearchBool = true
        //                filterContentForSearchText(searchText)
        //            }
        //
        //            CallShowHotelorCityListAPI(str: searchText)
        //        }else {
        //            if searchText == "" {
        //                isSearchBool = false
        //                filterContentForSearchText(searchText)
        //            }else {
        //                isSearchBool = true
        //                filterContentForSearchText(searchText)
        //            }
        //
        //            CallShowCityListAPI(str: searchText)
        //        }
    }
    
    func filterContentForSearchText(_ searchText: String) {
        print("Filterin with:", searchText)
        
        //        if keyStr == "hotel" {
        //            filtered1.removeAll()
        //            filtered1 = self.cityList1.filter { thing in
        //                return "\(thing.label?.lowercased() ?? "")".contains(searchText.lowercased())
        //            }
        //        }else {
        //            filtered.removeAll()
        //            filtered = self.cityList.filter { thing in
        //                return "\(thing.label?.lowercased() ?? "")".contains(searchText.lowercased())
        //            }
        //        }
        
        filtered.removeAll()
        filtered = self.cityList.filter { thing in
            return "\(thing.label?.lowercased() ?? "")".contains(searchText.lowercased())
        }
        commonTableView.reloadData()
    }
    
    
    
    func ShowCityList(response: [SelectCityModel]) {
        self.cityList = response
        DispatchQueue.main.async {[self] in
            commonTableView.reloadData()
        }
    }
    
    //    func getHotelCityList(response: [CityOrHotelListModel]) {
    //        self.cityList1 = response
    //        DispatchQueue.main.async {[self] in
    //            commonTableView.reloadData()
    //        }
    //    }
    
    
    
    
    func gotoBookFlightVC() {
        guard let vc = BookFlightVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: false)
    }
    
    func gotoSearchHotelsVC() {
        //        guard let vc = BookHotelVC.newInstance.self else {return}
        //        vc.modalPresentationStyle = .fullScreen
        //        self.present(vc, animated: false)
    }
    
    @IBAction func didTapOnBackButton(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
}


extension SelectCityVC {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //check search text & original text
        if( isSearchBool == true){
            return filtered.count
        }else{
            return cityList.count
        }
        
        
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! FromCityTVCell
        cell.selectionStyle = .none
        if( isSearchBool == true){
            let dict = cityList[indexPath.row]
            cell.titlelbl.text = dict.city
            cell.subtitlelbl.text = dict.value ?? ""
            cell.label = dict.value ?? ""
            cell.id = dict.id ?? ""
            cell.citycode = dict.code ?? ""
            cell.cityname = "\(dict.city ?? "")"
           
        }else{
            let dict = cityList[indexPath.row]
            cell.titlelbl.text = dict.city
            cell.subtitlelbl.text = dict.value ?? ""
            cell.label = dict.value ?? ""
            cell.id = dict.id ?? ""
            cell.citycode = dict.code ?? ""
            cell.cityname = "\(dict.city ?? "")"
        }
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let cell = tableView.cellForRow(at: indexPath) as? FromCityTVCell {
            
            if let selectedtab = defaults.string(forKey: UserDefaultsKeys.tabselect) {
                if selectedtab == "FLIGHT" {
                    if let selectedJourneyType = defaults.string(forKey: UserDefaultsKeys.journeyType) {
                        if selectedJourneyType == "oneway" {
                            if titleStr == "From Destination" {
                                defaults.set(cell.label , forKey: UserDefaultsKeys.fromCity)
                                defaults.set(cell.id , forKey: UserDefaultsKeys.fromlocid)
                                defaults.set(cell.cityname , forKey: UserDefaultsKeys.fromcityname)
                            }else {
                                defaults.set(cell.label , forKey: UserDefaultsKeys.toCity)
                                defaults.set(cell.id , forKey: UserDefaultsKeys.tolocid)
                                defaults.set(cell.cityname , forKey: UserDefaultsKeys.tocityname)
                                
                            }
                        }else if selectedJourneyType == "circle" {
                            if titleStr == "From Destination" {
                                defaults.set(cell.label, forKey: UserDefaultsKeys.rfromCity)
                                defaults.set(cell.id , forKey: UserDefaultsKeys.rfromlocid)
                                defaults.set(cell.cityname , forKey: UserDefaultsKeys.rfromcityname)
                            }else {
                                defaults.set(cell.label, forKey: UserDefaultsKeys.rtoCity)
                                defaults.set(cell.id , forKey: UserDefaultsKeys.rtolocid)
                                defaults.set(cell.cityname , forKey: UserDefaultsKeys.rtocityname)
                            }
                        }else {
                            
                        }
                    }
                    
                    
                    
                    
                    NotificationCenter.default.post(name: NSNotification.Name("reload"), object: nil)
                    
                    
                    if titleStr == "From Destination" {
                        guard let vc = SelectCityVC.newInstance.self else {return}
                        vc.modalPresentationStyle = .fullScreen
                        callapibool = true
                        vc.titleStr = "To Destination"
                        vc.tokey = "toooo"
                        present(vc, animated: false)
                    }else {
                        
                        
                        if tokey == "frommm" {
                            dismiss(animated: true, completion: nil)
                        }else {
                            presentingViewController?.presentingViewController?.dismiss(animated: true)
                            
                        }
                    }
                }else {
                    defaults.set(cell.titlelbl.text ?? "", forKey: UserDefaultsKeys.locationcity)
                    defaults.set(cell.id , forKey: UserDefaultsKeys.locationid)
                    
                    NotificationCenter.default.post(name: NSNotification.Name("reload"), object: nil)
                    self.dismiss(animated: true)
                }
            }
        }
        
        
    }
}
