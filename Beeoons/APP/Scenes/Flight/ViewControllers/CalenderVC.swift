//
//  CalenderVC.swift
//  Beeoons
//
//  Created by FCI on 09/08/23.
//

import UIKit
import JTAppleCalendar

class CalenderVC: UIViewController {
    
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var calendarView: JTAppleCalendarView!
    
    
    
    static var newInstance: CalenderVC? {
        let storyboard = UIStoryboard(name: Storyboard.Flight.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? CalenderVC
        return vc
    }
    
    var titleStr: String?
    var selectedfirstDate : Date?
    var selectedlastDate : Date?
    let df = DateFormatter()
    var startDate = Date().dateByAddingMonths(months: -12).startOfMonth
    var endDate = Date().dateByAddingMonths(months: 12).endOfMonth
    var selectedDays: Date?
    let grayView = UIView()
    var btnDoneActionBool = Bool()
    var calstartDate = String()
    var calendDate = String()
    var celltag = Int()
    var depDay = String()
    var retDay = String()
    
    override func viewWillDisappear(_ animated: Bool) {
        callapibool = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.celltag = Int(defaults.string(forKey: UserDefaultsKeys.cellTag) ?? "0") ?? 0
        NotificationCenter.default.addObserver(self, selector: #selector(nointernet), name: Notification.Name("nointernet"), object: nil)
        
    }
    
    
    
    //MARK: - nointernet
    @objc func nointernet() {
        //        guard let vc = NoInternetConnectionVC.newInstance.self else {return}
        //        vc.modalPresentationStyle = .overCurrentContext
        //        self.present(vc, animated: true)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.view.backgroundColor = .black.withAlphaComponent(0.70)
        setupCalView()
    }
    
    
    func setupViews(v:UIView,radius:CGFloat,color:UIColor) {
        v.backgroundColor = color
        v.layer.cornerRadius = radius
        v.clipsToBounds = true
        v.layer.borderWidth = 0.5
        v.layer.borderColor = UIColor.AppBorderColor.cgColor
    }
    
    func setupLabels(lbl:UILabel,text:String,textcolor:UIColor,font:UIFont) {
        lbl.text = text
        lbl.textColor = textcolor
        lbl.font = font
    }
    
    
    func setupCalView() {
        
        
        
        // Do any additional setup after loading the view.
        calendarView.scrollDirection  = .horizontal
        calendarView.scrollingMode = .stopAtEachSection
        calendarView.showsHorizontalScrollIndicator = false
        
        
        
        calendarView.scrollToDate(Date(),animateScroll: false)
        
        calendarView.register(UINib(nibName: "CalendarCVCell", bundle: nil), forCellWithReuseIdentifier: "CalendarCVCell")
        //        calendarView.allowsSelection = true
        calendarView.isRangeSelectionUsed = true
        
        calendarView.ibCalendarDelegate = self
        calendarView.ibCalendarDataSource = self
        calendarView.sectionInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        calendarView.minimumLineSpacing = 10
        calendarView.minimumInteritemSpacing = 10
        
        
        
        calendarView.visibleDates { (visibleDates) in
            self.setupMonthLabel(date: visibleDates.monthDates.first?.date ?? Date())
        }
        
        let panGensture = UILongPressGestureRecognizer(target: self, action: #selector(didStartRangeSelecting(gesture:)))
        panGensture.minimumPressDuration = 0.5
        calendarView.addGestureRecognizer(panGensture)
        
        
        
        let tabselect = defaults.string(forKey: UserDefaultsKeys.tabselect)
        if tabselect == "HOTEL" {
            calendarView.allowsMultipleSelection = true
        }else {
            let journyType = defaults.string(forKey: UserDefaultsKeys.journeyType)
            if journyType == "oneway" {
                calendarView.allowsMultipleSelection = false
            }else  if journyType == "circle"{
                calendarView.allowsMultipleSelection = true
            }else {
                calendarView.allowsMultipleSelection = false
            }
        }
    }
    
    
    @objc func didStartRangeSelecting(gesture: UITapGestureRecognizer) {
        let point = gesture.location(in: gesture.view!)
        let rangeSelectedDates = calendarView.selectedDates
        
        guard let cellState = calendarView.cellStatus(at: point) else { return }
        
        if !rangeSelectedDates.contains(cellState.date) {
            let dateRange = calendarView.generateDateRange(from: rangeSelectedDates.first ?? cellState.date, to: cellState.date)
            calendarView.selectDates(dateRange, keepSelectionIfMultiSelectionAllowed: true)
        }
    }
    
    func setupMonthLabel(date: Date) {
        monthLabel.text = date.monthYearName
    }
    
    
    func handleConfiguration(cell: JTAppleCell?, cellState: CellState) {
        guard let cell = cell as? CalendarCVCell else { return }
        handleCellColor(cell: cell, cellState: cellState)
        handleCellSelected(cell: cell, cellState: cellState)
        
        if calendarView.selectedDates.count == 0 {
            
        }else if calendarView.selectedDates.count == 1 {
            
            calstartDate = "\(cellState.date.customDateStringFormat("dd-MM-YYYY"))"
            calendDate = "\(cellState.date.customDateStringFormat("dd-MM-YYYY"))"
            
        }else {
            calstartDate = calendarView.selectedDates.first?.customDateStringFormat("dd-MM-YYYY") ?? ""
            calendDate = calendarView.selectedDates.last?.customDateStringFormat("dd-MM-YYYY") ?? ""
            
        }
    }
    
    
    func handleCellColor(cell: CalendarCVCell, cellState: CellState) {
        if cellState.dateBelongsTo == .thisMonth {
            cell.label.textColor = UIColor.black
        } else {
            cell.label.textColor = UIColor.lightGray
        }
    }
    
    func handleCellSelected(cell: CalendarCVCell, cellState: CellState) {
        cell.selectedView.isHidden = !cellState.isSelected
        
        switch cellState.selectedPosition() {
        case .left:
            cell.selectedView.layer.cornerRadius = 3
            cell.selectedView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMinXMinYCorner]
            cell.selectedView.isHidden = false
            cell.selectedView.backgroundColor = UIColor.ButtonColor
            cell.label.textColor = UIColor.white
        case .middle:
            cell.selectedView.layer.cornerRadius = 3
            cell.selectedView.layer.maskedCorners = []
            cell.selectedView.isHidden = false
            cell.selectedView.backgroundColor = UIColor.CalenderRangeColor.withAlphaComponent(0.3)
            cell.label.textColor = UIColor.TitleColor.withAlphaComponent(0.4)
        case .right:
            cell.selectedView.layer.cornerRadius = 3
            cell.selectedView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner]
            cell.selectedView.isHidden = false
            cell.selectedView.backgroundColor = UIColor.ButtonColor
            cell.label.textColor = UIColor.white
        case .full:
            cell.selectedView.layer.cornerRadius = 3
            cell.selectedView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMinXMinYCorner]
            cell.selectedView.isHidden = false
            cell.selectedView.backgroundColor = UIColor.ButtonColor
            cell.label.textColor = UIColor.white
        default: break
        }
        
        
        
    }
    
    
    @IBAction func leftButtonClick(_ sender: Any) {
        calendarView.scrollToSegment(.previous)
    }
    
    @IBAction func rightButtonClick(_ sender: Any) {
        calendarView.scrollToSegment(.next)
    }
    
    
    @IBAction func didTapOnBackButton(_ sender: Any) {
        self.dismiss(animated: false)
    }
    
    
    
    
    @IBAction func selectDateBtnAction(_ sender: Any) {
        
        if let selectedTab = defaults.string(forKey: UserDefaultsKeys.tabselect) {
            if selectedTab == "FLIGHT" {
                
                if let journeyType = defaults.string(forKey: UserDefaultsKeys.journeyType) {
                    if journeyType == "oneway" {
                        if calstartDate == "" {
                            showToast(message: "Please Select Date")
                        }else {
                            defaults.set(calstartDate, forKey: UserDefaultsKeys.calDepDate)
                            NotificationCenter.default.post(name: Notification.Name("reload"), object: nil)
                            dismiss(animated: false)
                        }
                        
                    }else if journeyType == "circle"{
                        if calstartDate == "" && calendDate == "" {
                            showToast(message: "Please Select Dates")
                        }else if calstartDate == calendDate{
                            showToast(message: "Please Select Multiple Dates")
                        }else{
                            defaults.set(calstartDate, forKey: UserDefaultsKeys.rcalDepDate)
                            defaults.set(calendDate, forKey: UserDefaultsKeys.rcalRetDate)
                            NotificationCenter.default.post(name: Notification.Name("reload"), object: nil)
                            dismiss(animated: false)
                        }
                    }else {
                        
                        if calstartDate == "" {
                            showToast(message: "Please Select Dates")
                        }else{
                            defaults.set(calstartDate, forKey: UserDefaultsKeys.mcalDepDate)
                            calDate[self.celltag] = convertDateFormat(inputDate: calstartDate, f1: "dd-MM-yyyy", f2: "dd MMM")
                            depatureDatesArray[self.celltag] = calstartDate
                            
                            
                            NotificationCenter.default.post(name: Notification.Name("reload"), object: nil)
                            dismiss(animated: false)
                            //gotoSearchFlightsVC()
                        }
                    }
                }
                
            }else {
                
                if calstartDate == "" && calendDate == "" {
                    showToast(message: "Please Select Dates")
                }else if calstartDate == calendDate{
                    showToast(message: "Please Select Multiple Dates")
                }else{
                    defaults.set(calstartDate, forKey: UserDefaultsKeys.checkin)
                    defaults.set(calendDate, forKey: UserDefaultsKeys.checkout)
                    
                    gotoSearchHotelsVC()
                }
                
            }
        }
        
    }
    
    
    func gotoSearchFlightsVC() {
        guard let vc = BookFlightVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: false)
    }
    
    
    func gotoSearchHotelsVC() {
        NotificationCenter.default.post(name: NSNotification.Name("hotelrooms"), object: nil)
        dismiss(animated: true)
    }
    
    
    
    
    
}



extension CalenderVC: JTAppleCalendarViewDelegate, JTAppleCalendarViewDataSource {
    
    func calendar(_ calendar: JTAppleCalendarView, willDisplay cell: JTAppleCell, forItemAt date: Date, cellState: CellState, indexPath: IndexPath) {
        
        handleConfiguration(cell: cell, cellState: cellState)
        
    }
    
    func calendar(_ calendar: JTAppleCalendarView, cellForItemAt date: Date, cellState: CellState, indexPath: IndexPath) -> JTAppleCell {
        let cell = calendar.dequeueReusableJTAppleCell(withReuseIdentifier: "CalendarCVCell", for: indexPath) as! CalendarCVCell
        cell.label.text = cellState.text
        handleConfiguration(cell: cell, cellState: cellState)
        
        
        if cellState.dateBelongsTo == .thisMonth {
            cell.isHidden = false
        } else {
            cell.isHidden = true
        }
        
        if date <= Date(){
            cell.label.textColor = HexColor("#555555", alpha: 0.4)
        }else {
            cell.label.textColor = HexColor("#555555")
        }
        
        
        return cell
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didScrollToDateSegmentWith visibleDates: DateSegmentInfo) {
        setupMonthLabel(date: visibleDates.monthDates.first!.date)
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didSelectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
        handleConfiguration(cell: cell, cellState: cellState)
        
        if selectedfirstDate != nil {
            if date < selectedfirstDate! {
                calendarView.selectDates(from: date, to: selectedfirstDate!,  triggerSelectionDelegate: false, keepSelectionIfMultiSelectionAllowed: true)
                selectedlastDate = calendarView.selectedDates.last
                selectedfirstDate = calendarView.selectedDates.first
                
            } else {
                selectedlastDate = calendarView.selectedDates.last
                calendarView.selectDates(from: selectedfirstDate!, to: date,  triggerSelectionDelegate: false, keepSelectionIfMultiSelectionAllowed: true)
            }
        } else {
            selectedfirstDate = calendarView.selectedDates.first
            selectedlastDate = nil
            handleConfiguration(cell: cell, cellState: cellState)
        }
        
    }
    
    
    
    
    func calendar(_ calendar: JTAppleCalendarView, didDeselectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
        handleConfiguration(cell: cell, cellState: cellState)
        
        if selectedfirstDate != nil{
            if date > (selectedfirstDate!){
                calendarView.deselectDates(from: selectedfirstDate!, to: date, triggerSelectionDelegate: false)
                selectedfirstDate = calendarView.selectedDates.first
            } else if selectedlastDate == nil || date == selectedlastDate {
                selectedfirstDate = nil
                selectedlastDate = nil
                handleConfiguration(cell: cell, cellState: cellState)
                
            }else {
                handleConfiguration(cell: cell, cellState: cellState)
            }
        }
    }
    
    func configureCalendar(_ calendar: JTAppleCalendarView) -> ConfigurationParameters {
        let parameter = ConfigurationParameters(startDate: self.startDate,
                                                endDate: self.endDate,
                                                numberOfRows: 6,
                                                generateInDates: .forAllMonths,
                                                generateOutDates: .tillEndOfGrid,
                                                firstDayOfWeek: .monday,
                                                hasStrictBoundaries:true)
        return parameter
    }
    
    func calendar(_ calendar: JTAppleCalendarView, shouldSelectDate date: Date, cell: JTAppleCell?, cellState: CellState) -> Bool {
        return date >= Date()
    }
    
    
    
    
    
}
