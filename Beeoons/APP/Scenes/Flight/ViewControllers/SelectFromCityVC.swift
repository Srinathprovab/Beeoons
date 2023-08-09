//
//  SelectFromCityVC.swift
//  BabSafar
//
//  Created by MA673 on 20/07/22.
//

import UIKit
import Alamofire


class SelectFromCityVC: BaseTableVC, SelectCityViewModelProtocal {
    
    @IBOutlet weak var searchTextfieldHolderView: UIView!
    @IBOutlet weak var searchImg: UIImageView!
    @IBOutlet weak var searchTF: UITextField!
    @IBOutlet weak var nav: NavBar!
    @IBOutlet weak var navHeight: NSLayoutConstraint!
    
    var tobool = false
    var tofromBool = false
    var filtered1:[CityOrHotelListModel] = []
    var cityList1:[CityOrHotelListModel] = []
    var keyStr = String()
    var filtered:[SelectCityModel] = []
    var cityList:[SelectCityModel] = []
    var cityViewModel: SelectCityViewModel?
    var tablerow = [TableRow]()
    var titleStr = String()
    var tokey = String()
    var payload = [String:Any]()
    var isSearchBool = Bool()
    var searchText = String()
    var celltag = Int()
    
    static var newInstance: SelectFromCityVC? {
        let storyboard = UIStoryboard(name: Storyboard.Main.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? SelectFromCityVC
        return vc
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(offline), name: NSNotification.Name("offline"), object: nil)
        
        searchTF.becomeFirstResponder()
        celltag = defaults.integer(forKey: UserDefaultsKeys.cellTag)
        
        if keyStr == "hotel" {
            CallShowHotelorCityListAPI(str: "")
        }else {
            CallShowCityListAPI(str: "")
        }
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(reloadTV(notification:)), name: NSNotification.Name("reloadTV"), object: nil)
        
    }
    
    
    @objc func offline(notificatio:UNNotification) {
        callapibool = true
        guard let vc = NoInternetConnectionVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: false)
    }
    
    
    
    @objc func reloadTV(notification:NSNotification) {
        if keyStr == "hotel" {
            CallShowHotelorCityListAPI(str: "")
        }else {
            CallShowCityListAPI(str: "")
        }
    }
    
    
    func CallShowCityListAPI(str:String) {
        payload["term"] = str
        cityViewModel?.CallShowCityListAPI(dictParam: payload)
    }
    
    func CallShowHotelorCityListAPI(str:String) {
        payload["term"] = str
        cityViewModel?.CALL_GET_HOTEL_CITY_LIST_API(dictParam: payload)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupUI()
        cityViewModel = SelectCityViewModel(self)
        
    }
    
    func setupUI() {
        
        
        if keyStr == "hotel" {
            searchTF.placeholder = "search hotel/city"
        }else {
            searchTF.placeholder = "search airport /city"
        }
        nav.titlelbl.text = titleStr
        nav.backBtn.addTarget(self, action: #selector(dismisVC(_:)), for: .touchUpInside)
        setupViews(v: searchTextfieldHolderView, radius: 6, color: .WhiteColor.withAlphaComponent(0.5))
        if screenHeight > 835 {
            navHeight.constant = 130
        }else {
            navHeight.constant = 100
        }
        
        searchImg.image = UIImage(named: "search")?.withRenderingMode(.alwaysOriginal).withTintColor(.AppBackgroundColor)
        searchTF.backgroundColor = .clear
        searchTF.setLeftPaddingPoints(20)
        searchTF.font = UIFont.LatoRegular(size: 16)
        searchTF.addTarget(self, action: #selector(searchTextChanged(_:)), for: .editingChanged)
        commonTableView.register(UINib(nibName: "FromCityTVCell", bundle: nil), forCellReuseIdentifier: "cell")
        commonTableView.separatorStyle = .singleLine
        commonTableView.separatorColor = .lightGray
    }
    
    
    
    @objc func dismisVC(_ sender:UIButton) {
        self.dismiss(animated: true)
    }
    
    func setupViews(v:UIView,radius:CGFloat,color:UIColor) {
        v.backgroundColor = color
        v.layer.cornerRadius = radius
        v.clipsToBounds = true
        v.layer.borderWidth = 1
        v.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.4).cgColor
    }
    
    func setupLabels(lbl:UILabel,text:String,textcolor:UIColor,font:UIFont) {
        lbl.text = text
        lbl.textColor = textcolor
        lbl.font = font
    }
    
    
    @objc func searchTextChanged(_ sender: UITextField) {
        searchText = sender.text ?? ""
        
        if keyStr == "hotel" {
            
            if searchText == "" {
                isSearchBool = false
                filterContentForSearchText(searchText)
            }else {
                isSearchBool = true
                filterContentForSearchText(searchText)
            }
            
            CallShowHotelorCityListAPI(str: searchText)
        }else {
            if searchText == "" {
                isSearchBool = false
                filterContentForSearchText(searchText)
            }else {
                isSearchBool = true
                filterContentForSearchText(searchText)
            }
            
            CallShowCityListAPI(str: searchText)
        }
    }
    
    func filterContentForSearchText(_ searchText: String) {
        print("Filterin with:", searchText)
        
        if keyStr == "hotel" {
            filtered1.removeAll()
            filtered1 = self.cityList1.filter { thing in
                return "\(thing.label?.lowercased() ?? "")".contains(searchText.lowercased())
            }
        }else {
            filtered.removeAll()
            filtered = self.cityList.filter { thing in
                return "\(thing.label?.lowercased() ?? "")".contains(searchText.lowercased())
            }
        }
        
        commonTableView.reloadData()
    }
    
    
    
    func ShowCityList(response: [SelectCityModel]) {
        self.cityList = response
        DispatchQueue.main.async {[self] in
            commonTableView.reloadData()
        }
    }
    
    func getHotelCityList(response: [CityOrHotelListModel]) {
        self.cityList1 = response
        DispatchQueue.main.async {[self] in
            commonTableView.reloadData()
        }
    }
    
    
    func gotoBookFlightVC() {
        guard let vc = BookFlightVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: false)
    }
    
    func gotoSearchHotelsVC() {
        guard let vc = BookHotelVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: false)
    }
    
    @IBAction func didTapOnBackButton(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
}


extension SelectFromCityVC {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //check search text & original text
        if keyStr == "hotel" {
            if(isSearchBool == true){
                return filtered1.count
            }else{
                return cityList1.count
            }
        }else {
            if( isSearchBool == true){
                return filtered.count
            }else{
                return cityList.count
            }
        }
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! FromCityTVCell
        cell.selectionStyle = .none
        if keyStr == "hotel" {
            if( isSearchBool == true){
                let dict = filtered1[indexPath.row]
                cell.titlelbl.text = dict.value
                cell.id = dict.id ?? ""
                cell.cityname = dict.label ?? ""
                cell.setAttributedString(str1: dict.value ?? "", str2: "")
                cell.citycode = dict.value ?? ""
            }else{
                let dict = cityList1[indexPath.row]
                cell.titlelbl.text = dict.value
                cell.id = dict.id ?? ""
                cell.cityname = dict.label ?? ""
                cell.setAttributedString(str1: dict.value ?? "", str2: "")
                cell.citycode = dict.value ?? ""
            }
        }else {
            if( isSearchBool == true){
                
                let dict = filtered[indexPath.row]
                cell.titlelbl.text = dict.city
                cell.label = dict.label ?? ""
                cell.id = dict.id ?? ""
                cell.citycode = dict.code ?? ""
                cell.cityname = "\(dict.city ?? "") (\(dict.code ?? ""))"
                cell.setAttributedString(str1: dict.airport_name ?? "", str2: " \(dict.code ?? "")")
                
            }else{
                
                let dict = cityList[indexPath.row]
                cell.titlelbl.text = dict.city
                cell.label = dict.label ?? ""
                cell.id = dict.id ?? ""
                cell.citycode = dict.code ?? ""
                cell.cityname = "\(dict.city ?? "") (\(dict.code ?? ""))"
                cell.setAttributedString(str1: dict.airport_name ?? "", str2: " \(dict.code ?? "")")
            }
        }
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let cell = tableView.cellForRow(at: indexPath) as? FromCityTVCell {
            
            if let selectedtab = defaults.string(forKey: UserDefaultsKeys.tabselect) {
                if selectedtab == "Flight" {
                    if let selectedJourneyType = defaults.string(forKey: UserDefaultsKeys.journeyType) {
                        if selectedJourneyType == "oneway" {
                            if titleStr == "From" {
                                
                                tofromBool = false
                                
                                defaults.set(cell.label , forKey: UserDefaultsKeys.fromCity)
                                defaults.set(cell.id , forKey: UserDefaultsKeys.fromlocid)
                                defaults.set(cell.cityname , forKey: UserDefaultsKeys.fromcityname)
                            }else {
                                
                                tofromBool = true
                                
                                defaults.set(cell.label , forKey: UserDefaultsKeys.toCity)
                                defaults.set(cell.id , forKey: UserDefaultsKeys.tolocid)
                                defaults.set(cell.cityname , forKey: UserDefaultsKeys.tocityname)
                                
                            }
                        }else if selectedJourneyType == "circle" {
                            if titleStr == "From" {
                                
                                tofromBool = false
                                
                                defaults.set(cell.label, forKey: UserDefaultsKeys.rfromCity)
                                defaults.set(cell.id , forKey: UserDefaultsKeys.rfromlocid)
                                defaults.set(cell.cityname , forKey: UserDefaultsKeys.rfromcityname)
                            }else {
                                
                                tofromBool = true
                                
                                defaults.set(cell.label, forKey: UserDefaultsKeys.rtoCity)
                                defaults.set(cell.id , forKey: UserDefaultsKeys.rtolocid)
                                defaults.set(cell.cityname , forKey: UserDefaultsKeys.rtocityname)
                            }
                        }else {
                            if titleStr == "From" {
                                defaults.set(cell.label, forKey: UserDefaultsKeys.mfromCity)
                                defaults.set(cell.id , forKey: UserDefaultsKeys.mfromlocid)
                                defaults.set(cell.cityname , forKey: UserDefaultsKeys.mfromcityname)
                                
                                fromCityCodeArray[self.celltag] = cell.citycode
                                fromCityNameArray[self.celltag] = cell.label
                                fromlocidArray[self.celltag] = cell.id
                            }else {
                                defaults.set(cell.label, forKey: UserDefaultsKeys.mtoCity)
                                defaults.set(cell.id , forKey: UserDefaultsKeys.mtolocid)
                                defaults.set(cell.cityname , forKey: UserDefaultsKeys.mtocityname)
                                
                                
                                
                                toCityCodeArray[self.celltag] = cell.citycode
                                toCityNameArray[self.celltag] = cell.label
                                tolocidArray[self.celltag] = cell.id
                                
                            }
                        }
                    }
                    
                    
                    NotificationCenter.default.post(name: NSNotification.Name("reload"), object: nil)
                    
                    
                    if titleStr == "From" {
                        guard let vc = SelectFromCityVC.newInstance.self else {return}
                        vc.modalPresentationStyle = .fullScreen
                        callapibool = true
                        vc.titleStr = "To"
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
