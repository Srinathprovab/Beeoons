//
//  SelectTabTVCell.swift
//  Beeoons
//
//  Created by FCI on 08/08/23.
//

import UIKit

protocol SelectTabTVCellDelegate {
    func didTapOnDashboardTab(cell:SelectTabTVCell)
}

class SelectTabTVCell: TableViewCell {

    @IBOutlet weak var tabscv: UICollectionView!
    
    
    var tabNames = ["FLIGHT","HOTEL","RENT A CAR","HOLIDAYS"]
    var tabImages = ["t1","t2","t3","t4"]
    var selectedTitle = String()
    var delegate:SelectTabTVCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupCV()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupCV() {
       
        let nib = UINib(nibName: "SelectTabCVCell", bundle: nil)
        tabscv.register(nib, forCellWithReuseIdentifier: "cell")
        tabscv.delegate = self
        tabscv.dataSource = self
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 70, height: 80)
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 20
        layout.minimumLineSpacing = 20
        layout.sectionInset = UIEdgeInsets(top: 5, left: 10, bottom: 0, right: 10)
        tabscv.collectionViewLayout = layout
        tabscv.backgroundColor = .clear
        tabscv.layer.cornerRadius = 4
        tabscv.clipsToBounds = true
        tabscv.showsVerticalScrollIndicator = false
        tabscv.isScrollEnabled = false
        
    }
    
}



extension SelectTabTVCell:UICollectionViewDelegate,UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tabNames.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var commonCell = UICollectionViewCell()
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? SelectTabCVCell {
            cell.titlelbl.text = tabNames[indexPath.row]
            cell.tabimg.image = UIImage(named: tabImages[indexPath.row])?.withRenderingMode(.alwaysOriginal).withTintColor(.WhiteColor)
           
            commonCell = cell
        }
        return commonCell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? SelectTabCVCell {
           
            selectedTitle = cell.titlelbl.text ?? ""
            defaults.set(cell.titlelbl.text ?? "", forKey: UserDefaultsKeys.tabselect)
            delegate?.didTapOnDashboardTab(cell: self)
        }
    }
    
  
}
