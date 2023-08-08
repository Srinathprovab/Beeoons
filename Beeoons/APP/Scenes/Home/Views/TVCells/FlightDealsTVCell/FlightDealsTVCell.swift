//
//  FlightDealsTVCell.swift
//  Beeoons
//
//  Created by FCI on 08/08/23.
//

import UIKit
protocol FlightDealsTVCellDelegate {
    func didTapOnBookFlightBtn(cell:DealsCVCell)
    func didTapOnBookHoteltBtn(cell:HotelDealsCVCell)
}

class FlightDealsTVCell: TableViewCell, DealsCVCellDelegate, HotelDealsCVCellDelegate {
    
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var dealsCV: UICollectionView!
    @IBOutlet weak var cvheight: NSLayoutConstraint!
    
    var delegate:FlightDealsTVCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func updateUI() {
        titlelbl.text = cellInfo?.title
        
        if titlelbl.text == "FLIGHT" {
            cvheight.constant = 181
            setupFlightCV()
        }else {
            cvheight.constant = 235
            setupHotelCV()
        }
    }
    
    
    func setupFlightCV() {
       
        let nib = UINib(nibName: "DealsCVCell", bundle: nil)
        dealsCV.register(nib, forCellWithReuseIdentifier: "cell")
        dealsCV.delegate = self
        dealsCV.dataSource = self
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 258, height: 170)
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 5, left: 10, bottom: 0, right: 10)
        dealsCV.collectionViewLayout = layout
        dealsCV.backgroundColor = .clear
        dealsCV.layer.cornerRadius = 4
        dealsCV.clipsToBounds = true
        dealsCV.showsVerticalScrollIndicator = false
    
    }
    
    func setupHotelCV() {
       
        let nib = UINib(nibName: "HotelDealsCVCell", bundle: nil)
        dealsCV.register(nib, forCellWithReuseIdentifier: "cell1")
        dealsCV.delegate = self
        dealsCV.dataSource = self
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 208, height: 228)
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 5, left: 10, bottom: 0, right: 10)
        dealsCV.collectionViewLayout = layout
        dealsCV.backgroundColor = .clear
        dealsCV.layer.cornerRadius = 4
        dealsCV.clipsToBounds = true
        dealsCV.showsVerticalScrollIndicator = false
    
    }
    
    
    func didTapOnBookFlightBtn(cell: DealsCVCell) {
        delegate?.didTapOnBookFlightBtn(cell: cell)
    }
    
    
    func didTapOnBookHoteltBtn(cell: HotelDealsCVCell) {
        delegate?.didTapOnBookHoteltBtn(cell: cell)
    }
    
    
    
}



extension FlightDealsTVCell:UICollectionViewDelegate,UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if titlelbl.text == "FLIGHT" {
            return 10
        }else {
           return 5
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var commonCell = UICollectionViewCell()
        
        if titlelbl.text == "FLIGHT" {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? DealsCVCell {
                cell.delegate = self
                cell.bookBtn.tag = indexPath.row
                commonCell = cell
            }
        }else {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell1", for: indexPath) as? HotelDealsCVCell {
                cell.delegate = self
                cell.bookBtn.tag = indexPath.row
                commonCell = cell
            }
        }
        
      
        return commonCell
    }
    
    
  
}
