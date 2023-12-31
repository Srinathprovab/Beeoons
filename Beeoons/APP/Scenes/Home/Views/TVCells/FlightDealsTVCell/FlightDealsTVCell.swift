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
    @IBOutlet weak var subtitlelbl: UILabel!
    
    
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
        subtitlelbl.text = cellInfo?.subTitle 
        
        if titlelbl.text == "FLIGHT" {
            backimg.image = UIImage(named: "flightback")?.withRenderingMode(.alwaysOriginal)
            cvheight.constant = 181
            setupFlightCV()
            itemCount = topflightDest.count
            flightcount = topflightDest.count
            // startAutoScroll()
        }else {
            backimg.image = UIImage(named: "hotelback")?.withRenderingMode(.alwaysOriginal)
            cvheight.constant = 235
            setupHotelCV()
            itemCount1 = topdesthotel.count
            hotelcount = topdesthotel.count
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
        dealsCV.bounces = false
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
        dealsCV.bounces = false
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
            return topflightDest.count
        }else {
            return topdesthotel.count
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
                
                let data = topflightDest[indexPath.row]
                cell.bookBtn.tag = indexPath.row
                cell.bgimg.sd_setImage(with: URL(string: "\(indeximagepath)\(data.image ?? "")"), placeholderImage:UIImage(contentsOfFile:"placeholder.png"))
                cell.operatorImg.sd_setImage(with: URL(string: "\(data.operator_image ?? "")"), placeholderImage:UIImage(contentsOfFile:"placeholder.png"))
                
                cell.citylbl.text = data.from_city_name ?? ""
                cell.depratureDatelbl.text = data.travel_date ?? ""
                cell.returnDatelbl.text = data.return_date ?? ""
                cell.flytolbl.text = data.to_city_name ?? ""
                cell.kwdpricelbl.text = "\(data.currency ?? ""):\(data.price ?? "")"
                cell.titlelbl.text = data.flight_text ?? ""
                
                cell.trip_type = data.trip_type ?? ""
                cell.fromcity = "\(data.from_airport_name ?? "") (\(data.from_city_loc ?? ""))"
                cell.from_loc_id = data.from_city ?? ""
                cell.tocity = "\(data.to_airport_name ?? "") (\(data.to_city_loc ?? ""))"
                cell.to_loc_id = data.to_city ?? ""
                cell.v_class = data.airline_class ?? ""
                cell.currency = data.currency ?? ""
                
                
                cell.fromcityname = data.from_city_name ?? ""
                cell.tocityname = data.to_city_name ?? ""
                
                if data.trip_type == "oneway" {
                    cell.journytypeImg.image = UIImage(named: "oneway")?.withRenderingMode(.alwaysOriginal)
                }else {
                    cell.journytypeImg.image = UIImage(named: "circle")?.withRenderingMode(.alwaysOriginal)
                }
                
                
                commonCell = cell
            }
        }else {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell1", for: indexPath) as? HotelDealsCVCell {
                cell.delegate = self
                cell.bookBtn.tag = indexPath.row
                let data = topdesthotel[indexPath.row]
                cell.bookBtn.tag = indexPath.row
                
                cell.hotelImg.sd_setImage(with: URL(string: "\(indeximagepath)\(data.image ?? "")"), placeholderImage:UIImage(contentsOfFile:"placeholder.png"))
                cell.hotelNamelbl.text = data.hotel_name ?? ""
                cell.pricelbl.text = "\(defaults.string(forKey: UserDefaultsKeys.selectedCurrency) ?? ""):\(data.price ?? "")"
                cell.checkinValuelbl.text = data.check_in ?? ""
                cell.checkoutValuelbl.text = data.check_out ?? ""
                cell.citylbl.text = data.city_name ?? ""
                cell.hotetextlbl.text = data.hotel_text ?? ""
                cell.citycode = data.city ?? ""
                
                
                commonCell = cell
            }
        }
        
        
        return commonCell
    }
    
    
    
    // MARK: Button Actions
    
    func showNextCard() {
        currentIndex += 1
        
        
        if titlelbl.text == "FLIGHT" {
            
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
        
        
        if titlelbl.text == "FLIGHT" {
            
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
            
            if lastIndexPath.item == flightcount - 1 {
                nextIndexPath = IndexPath(item: 0, section: lastIndexPath.section)
            } else {
                nextIndexPath = IndexPath(item: lastIndexPath.item + 1, section: lastIndexPath.section)
            }
            
            if nextIndexPath.item >= flightcount {
                nextIndexPath = IndexPath(item: 0, section: nextIndexPath.section) // Adjust the index path if it exceeds the bounds
            }
        }else {
            
            guard itemCount > 0 else {
                return // No items in the collection view
            }
            
            if lastIndexPath.item == hotelcount - 1 {
                nextIndexPath = IndexPath(item: 0, section: lastIndexPath.section)
            } else {
                nextIndexPath = IndexPath(item: lastIndexPath.item + 1, section: lastIndexPath.section)
            }
            
            if nextIndexPath.item >= hotelcount {
                nextIndexPath = IndexPath(item: 0, section: nextIndexPath.section) // Adjust the index path if it exceeds the bounds
            }
        }
        
        dealsCV.scrollToItem(at: nextIndexPath, at: .centeredHorizontally, animated: true)
    }
    
    
    
    
}
