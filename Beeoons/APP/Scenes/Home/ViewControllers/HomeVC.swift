//
//  HomeVC.swift
//  Beeoons
//
//  Created by FCI on 08/08/23.
//

import UIKit

class HomeVC: UIViewController {
    
    
    @IBOutlet weak var tab1img: UIImageView!
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var homelbl: UILabel!
    @IBOutlet weak var tab2img: UIImageView!
    @IBOutlet weak var myaccountlbl: UILabel!
    @IBOutlet weak var tab3img: UIImageView!
    @IBOutlet weak var mybookinglbl: UILabel!
    @IBOutlet weak var homeContinerView: UIView!
    @IBOutlet weak var myAccountContView: UIView!
    @IBOutlet weak var myBookingContView: UIView!
    @IBOutlet weak var tabbarHeight: NSLayoutConstraint!
    
    
    static var newInstance: HomeVC? {
        let storyboard = UIStoryboard(name: Storyboard.Main.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? HomeVC
        return vc
    }
    var vm:GetCountryListViewModel?
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        NotificationCenter.default.addObserver(self, selector: #selector(reload(_:)), name: NSNotification.Name("tabbarhide"), object: nil)
        
        DispatchQueue.main.async {[self] in
            callCourencyListApi()
        }
    }
    
    
    @objc func reload(_ n:NSNotification) {
        let tabbarhidebool = n.object as? Bool
        if tabbarhidebool == true {
            tabbarHeight.constant = 0
        }else {
            tabbarHeight.constant = 65
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupUI()
        vm = GetCountryListViewModel(self)
    }
    
    
    func setupUI() {
        setupHomeUI()
    }
    
    
    func setupHomeUI() {
        homeContinerView.isHidden = false
        myAccountContView.isHidden = true
        myBookingContView.isHidden = true
        homelbl.textColor = .ButtonColor
        myaccountlbl.textColor = .WhiteColor
        mybookinglbl.textColor = .WhiteColor
        tab1img.image = UIImage(named: "tab1")?.withRenderingMode(.alwaysOriginal).withTintColor(.ButtonColor)
        tab2img.image = UIImage(named: "tab2")?.withRenderingMode(.alwaysOriginal)
        tab3img.image = UIImage(named: "tab3")?.withRenderingMode(.alwaysOriginal)
        
    }
    
    func setupMyAccountUI() {
        homeContinerView.isHidden = true
        myAccountContView.isHidden = false
        myBookingContView.isHidden = true
        homelbl.textColor = .WhiteColor
        myaccountlbl.textColor = .ButtonColor
        mybookinglbl.textColor = .WhiteColor
        tab1img.image = UIImage(named: "tab1")?.withRenderingMode(.alwaysOriginal).withTintColor(.WhiteColor)
        tab2img.image = UIImage(named: "tab22")?.withRenderingMode(.alwaysOriginal)
        tab3img.image = UIImage(named: "tab3")?.withRenderingMode(.alwaysOriginal)
    }
    
    func setupMyBookingsUI() {
        homeContinerView.isHidden = true
        myAccountContView.isHidden = true
        myBookingContView.isHidden = false
        homelbl.textColor = .WhiteColor
        myaccountlbl.textColor = .WhiteColor
        mybookinglbl.textColor = .ButtonColor
        tab1img.image = UIImage(named: "tab1")?.withRenderingMode(.alwaysOriginal).withTintColor(.WhiteColor)
        tab2img.image = UIImage(named: "tab2")?.withRenderingMode(.alwaysOriginal)
        tab3img.image = UIImage(named: "tab33")?.withRenderingMode(.alwaysOriginal)
    }
    
    
    
    @IBAction func didTapOnHomeBtn(_ sender: Any) {
        setupHomeUI()
    }
    
    @IBAction func didTapOnMyAccountBtnAction(_ sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name("checkUserLogin"), object: nil)
        setupMyAccountUI()
    }
    
    @IBAction func didTapOnMyBookingBtnAction(_ sender: Any) {
        setupMyBookingsUI()
    }
    
    
}


extension HomeVC:GetCountryListViewModelDelegate {
    
    
    func callCourencyListApi() {
        vm?.CALL_GET_COUNTRY_LIST_API(dictParam: [:])
    }
    
    func countryList(response: CountryListModel) {
        countrylist = response.country_list ?? []
    }
    
    
}
