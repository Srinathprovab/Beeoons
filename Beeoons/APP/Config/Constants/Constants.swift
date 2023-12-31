//
//  Constants.swift
//  DoorcastRebase
//
//  Created by U Dinesh Kumar Reddy on 04/05/22.
//

import Foundation
import UIKit
import CoreData


/*SETTING USER DEFAULTS*/
let defaults = UserDefaults.standard

let loginResponseDefaultKey = "LoginResponse"
let KPlatform = "Platform"
let KPlatformValue = "iOS"
let KContentType = "Content-Type"
let KContentTypeValue = "application/x-www-form-urlencoded"
let KAccept = "Accept"
let KAcceptValue = "application/json"
let KAuthorization = "Authorization"
//let KDEVICE_ID = "DEVICE_ID"
let KAccesstoken = "Accesstoken"
let KAccesstokenValue = ""
var key = ""
let screenHeight = UIScreen.main.bounds.size.height
//var data : Data?
var loderBool = true
var callapibool = false
var menubool = false
var mobilenoMaxLengthBool = false

var BASE_URL = "https://beeoons.com/web_service/index.php/"
var BASE_URL1 = "https://beeoons.com/web_service/index.php/"
var countrylist = [Country_list]()
var profildata:ProfileUpdateData?

//index page
var topflightDest = [Flight_top_destinations1]()
var topdesthotel = [Top_dest_hotel]()
var flight_hotel_top_destinations = [Flight_hotel_top_destinations]()

var indeximagepath = String()
var currencylist = [Currency_list]()
var airlinelist1 = [Airline_list]()


//Filters
var filterModel = FlightFilterModel()
var sortBy: SortParameter = .nothing
var hotelfiltermodel = HotelFilterModel()


//Multicity
var fromCityNameArray = ["From","From"]
var fromCityShortNameArray = ["From","From"]
var toCityNameArray = ["To","To"]
var toCityShortNameArray = ["To","To"]
var calDate = ["Date","Date"]
var calDateYearArray = ["Date","Date"]
var depatureDatesArray = ["",""]
var fromlocidArray = ["",""]
var tolocidArray = ["",""]
var fromCityArray = ["",""]
var toCityArray = ["",""]

//Flight Result
var selectedAccesskey = ""
var searchid = ""
var bookingsource = ""
var bookingsourcekey = String()
var selectedResult = ""
var cityCodes = ""

//FlightDetails
var fd = [[FlightDetails]]()
var bggAllowance = [BaggageAllowance]()
var farepricedetails:PriceDetails?
var fareRulesData = [FareRulehtml]()
var fareRulesData1 = [FareRuleData]()

var Adults_Base_Price = String()
var Adults_Tax_Price = String()
var Childs_Base_Price = String()
var Childs_Tax_Price = String()
var Infants_Base_Price = String()
var Infants_Tax_Price = String()
var TotalPrice_API = String()
var grandTotal = String()
var subtotal = String()
var AdultsTotalPrice = String()
var ChildTotalPrice = String()
var InfantTotalPrice = String()
var sub_total_adult : String?
var sub_total_child : String?
var sub_total_infant : String?

//Contact Info
var countryCode = String()
var billingCountryCode = String()
var billingCountryName = String()
var email = String()
var mobile = String()


//paynow
var travelerArray: [Traveler] = []
var ageCategory: AgeCategory = .adult
var checkTermsAndCondationStatus = false



//MARK: - FILTERS
var prices = [String]()
var noofStopsA = [String]()
var fareTypeA = [String]()
var airlinesA = [String]()
var cancellationsTypeA = [String]()
var connectingFlightsA = [String]()
var connectingAirportA = [String]()
var departureTimeA = [String]()
var arrivalTimeA = [String]()



//MARK: - Hotel
var adtArray = [String]()
var chArray = [String]()
var hotelDetailsTapBool = true
var totalRooms = 0
var totalAdults = 0
var totalChildren = 0
var oldjournyType = ""
var hotel_id = String()
var hotelsearchid = String()
var hotelbookingsource = String()

/* URL endpoints */
struct ApiEndpoints {
    
    //FLIGHT
    static let indexpage = "general/index"
    static let indexpageapi = "general/index"
    static let get_airport_code_list = "ajax/get_airport_code_list"
    static let mobilepreflightsearch = "general/mobile_pre_flight_search"
    static let getFlightDetails = "flight/getFlightDetails"
    static let mobile_register_on_light_box = "auth/mobile_register_on_light_box"
    static let auth_forgot_password = "auth/forgot_password"
    static let countrylist = "flight/country_list"
    static let getAirlineList = "general/getAirlineList"
    static let authmobile_login = "auth/mobile_login"
    static let authajax_logout = "auth/ajax_logout"
    static let updatemobileprofile = "user/mobile_profile"
    static let flight_mobile_pre_process_booking = "flight/mobile_pre_process_booking"
    static let processpassengerdetail = "flight/mobile_process_passenger_detail"
    static let prebooking = "flight/mobile_pre_booking"
    static let prepaymentconfirmation = "flight/pre_payment_confirmation/"
    static let sendtopayment = "flight/send_to_payment/"
    static let securebooking = "flight/secure_booking/"
    static let flight_get_country = "flight/get_country"
    static let get_state_list_by_country_iso = "general/get_state_list_by_country_iso"
    static let get_city_list_by_state_name = "general/get_city_list_by_state_name"

    
    
    //HOTEL
    static let general_mobile_pre_hotel_search = "general/mobile_pre_hotel_search"
    static let hotel_mobile_details = "hotel/mobile_details"
    
    
    
}

/*App messages*/
struct Message {
    static let internetConnectionError = "Please check your connection and try reconnecting to internet"
    static let sessionExpired = "Your session has been expired, please login again"
}


/*USER ENTERED DETAILS DEFAULTS*/

struct UserDefaultsKeys {
    
    static var mobilecountrycode = "mobilecountrycode"
    static var mobilecountryname = "mobilecountryname"
    static var tabselect = "tabselect"
    static var userLoggedIn = "userLoggedIn"
    static var loggedInStatus = "loggedInStatus"
    static var userid = "userid"
    static var username = "username"
    static var userimg = "userimg"
    static var journeyType = "Journey_Type"
    static var itinerarySelectedIndex = "ItinerarySelectedIndex"
    static var selectedCurrency = "selectedCurrency"
    static var totalTravellerCount = "totalTravellerCount"
    static var select_classIndex = "select_classIndex"
    static var rselect_classIndex = "rselect_classIndex"
    static var mselect_classIndex = "mselect_classIndex"
    static var journeyCitys = "journeyCitys"
    static var journeyDates = "journeyDates"
    static var cellTag = "cellTag"
    
    
    
    
    //ONE WAY
    static var fromCity = "fromCity"
    static var toCity = "toCity"
    static var calDepDate = "calDepDate"
    static var calRetDate = "calRetDate"
    static var adultCount = "Adult_Count"
    static var childCount = "Child_Count"
    static var hadultCount = "HAdult_Count"
    static var hchildCount = "HChild_Count"
    static var infantsCount = "Infants_Count"
    static var selectClass = "select_class"
    static var fromlocid = "from_loc_id"
    static var tolocid = "to_loc_id"
    static var fromcityname = "fromcityname"
    static var tocityname = "tocityname"
    
    //ROUND TRIP
    static var rlocationcity = "rlocation_city"
    static var rfromCity = "rfromCity"
    static var rtoCity = "rtoCity"
    static var rcalDepDate = "rcalDepDate"
    static var rcalRetDate = "rcalRetDate"
    static var radultCount = "rAdult_Count"
    static var rchildCount = "rChild_Count"
    static var rhadultCount = "rHAdult_Count"
    static var rhchildCount = "rHChild_Count"
    static var rinfantsCount = "rInfants_Count"
    static var rselectClass = "rselect_class"
    static var rfromlocid = "rfrom_loc_id"
    static var rtolocid = "rto_loc_id"
    static var rfromcityname = "rfromcityname"
    static var rtocityname = "rtocityname"
    
    
    //MULTICITY TRIP
    static var mlocationcity = "mlocation_city"
    static var mfromCity = "mfromCity"
    static var mtoCity = "mtoCity"
    static var mcalDepDate = "mcalDepDate"
    static var mcalRetDate = "mcalRetDate"
    static var madultCount = "mAdult_Count"
    static var mchildCount = "mChild_Count"
    static var mhadultCount = "mHAdult_Count"
    static var mhchildCount = "mHChild_Count"
    static var minfantsCount = "mInfants_Count"
    static var mselectClass = "mselect_class"
    static var mfromlocid = "mfrom_loc_id"
    static var mtolocid = "mto_loc_id"
    static var mfromcityname = "mfromcityname"
    static var mtocityname = "mtocityname"
    
    
    //Hotel
    static var locationcity = "location_city"
    static var locationid = "location_id"
    static var hoteladultCount = "HotelAdult_Count"
    static var hotelchildCount = "HotelChild_Count"
    static var cityid = "cityid"
    static var htravellerDetails = "htraveller_Details"
    static var roomType = "Room_Type"
    static var refundtype = "refundtype"
    
    
    static var select = "select"
    static var checkin = "check_in"
    static var checkout = "check _out"
    static var addTarvellerDetails = "addTarvellerDetails"
    static var travellerDetails = "traveller_Details"
    static var rtravellerDetails = "rtraveller_Details"
    static var mtravellerDetails = "mtraveller_Details"
    static var roomcount = "room_count"
    static var hoteladultscount = "hotel_adults_count"
    static var hotelchildcount = "hotel_child_count"
    static var guestcount = "guestcount"
    static var selectPersons = "selectPersons"
    static var kwdprice = "kwdprice"
    
}


struct sessionMgrDefaults {
    
    static var userLoggedIn = "username"
    static var loggedInStatus = "email"
    static var globalAT = "mobile_no"
    static var Base_url = "accesstoken"
}



/*LOCAL JSON FILES*/
struct LocalJsonFiles {
    
}
