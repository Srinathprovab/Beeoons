//
//  BookFlightMCTVCell.swift
//  Beeoons
//
//  Created by FCI on 15/08/23.
//

import UIKit
import DropDown


protocol BookFlightMCTVCellDelegate {
    
    func didTapOnFromCityBtn(cell:BookFlightMCTVCell)
    func didTapOnToCityBtn(cell:BookFlightMCTVCell)
    func didTapOnDateBtn(cell:BookFlightMCTVCell)
    func didTapOnSelectTravellersBtnAction(cell:BookFlightMCTVCell)
    func didTapOnSelectClassBtnAction(cell:BookFlightMCTVCell)
    func didTapOnSearchFlightBtnAction(cell:BookFlightMCTVCell)
    
}

class BookFlightMCTVCell: TableViewCell,AddcityTVCellDelegate {
    
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var travellerlbl: UILabel!
    @IBOutlet weak var classlbl: UILabel!
    @IBOutlet weak var classView: UIView!
    @IBOutlet weak var addCityTV: UITableView!
    @IBOutlet weak var tvHeight: NSLayoutConstraint!
    @IBOutlet weak var addCityBtn: UIButton!
    @IBOutlet weak var addCityBtnView: UIView!
    
    var count = 0
    var cname = String()
    var countryCode = String()
    var countryNames = [String]()
    var countrycodesArray = [String]()
    var originArray = [String]()
    var isocountrycodeArray = [String]()
    var filterdcountrylist = [Country_list]()
    let dropDown = DropDown()
    let airlinedropDown = DropDown()
    var tapairlinebool = true
    var delegate:BookFlightMCTVCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    override func updateUI() {
        filterdcountrylist = countrylist
        loadCountryNamesAndCode()
        
        self.travellerlbl.text = "\(defaults.string(forKey: UserDefaultsKeys.mtravellerDetails) ?? "Traveller(s)")"
        self.classlbl.text = "\(defaults.string(forKey: UserDefaultsKeys.mselectClass) ?? "Class")"
        
        updateheight()
    }
    
    func updateheight() {
        tvHeight.constant = CGFloat(70 * (fromCityShortNameArray.count))
        addCityTV.reloadData()
    }
    
    func loadCountryNamesAndCode(){
        countryNames.removeAll()
        countrycodesArray.removeAll()
        isocountrycodeArray.removeAll()
        originArray.removeAll()
        
        filterdcountrylist.forEach { i in
            countryNames.append(i.name ?? "")
            countrycodesArray.append(i.country_code ?? "")
            isocountrycodeArray.append(i.iso_country_code ?? "")
            originArray.append(i.origin ?? "")
        }
        
        DispatchQueue.main.async {[self] in
            airlinedropDown.dataSource = countryNames
        }
    }
    
    
    func setupUI() {
        holderView.layer.borderWidth = 1
        holderView.layer.borderColor = UIColor.WhiteColor.cgColor
        setupDropDown()
        
        setupTV()
    }
    
    func setupTV() {
        
        let nib = UINib(nibName: "AddcityTVCell", bundle: nil)
        addCityTV.register(nib, forCellReuseIdentifier: "cell")
        addCityTV.delegate = self
        addCityTV.dataSource = self
        addCityTV.tableFooterView = UIView()
        addCityTV.separatorStyle = .none
        addCityTV.isScrollEnabled = false
        
    }
    
    
    
    func setupDropDown() {
        
        dropDown.dataSource = ["Economy","PremimumEconomy","Business","First"]
        dropDown.textFont = .OswaldLight(size: 16)
        dropDown.direction = .bottom
        dropDown.backgroundColor = .WhiteColor
        dropDown.anchorView = self.classView
        dropDown.bottomOffset = CGPoint(x: 0, y: classView.frame.size.height + 10)
        dropDown.selectionAction = { [weak self] (index: Int, item: String) in
            
            self?.classlbl.text = item
            defaults.set(self?.classlbl.text, forKey: UserDefaultsKeys.mselectClass)
            
        }
    }
    
    
    @IBAction func didTapOnSelectTravellersBtnAction(_ sender: Any) {
        delegate?.didTapOnSelectTravellersBtnAction(cell: self)
    }
    
    @IBAction func didTapOnSelectClassBtnAction(_ sender: Any) {
        dropDown.show()
    }
    
    
    @IBAction func didTapOnSearchFlightBtnAction(_ sender: Any) {
        delegate?.didTapOnSearchFlightBtnAction(cell: self)
    }
    
    
    @IBAction func didTapOnAddCityBtnAction(_ sender: Any) {
        count += 1
        print("count \(count)")
        print("fromCityNameArray count \(fromCityNameArray.count)")
        if fromCityShortNameArray.count >= 5 {
            //            multicityTV.deleteRows(at: [IndexPath(item: 5, section: 0)], with: .automatic)
            //            multicityTV.reloadData()
            
            addCityBtnView.isHidden = true
            
        }else {
            
            fromCityNameArray.append("From")
            fromCityShortNameArray.append("From")
            toCityNameArray.append("To")
            toCityShortNameArray.append("To")
            calDate.append("Date")
            depatureDatesArray.append("Date")
            
            
            fromlocidArray.append("")
            tolocidArray.append("")
            fromCityArray.append("")
            toCityArray.append("")
           
            
            // multicityTV.insertRows(at: [IndexPath(item: fromCityNameArray.count, section: 0)], with: .automatic)
            
            DispatchQueue.main.async {[self] in
                updateheight()
                NotificationCenter.default.post(name: Notification.Name("reload"), object: nil)
            }
            
            
            if fromCityShortNameArray.count == 5 {
                addCityBtnView.isHidden = true
            }
            
        }
        
    }
    
    
    
    
    func didTapOnDeleteCityBtn(cell:AddcityTVCell) {
        
        fromCityNameArray.remove(at: cell.deleteBtn.tag)
        fromCityShortNameArray.remove(at: cell.deleteBtn.tag)
        toCityNameArray.remove(at: cell.deleteBtn.tag)
        toCityShortNameArray.remove(at: cell.deleteBtn.tag)
        calDate.remove(at: cell.deleteBtn.tag)
        depatureDatesArray.remove(at: cell.deleteBtn.tag)
        
        
        //---------------
        
        fromlocidArray.remove(at: cell.deleteBtn.tag)
        tolocidArray.remove(at: cell.deleteBtn.tag)
        fromCityArray.remove(at: cell.deleteBtn.tag)
        toCityArray.remove(at: cell.deleteBtn.tag)
        
        //---------------
        
        addCityTV.deleteRows(at: [IndexPath(item: cell.deleteBtn.tag, section: 0)], with: .automatic)
        DispatchQueue.main.async {[self] in
            if fromCityShortNameArray.count < 5 {
                addCityBtnView.isHidden = false
            }
        }
        
        updateheight()
        NotificationCenter.default.post(name: Notification.Name("reload"), object: nil)
    }
    
    
    
    func didTapOnFromCityBtnAction(cell: AddcityTVCell) {
        defaults.set(cell.fromCityBtn.tag, forKey: UserDefaultsKeys.cellTag)
        delegate?.didTapOnFromCityBtn(cell: self)
    }
    
    func didTapOnToCityBtnAction(cell: AddcityTVCell) {
        defaults.set(cell.toCityBtn.tag, forKey: UserDefaultsKeys.cellTag)
        delegate?.didTapOnToCityBtn(cell: self)
    }
    
    func didTapOnSelectDepartureDateBtnAction(cell: AddcityTVCell) {
        defaults.set(cell.depDateBtn.tag, forKey: UserDefaultsKeys.cellTag)
        delegate?.didTapOnDateBtn(cell: self)
    }

    
}




extension BookFlightMCTVCell:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fromCityShortNameArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var commonCell = UITableViewCell()
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? AddcityTVCell {
            
            cell.delegate = self
           
            
            if indexPath.row != 0 && indexPath.row != 1{
                cell.showDeleteBtnView()
                cell.fromlbl.text = ""
                cell.tocitylbl.text = ""
                cell.departureDatelbl.text = ""
                cell.deleteBtn.tag = indexPath.row
            }
            
            cell.fromCityBtn.tag = indexPath.row
            cell.toCityBtn.tag = indexPath.row
            cell.depDateBtn.tag = indexPath.row
            
            cell.fromlbl.text = fromCityShortNameArray[indexPath.row]
            cell.tocitylbl.text = toCityShortNameArray[indexPath.row]
            cell.departureDatelbl.text = calDate[indexPath.row]
            
            
            commonCell = cell
        }
        return commonCell
    }
    
}
