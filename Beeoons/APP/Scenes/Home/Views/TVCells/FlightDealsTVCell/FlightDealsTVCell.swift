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
    @IBOutlet weak var backimg: UIImageView!
    
    
    var delegate:FlightDealsTVCellDelegate?
    var currentIndex = 0
    var currentCellIndex = 0
    var key = String()
    var flightcount = 10
    var hotelcount = 5
    var itemCount = Int()
    var itemCount1 = Int()
    var autoScrollTimer: Timer?
    var nextButtonAction: (() -> Void)?
    var previousButtonAction: (() -> Void)?
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
            backimg.image = UIImage(named: "flightback")?.withRenderingMode(.alwaysOriginal)
            cvheight.constant = 181
            setupFlightCV()
            itemCount = flightcount
            // startAutoScroll()
        }else {
            backimg.image = UIImage(named: "hotelback")?.withRenderingMode(.alwaysOriginal)
            cvheight.constant = 235
            setupHotelCV()
            itemCount1 = hotelcount
            //  startAutoScroll()
        }
        
        dealsCV.reloadData()
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
    
    @IBAction func nextButtonTapped(_ sender: UIButton) {
        
        nextButtonAction?()
    }
    
    @IBAction func previousButtonTapped(_ sender: UIButton) {
        
        previousButtonAction?()
        
    }
    
}



extension FlightDealsTVCell:UICollectionViewDelegate,UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if titlelbl.text == "FLIGHT" {
            return flightcount
        }else {
            return hotelcount
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var commonCell = UICollectionViewCell()
        
        // Set up next and previous button actions
        self.nextButtonAction = { [weak self] in
            self?.showNextCard()
        }
        
        self.previousButtonAction = { [weak self] in
            self?.showPreviousCard()
        }
        
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
    
    
    
    // MARK: Button Actions
    
    func showNextCard() {
        currentIndex += 1
        
        
        if cellInfo?.key == "FLIGHT" {
            
            if currentIndex >= flightcount {
                currentIndex = 0
            }
        }else {
            
            if currentIndex >= hotelcount {
                currentIndex = 0
            }
        }
        
        
        // Scroll to the next cell
        let indexPath = IndexPath(item: currentIndex, section: 0)
        dealsCV.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    func showPreviousCard() {
        currentIndex -= 1
        
        
        if cellInfo?.key == "FLIGHT" {
            
            if currentIndex < 0 {
                currentIndex = flightcount - 1
            }
        }else {
            
            if currentIndex < 0 {
                currentIndex = hotelcount - 1
            }
        }
        
        
        // Scroll to the previous cell
        let indexPath = IndexPath(item: currentIndex, section: 0)
        dealsCV.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    
    
    // MARK: - Auto Scrolling
    
    func startAutoScroll() {
        autoScrollTimer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(scrollToNextItem), userInfo: nil, repeats: true)
    }
    
    func stopAutoScroll() {
        autoScrollTimer?.invalidate()
        autoScrollTimer = nil
    }
    
    @objc func scrollToNextItem() {
        
        let currentIndexPaths = dealsCV.indexPathsForVisibleItems.sorted()
        let lastIndexPath = currentIndexPaths.last ?? IndexPath(item: 0, section: 0)
        var nextIndexPath: IndexPath
        
        if titlelbl.text == "FLIGHT" {
            
            
            guard itemCount > 0 else {
                return // No items in the collection view
            }
            
            if lastIndexPath.item == itemCount - 1 {
                nextIndexPath = IndexPath(item: 0, section: lastIndexPath.section)
            } else {
                nextIndexPath = IndexPath(item: lastIndexPath.item + 1, section: lastIndexPath.section)
            }
            
            if nextIndexPath.item >= itemCount {
                nextIndexPath = IndexPath(item: 0, section: nextIndexPath.section) // Adjust the index path if it exceeds the bounds
            }
        }else {
            
            guard itemCount > 0 else {
                return // No items in the collection view
            }
            
            if lastIndexPath.item == itemCount1 - 1 {
                nextIndexPath = IndexPath(item: 0, section: lastIndexPath.section)
            } else {
                nextIndexPath = IndexPath(item: lastIndexPath.item + 1, section: lastIndexPath.section)
            }
            
            if nextIndexPath.item >= itemCount1 {
                nextIndexPath = IndexPath(item: 0, section: nextIndexPath.section) // Adjust the index path if it exceeds the bounds
            }
        }
        
        dealsCV.scrollToItem(at: nextIndexPath, at: .centeredHorizontally, animated: true)
    }
    
    
    
    
}
