//
//  MyAccountVC.swift
//  Beeoons
//
//  Created by FCI on 08/08/23.
//

import UIKit
import Alamofire

class MyAccountVC: BaseTableVC {
    
    
    @IBOutlet weak var profilePic: UIImageView!
    @IBOutlet weak var profileHolderView: UIView!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var changeProfileView: UIView!
    
    var key = "noedit"
    var tablerow = [TableRow]()
    var pickerbool = false
    var first_name = String()
    var last_name = String()
    var address2 = String()
    var date_of_birth = String()
    var address = String()
    var phone = String()
    var email_id = String()
    var gender = String()
    var country_name = String()
    var state_name = String()
    var city_name = String()
    var pin_code = String()
    var country_code = String()
    var payload = [String:Any]()
    var vm:ProfileUpdateViewModel?
    
    
    override func viewWillAppear(_ animated: Bool) {
        
       
        
        NotificationCenter.default.addObserver(self, selector: #selector(offline), name: NSNotification.Name("offline"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(loginDone), name: NSNotification.Name("checkUserLogin"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(edit), name: NSNotification.Name("edit"), object: nil)

        checkUserLogin()
        
    }
    
    
    @objc func edit(){
        key = "edit"
        checkUserLogin()
    }
    
    @objc func offline(notificatio:UNNotification) {
        callapibool = true
        guard let vc = NoInternetConnectionVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: false)
    }
    
    func checkUserLogin() {
        let logstatus = defaults.bool(forKey: UserDefaultsKeys.loggedInStatus)
        if logstatus == true {
            TableViewHelper.EmptyMessage(message: "", tableview: commonTableView, vc: self)
            profileHolderView.isHidden = false
            loginBtn.isHidden = true
            if pickerbool == true {
                
            }else {
                callApi()
            }
            
        }else {
            profilePic.image = UIImage(named: "profile")?.withRenderingMode(.alwaysOriginal)
            profilePic.alpha = 0.5
            loginBtn.isHidden = false
            profileHolderView.isHidden = true
            tablerow.removeAll()
            TableViewHelper.EmptyMessage(message: "", tableview: commonTableView, vc: self)
            commonTVData = tablerow
            commonTableView.reloadData()
        }
    }
    
    @objc func loginDone() {
        checkUserLogin()
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupTV()
        vm = ProfileUpdateViewModel(self)
    }
    
    func setupTV() {
        
        self.changeProfileView.isHidden = true
        loginBtn.isHidden = false
        loginBtn.addBottomBorderWithColor(color: .AppBorderColor, width: 1)
        commonTableView.registerTVCells(["UserNameTextFieldTVCell",
                                         "EmptyTVCell",
                                         "ButtonTVCell"])
        appendMyaccountTvcells()
    }
    
    
    
    func appendMyaccountTvcells() {
        tablerow.removeAll()
        
        tablerow.append(TableRow(title:"First Name",
                                 subTitle: profildata?.first_name ?? "",
                                 key: "name",
                                 buttonTitle: "Enter First Name*",
                                 key1: "noedit",
                                 cellType:.UserNameTextFieldTVCell))
        
        tablerow.append(TableRow(title:"Last Name",
                                 subTitle: profildata?.last_name ?? "",
                                 key: "name",
                                 buttonTitle: "Enter Last Name*",
                                 key1: "noedit",
                                 cellType:.UserNameTextFieldTVCell))
        
        
        tablerow.append(TableRow(title:"Email Address",
                                 subTitle: profildata?.email ?? "",
                                 key: "name",
                                 buttonTitle: "Enter Email Address*",
                                 key1: "noedit",
                                 cellType:.UserNameTextFieldTVCell))
        
        
        tablerow.append(TableRow(title:"Mobile Number",
                                 subTitle: profildata?.phone ?? "",
                                 key: "mobile",
                                 buttonTitle: "Enter Mobile*",
                                 key1: "noedit",
                                 cellType:.UserNameTextFieldTVCell))
        
        tablerow.append(TableRow(title:"Date Of Birth",
                                 subTitle: profildata?.date_of_birth ?? "",
                                 key: "dob",
                                 buttonTitle: "Enter Date Of Birth*",
                                 key1: "noedit",
                                 cellType:.UserNameTextFieldTVCell))
        
        
        commonTVData = tablerow
        commonTableView.reloadData()
        
    }
    
    
    
    func appendEditProfileTvcells() {
        tablerow.removeAll()
        
        tablerow.append(TableRow(title:"First Name",
                                 subTitle: profildata?.first_name ?? "",
                                 key: "name",
                                 buttonTitle: "Enter First Name*",
                                 key1: "edit",
                                 characterLimit: 1,
                                 cellType:.UserNameTextFieldTVCell))
        
        tablerow.append(TableRow(title:"Last Name",
                                 subTitle: profildata?.last_name ?? "",
                                 key: "name",
                                 buttonTitle: "Enter Last Name*",
                                 key1: "edit",
                                 characterLimit: 2,
                                 cellType:.UserNameTextFieldTVCell))
        
        
        tablerow.append(TableRow(title:"Email Address",
                                 subTitle: profildata?.email ?? "",
                                 key: "name",
                                 buttonTitle: "Enter Email Address*",
                                 key1: "edit",
                                 characterLimit: 3,
                                 cellType:.UserNameTextFieldTVCell))
        
        
        tablerow.append(TableRow(title:"Mobile Number",
                                 subTitle: profildata?.phone ?? "",
                                 key: "mobile",
                                 buttonTitle: "Enter Mobile*",
                                 key1: "edit",
                                 characterLimit: 4,
                                 cellType:.UserNameTextFieldTVCell))
        
        tablerow.append(TableRow(title:"Date Of Birth",
                                 subTitle: profildata?.date_of_birth ?? "",
                                 key: "dob",
                                 buttonTitle: "Enter Date Of Birth*",
                                 key1: "edit",
                                 characterLimit: 5,
                                 cellType:.UserNameTextFieldTVCell))
        
        
        
        tablerow.append(TableRow(height:20,cellType:.EmptyTVCell))
        tablerow.append(TableRow(title:"UPDATE",bgColor: .ButtonColor,cellType:.ButtonTVCell))
        tablerow.append(TableRow(height:50,cellType:.EmptyTVCell))
        
        commonTVData = tablerow
        commonTableView.reloadData()
        
    }
    
    
    
    
    override func editingTextField(tf: UITextField) {
        
        print(tf.text ?? "")
        switch tf.tag {
        case 1:
            first_name = tf.text ?? ""
            break
            
        case 2:
            last_name = tf.text ?? ""
            break
            
        case 4:
            date_of_birth = tf.text ?? ""
            break
            
            
            
        default:
            break
        }
    }
    
    
    
    override func donedatePicker(cell:UserNameTextFieldTVCell){
        date_of_birth = convertDateFormat(inputDate: cell.txtField.text ?? "", f1: "dd/MM/yyyy", f2: "yyyy-MM-dd")
        self.view.endEditing(true)
    }
    
    override func cancelDatePicker(cell:UserNameTextFieldTVCell){
        self.view.endEditing(true)
    }
    
    
    override func didTapOnBnAction(cell: ButtonTVCell){
        
        if first_name.isEmpty == true {
            showToast(message: "Enter First Name")
        }else  if last_name.isEmpty == true {
            showToast(message: "Enter Last Name")
        }else  if date_of_birth.isEmpty == true {
            showToast(message: "Enter Date Of Birth ")
        }
        //        else if phone.isEmpty == true {
        //            showToast(message: "Enter Mobile Number")
        //        }
        //        else if gender.isEmpty == true {
        //            showToast(message: "Enter Gender")
        //        }else  if address.isEmpty == true {
        //            showToast(message: "Enter Address")
        //        }else  if country_name.isEmpty == true {
        //            showToast(message: "Enter Country Name ")
        //        }else if state_name.isEmpty == true {
        //            showToast(message: "Enter State Name")
        //        }else if city_name.isEmpty == true {
        //            showToast(message: "Enter City Name")
        //        }else if pin_code.isEmpty == true {
        //            showToast(message: "Enter Pin Code")
        //        }
        
        else {
            
            callUpdateProfileAPI()
        }
    }
    
    @objc func didTapOnBackBtn(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    
    @IBAction func didTapOnLoginToViewBtnAction(_ sender: Any) {
        guard let vc = LoginVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        vc.isvcFrom = "menu"
        callapibool = true
        present(vc, animated: true)
    }
    
    
    @IBAction func didTapOnChangePictureBtnAction(_ sender: Any) {
        let alert = UIAlertController(title: "Choose To Open", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Open Gallery", style: .default){ (action) in
            self.openGallery()
        })
        alert.addAction(UIAlertAction(title: "Open Camera", style: .default){ (action) in
            self.openCemera()
        })
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel){ (action) in
        })
        
        self.present(alert, animated: true, completion: nil)
    }
    
    
    @IBAction func didTapOnEditProfile(_ sender: Any) {
        changeProfileView.isHidden = false
        appendEditProfileTvcells()
    }
    
}



extension MyAccountVC:UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        
        if let tempImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            self.profilePic.image = tempImage
        }
        
        self.pickerbool = true
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    func openGallery() {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary){
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
            self.present(imagePicker, animated: true, completion: nil)
        } else {
            let alert  = UIAlertController(title: "Warning", message: "You don't have permission to access gallery.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    
    func openCemera() {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera){
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            imagePicker.sourceType = UIImagePickerController.SourceType.camera
            self.present(imagePicker, animated: true, completion: nil)
        } else {
            let alert  = UIAlertController(title: "Warning", message: "You don't have camera.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    
    
    
}



extension MyAccountVC:ProfileUpdateViewModelDelegate {
    
    func callApi() {
        payload.removeAll()
        payload["user_id"] = defaults.string(forKey: UserDefaultsKeys.userid)
        vm?.CALL_SHOW_PROFILE_API(dictParam: payload)
    }
    
    
    func profileDetails(response: ProfileUpdateModel) {
        profildata = response.data
        self.changeProfileView.isHidden = true
        
        first_name = profildata?.first_name ?? ""
        last_name = profildata?.last_name ?? ""
        email_id = profildata?.email ?? ""
        date_of_birth = profildata?.date_of_birth ?? ""
        address = profildata?.address ?? ""
        address2 = profildata?.address2 ?? ""
        city_name = profildata?.city_name ?? ""
        state_name = profildata?.state_name ?? ""
        country_name = profildata?.country_name ?? ""
        pin_code = profildata?.pin_code ?? ""
        gender = profildata?.gender ?? ""
        country_code = profildata?.country_code ?? ""
        phone = profildata?.phone ?? ""
        
        if profildata?.image == "" {
            self.profilePic.image = UIImage(named: "profile")
            self.profilePic.alpha = 0.5
        }else {
            self.profilePic.sd_setImage(with: URL(string: profildata?.image ?? ""), placeholderImage:UIImage(contentsOfFile:"placeholder.png"))
            self.profilePic.alpha = 1
            
        }
        
        if key == "noedit" {
            DispatchQueue.main.async {[self] in
                appendMyaccountTvcells()
            }
        }else {
            DispatchQueue.main.async {[self] in
                appendEditProfileTvcells()
            }
        }
        
    }
}



extension MyAccountVC {
    
    func callUpdateProfileAPI() {
        self.vm?.view.showLoader()
        payload.removeAll()
        payload["user_id"] = defaults.string(forKey: UserDefaultsKeys.userid)
        payload["first_name"] = first_name
        payload["last_name"] = last_name
        payload["date_of_birth"] = date_of_birth
        payload["address"] = address
        payload["address2"] = address2
        payload["phone"] = phone
        payload["gender"] = gender
        payload["country_name"] = country_name
        payload["state_name"] = state_name
        payload["city_name"] = city_name
        payload["pin_code"] = pin_code
        payload["country_code"] = country_code
        
        
        // Create a multipart form data request using Alamofire
        AF.upload(multipartFormData: { multipartFormData in
            // Append the parameters to the request
            for (key, value) in self.payload {
                multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key)
            }
            
            // Append the image to the request
            if let imageData = self.profilePic?.image?.jpegData(compressionQuality: 0.4) {
                multipartFormData.append(imageData, withName: "image", fileName: "example.jpg", mimeType: "image/jpeg")
            }
        }, to: BASE_URL + ApiEndpoints.updatemobileprofile ).responseDecodable(of: ProfileUpdateModel.self) { response in
            // Handle the response
            switch response.result {
            case .success(let profileUpdateModel):
                // Handle success
                // self.vm?.view.hideLoader()
                self.showToast(message: profileUpdateModel.msg ?? "")
                
                defaults.set(profileUpdateModel.data?.image ?? "", forKey: UserDefaultsKeys.userimg)
                defaults.set("\(profileUpdateModel.data?.first_name ?? "") \(profileUpdateModel.data?.last_name ?? "")", forKey: UserDefaultsKeys.userimg)
                self.changeProfileView.isHidden = true
                
                let seconds = 2.0
                DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
                    self.appendMyaccountTvcells()
                    NotificationCenter.default.post(name: NSNotification.Name("callprofile"), object: nil)
                    //                    self.dismiss(animated: true)
                }
                
            case .failure(let error):
                // Handle error
                print("Upload failure: \(error.localizedDescription)")
            }
        }
        
        
        
    }
}
