//
//  FlightResultTVCell.swift
//  Beeoons
//
//  Created by FCI on 10/08/23.
//

import UIKit
import SDWebImage

protocol FlightResultTVCellDelegate {
    func didTapOnFlightDetails(cell:FlightResultTVCell)
}


class FlightResultTVCell: TableViewCell {
    
    
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var pricelbl: UILabel!
    @IBOutlet weak var refundablelbl: UILabel!
    @IBOutlet weak var flightinfoTV: UITableView!
    @IBOutlet weak var tvHeight: NSLayoutConstraint!
    
    var selectedResult = String()
    var fdetails = [Summary]()
    var delegate:FlightResultTVCellDelegate?
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
        selectedResult = cellInfo?.title ?? ""
        selectedAccesskey = cellInfo?.title ?? ""
        pricelbl.text = cellInfo?.kwdprice ?? ""
        refundablelbl.text = cellInfo?.refundable ?? ""
        fdetails = cellInfo?.moreData as? [Summary] ?? []
        tvHeight.constant = CGFloat(fdetails.count * 130)
        flightinfoTV.reloadData()
    }
    
    func setupUI() {
        holderView.layer.borderWidth = 1
        holderView.layer.borderColor = UIColor.AppBorderColor.cgColor
        setupTV()
    }
    
    
    func setupTV() {
        flightinfoTV.register(UINib(nibName: "AddFlightInfoTVCell", bundle: nil), forCellReuseIdentifier: "cell")
        flightinfoTV.delegate = self
        flightinfoTV.dataSource = self
        flightinfoTV.tableFooterView = UIView()
        flightinfoTV.separatorStyle = .none
        flightinfoTV.isScrollEnabled = false
    }
    
    
    @IBAction func didTapOnFlightDetails(_ sender: Any) {
        delegate?.didTapOnFlightDetails(cell: self)
    }
    
    
    
}



extension FlightResultTVCell:UITableViewDelegate,UITableViewDataSource {
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fdetails.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var commonCell = UITableViewCell()
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? AddFlightInfoTVCell {
            cell.selectionStyle = .none
            
            let data = fdetails[indexPath.row]
            
            cell.flightnamelbl.text = data.operator_name
            cell.operatorImg.sd_setImage(with: URL(string: data.operator_image ?? ""), placeholderImage:UIImage(contentsOfFile:"placeholder.png"))
            
            cell.fromCityTimelbl.text = data.origin?.time
            cell.toCityTimelbl.text = data.destination?.time
            cell.fromCityNamelbl.text = data.origin?.city
            cell.toCityNamelbl.text = data.destination?.city
            cell.hourslbl.text = data.duration
            cell.noOfStopslbl.text = "\(data.no_of_stops ?? 0) Stops"
            
            
            
            commonCell = cell
        }
        return commonCell
    }
    
}
