//
//  NavBar.swift
//  AirportProject
//
//  Created by Codebele 09 on 21/06/22.
//

import UIKit
import Foundation

class NavBar: UIView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var citylbl: UILabel!
    @IBOutlet weak var datelbl: UILabel!
    @IBOutlet weak var travellerlbl: UILabel!
    @IBOutlet weak var editView: UIView!
    @IBOutlet weak var editImg: UIImageView!
    @IBOutlet weak var editBtn: UIButton!
    @IBOutlet weak var filterView: UIView!
    @IBOutlet weak var filterImg: UIImageView!
    @IBOutlet weak var filterBtn: UIButton!
    
    var titleString = String()
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func commonInit() {
        Bundle.main.loadNibNamed("NavBar", owner: self, options: nil)
        contentView.frame = self.bounds
        addSubview(contentView)
        
        setupuiview()
    }
    
    
    
    func setupuiview(){
        contentView.backgroundColor = .NavBackColor
        backBtn.setTitle("", for: .normal)
        editBtn.setTitle("", for: .normal)
        filterBtn.setTitle("", for: .normal)
        
        
        setupLabels(lbl: titlelbl, text: "", textcolor: .WhiteColor, font: .OswaldMedium(size: 20))
        titlelbl.textAlignment = .center
        backBtn.tintColor = .WhiteColor
        
        setupLabels(lbl: citylbl, text: "", textcolor: .WhiteColor, font: .OswaldMedium(size: 16))
        setupLabels(lbl: datelbl, text: "", textcolor: .WhiteColor, font: .OswaldRegular(size: 12))
        setupLabels(lbl: travellerlbl, text: "", textcolor: .WhiteColor, font: .OswaldRegular(size: 12))
        
        setupViews(v: editView, radius: 4, color: .white)
        editView.isHidden = true
        editView.backgroundColor = .white
        setupViews(v: filterView, radius: 4, color: .white)
        filterView.isHidden = true
        filterView.backgroundColor = .white
        editImg.image = UIImage(named: "edit")
        filterImg.image = UIImage(named: "filter")
        
        
        citylbl.isHidden = true
        datelbl.isHidden = true
        travellerlbl.isHidden = true
    }
    
    
    func setupLabels(lbl:UILabel,text:String,textcolor:UIColor,font:UIFont) {
        lbl.text = text
        lbl.textColor = textcolor
        lbl.font = font
    }
    
    
    func setupViews(v:UIView,radius:CGFloat,color:UIColor) {
        v.backgroundColor = color
        v.layer.cornerRadius = radius
        v.clipsToBounds = true
        v.layer.borderWidth = 0.2
        v.layer.borderColor = UIColor.AppBorderColor.cgColor
    }
    
    
    
    
    
}



