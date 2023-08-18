//
//  LoadWebViewVC.swift
//  Beeoons
//
//  Created by FCI on 18/08/23.
//

import UIKit
import WebKit

class LoadWebViewVC: UIViewController , TimerManagerDelegate {
    
    
    @IBOutlet weak var webview: WKWebView!
    static var newInstance: LoadWebViewVC? {
        let storyboard = UIStoryboard(name: Storyboard.BookingCnf.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? LoadWebViewVC
        return vc
    }
    
    
    var urlString = String()
    var titleString = String()
    var apicallbool = true
    var openpaymentgatewaybool = false
    var isVcFrom = String()
    
    let activityIndicatorView = UIActivityIndicatorView(style: .large)
    
    
    
    @objc func offline(notificatio:UNNotification) {
        callapibool = true
        guard let vc = NoInternetConnectionVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: false)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //loderBool = false
        
        NotificationCenter.default.addObserver(self, selector: #selector(offline), name: NSNotification.Name("offline"), object: nil)
        
        
        print("<<<<<<<=== urlString ==>>>>>>\n \(urlString)")
        activityIndicatorView.startAnimating()
        self.webview.isUserInteractionEnabled = false
        
        
        if let url1 = URL(string: urlString) {
            webview.load(URLRequest(url: url1))
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(nointernet), name: NSNotification.Name("nointernet"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(reloadscreen), name: NSNotification.Name("reloadscreen"), object: nil)
        
        
        
        
        let seconds = 120.0
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {[self] in
            if  openpaymentgatewaybool == false {
                
                
                showAlertOnWindow(title: "",message: "Somthing Went Wrong",titles: ["OK"]) { title in
                    self.gotoDashBoardTabbarVC()
                }
            }
        }
        
    }
    
    
    
    
    //MARK: - nointernet
    
    @objc func nointernet(){
        guard let vc = NoInternetConnectionVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        present(vc, animated: true)
    }
    
    @objc func reloadscreen(){
        guard let vc = PopupVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: false)
    }
    
    func timerDidFinish() {
        
    }
    
    func updateTimer() {
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        TimerManager.shared.delegate = self
        // Do any additional setup after loading the view.
        activityIndicatorView.center = view.center
        activityIndicatorView.color = .NavBackColor
        view.addSubview(activityIndicatorView)
        
        setupUI()
        
        
    }
    
    
    func setupUI() {
        
        
        webview.navigationDelegate = self
        webview.isUserInteractionEnabled = true
        
    }
    
    
    @objc func didTapOnBackBtn(_ sender:UIButton) {
        if isVcFrom == "voucher" {
            callapibool = false
            dismiss(animated: true)
        }else {
            gotoDashBoardTabbarVC()
        }
    }
    
    
    
    func gotoBookingConfirmedVC(url:String) {
        TimerManager.shared.sessionStop()
        //        guard let vc = BookingConfirmedVC.newInstance.self else {return}
        //        vc.modalPresentationStyle = .fullScreen
        //        vc.vocherurl = url
        //        callapibool = true
        //        present(vc, animated: true)
        
        
        print(url)
    }
    
    
    
    func gotoDashBoardTabbarVC() {
        guard let vc = HomeVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        callapibool = true
        present(vc, animated: true)
    }
    
    
    
    @IBAction func didTapOnBackBtnAction(_ sender: Any) {
        gotoDashBoardTabbarVC()
    }
    
    
}



extension LoadWebViewVC: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        if let response = navigationResponse.response as? HTTPURLResponse {
            print(response)
            
            if response.statusCode == 200 {
                openpaymentgatewaybool = true
            }
            
        }
        decisionHandler(.allow)
    }
    
    
    
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        openpaymentgatewaybool = true
        debugPrint("didCommit")
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        
        // Simulate a time-consuming operation
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            // Stop the activity indicator after 3 seconds (replace this with your actual data-fetching logic)
            self.activityIndicatorView.stopAnimating()
            self.webview.isUserInteractionEnabled = true
            
        }
        
        
        let str = webView.url?.absoluteString ?? ""
        
        if apicallbool == false {
            
            if str.containsIgnoringCase(find: "paymentcancel") || str.containsIgnoringCase(find: "CANCELED") || str.containsIgnoringCase(find: "bookingFailuer"){
                
                showAlertOnWindow(title: "",message: "Somthing Went Wrong",titles: ["OK"]) { title in
                    self.gotoDashBoardTabbarVC()
                }
            }else {
                
                
                if str.contains(find: "voucher") && str.contains(find: "show_voucher"){
                    gotoBookingConfirmedVC(url: webView.url?.absoluteString ?? "")
                }
                
                
                
            }
        }
        apicallbool = false
        
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        debugPrint("didFail")
    }
    
    
}

extension String {
    func contains(find: String) -> Bool{
        return self.range(of: find) != nil
    }
    func containsIgnoringCase(find: String) -> Bool{
        return self.range(of: find, options: .caseInsensitive) != nil
    }
}
