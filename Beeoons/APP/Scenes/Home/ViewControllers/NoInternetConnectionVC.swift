//
//  NoInternetConnectionVC.swift
//  Beeoons
//
//  Created by FCI on 11/08/23.
//

import UIKit

class NoInternetConnectionVC: UIViewController {
    
    
    static var newInstance: NoInternetConnectionVC? {
        let storyboard = UIStoryboard(name: Storyboard.Main.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? NoInternetConnectionVC
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
    }
    
    
    
    
    @IBAction func didTapOnTryAgainBtn(_ sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name("reloadTV"), object: nil)
        dismiss(animated: false)
    }
    
}

