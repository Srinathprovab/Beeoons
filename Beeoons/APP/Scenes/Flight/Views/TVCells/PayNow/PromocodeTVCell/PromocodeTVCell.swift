//
//  PromocodeTVCell.swift
//  Beeoons
//
//  Created by FCI on 13/08/23.
//

import UIKit

protocol PromocodeTVCellDelegate {
    func editingTextField(tf:UITextField)
    func didTapOnApplyPromocodeBtnAction(cell:PromocodeTVCell)
}

class PromocodeTVCell: TableViewCell {
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var promocodeTF: UITextField!
    @IBOutlet weak var promocodeTFHolderView: UIView!
    
    var delegate:PromocodeTVCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func setupUI() {
        holderView.layer.borderWidth = 1
        holderView.layer.borderColor = UIColor.AppBorderColor.cgColor
        promocodeTFHolderView.layer.borderWidth = 1
        promocodeTFHolderView.layer.borderColor = UIColor.AppBorderColor.cgColor
        setuptf(tf: promocodeTF, tag1: 1, leftpadding: 16, font: .OswaldRegular(size: 14), placeholder: "Enter Promocode")
    }
    
    
    func setuptf(tf:UITextField,tag1:Int,leftpadding:Int,font:UIFont,placeholder:String){
        tf.backgroundColor = .clear
        tf.placeholder = placeholder
        tf.setLeftPaddingPoints(CGFloat(leftpadding))
        tf.font = font
        tf.tag = tag1
        tf.delegate = self
        tf.addTarget(self, action: #selector(editingText(textField:)), for: .editingChanged)
    }
    
    
    @objc func editingText(textField:UITextField) {
        delegate?.editingTextField(tf: textField)
    }
    
    
    
    @IBAction func didTapOnApplyPromocodeBtnAction(_ sender: Any) {
        delegate?.didTapOnApplyPromocodeBtnAction(cell: self)
    }
    
}

extension PromocodeTVCell {
    
    //MARK - UITextField Delegates
    override func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        var maxLength = 50
        let currentString: NSString = textField.text! as NSString
        let newString: NSString =  currentString.replacingCharacters(in: range, with: string) as NSString
        return newString.length <= maxLength
        
    }
    
    
}
