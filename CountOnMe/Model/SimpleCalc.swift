//
//  SimpleCalc.swift
//  CountOnMe
//
//  Created by Adeline GIROIX on 02/04/2021.
//  Copyright © 2021 Vincent Saluzzo. All rights reserved.
//

import Foundation


class SimpleCalc {
    
    // MARK: - Proprietes
    
    var calculText: String = "1 + 1 = 2" {
        didSet {
            NotificationCenter.default.post(name: Notification.Name("updateDisplay"), object: nil, userInfo: ["updateDisplay":calculText])
        }
    } // end of: var calculText: String = "1 + 1 = 2" {
    
    /// This array contains each element of the expression
    var elements: [String] {
        return calculText.split(separator: " ").map { "\($0)" }
    } // end of: var elements: [String] {
    
    /// Used to trap division by zero
    var flagDivisionOperator: Bool = false
    var isDivisionByZero:Bool = false

    let initCurrentIndexInCalcultext: Int = -1
    var currentIndexInCalcultext: Int
    let initMemIndexAfterDivisionOperatorInCalcultext = 0
    var memIndexAfterOperatorInsertionInCalcultext:Int
    
    /// Method that check if the expression do not finish by an operator.
    var isExpressionCorrect: Bool {
        return elements.last != "+" && elements.last != "-" && elements.last != "x" && elements.last != "/"
    } // end of: var isExpressionCorrect: Bool {
    
    /// Checks if there is at least 3 elements in the expression
    var expressionHaveEnoughElement: Bool {
        return elements.count >= 3
    } // end of: var expressionHaveEnoughElement: Bool {
    
    /// Check if a number has been entered.
    var emptyScreen: Bool {
        //print(elements.count)
        return elements.count == 0
    } // end of: var emptyScreen: Bool {
    
    /// Boolean used to check if there's a result already done.
    var isExpressionHaveResult: Bool {
        return calculText.contains("=")
    } // end of: var isExpressionHaveResult: Bool {
    
    /// Check if expression contains " x" or " / ".
    var priorityOperator: Bool {
        return (elements.contains("x") || elements.contains( "/"))
    } // end of: var priorityOperator: Bool {
    
    // MARK: - Methods
    
    /// Send notification with a customed message for errors
    private func sendAlertNotification(message: String) {
        let name = Notification.Name("alertDisplay")
        NotificationCenter.default.post(name: name, object: nil, userInfo: ["message": message])
    } // end of: private func sendAlertNotification(message: String) {
    
    init() {
        self.currentIndexInCalcultext = self.initCurrentIndexInCalcultext
        self.memIndexAfterOperatorInsertionInCalcultext = initMemIndexAfterDivisionOperatorInCalcultext
    } // end of: init() {

    /// Append a number
    func tappedNumberButton(numberText: String) {
        refreshCalcul()
        calculText.append(numberText)
        
        currentIndexInCalcultext += 1
    } // end of: func tappedNumberButton(numberText: String) {
 
    /// Methods for each operator , which operator buttons are registered
    func additionButtonTaped() {
        if flagDivisionOperator {
            isDivisionByZero = checkTheCaseOfDivisionByOperandNul(anyOperator: " + ")
        }
        if !isDivisionByZero {
            operatorTaped(anyOperator: " + ")
        }
    } // end of: func additionButtonTaped() {

    func substractionButtonTaped() {
        if flagDivisionOperator {
            isDivisionByZero = checkTheCaseOfDivisionByOperandNul(anyOperator: " - ")
        }
        if !isDivisionByZero {
            operatorTaped(anyOperator: " - ")
        }
    } // end of: func substractionButtonTaped() {
    
    func multiplicationButtonTaped() {
        if flagDivisionOperator {
            isDivisionByZero = checkTheCaseOfDivisionByOperandNul(anyOperator: " x ")
        }
        if !isDivisionByZero {
            operatorTaped(anyOperator: " x ")
        }
    } // end of: func multiplicationButtonTaped() {

    func divisionButtonTaped() {
        if flagDivisionOperator {
            isDivisionByZero = checkTheCaseOfDivisionByOperandNul(anyOperator: " / ")
        }
        if !isDivisionByZero {
            operatorTaped(anyOperator: " / ")
        }
    } // end of: func divisionButtonTaped() {
    
    /// Append an operator
    func operatorTaped(anyOperator: String) {
                
        refreshCalcul()
        
        if emptyScreen {
            sendAlertNotification(message: "Commencez par un opérande !")
            return calculText = String()
            
        } else {
        
            if isExpressionCorrect {
                calculText.append(anyOperator)
                
                self.currentIndexInCalcultext += 3
                
                flagDivisionOperator = anyOperator == " / " ? true : false
                
            } else { // Operateur en double !
                sendAlertNotification(message: "Un opérateur est déja saisi !")
            }
        } // end of: if emptyScreen {
    } // end of: func operatorTaped(anyOperator: String) {
    
    /// Used to display the result of operations
    func tappedEqualButton() {

        if flagDivisionOperator {
            isDivisionByZero = checkTheCaseOfDivisionByOperandNul(anyOperator: " = ")
        }

        if !isDivisionByZero {
            
            refreshCalcul()

            if emptyScreen {
                sendAlertNotification(message: "Commencez par un opérande !")
            } else if !isExpressionCorrect && !expressionHaveEnoughElement {
                sendAlertNotification(message: "Entrez une expression correcte\n (Pas assez d'éléments,\n Double opérateur) !")
            } else if !isExpressionCorrect  {
                sendAlertNotification(message: "Entrez une expression correcte\n (Double opérateur) !")
            } else if !expressionHaveEnoughElement {
                sendAlertNotification(message: "Entrez une expression correcte (Pas assez d'éléments) !")
            } else {
                calculate()
            }
        } // if !isDivisionByZero
    } // end of: func tappedEqualButton() {
    
    func checkTheCaseOfDivisionByOperandNul(anyOperator: String) -> Bool {
                
        var isDivisionByZero: Bool = true
        
        for index in memIndexAfterOperatorInsertionInCalcultext...currentIndexInCalcultext {
            
            self.currentIndexInCalcultext = index
            
            let indexOperandDigit = self.calculText.index(self.calculText.startIndex, offsetBy: self.currentIndexInCalcultext)
                        
            if self.calculText[indexOperandDigit] != "0" {
                isDivisionByZero = false
            }
        } // end of: for index in memIndexAfterOperatorInsertionInCalcultext...currentIndexInCalcultext {
            
            if isDivisionByZero {
                sendAlertNotification(message: "Division par zéro !\n(Saississez un autre opérande !)")
                
                let removeOffset = self.currentIndexInCalcultext - self.memIndexAfterOperatorInsertionInCalcultext + 1
                let range = self.calculText.index(self.calculText.endIndex, offsetBy: -removeOffset)..<self.calculText.endIndex
                self.calculText.removeSubrange(range)
                currentIndexInCalcultext = currentIndexInCalcultext - removeOffset
                
                let savecalculText = self.calculText
                clear()
                self.calculText = savecalculText
                currentIndexInCalcultext = calculText.count-1
            } // end of: if isDivisionByZero {
        
        return isDivisionByZero
    } // end of: func checkTheCaseOfDivisionByOperandNul(anyOperator: String) -> Bool {

    /// Clear operation and refresh calcul if expression has result
    func clear() {
        calculText = String()
        currentIndexInCalcultext = initCurrentIndexInCalcultext
        memIndexAfterOperatorInsertionInCalcultext = initMemIndexAfterDivisionOperatorInCalcultext
    } // end of: func clear() {
    
    func calculate() {
        
        // Create local copy of operationsen tableau d'éléments
        var dynamicResolutionArray = elements
        
        if priorityOperator {
            dynamicResolutionArray = priorityOperations(expression: elements)
        }
    
        noPriorityOperations(&dynamicResolutionArray)
    
        guard let currentResult = dynamicResolutionArray.first else { return }
        calculText.append(" = \(currentResult)")
    } // end of: func Calculate() {
    
    /// Multiplication and division : Get priority for operator * and /
    private func priorityOperations(expression: [String]) -> [String] {
        
        var tempExpression: [String] = expression
        
        while tempExpression.contains("x") || tempExpression.contains("/") {
            
            // If an operator x ou / at the index of indextempExpression
            if let indexTempExpression = tempExpression.firstIndex(where: {$0 == "x" || $0 == "/"}) {
                
                // Assigning index to operand
                let operand = tempExpression[indexTempExpression]
                
                // Assignment to leftNumber of the previous index
                guard let leftNumber = Double(tempExpression[indexTempExpression - 1]) else { return [] }
                // Assignment to rightNumber of the following index
                guard let rightNumber = Double(tempExpression[indexTempExpression + 1]) else { return [] }
                
                var currentResult: Double
                
                // Calculatin of the transaction between the 3 members (3 index)
                if operand == "x" {
                    currentResult = leftNumber * rightNumber
                } else {
                    currentResult = Double(round((leftNumber / rightNumber)*100)/100)
                }
                
                //Replace the leftNumber by the new result
                tempExpression[indexTempExpression - 1] = String(doubleToInteger(currentResult: currentResult))
                //Remove the operator founded
                tempExpression.remove(at: indexTempExpression + 1)
                //Remove the second operand founded
                tempExpression.remove(at: indexTempExpression)
            } // end of: if let indexTempExpression = tempExpression.firstIndex(where: {$0 == "x" || $0 == "/"}) {
        } // end of:   while tempExpression.contains("x") || tempExpression.contains("/") {

                
        return tempExpression
    } // end of: private func priorityOperations(expression: [String]) -> [String] {
    
    fileprivate func noPriorityOperations(_ dynamicResolutionArray: inout [String]) {
        // Iterate over operations while an operand + or - still here
        while dynamicResolutionArray.count > 1 {
            
            let leftOperand_str_comma:String  = dynamicResolutionArray[0]
            
            let leftOperand_str_point = leftOperand_str_comma.replacingOccurrences(of: ",", with: ".")
            
            let leftOperand_double = Double(leftOperand_str_point)
            
            let operatorPlusOrMinus  = dynamicResolutionArray[1]
            
            let rightOperand_str_comma:String  = dynamicResolutionArray[2]
            
            let rightOperand_str_point = rightOperand_str_comma.replacingOccurrences(of: ",", with: ".")
            
            let rightOperand_double = Double(rightOperand_str_point)
            
            var currentResult: Double = 0.0
            
            switch operatorPlusOrMinus {
            
            case "+":
                currentResult = leftOperand_double! + rightOperand_double!
            case "-":
                currentResult = leftOperand_double! - rightOperand_double!
            default: break
            }
            // Remove the firts 3 elements from the table
            dynamicResolutionArray = Array(dynamicResolutionArray.dropFirst(3))
            // Insertion of the previousky calculated subtotal
            dynamicResolutionArray.insert("\(doubleToInteger(currentResult: currentResult))", at: 0)
        } // end of: while dynamicResolutionArray.count > 1 {
    } // end of: fileprivate func noPriorityOperations(_ dynamicResolutionArray: inout [String]) {
    
    // Remove dot and zero to display an integer
    func doubleToInteger(currentResult: Double) -> String {
        
        let doubleAsString = NumberFormatter.localizedString(from: (NSNumber(value: currentResult)), number: .decimal)
        return doubleAsString
    } // end of: func doubleToInteger(currentResult: Double) -> String {
    
    func refreshCalcul() {
        if isExpressionHaveResult{
            calculText = ""
            currentIndexInCalcultext = initCurrentIndexInCalcultext
            memIndexAfterOperatorInsertionInCalcultext = initMemIndexAfterDivisionOperatorInCalcultext
        } // end of: if isExpressionHaveResult{
    } // end of: func refreshCalcul() {
} // end of : class SimpleCalc {
