//
//  DashboardVC.swift
//  Beeoons
//
//  Created by FCI on 08/08/23.
//

import UIKit

class DashboardVC: BaseTableVC {
    
    
    var tablerow = [TableRow]()
    var vm:IndexPageViewModel?
    //MARK: - side menu initial setup
    private var sideMenuViewController: SideMenuVC!
    private var sideMenuShadowView: UIView!
    private var sideMenuRevealWidth: CGFloat = 260
    private let paddingForRotation: CGFloat = 150
    private var isExpanded: Bool = false
    private var draggingIsEnabled: Bool = false
    private var panBaseLocation: CGFloat = 0.0
    
    //MARK: - Expand/Collapse the side menu by changing trailing's constant
    private var sideMenuTrailingConstraint: NSLayoutConstraint!
    private var revealSideMenuOnTop: Bool = true
    var gestureEnabled: Bool = true
    var payload = [String:Any]()
    
    //MARK: - viewDidLoad
    
    override func viewWillAppear(_ animated: Bool) {
        
        if !UserDefaults.standard.bool(forKey: "ExecuteOnce") {
            
            defaults.set("FLIGHTS", forKey: UserDefaultsKeys.tabselect)
            defaults.set("oneway", forKey: UserDefaultsKeys.journeyType)
            defaults.set("KWD", forKey: UserDefaultsKeys.selectedCurrency)
            
            defaults.set("", forKey: UserDefaultsKeys.fromCity)
            defaults.set("", forKey: UserDefaultsKeys.toCity)
            defaults.set("", forKey: UserDefaultsKeys.rfromCity)
            defaults.set("", forKey: UserDefaultsKeys.rtoCity)
            defaults.set("", forKey: UserDefaultsKeys.calDepDate)
            defaults.set("", forKey: UserDefaultsKeys.rcalDepDate)
            
            defaults.set("Economy", forKey: UserDefaultsKeys.selectClass)
            defaults.set("1", forKey: UserDefaultsKeys.adultCount)
            defaults.set("0", forKey: UserDefaultsKeys.childCount)
            defaults.set("0", forKey: UserDefaultsKeys.infantsCount)
            
            defaults.set("Economy", forKey: UserDefaultsKeys.rselectClass)
            defaults.set("1", forKey: UserDefaultsKeys.radultCount)
            defaults.set("0", forKey: UserDefaultsKeys.rchildCount)
            defaults.set("0", forKey: UserDefaultsKeys.rinfantsCount)
            
            
            defaults.set("1", forKey: UserDefaultsKeys.totalTravellerCount)
            let totaltraverlers = "\(defaults.string(forKey: UserDefaultsKeys.totalTravellerCount) ?? "1") Traveller"
            defaults.set(totaltraverlers, forKey: UserDefaultsKeys.travellerDetails)
            
            let totaltraverlers1 = "\(defaults.string(forKey: UserDefaultsKeys.totalTravellerCount) ?? "1") Traveller"
            defaults.set(totaltraverlers1, forKey: UserDefaultsKeys.rtravellerDetails)
            
            
            
            defaults.set("Economy", forKey: UserDefaultsKeys.mselectClass)
            defaults.set("1", forKey: UserDefaultsKeys.madultCount)
            defaults.set("0", forKey: UserDefaultsKeys.mchildCount)
            defaults.set("0", forKey: UserDefaultsKeys.minfantsCount)
            let totaltraverlers2 = "\(defaults.string(forKey: UserDefaultsKeys.totalTravellerCount) ?? "1") Traveller"
            defaults.set(totaltraverlers2, forKey: UserDefaultsKeys.mtravellerDetails)
            
            
            
            
            UserDefaults.standard.set(true, forKey: "ExecuteOnce")
        }
        
        if callapibool == true {
            callIndexPageAPI()
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.view.backgroundColor = .WhiteColor
        setupUI()
        vm = IndexPageViewModel(self)
    }
    
    //MARK: -
    func setupUI() {
        
        setupMenu()
        commonTableView.registerTVCells(["EmptyTVCell",
                                         "MenuBtnWithLogoTVCell",
                                         "SelectTabTVCell",
                                         "DearMemberTVCell",
                                         "FlightDealsTVCell"])
        
    }
    
    
    
    //MARK: - setupTVCell
    func setupTVCell() {
        tablerow.removeAll()
        tablerow.append(TableRow(height:50,bgColor: .WhiteColor,cellType: .EmptyTVCell))
        tablerow.append(TableRow(cellType: .MenuBtnWithLogoTVCell))
        tablerow.append(TableRow(cellType: .SelectTabTVCell))
        tablerow.append(TableRow(title:"HOTEL",cellType: .FlightDealsTVCell))
        tablerow.append(TableRow(title:"Dear Members,",
                                 subTitle: "As of 20 September 2022, Miles & Smiles award ticket issuance and profile updates will be made with verification code to be sent your phone",
                                 cellType: .DearMemberTVCell))
        tablerow.append(TableRow(title:"Dear Passengers,",
                                 subTitle: "You can Access the Announcement regarding our flights to Ukraine, Belarus and Russia and the rights granted to our passengers for our flights to these countries",
                                 cellType: .DearMemberTVCell))
        
        
        tablerow.append(TableRow(title:"FLIGHT",cellType: .FlightDealsTVCell))
        tablerow.append(TableRow(height:80,bgColor: .WhiteColor,cellType: .EmptyTVCell))
        commonTVData = tablerow
        commonTableView.reloadData()
    }
    
    
    
    //MARK: - didTapOnDashboardTab
    override func didTapOnDashboardTab(cell: SelectTabTVCell) {
        switch cell.selectedTitle {
            
        case "FLIGHT":
            gotoBookFlightVC()
            break
            
        case "HOTEL":
            print("HOTEL")
            break
            
        case "RENT A CAR":
            print("RENT A CAR")
            break
            
        case "HOLIDAYS":
            print("HOLIDAYS")
            break
            
            
        default:
            break
        }
    }
    
    
    
    //MARK: -
    func gotoBookFlightVC(){
        guard let vc = BookFlightVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    //MARK: -
    func gotoBookHotelVC(){
        
    }
    
    //MARK: -
    func goto(){
        
    }
    
    
    
    //MARK: -
    override func didTapOnMenuBtnAction(cell: MenuBtnWithLogoTVCell) {
        NotificationCenter.default.post(name: NSNotification.Name("tabbarhide"), object: true)
        NotificationCenter.default.post(name: NSNotification.Name("callprofile"), object: true)
        
        self.sideMenuState(expanded: self.isExpanded ? false : true)
    }
    
    
    //MARK: -
    override func didTapOnLangBtnAction(cell: MenuBtnWithLogoTVCell) {
        print("didTapOnLangBtnAction")
    }
    
    
    //MARK: -
    override func didTapOnBookFlightBtn(cell: DealsCVCell) {
        payload["trip_type"] = cell.trip_type
        payload["adult"] = "1"
        payload["child"] = "0"
        payload["infant"] = "0"
        payload["sector_type"] = "international"
        payload["from"] = cell.fromcity
        payload["from_loc_id"] = cell.from_loc_id
        payload["to"] = cell.tocity
        payload["to_loc_id"] = cell.to_loc_id
        payload["depature"] = cell.depratureDatelbl.text ?? ""
        payload["return"] = cell.returnDatelbl.text ?? ""
        payload["carrier"] = ""
        payload["psscarrier"] = ""
        payload["v_class"] = cell.v_class
        payload["search_flight"] = "Search"
        payload["search_source"] = "search"
        payload["user_id"] = defaults.string(forKey: UserDefaultsKeys.userid) ?? "0"
        payload["currency"] = cell.currency
    
        gotoFlightResultVC()
       
    }
    
    
    func gotoFlightResultVC() {
        guard let vc = FlightResultVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        loderBool = true
        callapibool = true
        vc.payload = payload
        self.present(vc, animated: true)
    }
    
    
    
    //MARK: -
    override func didTapOnBookHoteltBtn(cell:HotelDealsCVCell){
        print(cell.bookBtn.tag)
    }
    
    
}




extension DashboardVC: UIGestureRecognizerDelegate {
    
    
    //MARK: SETUP SIDE MENU
    func setupMenu(){
        menubool = true
        //MARK: Shadow Background View
        self.sideMenuShadowView = UIView(frame: self.view.bounds)
        self.sideMenuShadowView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.sideMenuShadowView.backgroundColor = .black
        self.sideMenuShadowView.alpha = 0.0
        
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(TapGestureRecognizer))
        tapGestureRecognizer.numberOfTapsRequired = 1
        tapGestureRecognizer.delegate = self
        self.sideMenuShadowView.addGestureRecognizer(tapGestureRecognizer)
        if self.revealSideMenuOnTop {
            view.insertSubview(self.sideMenuShadowView, at: 1)
        }
        
        //MARK: Side Menu
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        self.sideMenuViewController = storyboard.instantiateViewController(withIdentifier: "SideMenuVC") as? SideMenuVC
        view.insertSubview(self.sideMenuViewController!.view, at: self.revealSideMenuOnTop ? 2 : 0)
        addChild(self.sideMenuViewController!)
        self.sideMenuViewController!.didMove(toParent: self)
        
        //MARK: Side Menu AutoLayout
        self.sideMenuViewController.view.translatesAutoresizingMaskIntoConstraints = false
        
        if self.revealSideMenuOnTop {
            self.sideMenuTrailingConstraint = self.sideMenuViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: -self.sideMenuRevealWidth - self.paddingForRotation)
            self.sideMenuTrailingConstraint.isActive = true
        }
        NSLayoutConstraint.activate([
            self.sideMenuViewController.view.widthAnchor.constraint(equalToConstant: self.sideMenuRevealWidth + 50),
            self.sideMenuViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            self.sideMenuViewController.view.topAnchor.constraint(equalTo: view.topAnchor)
        ])
        
        //MARK: Side Menu Gestures
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture))
        panGestureRecognizer.delegate = self
        view.addGestureRecognizer(panGestureRecognizer)
    }
    
    //MARK: Keep the state of the side menu (expanded or collapse) in rotation
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        coordinator.animate { _ in
            if self.revealSideMenuOnTop {
                self.sideMenuTrailingConstraint.constant = self.isExpanded ? 0 : (-self.sideMenuRevealWidth - self.paddingForRotation)
            }
        }
    }
    
    func animateShadow(targetPosition: CGFloat) {
        UIView.animate(withDuration: 0.5) {
            //MARK: When targetPosition is 0, which means side menu is expanded, the shadow opacity is 0.6
            self.sideMenuShadowView.alpha = (targetPosition == 0) ? 0.6 : 0.0
        }
    }
    
    
    
    func sideMenuState(expanded: Bool) {
        if expanded {
            NotificationCenter.default.post(name: NSNotification.Name("tabbarhide"), object: true)
            NotificationCenter.default.post(name: NSNotification.Name("callprofile"), object: true)
            
            self.animateSideMenu(targetPosition: self.revealSideMenuOnTop ? 0 : self.sideMenuRevealWidth) { _ in
                self.isExpanded = true
            }
            // Animate Shadow (Fade In)
            UIView.animate(withDuration: 0.5) { self.sideMenuShadowView.alpha = 0.6 }
            menubool = true
        }
        else {
            NotificationCenter.default.post(name: NSNotification.Name("tabbarhide"), object: false)
            //            NotificationCenter.default.post(name: NSNotification.Name("callprofile"), object: true)
            
            self.animateSideMenu(targetPosition: self.revealSideMenuOnTop ? (-self.sideMenuRevealWidth - self.paddingForRotation) : 0) { _ in
                self.isExpanded = false
            }
            // Animate Shadow (Fade Out)
            UIView.animate(withDuration: 0.5) { self.sideMenuShadowView.alpha = 0.0 }
            
        }
    }
    
    func animateSideMenu(targetPosition: CGFloat, completion: @escaping (Bool) -> ()) {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0, options: .layoutSubviews, animations: {
            if self.revealSideMenuOnTop {
                self.sideMenuTrailingConstraint.constant = targetPosition
                self.view.layoutIfNeeded()
            }
            else {
                self.view.subviews[1].frame.origin.x = targetPosition
            }
        }, completion: completion)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    
    @objc func TapGestureRecognizer(sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            if self.isExpanded {
                self.sideMenuState(expanded: false)
            }
        }
    }
    
    // Close side menu when you tap on the shadow background view
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if (touch.view?.isDescendant(of: self.sideMenuViewController.view))! {
            return false
        }
        return true
    }
    
    // Dragging Side Menu
    @objc private func handlePanGesture(sender: UIPanGestureRecognizer) {
        
        guard gestureEnabled == true else { return }
        
        let position: CGFloat = sender.translation(in: self.view).x
        let velocity: CGFloat = sender.velocity(in: self.view).x
        
        switch sender.state {
        case .began:
            
            // If the user tries to expand the menu more than the reveal width, then cancel the pan gesture
            if velocity > 0, self.isExpanded {
                sender.state = .cancelled
            }
            
            // If the user swipes right but the side menu hasn't expanded yet, enable dragging
            if velocity > 0, !self.isExpanded {
                self.draggingIsEnabled = true
            }
            // If user swipes left and the side menu is already expanded, enable dragging
            else if velocity < 0, self.isExpanded {
                self.draggingIsEnabled = true
            }
            
            if self.draggingIsEnabled {
                // If swipe is fast, Expand/Collapse the side menu with animation instead of dragging
                let velocityThreshold: CGFloat = 550
                if abs(velocity) > velocityThreshold {
                    self.sideMenuState(expanded: self.isExpanded ? false : true)
                    self.draggingIsEnabled = false
                    return
                }
                
                if self.revealSideMenuOnTop {
                    self.panBaseLocation = 0.0
                    if self.isExpanded {
                        self.panBaseLocation = self.sideMenuRevealWidth
                    }
                }
            }
            
        case .changed:
            
            // Expand/Collapse side menu while dragging
            if self.draggingIsEnabled {
                if self.revealSideMenuOnTop {
                    // Show/Hide shadow background view while dragging
                    let xLocation: CGFloat = self.panBaseLocation + position
                    let percentage = (xLocation * 150 / self.sideMenuRevealWidth) / self.sideMenuRevealWidth
                    
                    let alpha = percentage >= 0.6 ? 0.6 : percentage
                    self.sideMenuShadowView.alpha = alpha
                    
                    // Move side menu while dragging
                    if xLocation <= self.sideMenuRevealWidth {
                        self.sideMenuTrailingConstraint.constant = xLocation - self.sideMenuRevealWidth
                    }
                }
                else {
                    if let recogView = sender.view?.subviews[1] {
                        // Show/Hide shadow background view while dragging
                        let percentage = (recogView.frame.origin.x * 150 / self.sideMenuRevealWidth) / self.sideMenuRevealWidth
                        
                        let alpha = percentage >= 0.6 ? 0.6 : percentage
                        self.sideMenuShadowView.alpha = alpha
                        
                        // Move side menu while dragging
                        if recogView.frame.origin.x <= self.sideMenuRevealWidth, recogView.frame.origin.x >= 0 {
                            recogView.frame.origin.x = recogView.frame.origin.x + position
                            sender.setTranslation(CGPoint.zero, in: view)
                        }
                    }
                }
            }
        case .ended:
            self.draggingIsEnabled = false
            // If the side menu is half Open/Close, then Expand/Collapse with animation
            if self.revealSideMenuOnTop {
                let movedMoreThanHalf = self.sideMenuTrailingConstraint.constant > -(self.sideMenuRevealWidth * 0.5)
                self.sideMenuState(expanded: movedMoreThanHalf)
            }
            else {
                if let recogView = sender.view?.subviews[1] {
                    let movedMoreThanHalf = recogView.frame.origin.x > self.sideMenuRevealWidth * 0.5
                    self.sideMenuState(expanded: movedMoreThanHalf)
                }
            }
        default:
            break
        }
    }
}



extension DashboardVC:IndexPageViewModelDelegate {
    
    func callIndexPageAPI() {
        vm?.CALL_INDEXPAGE_API(dictParam: [:])
    }
    
    func indexPageDetails(response: IndexPageModel) {
        topflightDest = response.flight_top_destinations1 ?? []
        indeximagepath = response.base_url ?? ""
        
        DispatchQueue.main.async {[self] in
            setupTVCell()
        }
    }
    
}
