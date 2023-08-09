//
//  CalendarCVCell.swift
//  Beeoons
//
//  Created by FCI on 09/08/23.
//

import UIKit
import JTAppleCalendar


class CalendarCVCell: JTAppleCell {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var selectedView: UIView!
    @IBOutlet weak var holderView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        updateFont()
    }
    
    func updateFont() {
        label.font = UIFont.OswaldMedium(size: 12)
        holderView.backgroundColor = UIColor.WhiteColor
        

    }

}
