//
//  ViewFlightDetailsTVCell.swift
//  Beeoons
//
//  Created by FCI on 13/08/23.
//

import UIKit

protocol ViewFlightDetailsTVCellDelegate {
    func didTapOnViewFlightDetails(cell:ViewFlightDetailsTVCell)
}

class ViewFlightDetailsTVCell: TableViewCell {
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var flightDataTV: UITableView!
    @IBOutlet weak var tvHeight: NSLayoutConstraint!
    
    var delegate:ViewFlightDetailsTVCellDelegate?
    var fdetails = [Summary]()
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
       
        fdetails = cellInfo?.moreData as? [Summary] ?? []
        tvHeight.constant = CGFloat(fdetails.count * 148)
        flightDataTV.reloadData()
    }
    
    func setupUI() {
        holderView.layer.borderWidth = 1
        holderView.layer.borderColor = UIColor.AppBorderColor.cgColor
        setupTV()
    }
    
    
    func setupTV() {
        flightDataTV.register(UINib(nibName: "AddViewFlightDataTVCell", bundle: nil), forCellReuseIdentifier: "cell")
        flightDataTV.delegate = self
        flightDataTV.dataSource = self
        flightDataTV.tableFooterView = UIView()
        flightDataTV.separatorStyle = .none
        flightDataTV.isScrollEnabled = false
    }
    
    
    @IBAction func didTapOnViewFlightDetails(_ sender: Any) {
        delegate?.didTapOnViewFlightDetails(cell: self)
    }
    
    
    
}



extension ViewFlightDetailsTVCell:UITableViewDelegate,UITableViewDataSource {
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fdetails.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var commonCell = UITableViewCell()
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? AddViewFlightDataTVCell {
            cell.selectionStyle = .none
            
            let data = fdetails[indexPath.row]
            
            cell.flightnamelbl.text = data.operator_name
            cell.operatorImg.sd_setImage(with: URL(string: data.operator_image ?? ""), placeholderImage:UIImage(contentsOfFile:"placeholder.png"))
            
            cell.fromCityTimelbl.text = data.origin?.time
            cell.toCityTimelbl.text = data.destination?.time
            cell.fromCityNamelbl.text = data.origin?.city
            cell.toCityNamelbl.text = data.destination?.city
            cell.hourstopslbl.text = "\(data.duration ?? "")\(data.no_of_stops ?? 0) Stops"
            cell.economylbl.text = data.cabin_class ?? ""
            cell.fromdatalbl.text = data.origin?.date
            cell.todatelbl.text = data.destination?.date
            cell.cityslbl.text = "(\(data.origin?.loc ?? "") to \(data.destination?.loc ?? ""))"
            
            commonCell = cell
        }
        return commonCell
    }
    
}
