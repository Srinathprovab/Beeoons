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
    @IBOutlet weak var dropDownImg: UIImageView!
    @IBOutlet weak var cvHeight: NSLayoutConstraint!
    @IBOutlet weak var morelbl: UILabel!
    
    var isToggle = false
    var tabNames = ["FLIGHT","HOTEL","FLIGHT + HOTEL","HOLIDAY","RENT A CAR","TRANSFERS","EVENTS"]
    var tabImages = ["t1","t2","t1","holiday","t3","transfers","events"]
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
        
        dropDownImg.image = UIImage(named: "downarrow1")?.withRenderingMode(.alwaysOriginal).withTintColor(.WhiteColor)
        let nib = UINib(nibName: "SelectTabCVCell", bundle: nil)
        tabscv.register(nib, forCellWithReuseIdentifier: "cell")
        tabscv.delegate = self
        tabscv.dataSource = self
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 60, height: 80)
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 5
        layout.minimumLineSpacing = 5
        layout.sectionInset = UIEdgeInsets(top: 5, left: 10, bottom: 0, right: 10)
        tabscv.collectionViewLayout = layout
        tabscv.backgroundColor = .clear
        tabscv.layer.cornerRadius = 4
        tabscv.clipsToBounds = true
        tabscv.showsVerticalScrollIndicator = false
        tabscv.isScrollEnabled = false
        
    }
    
    
    @IBAction func disTaoOnMoreBtnAction(_ sender: Any) {
        isToggle.toggle()
        // Use a ternary conditional operator to determine the action
        isToggle ? actionIfTrue() : actionIfFalse()
        NotificationCenter.default.post(name: NSNotification.Name("reloadcommonTableView"), object: nil)
    }
    
    func actionIfTrue() {
        cvHeight.constant = 160
        morelbl.text = "Less"
        dropDownImg.image = UIImage(named: "dropup1")?.withRenderingMode(.alwaysOriginal).withTintColor(.WhiteColor)
    }
    
    func actionIfFalse() {
        cvHeight.constant = 80
        morelbl.text = "More"
        dropDownImg.image = UIImage(named: "downarrow1")?.withRenderingMode(.alwaysOriginal).withTintColor(.WhiteColor)
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
