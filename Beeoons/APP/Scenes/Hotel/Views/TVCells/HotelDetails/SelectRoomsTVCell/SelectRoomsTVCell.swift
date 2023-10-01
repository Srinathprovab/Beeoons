//
//  SelectRoomsTVCell.swift
//  Beeoons
//
//  Created by FCI on 30/09/23.
//

import UIKit

class SelectRoomsTVCell: TableViewCell {
    
    @IBOutlet weak var hdTabsCV: UICollectionView!
    @IBOutlet weak var roomDetailsTV: UITableView!
    
    var key = String()
    var room = [[Rooms]]()
    var tabnames = ["Hotel_Details","Rooms","Aminities","Post A Review"]
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
        room = cellInfo?.moreData as! [[Rooms]]
    }
    
    func setupUI() {
        setupCV()
        setuTV()
        
       key = "rooms"
    }
    
}


extension SelectRoomsTVCell:UICollectionViewDelegate,UICollectionViewDataSource {
    
    func setupCV() {
        
        let nib = UINib(nibName: "HotelDetailsTabCVCell", bundle: nil)
        hdTabsCV.register(nib, forCellWithReuseIdentifier: "cell")
        hdTabsCV.delegate = self
        hdTabsCV.dataSource = self
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 105, height: 42)
        layout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 5
        layout.minimumLineSpacing = 5
        hdTabsCV.collectionViewLayout = layout
        hdTabsCV.showsVerticalScrollIndicator = false
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tabnames.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var commonCell = UICollectionViewCell()
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? HotelDetailsTabCVCell {
            
            cell.titlelbl.text = tabnames[indexPath.row]
            
            
            
            
            if indexPath.row == 0 {
                cell.setupImage(image: "hdtab1", width: 21, height: 21)
                cell.selected()
            }else  if indexPath.row == 1 {
                cell.setupImage(image: "hdtab2", width: 28, height: 16)
            }else  if indexPath.row == 2 {
                cell.setupImage(image: "hdtab3", width: 20, height: 20)
            }else {
                cell.setupImage(image: "hdtab4", width: 20, height: 20)
            }
            commonCell = cell
            
            
        }
        
        return commonCell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? HotelDetailsTabCVCell {
            cell.selected()
            
            switch cell.titlelbl.text {
            case "Rooms":
                key = "rooms"
                roomDetailsTV.reloadData()
                break
            default:
                break
            }
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? HotelDetailsTabCVCell {
            cell.unSelected()
        }
    }
    
    
    
}




extension SelectRoomsTVCell: UITableViewDataSource ,UITableViewDelegate {
    
    
    func setuTV() {
        roomDetailsTV.register(UINib(nibName: "RoomsTVCell", bundle: nil), forCellReuseIdentifier: "rooms")
       
        roomDetailsTV.delegate = self
        roomDetailsTV.dataSource = self
        roomDetailsTV.tableFooterView = UIView()
        roomDetailsTV.separatorStyle = .none
        roomDetailsTV.showsHorizontalScrollIndicator = false
    }
    
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if self.key == "rooms" {
            return room.count
        }else {
            return 1
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.key == "rooms" {
            return room[section].count
        }else if self.key == "hotels details"{
            return 0
        }
        else {
            return 1
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var ccell = UITableViewCell()
        
        if self.key == "rooms" {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "rooms") as? RoomsTVCell {
                cell.selectionStyle = .none
               
                if indexPath.section < room.count && indexPath.row < room[indexPath.section].count {
                    
                   
                    
                } else {
                    print("Index out of range error: indexPath = \(indexPath)")
                }
                
                
                ccell = cell
            }
        }else if self.key == "hotels details"{
           
        }else {
           
        }
        return ccell
    }
    
    
    
}
