//
//  CommonFunctions.swift
//  Beeoons
//
//  Created by FCI on 10/08/23.
//

import Foundation
import UIKit



//MARK: - INITIAL SETUP LABELS
func setuplabels(lbl:UILabel,text:String,textcolor:UIColor,font:UIFont,align:NSTextAlignment) {
    lbl.text = text
    lbl.textColor = textcolor
    lbl.font = font
    lbl.numberOfLines = 0
    lbl.textAlignment = align
}

//MARK: - convert Date Format
func convertDateFormat(inputDate: String,f1:String,f2:String) -> String {
    
    let olDateFormatter = DateFormatter()
    olDateFormatter.dateFormat = f1
    
    guard let oldDate = olDateFormatter.date(from: inputDate) else { return "" }
    
    let convertDateFormatter = DateFormatter()
    convertDateFormatter.dateFormat = f2
    
    return convertDateFormatter.string(from: oldDate)
}


//MARK: - check Departure And Return Dates
func checkDepartureAndReturnDates1(_ parameters: [String: Any],p1:String) -> Bool {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "dd-MM-yyyy"
    
    guard let departureDateStr = parameters[p1] as? String,
          let departureDate = dateFormatter.date(from: departureDateStr)
    else {
        print("Invalid date format")
        return false
    }
    
    let calendar = Calendar.current
    let currentDate = Date()
    
    if calendar.isDateInTomorrow(departureDate) {
        print("Departure is tomorrow's date")
        return true
    } else if departureDate > currentDate {
        print("Departure is a future date")
        return true
    } else {
        print("Departure is not a future or tomorrow's date")
        return false
    }
    
    
}


//MARK: - check Departure And Return Dates
func checkDepartureAndReturnDates(_ parameters: [String: Any],p1:String,p2:String) -> Bool {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "dd-MM-yyyy"
    
    guard let departureDateStr = parameters[p1] as? String,
          let returnDateStr = parameters[p2] as? String,
          let departureDate = dateFormatter.date(from: departureDateStr),
          let returnDate = dateFormatter.date(from: returnDateStr) else {
        print("Invalid date format")
        return false
    }
    
    let calendar = Calendar.current
    let currentDate = Date()
    
    if calendar.isDateInTomorrow(departureDate) {
        print("Departure is tomorrow's date")
        return true
    } else if departureDate > currentDate {
        print("Departure is a future date")
        return true
    } else {
        print("Departure is not a future or tomorrow's date")
        return false
    }
    
    if calendar.isDateInTomorrow(returnDate) {
        print("Return is tomorrow's date")
        return true
    } else if returnDate > currentDate {
        print("Return is a future date")
        return true
    } else {
        print("Return is not a future or tomorrow's date")
        return false
    }
}


//MARK: -  TimerManager
//protocol TimerManagerDelegate: AnyObject {
//    func timerDidFinish()
//    func updateTimer()
//}
//
//class TimerManager {
//    static let shared = TimerManager() // Singleton instance
//    weak var delegate: TimerManagerDelegate?
//
//    var timer: Timer?
//    var totalTime = 1
//    private var backgroundTask: UIBackgroundTaskIdentifier = .invalid
//
//    private init() {}
//
//    func startTimer() {
//
//
//        endBackgroundTask() // End any existing background task (if any)
//        backgroundTask = UIApplication.shared.beginBackgroundTask { [weak self] in
//            self?.endBackgroundTask()
//        }
//
//        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
//        RunLoop.current.add(timer!, forMode: RunLoop.Mode.common)
//
//
//    }
//
//    @objc func updateTimer() {
//        if totalTime != 0 {
//            totalTime -= 1
//            delegate?.updateTimer()
//        } else {
//            sessionStop()
//            delegate?.timerDidFinish()
//            endBackgroundTask()
//        }
//    }
//
//    @objc func sessionStop() {
//        if let timer = timer {
//            timer.invalidate()
//            self.timer = nil
//        }
//    }
//
//    private func endBackgroundTask() {
//        guard backgroundTask != .invalid else { return }
//        UIApplication.shared.endBackgroundTask(backgroundTask)
//        backgroundTask = .invalid
//    }
//}





//MARK: -  TimerManager
protocol TimerManagerDelegate: AnyObject {
    func timerDidFinish()
    func updateTimer()
}

class TimerManager {
    static let shared = TimerManager() // Singleton instance
    weak var delegate: TimerManagerDelegate?
    
    private var timer: Timer?
     var totalTime = 1
    private var backgroundTask: UIBackgroundTaskIdentifier = .invalid
    
    private init() {}
    
    func startTimer() {
        endBackgroundTask() // End any existing background task (if any)
        backgroundTask = UIApplication.shared.beginBackgroundTask { [weak self] in
            self?.endBackgroundTask()
        }
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    @objc private func updateTimer() {
        if totalTime != 0 {
            totalTime -= 1
            delegate?.updateTimer()
        } else {
            sessionStop()
            delegate?.timerDidFinish()
            endBackgroundTask()
        }
    }
    
    func stopTimer() {
        sessionStop()
        endBackgroundTask()
    }
    
     func sessionStop() {
        timer?.invalidate()
        timer = nil
    }
    
    private func endBackgroundTask() {
        guard backgroundTask != .invalid else { return }
        UIApplication.shared.endBackgroundTask(backgroundTask)
        backgroundTask = .invalid
    }
}




//MARK: - convertUnitString
func convertUnitString(_ input: String) -> String {
    let components = input.components(separatedBy: " ")
    
    guard components.count == 2 else {
        return input
    }
    
    let value = components[0]
    let unit = components[1]
    
    var convertedValue = value
    var convertedUnit = unit
    
    switch unit {
    case "Kilograms", "kilogram":
        convertedValue = value
        convertedUnit = "KG"
    case "Pieces", "piece":
        convertedValue = value
        convertedUnit = "PC"
    default:
        break
    }
    
    return "\(convertedValue) \(convertedUnit)"
}

