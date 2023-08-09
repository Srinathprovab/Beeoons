//
//  BookFlightVC.swift
//  Beeoons
//
//  Created by FCI on 09/08/23.
//

import UIKit

class BookFlightVC: BaseTableVC {
    
    
    @IBOutlet weak var onewayView: UIView!
    @IBOutlet weak var onewaylbl: UILabel!
    @IBOutlet weak var roundtripview: UIView!
    @IBOutlet weak var roundtriplbl: UILabel!
    @IBOutlet weak var multicityView: UIView!
    @IBOutlet weak var multicitylbl: UILabel!
    
    
    
    var tablerow = [TableRow]()
    static var newInstance: BookFlightVC? {
        let storyboard = UIStoryboard(name: Storyboard.Flight.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? BookFlightVC
        return vc
    }
    
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        addObserverCall()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupUI()
    }
    
    
    //MARK: -
    func setupUI() {
        
        // multicityView.isHidden = true
        setupOnewayUI()
        commonTableView.registerTVCells(["BookFlightTVCell",
                                         "FlightDealsTVCell"])
        
    }
    
    
    
    func addObserverCall() {
        NotificationCenter.default.addObserver(self, selector: #selector(reload(notification:)), name: NSNotification.Name("reload"), object: nil)
    }
    
    @objc func reload(notification: NSNotification){
        commonTableView.reloadData()
    }
    
    
    
    func setupOnewayUI() {
        onewayView.backgroundColor = .ButtonColor
        roundtripview.backgroundColor = .WhiteColor
        multicityView.backgroundColor = .WhiteColor
        onewaylbl.textColor = .WhiteColor
        roundtriplbl.textColor = .Journytabunselectedcolor
        multicitylbl.textColor = .Journytabunselectedcolor
        defaults.set("oneway", forKey: UserDefaultsKeys.journeyType)
        setupTVCell()
    }
    
    
    func setupRoundtripUI() {
        onewayView.backgroundColor = .WhiteColor
        roundtripview.backgroundColor = .ButtonColor
        multicityView.backgroundColor = .WhiteColor
        onewaylbl.textColor = .Journytabunselectedcolor
        roundtriplbl.textColor = .WhiteColor
        multicitylbl.textColor = .Journytabunselectedcolor
        defaults.set("circle", forKey: UserDefaultsKeys.journeyType)
        setupTVCell()
    }
    
    
    func setupMulticityUI() {
        onewayView.backgroundColor = .WhiteColor
        roundtripview.backgroundColor = .WhiteColor
        multicityView.backgroundColor = .ButtonColor
        onewaylbl.textColor = .Journytabunselectedcolor
        roundtriplbl.textColor = .Journytabunselectedcolor
        multicitylbl.textColor = .WhiteColor
        defaults.set("multicity", forKey: UserDefaultsKeys.journeyType)
        setupTVCell()
    }
    
    //MARK: - setupTVCell
    func setupTVCell() {
        tablerow.removeAll()
        
        tablerow.append(TableRow(cellType: .BookFlightTVCell))
        tablerow.append(TableRow(title:"FLIGHT",cellType: .FlightDealsTVCell))
        
        
        commonTVData = tablerow
        commonTableView.reloadData()
    }
    
    
    
    @IBAction func didTapOnBackBtnAction(_ sender: Any) {
        dismiss(animated: true)
    }
    
    
    
    @IBAction func didTapOnOnewayBtnAction(_ sender: Any) {
        setupOnewayUI()
    }
    
    
    @IBAction func didTapOnRoundTripButtonAction(_ sender: Any) {
        setupRoundtripUI()
    }
    
    
    @IBAction func didTapOnMulticityButtonAction(_ sender: Any) {
        setupMulticityUI()
    }
    
    
    
    
    //MARK: - gotoSelectCityVC
    override func didTapOnFromCityBtnAction(cell: BookFlightTVCell) {
        gotoSelectCityVC(str: "From Destination", tokey: "Tooo")
    }
    
    override func didTapOnToCityBtnAction(cell: BookFlightTVCell) {
        gotoSelectCityVC(str: "To Destination", tokey: "frommm")
    }
    
    func gotoSelectCityVC(str:String,tokey:String) {
        guard let vc = SelectCityVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        vc.titleStr = str
        vc.keyStr = "FLIGHT"
        vc.tokey = tokey
        self.present(vc, animated: true)
    }
    
    
    
    //MARK: - didTapOnSelectDepartureDateBtnAction
    override func didTapOnSelectDepartureDateBtnAction(cell: BookFlightTVCell) {
        gotoCalenderVC()
    }
    
    override func didTapOnArrivalDateBtnAction(cell: BookFlightTVCell) {
        gotoCalenderVC()
    }
    
    
    func gotoCalenderVC() {
        guard let vc = CalenderVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: false)
    }
    
    
    //MARK: - didTapOnSelectTravellersBtnAction
    override func didTapOnSelectTravellersBtnAction(cell: BookFlightTVCell) {
        print("didTapOnSelectTravellersBtnAction")
    }
    
    
    
    //MARK: - didTapOnSelectClassBtnAction
    override func didTapOnSelectClassBtnAction(cell: BookFlightTVCell) {
        print("didTapOnSelectClassBtnAction")
    }
    
    
    
    //MARK: - didTapOnAddAirlineButtonAction
    override func didTapOnAddAirlineButtonAction(cell:BookFlightTVCell){
        commonTableView.reloadData()
    }
    
    
    
    
}
