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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func setupUI() {
        holderView.layer.borderWidth = 1
        holderView.layer.borderColor = UIColor.UnselectedBtnColor.cgColor
        setupCV()
    }
    
    
    
    func setupCV() {
        
        let nib = UINib(nibName: "AddCheckinBaggageCVCell", bundle: nil)
        checkedInBaggageCV.register(nib, forCellWithReuseIdentifier: "cell")
        checkedInBaggageCV.delegate = self
        checkedInBaggageCV.dataSource = self
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 150, height: 60)
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
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var commonCell = UICollectionViewCell()
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? AddCheckinBaggageCVCell {
           
            
            commonCell = cell
        }
        return commonCell
    }

    
}
