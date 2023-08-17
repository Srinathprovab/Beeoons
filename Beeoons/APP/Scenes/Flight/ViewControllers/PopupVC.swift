//
//  PopupVC.swift
//  Beeoons
//
//  Created by FCI on 17/08/23.
//

import UIKit

class PopupVC: UIViewController {
    
    static var newInstance: PopupVC? {
        let storyboard = UIStoryboard(name: Storyboard.Flight.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? PopupVC
        return vc
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.view.backgroundColor = .black.withAlphaComponent(0.4)

    }
    
    
    
    @IBAction func didTaponOkBtnAction(_ sender: Any) {
        if let tabselect = defaults.string(forKey: UserDefaultsKeys.tabselect) {
            if tabselect == "FLIGHT" {
                guard let vc = BookFlightVC.newInstance.self else {return}
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: false)
            }else {
                
            }
        }
    }
}
