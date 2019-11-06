//
//  TRPTimePickerView.swift
//  TRPUIKit
//
//  Created by Rozeri Dağtekin on 11/4/19.
//  Copyright © 2019 Evren Yaşar. All rights reserved.
//

//Custom Time Picker View Class

import UIKit

public protocol TRPTimePickerViewProtocol {
    func timePickerDidSelectRow(selectedHour:String?, timeType: TimeFieldType?)
    func toolBarButtonPressed(selectedHour:String?, timeType: TimeFieldType?)
}

public enum TimeFieldType: Int{
     case start,end
 }

public class TRPTimePickerView: UIPickerView {
    
    //MARK: - Variables
    private var hours: [String] = ["00:00", "01:00", "02:00", "03:00", "04:00", "05:00", "06:00", "07:00", "08:00", "09:00", "10:00", "11:00", "12:00", "13:00", "14:00", "15:00", "16:00", "17:00", "18:00", "19:00", "20:00", "21:00", "22:00", "23:00"]
    
    private var tmpHours: [String] = []
    private var defaultHour: String = ""
    private var selectedHour: String = ""
    private var timeType: TimeFieldType?
    
    public static let lastStartHour = "23:00"
    public static let lastEndHour = "23:45"
    
    //MARK: - Delegate
    public var timePickerDelegate:TRPTimePickerViewProtocol?
    
    private var timeToolBar: UIToolbar = {
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.sizeToFit()
        return toolBar
    }()
    
    //MARK: - Initialization
    public override init(frame:CGRect){
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Private Functions
    private func commonInit() {
        if(hours.count > 23){
            tmpHours = hours
        }
    }
    
    //MARK: - ObjC Functions
    @objc func applyButtonOfTimePressed() {
        timePickerDelegate?.toolBarButtonPressed(selectedHour: selectedHour, timeType: timeType)
    }
    
    
    
}

//MARK: - Delegate & DataSource functions
extension TRPTimePickerView: UIPickerViewDataSource, UIPickerViewDelegate{
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return hours.count
    }
    
    public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedHour = hours[row]
        timePickerDelegate?.timePickerDidSelectRow(selectedHour: selectedHour, timeType: timeType)
    }
    
    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return hours[row]
    }
}

//MARK: - Calculation functions
extension TRPTimePickerView{
    public func setMinVal(in minVal: Int) {
        if(hours.count < 23){
         hours = tmpHours
        }
        if(minVal == 23){
            hours = ["23:45"]
        }else{
            hours.removeSubrange(ClosedRange(uncheckedBounds: (lower: 0, upper: minVal)))
        }
        reloadAllComponents()
    }
    
    public func setMinVal(in minVal: String){
        if minVal.count != 0, minVal.contains(":"){
            let newTime = minVal.components(separatedBy: ":")
            if newTime.count == 2 {
                if let hour = Int(newTime[0]){
                      setMinVal(in: hour)
                }
            }
        }
    }
    
    public func setDefaultVal(with defaultVal: Int) {
        defaultHour = hours[defaultVal]
        self.selectRow(defaultVal, inComponent: 0, animated: false)
    }
    
    public func setDefaultVal(with defaultVal: String) {
        defaultHour = defaultVal
        guard let index = hours.firstIndex(of: defaultVal) else {
            return
        }
        self.selectRow(index, inComponent: 0, animated: false)
    }
    
    public func getdefaultVal() -> String? {
        return defaultHour
    }
    
    public func getToolBar(with buttonTitle: String, _ buttonTintColor: UIColor? = nil) -> UIToolbar{
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let applyTitle = buttonTitle
        let applyButton = UIBarButtonItem(title: applyTitle, style: UIBarButtonItem.Style.done, target: self, action: #selector(applyButtonOfTimePressed))
        if let color = buttonTintColor{
            applyButton.tintColor = color
        }else{
            applyButton.tintColor = TRPColor.pink
        }
        timeToolBar.items = [spaceButton,applyButton]
        return timeToolBar
    }
    
    public func setTimeFieldType(with type:TimeFieldType){
        timeType = type
        setDefaultTime(with: type)
    }
    
    private func setDefaultTime(with type: TimeFieldType){
        switch type {
        case TimeFieldType.start:
            setDefaultVal(with: 9)
        default:
            setDefaultVal(with: 21)
        }
    }
    
    public func getTimeFieldType() -> TimeFieldType?{
        return timeType
    }
}

//MARK: - Toolbar functions
extension TRPTimePickerView{
    public func setToolBarRightText(with text: String) {
        
    }
}

