//
//  BaseTableVC.swift
//  Clique
//
//  Created by Codebele-03 on 03/06/21.
//

import UIKit

class BaseTableVC: UIViewController, MenuBtnWithLogoTVCellDelegate, SelectTabTVCellDelegate, FlightDealsTVCellDelegate, BookFlightTVCellDelegate, TravellerEconomyTVCellDelegate, ButtonTVCellDelegate, FlightResultTVCellDelegate, CheckBoxTVCellDelegate, checkOptionsTVCellDelegate, SliderTVCellDelegate, SortByPriceTVCellDelegate, MenuOptionTVCellDelegate, MenuBGTVCellDelegate, RegisterUserTVCellDelegate, UserNameTextFieldTVCellDelegate, FareRulesTVCellDelegate, ViewFlightDetailsTVCellDelegate, BookFlightMCTVCellDelegate, PromocodeTVCellDelegate {
    
    
    
    @IBOutlet weak var commonScrollView: UITableView!
    @IBOutlet weak var commonTableView: UITableView!
    @IBOutlet weak var commonTVTopConstraint: NSLayoutConstraint!
    
    
    var commonTVData = [TableRow]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.modalPresentationCapturesStatusBarAppearance = true
        self.navigationController?.navigationBar.isHidden = true
        configureTableView()
        //        self.automaticallyAdjustsScrollViewInsets = false
        
        // Do any additional setup after loading the view.
    }
    
    
    func configureTableView() {
        if commonTableView != nil {
            makeDefaultConfigurationForTable(tableView: commonTableView)
        } else {
            print("commonTableView is nil")
        }
    }
    
    func makeDefaultConfigurationForTable(tableView: UITableView) {
        
        tableView.estimatedRowHeight = 80
        tableView.rowHeight = UITableView.automaticDimension
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.tableFooterView = UIView()
        
        tableView.backgroundColor = UIColor.clear
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        
        if #available(iOS 11.0, *) {
            tableView.contentInsetAdjustmentBehavior = UIScrollView.ContentInsetAdjustmentBehavior.never
        } else {
            // Fallback on earlier versions
        }
    }
    
    func serviceCall_Completed_ForNoDataLabel(noDataMessage: String? = nil, data: [Any]? = nil, centerVal:CGFloat? = nil, color: UIColor = HexColor("#182541")) {
        dealWithNoDataLabel(message: noDataMessage, data: data, centerVal: centerVal ?? 2.0, color: color)
    }
    
    func dealWithNoDataLabel(message: String?, data: [Any]?, centerVal: CGFloat = 2.0, color: UIColor = HexColor("#182541")) {
        if commonTableView == nil { return; }
        
        commonTableView.viewWithTag(100)?.removeFromSuperview()
        
        if let message = message, let data = data {
            if data.count == 0 {
                let tableSize = commonTableView.frame.size
                
                let label = UILabel(frame: CGRect(x: 15, y: 15, width: tableSize.width, height: 60))
                label.center = CGPoint(x: (tableSize.width/2), y: (tableSize.height/centerVal))
                label.tag = 100
                label.numberOfLines = 0
                
                label.textAlignment = NSTextAlignment.center
                //                label.font = UIFont.CircularStdMedium(size: 14)
                label.textColor = color
                label.text = message
                
                commonTableView.addSubview(label)
            }
        }
        
    }
    
    
    //functions
    func didTapOnMenuBtnAction(cell: MenuBtnWithLogoTVCell) {}
    func didTapOnLangBtnAction(cell: MenuBtnWithLogoTVCell) {}
    func didTapOnDashboardTab(cell: SelectTabTVCell) {}
    func didTapOnBookFlightBtn(cell: DealsCVCell) {}
    func didTapOnBookHoteltBtn(cell:HotelDealsCVCell){}
    func didTapOnBnAction(cell:ButtonTVCell){}
    
    func didTapOnFromCityBtnAction(cell: BookFlightTVCell) {}
    func didTapOnToCityBtnAction(cell: BookFlightTVCell) {}
    func didTapOnSelectDepartureDateBtnAction(cell: BookFlightTVCell) {}
    func didTapOnArrivalDateBtnAction(cell: BookFlightTVCell) {}
    func didTapOnSelectTravellersBtnAction(cell: BookFlightTVCell) {}
    func didTapOnSelectClassBtnAction(cell: BookFlightTVCell) {}
    func didTapOnAddAirlineButtonAction(cell:BookFlightTVCell){}
    func didTapOnDecrementButton(cell: TravellerEconomyTVCell) {}
    func didTapOnIncrementButton(cell: TravellerEconomyTVCell) {}
    func didTapOnSearchFlightBtnAction(cell:BookFlightTVCell) {}
    func didTapOnFlightDetails(cell:FlightResultTVCell){}
    func didTapOnAirLineDropDownBtn(cell:BookFlightTVCell){}
    
    func didTapOnSelectTravellersBtnAction(cell: BookFlightMCTVCell) {}
    func didTapOnSelectClassBtnAction(cell: BookFlightMCTVCell) {}
    func didTapOnSearchFlightBtnAction(cell: BookFlightMCTVCell) {}
    func didTapOnFromCityBtn(cell: BookFlightMCTVCell) {}
    func didTapOnToCityBtn(cell: BookFlightMCTVCell) {}
    func didTapOnDateBtn(cell: BookFlightMCTVCell) {}
    
    func didTapOnCheckBoxDropDownBtn(cell: CheckBoxTVCell) {}
    func didTapOnShowMoreBtn(cell: CheckBoxTVCell) {}
    func didTapOnCheckBox(cell: checkOptionsTVCell) {}
    func didTapOnDeselectCheckBox(cell: checkOptionsTVCell) {}
    func didTapOnMenuOptionBtn(cell: checkOptionsTVCell) {}
    func didTapOnShowSliderBtn(cell: SliderTVCell) {}
    func didTapOnLowToHeighBtnAction(cell: SortByPriceTVCell) {}
    func didTapOnHeighToLowBtnAction(cell: SortByPriceTVCell) {}
    
    func didTapOnMenuOtptionBtnAction(cell: MenuOptionTVCell) {}
    func didTapOnLoginBtnAction(cell:MenuBGTVCell){}
    func editingText(tf: UITextField) {}
    func didTapOnRegisterBtnAction(cell: RegisterUserTVCell) {}
    func didTapOnLoginBtnAction(cell: RegisterUserTVCell) {}
    func didTapOnCountryCodeBtnAction(cell: RegisterUserTVCell) {}
    
    func editingTextField(tf: UITextField) {}
    func didTapOnCountryCodeBtnAction(cell: UserNameTextFieldTVCell) {}
    func donedatePicker(cell:UserNameTextFieldTVCell){}
    func cancelDatePicker(cell:UserNameTextFieldTVCell){}
    func showContentBtnAction(cell: FareRulesTVCell) {}
    func didTapOnViewFlightDetails(cell: ViewFlightDetailsTVCell) {}
    func didTapOnApplyPromocodeBtnAction(cell: PromocodeTVCell) {}
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}

extension BaseTableVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let height = commonTVData[indexPath.row].height
        
        if let height = height {
            return height
        }
        
        return UITableView.automaticDimension
    }
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
    }
    
}
extension BaseTableVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == commonTableView {
            return commonTVData.count
        }else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var commonCell: TableViewCell!
        
        var data: TableRow?
        var commonTV = UITableView()
        
        if tableView == commonTableView {
            data = commonTVData[indexPath.row]
            commonTV = commonTableView
        }
        
        
        if let cellType = data?.cellType {
            switch cellType {
                
                //Sign & SignUp Cells
                
            case .EmptyTVCell:
                let cell: EmptyTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                commonCell = cell
                
                
            case .MenuBtnWithLogoTVCell:
                let cell: MenuBtnWithLogoTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                cell.delegate = self
                commonCell = cell
                
                
            case .SelectTabTVCell:
                let cell: SelectTabTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                cell.delegate = self
                commonCell = cell
                
                
            case .DearMemberTVCell:
                let cell: DearMemberTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                commonCell = cell
                
                
            case .FlightDealsTVCell:
                let cell: FlightDealsTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                cell.delegate = self
                commonCell = cell
                
                
                
            case .BookFlightTVCell:
                let cell: BookFlightTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                cell.delegate = self
                commonCell = cell
                
                
                
            case .TravellerEconomyTVCell:
                let cell: TravellerEconomyTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                cell.delegate = self
                commonCell = cell
                
                
                
            case .ButtonTVCell:
                let cell: ButtonTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                cell.delegate = self
                commonCell = cell
                
                
                
            case .FlightResultTVCell:
                let cell: FlightResultTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                cell.delegate = self
                commonCell = cell
                
                
            case .CheckBoxTVCell:
                let cell: CheckBoxTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                cell.delegate = self
                commonCell = cell
                
                
            case .checkOptionsTVCell:
                let cell: checkOptionsTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                cell.delegate = self
                commonCell = cell
                
                
            case .SliderTVCell:
                let cell: SliderTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                cell.delegate = self
                commonCell = cell
                
                
            case .SortByPriceTVCell:
                let cell:  SortByPriceTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                cell.delegate = self
                commonCell = cell
                
                
            case .AddItineraryTVCell:
                let cell:  AddItineraryTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                commonCell = cell
                
                
                
            case .MenuBGTVCell:
                let cell:  MenuBGTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                cell.delegate = self
                commonCell = cell
                
                
            case .MenuOptionTVCell:
                let cell:  MenuOptionTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                cell.delegate = self
                commonCell = cell
                
                
            case .RegisterUserTVCell:
                let cell:  RegisterUserTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                cell.delegate = self
                commonCell = cell
                
                
                
            case .UserNameTextFieldTVCell:
                let cell:  UserNameTextFieldTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                cell.delegate = self
                commonCell = cell
                
                
                
            case .LabelTVCell:
                let cell:  LabelTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                commonCell = cell
                
                
                
            case .FarBreakdownTVCell:
                let cell:  FarBreakdownTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                commonCell = cell
                
                
                
            case .BaggageInfoTVCell:
                let cell:  BaggageInfoTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                commonCell = cell
                
                
                
                
            case .FareRulesTVCell:
                let cell:  FareRulesTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                cell.delegate = self
                commonCell = cell
                
                
                
            case . ViewFlightDetailsTVCell:
                let cell:   ViewFlightDetailsTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                cell.delegate = self
                commonCell = cell
                
                
                
                
            case .PurchaseSummaryTVCell:
                let cell:  PurchaseSummaryTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                commonCell = cell
                
                
                
            case .PromocodeTVCell:
                let cell:  PromocodeTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                cell.delegate = self
                commonCell = cell
                
                
                
            case .TravellerDetailsTVCell:
                let cell:  TravellerDetailsTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                commonCell = cell
                
                
                
            case .BookFlightMCTVCell:
                let cell:  BookFlightMCTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                cell.delegate = self
                commonCell = cell
                
                
                
            default:
                print("handle this case in getCurrentCellAt")
            }
        }
        
        commonCell.cellInfo = data
        commonCell.indexPath = indexPath
        commonCell.selectionStyle = .none
        
        return commonCell
    }
} 



extension UITableView {
    func registerTVCells(_ classNames: [String]) {
        for className in classNames {
            register(UINib(nibName: className, bundle: nil), forCellReuseIdentifier: className)
        }
    }
    
    func dequeTVCell<T: UITableViewCell>(indexPath: IndexPath, osVersion: String? = nil) -> T {
        let className = String(describing: T.self) + "\(osVersion ?? "")"
        guard let cell = dequeueReusableCell(withIdentifier: className, for: indexPath) as? T  else { fatalError("Couldn’t get cell with identifier \(className)") }
        return cell
    }
    
    func dequeTVCellForFooter<T: UITableViewCell>() -> T {
        let className = String(describing: T.self)
        guard let cell = dequeueReusableCell(withIdentifier: className) as? T  else { fatalError("Couldn’t get cell with identifier \(className)") }
        return cell
    }
    
    
    
    func isLast(for indexPath: IndexPath) -> Bool {
        
        let indexOfLastSection = numberOfSections > 0 ? numberOfSections - 1 : 0
        let indexOfLastRowInLastSection = numberOfRows(inSection: indexOfLastSection) - 1
        
        return indexPath.section == indexOfLastSection && indexPath.row == indexOfLastRowInLastSection
    }
    
}
