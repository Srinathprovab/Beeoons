//
//  AddItineraryTVCell.swift
//  Beeoons
//
//  Created by FCI on 11/08/23.
//

import UIKit

class AddItineraryTVCell: TableViewCell {
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var addDetailsTv: UITableView!
    @IBOutlet weak var tvHeight: NSLayoutConstraint!
    
    var fd = [FlightDetails]()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupTV()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    override func updateUI() {
        
        fd = cellInfo?.moreData as! [FlightDetails]
        tvHeight.constant = CGFloat(fd.count * 170)
        addDetailsTv.reloadData()
    }
    
    
   
    
}

extension AddItineraryTVCell:UITableViewDelegate,UITableViewDataSource {
    
    
    
    func setupTV() {
        
        
        holderView.backgroundColor = .WhiteColor
        holderView.layer.borderWidth = 1
        holderView.layer.borderColor = UIColor.AppBorderColor.cgColor
        
        addDetailsTv.register(UINib(nibName: "ItineraryTVCell", bundle: nil), forCellReuseIdentifier: "cell")
        addDetailsTv.delegate = self
        addDetailsTv.dataSource = self
        addDetailsTv.tableFooterView = UIView()
        addDetailsTv.showsHorizontalScrollIndicator = false
        addDetailsTv.separatorStyle = .none
        addDetailsTv.isScrollEnabled = false
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fd.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var c = UITableViewCell()
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? ItineraryTVCell {
            cell.selectionStyle = .none
            
            let data = fd[indexPath.row]
            cell.flightnolbl.text = "\(data.operator_code ?? "")-\(data.flight_number ?? "")"
            cell.cityscodelbl.text = data.operator_name
            
            cell.fromcitytimelbl.text = data.origin?.time
            cell.fromCitylbl.text = "\(data.origin?.city ?? "")(\(data.origin?.loc ?? ""))"
            cell.fromDatelbl.text = data.origin?.date
            
            cell.tocitytimelbl.text =  data.destination?.time
            cell.toCitylbl.text = "\(data.destination?.city ?? "")(\(data.destination?.loc ?? ""))"
            cell.toDatelbl.text = data.destination?.date
            
            cell.hourslbl.text = data.duration
            cell.stopslbl.text = "\(data.no_of_stops ?? 0) stop"
            
            cell.layoverCitylbl.text = "Layover duration \(data.destination?.city ?? "") (\(data.destination?.loc ?? "")), TIME:\(data.destination?.time ?? "")"
            
            cell.operatorImg.sd_setImage(with: URL(string: data.operator_image ?? ""), placeholderImage:UIImage(contentsOfFile:"placeholder.png"))
            
            
//            if tableView.isLast(for: indexPath) == true {
//                cell.bottomView.isHidden = true
//            }
            cell.bottomView.isHidden = true
            c = cell
        }
        return c
    }
    
    
    
}


extension UITableView {
    func isLastVisibleCell(at indexPath: IndexPath) -> Bool {
        guard let lastIndexPath = indexPathsForVisibleRows?.last else {
            return false
        }
        return lastIndexPath == indexPath
    }
}
