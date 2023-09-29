//
//  MenuBGTVCell.swift
//  Beeoons
//
//  Created by FCI on 11/08/23.
//

import UIKit

protocol MenuBGTVCellDelegate {
    func didTapOnLoginBtnAction(cell:MenuBGTVCell)
    func didTapOnEditProfileBtnAction(cell:MenuBGTVCell)
    
}

class MenuBGTVCell: TableViewCell {
    
    
    @IBOutlet weak var profileimg: UIImageView!
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var loginBtnView: UIView!
    @IBOutlet weak var userNameView: UIStackView!
    @IBOutlet weak var editView: UIView!
    
    
    
    var delegate:MenuBGTVCellDelegate?
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
        
        if let userstatusObject = defaults.object(forKey: UserDefaultsKeys.loggedInStatus) as? Bool, userstatusObject == true {
            loginBtnView.isHidden = true
            userNameView.isHidden = false
            editView.isHidden = false
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
            editView.isHidden = true
            loginBtnView.isHidden = false
            profileimg.image = UIImage(named: "profile")?.withRenderingMode(.alwaysOriginal)
            profileimg.alpha = 0.5
        }
    }
    
    
    func setupUI() {
        editView.layer.borderWidth = 1
        editView.layer.borderColor = UIColor.WhiteColor.cgColor
    }
    
    
    @IBAction func didTapOnLoginBtnAction(_ sender: Any) {
        delegate?.didTapOnLoginBtnAction(cell: self)
    }
    
    
    @IBAction func didTapOnEditProfileBtnAction(_ sender: Any) {
        delegate?.didTapOnEditProfileBtnAction(cell: self)
    }
    
    
}
