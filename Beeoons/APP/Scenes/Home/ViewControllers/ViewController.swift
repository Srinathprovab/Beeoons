//
//  ViewController.swift
//  Beeoons
//
//  Created by FCI on 08/08/23.
//

import UIKit

class ViewController: UIViewController {
    
    var ExecuteOnceBool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        if !UserDefaults.standard.bool(forKey: "ExecuteOnceLoginVC") {
            ExecuteOnceBool = false
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0, execute: {
                self.gotoLoginVC()
            })
            
            UserDefaults.standard.set(true, forKey: "ExecuteOnceLoginVC")
        }
        
        
        if ExecuteOnceBool == true {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0, execute: {
                self.gotodashBoardScreen()
                
            })
        }
        
    }
    
    
    func gotodashBoardScreen() {
        guard let vc = HomeVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    func gotoLoginVC() {
        guard let vc = LoginVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
//        callapibool = true
//        vc.isvcfrom = "ViewController"
        present(vc, animated: true)
    }
    
    
}

