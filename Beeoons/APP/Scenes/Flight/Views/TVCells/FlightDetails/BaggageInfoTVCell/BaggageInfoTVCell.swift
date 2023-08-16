//
//  BaggageInfoTVCell.swift
//  Beeoons
//
//  Created by FCI on 12/08/23.
//

import UIKit

class BaggageInfoTVCell: TableViewCell {
    
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var cabinBaggagelbl: UILabel!
    @IBOutlet weak var checkedInBaggageCV: UICollectionView!
    @IBOutlet weak var cvHeight: NSLayoutConstraint!
    
    
    var adultsCount = Int()
    var childCount = Int()
    var infantsCount = Int()
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
        
        if let journeyType = defaults.string(forKey: UserDefaultsKeys.journeyType) {
            if journeyType == "oneway" {
                adultsCount = Int(defaults.string(forKey: UserDefaultsKeys.adultCount) ?? "1") ?? 0
                childCount = Int(defaults.string(forKey: UserDefaultsKeys.childCount) ?? "0") ?? 0
                infantsCount = Int(defaults.string(forKey: UserDefaultsKeys.infantsCount) ?? "0") ?? 0
                
                
            }else if journeyType == "circle"{
                adultsCount = Int(defaults.string(forKey: UserDefaultsKeys.radultCount) ?? "1") ?? 0
                childCount = Int(defaults.string(forKey: UserDefaultsKeys.rchildCount) ?? "0") ?? 0
                infantsCount = Int(defaults.string(forKey: UserDefaultsKeys.rinfantsCount) ?? "0") ?? 0
            }else {
                
                adultsCount = Int(defaults.string(forKey: UserDefaultsKeys.madultCount) ?? "1") ?? 0
                childCount = Int(defaults.string(forKey: UserDefaultsKeys.mchildCount) ?? "0") ?? 0
                infantsCount = Int(defaults.string(forKey: UserDefaultsKeys.minfantsCount) ?? "0") ?? 0
            }
        }
        
        setupCV()
        checkedInBaggageCV.reloadData()
    }
    
    
    func setupUI() {
        holderView.layer.borderWidth = 1
        holderView.layer.borderColor = UIColor.UnselectedBtnColor.cgColor
        
    }
    
    
    
    func setupCV() {
        
        let nib = UINib(nibName: "AddCheckinBaggageCVCell", bundle: nil)
        checkedInBaggageCV.register(nib, forCellWithReuseIdentifier: "cell")
        checkedInBaggageCV.delegate = self
        checkedInBaggageCV.dataSource = self
        let layout = UICollectionViewFlowLayout()
       
        
        
        if adultsCount > 0 && childCount == 0 && infantsCount == 0 {
            layout.itemSize = CGSize(width: 150, height: 65)
            cvHeight.constant = 65
            
        }else if adultsCount > 0 && childCount > 0 && infantsCount == 0 {
            layout.itemSize = CGSize(width: 150, height: 90)
            cvHeight.constant = 90
        }else if adultsCount > 0 && childCount == 0 && infantsCount > 0 {
            layout.itemSize = CGSize(width: 150, height: 90)
            cvHeight.constant = 90
        }else {
            layout.itemSize = CGSize(width: 150, height: 113)
            cvHeight.constant = 115
        }
        
        
        
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        checkedInBaggageCV.collectionViewLayout = layout
        checkedInBaggageCV.backgroundColor = .clear
        checkedInBaggageCV.layer.cornerRadius = 4
        checkedInBaggageCV.clipsToBounds = true
        checkedInBaggageCV.showsHorizontalScrollIndicator = false
        
        
    }
    
}



extension BaggageInfoTVCell:UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return bggAllowance.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var commonCell = UICollectionViewCell()
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? AddCheckinBaggageCVCell {
            
            
            let data = bggAllowance[indexPath.row]
            cell.sectorlbl.text = data.journeySummary ?? ""
            cell.adultlbl.text = "Adult \(data.aDT ?? "")"
         
            if childCount != 0 {
                cell.childlbl.text = "Child \(data.cNN ?? "")"
                cell.childlbl.isHidden = false
            }
            
            if infantsCount != 0 {
                cell.infantlbl.text = "Infant \(data.iNF ?? "")"
                cell.infantlbl.isHidden = false
            }
           
            
            commonCell = cell
        }
        return commonCell
    }

    
}
