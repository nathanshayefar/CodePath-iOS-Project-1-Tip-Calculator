//
//  ViewController.swift
//  tips
//
//  Created by Nathan Shayefar on 1/6/15.
//  Copyright (c) 2015 nathanshayefar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var tipControl: UISegmentedControl!
    
    let currencyFormatter = NSNumberFormatter()
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

        tipControl.selectedSegmentIndex = SettingsHelper.getDefaultTipIndex()
        onEditingChanged(tipControl)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currencyFormatter.locale = NSLocale.currentLocale()
        currencyFormatter.numberStyle = .CurrencyStyle
        
        tipLabel.text = currencyFormatter.stringFromNumber(0)
        totalLabel.text = currencyFormatter.stringFromNumber(0)
        
        if let lastBillAmount = SettingsHelper.getLastBillAmount() {
            billField.text = lastBillAmount
        }
        
        // Makes it more obvious want the focus is on startup
        billField.becomeFirstResponder()
    }

    @IBAction func onEditingChanged(sender: AnyObject) {
        let billAmountString = billField.text as NSString
        SettingsHelper.setLastBillAmount(billAmountString)
        
        let tipPercentages = [0.18, 0.20, 0.22]
        let tipPercentage = tipPercentages[tipControl.selectedSegmentIndex]
        
        let billAmount = billAmountString.doubleValue
        let tip = billAmount * tipPercentage
        var total = billAmount + tip
        
        tipLabel.text = currencyFormatter.stringFromNumber(tip)
        totalLabel.text = currencyFormatter.stringFromNumber(total)
        
        fadeInTotal()
    }
    
    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
    }
    
    func fadeInTotal() {
        self.totalLabel.alpha = 0
        UIView.animateWithDuration(0.4, delay: 0.0, options: UIViewAnimationOptions.CurveEaseIn,
            animations: {
                self.totalLabel.alpha = 1
            }, completion: nil )
    }
}

