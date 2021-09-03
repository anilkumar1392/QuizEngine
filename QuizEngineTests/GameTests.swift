//
//  File.swift
//  
//
//  Created by mac on 03/04/21.
//

import Foundation
import XCTest
import QuizEngine

class GameTest: XCTestCase {
    
    let router = RouterSpy()
    var game : Game<String,String,RouterSpy>!
    
    override func setUp() {
        super.setUp()
        game = startGame(questions : ["Q1","Q2"],router : router, correctAnnswers : ["Q1" : "A1","Q2" : "A2"])
    }
    
    func test_startTest_answerzeroOutOfTwoCorrectly_scores1(){
        router.answerCallback("Wrong")
        router.answerCallback("Wrong")
        XCTAssertEqual(router.routedResults!.score, 0)
    }
    
    func test_startTest_answerOneOutOfTwoCorrectly_scores1(){
        router.answerCallback("A1")
        router.answerCallback("Wrong")
        XCTAssertEqual(router.routedResults!.score, 1)
    }
    
    func test_startTest_answerTwoOutOfTwoCorrectly_scores1(){
        router.answerCallback("A1")
        router.answerCallback("A2")
        XCTAssertEqual(router.routedResults!.score, 2)
    }
}
