//
//  NoInternetConnectionVC.swift
//  Beeoons
//
//  Created by FCI on 11/08/23.
//

import UIKit

class NoInternetConnectionVC: UIViewController {
    
    
    @IBOutlet weak var wifiImg: UIImageView!
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var subTitlelbl: UILabel!
    @IBOutlet weak var btnView: UIView!
    @IBOutlet weak var btnlbl: UILabel!
    @IBOutlet weak var tryAgainBtn: UIButton!
    
    
    var key = String()
    var titleStr = String()
    static var newInstance: NoInternetConnectionVC? {
        let storyboard = UIStoryboard(name: Storyboard.Main.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? NoInternetConnectionVC
        return vc
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        if key == "noresult" {
            noresultSetup()
        }
    }
    
    func noresultSetup(){
        wifiImg.image = UIImage(named: "oops")?.withRenderingMode(.alwaysOriginal)
        titlelbl.text = titleStr
        subTitlelbl.text = "Please Search Again"
        btnlbl.text = "Search Again"
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
    }
    
    
    
    
    @IBAction func didTapOnTryAgainBtn(_ sender: Any) {
        
        if key == "noresult" {
            
            if let tabselect = defaults.string(forKey: UserDefaultsKeys.tabselect),tabselect == "FLIGHT" {
                guard let vc = BookFlightVC.newInstance.self else {return}
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: true)
            }else {
                guard let vc = BookHotelVC.newInstance.self else {return}
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: true)
            }
           
        }else {
            NotificationCenter.default.post(name: NSNotification.Name("reloadTV"), object: nil)
            dismiss(animated: false)
        }
    }
    
}

