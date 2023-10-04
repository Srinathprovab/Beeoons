//
//  MenuBtnWithLogoTVCell.swift
//  Beeoons
//
//  Created by FCI on 08/08/23.
//

import UIKit
import DropDown


protocol MenuBtnWithLogoTVCellDelegate {
    func didTapOnMenuBtnAction(cell:MenuBtnWithLogoTVCell)
    func didTapOnLangBtnAction(cell:MenuBtnWithLogoTVCell)
}

class MenuBtnWithLogoTVCell: TableViewCell {
    
    
    
    @IBOutlet weak var currencylbl: UILabel!
    @IBOutlet weak var currencyView: UIView!
    
    
    
    var countryNames = [String]()
    var countrySymbols = [String]()
    var filterdcountrylist = [Currency_list]()
    let dropDown = DropDown()
    var delegate:MenuBtnWithLogoTVCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupDropDown()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    override func updateUI() {
        currencylbl.text = defaults.string(forKey: UserDefaultsKeys.selectedCurrency) ?? "KWD"
        filterdcountrylist = currencylist
        loadCountryNamesAndCode()
        
    }
    
    
    
    func loadCountryNamesAndCode(){
        countryNames.removeAll()
        countrySymbols.removeAll()
        
        
        filterdcountrylist.forEach { i in
            countryNames.append(i.name ?? "")
            countrySymbols.append(i.symbol ?? "")
            
        }
        
        DispatchQueue.main.async {[self] in
            dropDown.dataSource = countryNames
        }
    }
    
    
    
    func setupDropDown() {
        
        dropDown.textFont = .OswaldLight(size: 16)
        dropDown.direction = .bottom
        dropDown.backgroundColor = .WhiteColor
        dropDown.anchorView = self.currencyView
        dropDown.bottomOffset = CGPoint(x: 0, y: currencyView.frame.size.height + 10)
        dropDown.selectionAction = { [weak self] (index: Int, item: String) in
            
            self?.currencylbl.text = self?.countrySymbols[index]
            defaults.set(self?.countrySymbols[index], forKey: UserDefaultsKeys.selectedCurrency)
            
        }
    }
    
    
    @IBAction func didTapOnMenuBtnAction(_ sender: Any) {
        delegate?.didTapOnMenuBtnAction(cell: self)
    }
    
    @IBAction func didTapOnLangBtnAction(_ sender: Any) {
        dropDown.show()
        //  delegate?.didTapOnLangBtnAction(cell: self)
    }
}
