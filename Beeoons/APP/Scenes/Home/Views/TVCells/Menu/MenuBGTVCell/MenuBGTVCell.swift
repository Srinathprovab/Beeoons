//
//  MenuBGTVCell.swift
//  Beeoons
//
//  Created by FCI on 11/08/23.
//

import UIKit

protocol MenuBGTVCellDelegate {
    func didTapOnLoginBtnAction(cell:MenuBGTVCell)
}

class MenuBGTVCell: TableViewCell {

    
    @IBOutlet weak var profileimg: UIImageView!
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var subtitlelbl: UILabel!
    @IBOutlet weak var loginBtnView: UIView!
    @IBOutlet weak var userNameView: UIStackView!
    
    
    
    var delegate:MenuBGTVCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    override func updateUI() {
        
        if let userstatusObject = defaults.object(forKey: UserDefaultsKeys.loggedInStatus) as? Bool, userstatusObject == true {
            loginBtnView.isHidden = true
            userNameView.isHidden = false
            titlelbl.text = "\(profildata?.first_name ?? "") \(profildata?.last_name ?? "")"
            
            if let userstatusObject = profildata?.image as? String, !userstatusObject.isEmpty {
                self.profileimg.sd_setImage(with: URL(string: profildata?.image ?? ""), placeholderImage:UIImage(contentsOfFile:"placeholder.png"))
                profileimg.alpha = 1
            }else {
                profileimg.image = UIImage(named: "profile")?.withRenderingMode(.alwaysOriginal)
                profileimg.alpha = 0.5
            }
        }else {
            userNameView.isHidden = true
            loginBtnView.isHidden = false
            profileimg.image = UIImage(named: "profile")?.withRenderingMode(.alwaysOriginal)
            profileimg.alpha = 0.5
        }
    }
    
    
    func setupUI() {
        
    }
    
    
    @IBAction func didTapOnLoginBtnAction(_ sender: Any) {
        delegate?.didTapOnLoginBtnAction(cell: self)
    }
    
    
}
