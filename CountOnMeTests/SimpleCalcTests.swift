//
//  SimpleCalcTests.swift
//  CountOnMeTests
//
//  Created by Adeline GIROIX on 02/04/2021.
//  Copyright © 2021 Vincent Saluzzo. All rights reserved.
//

import XCTest
@testable import CountOnMe

class SimpleCalcTests: XCTestCase {
    
    var simpleCalc: SimpleCalc!
    
    override func setUp() {
        super.setUp()
        simpleCalc = SimpleCalc()
    }
    // MARK: - Test Calcul
    
    // additionButtonTaped
    func testGiven2Plus3_WhenAddition_ThenResultShouldBe5() {
        simpleCalc.tappedNumberButton(numberText: "2")
        simpleCalc.additionButtonTaped()
        simpleCalc.tappedNumberButton(numberText: "3")
        simpleCalc.tappedEqualButton()
        XCTAssertEqual(simpleCalc.calculText, "2 + 3 = 5")
    }
    
    // substractionButtonTaped
    func testGiven2Plus3_WhenSubstraction_ThenResultShouldBe1() {
        simpleCalc.tappedNumberButton(numberText: "3")
        simpleCalc.substractionButtonTaped()
        simpleCalc.tappedNumberButton(numberText: "2")
        simpleCalc.tappedEqualButton()
        XCTAssertEqual(simpleCalc.calculText, "3 - 2 = 1")
    }
    
    // multiplicationButtonTaped
    func testGiven2Plus3_WhenMultiplication_ThenResultShouldBe6() {
        simpleCalc.tappedNumberButton(numberText: "3")
        simpleCalc.multiplicationButtonTaped()
        simpleCalc.tappedNumberButton(numberText: "2")
        simpleCalc.tappedEqualButton()
        XCTAssertEqual(simpleCalc.calculText, "3 x 2 = 6")
    }
    
    // divisionButtonTaped
    func testGiven2Plus3_WhenDivisionButtonTaped_ThenResultShouldBe5() {
        simpleCalc.tappedNumberButton(numberText: "1")
        simpleCalc.tappedNumberButton(numberText: "0")
        simpleCalc.divisionButtonTaped()
        simpleCalc.tappedNumberButton(numberText: "2")
        simpleCalc.tappedEqualButton()
        XCTAssertEqual(simpleCalc.calculText, "10 / 2 = 5")
    }
    
    // Division result as Double (rounded to 2 decimal places )
    func testGivenOperator_WhenDivisionByAnOtherOperator_ThenResultShouldBeDouble5dot67() {
        simpleCalc.tappedNumberButton(numberText: "17")
        simpleCalc.divisionButtonTaped()
        simpleCalc.tappedNumberButton(numberText: "3")
        simpleCalc.tappedEqualButton()
        XCTAssertEqual(simpleCalc.calculText, "17 / 3 = 5.67")
    }
    
    // Is priority operations
    func testGivenOperations_WhenEqualButtonTaped_ThenResultPriorityOperatorIsTrue(){
        simpleCalc.calculText = "100 + 2 / 2 - 1"
        simpleCalc.tappedEqualButton()
        XCTAssertEqual(simpleCalc.priorityOperator, true)
    }
    
    // Priority of operations1 (rounded to 2 decimal places )
    func testGiven2Plus3_WhenPriorityOperators_ThenResultShouldBe1() {
        simpleCalc.calculText = "100 / 2 / 2 / 5 / 5"
        simpleCalc.tappedEqualButton()
        XCTAssertEqual(simpleCalc.calculText, "100 / 2 / 2 / 5 / 5 = 1")
    }
    
    // Priority of operations2 (rounded to 2 decimal places )
    func testGiven2Plus3_WhenPriorityOperators2_ThenResultShouldBe0() {
        simpleCalc.calculText = "1 - 100 / 2 / 2 / 5 / 5"
        simpleCalc.tappedEqualButton()
        XCTAssertEqual(simpleCalc.calculText, "1 - 100 / 2 / 2 / 5 / 5 = 0")
    }
    
    // Priority of operations3 (rounded to 2 decimal places )
    func testGiven2Plus3_WhenPriorityOperators3_ThenResultShouldBe5() {
        simpleCalc.calculText = "100 - 100 / 2 / 2 / 5 / 5 + 1"
        simpleCalc.tappedEqualButton()
        XCTAssertEqual(simpleCalc.calculText, "100 - 100 / 2 / 2 / 5 / 5 + 1 = 100")
    }
    
    // WhenClearButtonTapped
    func testGivenOperation_WhenClearButtonTapped_ThenResultShouldBeCleared() {
        simpleCalc.calculText = "100 / 2 / 2 / 5 / 5"
        simpleCalc.clear()
        XCTAssertEqual(simpleCalc.calculText, "")
    }
    
    // WhenDivisionOperator=>flagDivisionOperator=true
    func testGiven1_WhenDivisionOperator_ThenflagDivisionOperatortShouldBetrue() {
        simpleCalc.tappedNumberButton(numberText: "1")
        simpleCalc.divisionButtonTaped()
        //XCTAssertEqual(simpleCalc.flagDivisionOperator, true)
        XCTAssertTrue(simpleCalc.flagDivisionOperator)
    }
    
    // WhenDivisionByZero and flagDivisionOperator=true
    func testGiven1AfterDivisionOperatorZeros_WhenNextOperatorTaped_ThenTheZerosAreRemoved() {
        simpleCalc.tappedNumberButton(numberText: "1")
        simpleCalc.divisionButtonTaped()
        simpleCalc.tappedNumberButton(numberText: "0")
        simpleCalc.additionButtonTaped()
        XCTAssertEqual(simpleCalc.calculText, "1 / ")
    }
    
    // WhenDivisionByMultipleZero=>flagDivisionOperator=true
    func testGiven100AfterDivisionOperatorAfterTreeTileZeros_WhenNextOperatorTaped_ThenTheZerosAreRemoved() {
        simpleCalc.tappedNumberButton(numberText: "1")
        simpleCalc.divisionButtonTaped()
        simpleCalc.tappedNumberButton(numberText: "0")
        simpleCalc.tappedNumberButton(numberText: "0")
        simpleCalc.tappedNumberButton(numberText: "0")
        simpleCalc.additionButtonTaped()
        XCTAssertEqual(simpleCalc.calculText, "1 / ")
    }
    
    // additionButtonTaped after Division sequence (flagDivisionOperator = true)
    func testGiven12DivideBy2_WhenAdditionButtonTaped_ThenResultShouldBe5() {
        simpleCalc.tappedNumberButton(numberText: "1")
        simpleCalc.tappedNumberButton(numberText: "2")
        simpleCalc.divisionButtonTaped()
        XCTAssertEqual(simpleCalc.flagDivisionOperator, true)
        simpleCalc.tappedNumberButton(numberText: "2")
        simpleCalc.additionButtonTaped()
        simpleCalc.tappedNumberButton(numberText: "4")
        simpleCalc.tappedEqualButton()
        XCTAssertEqual(simpleCalc.calculText, "12 / 2 + 4 = 10")
    }
    
    // SubstractionButtonTaped after Division sequence (flagDivisionOperator = true)
    func testGiven12DivideBy2_WhenSubstractionButtonTaped_ThenResultShouldBe5() {
        simpleCalc.tappedNumberButton(numberText: "1")
        simpleCalc.tappedNumberButton(numberText: "2")
        simpleCalc.divisionButtonTaped()
        XCTAssertEqual(simpleCalc.flagDivisionOperator, true)
        simpleCalc.tappedNumberButton(numberText: "2")
        simpleCalc.substractionButtonTaped()
        simpleCalc.tappedNumberButton(numberText: "1")
        simpleCalc.tappedEqualButton()
        XCTAssertEqual(simpleCalc.calculText, "12 / 2 - 1 = 5")
    }
    
    // multiplicationButtonTaped after Division sequence (flagDivisionOperator = true)
    func testGiven12DivideBy2_WhenMultiplicationButtonTaped_ThenResultShouldBe12() {
        simpleCalc.tappedNumberButton(numberText: "1")
        simpleCalc.tappedNumberButton(numberText: "2")
        simpleCalc.divisionButtonTaped()
        XCTAssertEqual(simpleCalc.flagDivisionOperator, true)
        simpleCalc.tappedNumberButton(numberText: "2")
        simpleCalc.multiplicationButtonTaped()
        simpleCalc.tappedNumberButton(numberText: "2")
        simpleCalc.tappedEqualButton()
        XCTAssertEqual(simpleCalc.calculText, "12 / 2 x 2 = 12")
    }
    
    // divisionButtonTaped after Division sequence (flagDivisionOperator = true)
    func testGiven12DivideBy2_WhenDivisionButtonTaped_ThenResultShouldBe3() {
        simpleCalc.tappedNumberButton(numberText: "1")
        simpleCalc.tappedNumberButton(numberText: "2")
        simpleCalc.divisionButtonTaped()
        XCTAssertEqual(simpleCalc.flagDivisionOperator, true)
        simpleCalc.tappedNumberButton(numberText: "2")
        simpleCalc.divisionButtonTaped()
        simpleCalc.tappedNumberButton(numberText: "2")
        simpleCalc.tappedEqualButton()
        XCTAssertEqual(simpleCalc.calculText, "12 / 2 / 2 = 3")
    }
    
    // Double to Integer (rounded to 2 decimal places )
    func testGivenDivision_WhentappedEqualButton_ThenResultShouldBe5dot67() {
        simpleCalc.calculText = "17 / 3"
        simpleCalc.tappedEqualButton()
        XCTAssertEqual(simpleCalc.doubleToInteger(currentResult: 3.4), "3.4")
    }
    
    // WhentappedOperatorButton in empty screen
    func testGivenEmptyScreen_WhentappedOperatorButton_ThenResultShouldBeEmpty() {
        simpleCalc.calculText = ""
        simpleCalc.operatorTaped(anyOperator: "+")
        XCTAssertEqual(simpleCalc.calculText, "")
    }
    
    // WhentappedOperatorButton Two Time
    func testGivenEmptyScreen_WhentappedOperatorButtonTwoTime_ThenResultShouldBeTheSame() {
        simpleCalc.calculText = "1 + "
        simpleCalc.operatorTaped(anyOperator: "+")
        XCTAssertEqual(simpleCalc.calculText, "1 + ")
    }
    
    // WhentappedEqualButton in empty screen
    func testGivenEmptyScreen_WhentappedEqualButton_ThenResultShouldBeEmpty() {
        simpleCalc.calculText = ""
        simpleCalc.tappedEqualButton()
        XCTAssertEqual(simpleCalc.calculText, "")
    }
    
    
       //EqualButton
    
    
    // expression Have Enough Element
    func testGivenOperation_WhentappedEqualButton_ThenExpressionHaveEnoughElementTrue() {
        simpleCalc.calculText = "15 / 3"
        simpleCalc.tappedEqualButton()
        XCTAssertEqual(simpleCalc.expressionHaveEnoughElement, true)
    }
    
    // expression Have Not Enough Element
    func testGivenOperation_WhentappedEqualButton_ThenExpressionHaveEnoughElementFalse() {
        simpleCalc.calculText = "15"
        simpleCalc.tappedEqualButton()
        XCTAssertEqual(simpleCalc.expressionHaveEnoughElement, false)
    }
    
    // expression Have Not Enough Element isExpressionCorrect, false
    func testGivenOperation_WhentappedEqualButtonBehindAn_OperatorisExpressionCorrectFalse() {
        simpleCalc.tappedNumberButton(numberText: "2")
        simpleCalc.additionButtonTaped()
        simpleCalc.tappedNumberButton(numberText: "3")
        simpleCalc.additionButtonTaped()
        simpleCalc.tappedEqualButton()
        XCTAssertEqual(simpleCalc.isExpressionCorrect, false)
    }
    
    // expression Have  Enough Element isExpressionCorrect, true
    func testGivenOperation_WhentappedEqualButtonBehindAn_OperatorisExpressionCorrectTrue() {
        simpleCalc.tappedNumberButton(numberText: "2")
        simpleCalc.additionButtonTaped()
        simpleCalc.tappedNumberButton(numberText: "3")
        simpleCalc.additionButtonTaped()
        simpleCalc.tappedNumberButton(numberText: "5")
        simpleCalc.tappedEqualButton()
        XCTAssertEqual(simpleCalc.isExpressionCorrect, true)
    }
    
    // isExpressionCorrect: false  && expressionHaveEnoughElement: false
    func testGivenOperation_WhentappedEqualButtonBehindAn_isExpressionCorrectExpressionHaveEnoughElement() {
        simpleCalc.tappedNumberButton(numberText: "2")
        simpleCalc.additionButtonTaped()
//        simpleCalc.tappedNumberButton(numberText: "3")
//        simpleCalc.additionButtonTaped()
//        simpleCalc.tappedNumberButton(numberText: "5")
        simpleCalc.tappedEqualButton()
        XCTAssertEqual(simpleCalc.isExpressionCorrect, false)
        XCTAssertEqual(simpleCalc.expressionHaveEnoughElement, false)
    }
} // class SimpleCalcTests: XCTestCase

