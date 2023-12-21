//
//  HotelImagesTVCell.swift
//  Beeoons
//
//  Created by FCI on 30/09/23.
//

import UIKit

class HotelImagesTVCell: TableViewCell {
    
    
    @IBOutlet weak var hotelNamelbl: UILabel!
    @IBOutlet weak var hotelloclbl: UILabel!
    @IBOutlet weak var hotelImg: UIImageView!
    @IBOutlet weak var hotelImagesCV: UICollectionView!
    
    
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
        
        hotelNamelbl.text = cellInfo?.title ?? ""
        hotelloclbl.text = cellInfo?.subTitle ?? ""
        hotelImg.sd_setImage(with: URL(string: cellInfo?.image ?? ""), placeholderImage:UIImage(contentsOfFile:"placeholder.png"))
        
    }
    
    
    func setupUI() {
        hotelImg.layer.cornerRadius = 6
        hotelImg.clipsToBounds = true
        setupCV()
    }
    
    
}


extension HotelImagesTVCell:UICollectionViewDelegate,UICollectionViewDataSource {
    
    func setupCV() {
        
        let nib = UINib(nibName: "HotelImageCVCell", bundle: nil)
        hotelImagesCV.register(nib, forCellWithReuseIdentifier: "cell")
        hotelImagesCV.delegate = self
        hotelImagesCV.dataSource = self
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 80, height: 80)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 5
        layout.minimumLineSpacing = 5
        hotelImagesCV.collectionViewLayout = layout
        hotelImagesCV.showsVerticalScrollIndicator = false
        hotelImagesCV.bounces = false
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var commonCell = UICollectionViewCell()
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? HotelImageCVCell {
            cell.img.sd_setImage(with: URL(string: cellInfo?.image ?? ""), placeholderImage:UIImage(contentsOfFile:"placeholder.png"))
            commonCell = cell
        }
        return commonCell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? HotelImageCVCell {
            self.hotelImg = cell.img
        }
    }
    
    
    
}
