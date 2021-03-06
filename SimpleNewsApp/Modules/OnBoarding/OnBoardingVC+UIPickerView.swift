//
//  OnBoardingVC+UIPickerView.swift
//  SimpleNewsApp
//
//  Created by Muhammad Adam on 12/17/20.
//

import UIKit

extension OnBoardingVC: UIPickerViewDelegate, UIPickerViewDataSource{
    
    func setupCountriesPicker() {
        countryPicker.delegate = self
        countryPicker.dataSource = self
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        presenter.getCountriesCount()
    }
    

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        presenter.country(atIndex: row)
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        presenter.didSelectCountry(index: row)
    }
}
