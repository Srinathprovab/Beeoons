//
//  ViewFlightDetailsVC.swift
//  Beeoons
//
//  Created by FCI on 13/08/23.
//

import UIKit

class ViewFlightDetailsVC: BaseTableVC {
    
    @IBOutlet weak var cityslbl: UILabel!
    
    
    var tablerow = [TableRow]()
    static var newInstance: ViewFlightDetailsVC? {
        let storyboard = UIStoryboard(name: Storyboard.Flight.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? ViewFlightDetailsVC
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupUI()
    }
    
    
    
    
    func setupUI() {
        self.view.backgroundColor = .black.withAlphaComponent(0.6)
        commonTableView.registerTVCells(["AddItineraryTVCell"])
        setupItineraryTVCells()
    }
    
    
    
    func setupItineraryTVCells() {
        tablerow.removeAll()
        
        fd.forEach { i in
            tablerow.append(TableRow(moreData:i,cellType:.AddItineraryTVCell))
        }
        
        commonTVData = tablerow
        commonTableView.reloadData()
    }
    
    
    //MARK: - didTapOnBackBtnAction
    @IBAction func didTapOnCloseBtnAction(_ sender: Any) {
        dismiss(animated: true)
    }
    
    
}
