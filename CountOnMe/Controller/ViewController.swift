//
//  ViewController.swift
//  SimpleCalc
//
//  Created by Vincent Saluzzo on 29/03/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let simpleCalc = SimpleCalc()
    
    // MARK: - Outlets
    
    @IBOutlet weak var textView: UITextView!
    @IBOutlet var numberButtons: [UIButton]!
    
    // View Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(displayCalcul(notification:)), name: Notification.Name("updateDisplay"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(displayAlert(notification:)), name: Notification.Name("alertDisplay"), object: nil)
    }
    
    // MARK: - Methods
    
    @objc func displayCalcul(notification: Notification) {
        guard let userInfo = notification.userInfo else { return }
        textView.text = userInfo["updateDisplay"] as? String
    }
    

    // Method called to display alert message
    @objc func displayAlert(notification: Notification) {
        guard let userInfo = notification.userInfo else { return }
        guard let errorMessage = userInfo["message"] as? String else { return }
        createAlert(message: errorMessage)
    }
    
    // Method called to create an alert
    func createAlert(message: String) {
        let alertVC = UIAlertController(title: "Alert!", message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
    
    // MARK: - View actions
    
    @IBAction func tappedNumberButton(_ sender: UIButton) {
        guard let numberText = sender.title(for: .normal) else {
            return
        }
        simpleCalc.tappedNumberButton(numberText: numberText)
    }
    
    @IBAction func tappedEqualButton(_ sender: UIButton) {
        simpleCalc.tappedEqualButton()
    }
    
    @IBAction func tappedACButton(_ sender: UIButton) {
        simpleCalc.clear()
    }
    
    
    @IBAction func tappedAdditionButton(_ sender: UIButton) {
        simpleCalc.additionButtonTaped()
    }
    
    @IBAction func tappedSubstractionButton(_ sender: UIButton) {
        simpleCalc.substractionButtonTaped()
    }

    @IBAction func tappedMultiplicationButton(_ sender: UIButton) {
        simpleCalc.multiplicationButtonTaped()
    }
        
    @IBAction func tappedDivisionButton(_ sender: UIButton) {
        simpleCalc.divisionButtonTaped()
    }
    
}

