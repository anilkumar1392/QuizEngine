import XCTest
import QuizEngine
@testable import QuizEngine

class FlowTests : XCTestCase {
    let router = RouterSpy()

    func test_start_withNoQuestions_doesNotRouteToQuestions() {
        makeSUT(questions: []).start()
        XCTAssertEqual(router.routedQuestions.isEmpty, true)
    }
    
    func test_start_withOneQuestions_routeToQuestions() {
        makeSUT(questions: ["Q1"]).start()
        XCTAssertEqual(router.routedQuestions, ["Q1"])
    }
    
    func test_start_withOneQuestions_routeToCorrectQuestions() {
        makeSUT(questions: ["Q1"]).start()
        XCTAssertEqual(router.routedQuestions, ["Q1"])
    }
    
    func test_withTwoQuestion_routeToFirstQuestion(){
        makeSUT(questions: ["Q1","Q2"]).start()
        XCTAssertEqual(router.routedQuestions, ["Q1"])
    }
    
    func test_startTwice_withTwoQuestion_routeToFirstQuestion(){
        let sut = makeSUT(questions: ["Q1","Q2"])
        sut.start()
        sut.start()
        XCTAssertEqual(router.routedQuestions, ["Q1","Q1"])
    }
    
    func test_answerFirstQuestion_startWithTwo_routeToSecond(){
        let sut = makeSUT(questions: ["Q1","Q2"])
        sut.start()
        
        router.answerCallback("A1")
        XCTAssertEqual(router.routedQuestions,["Q1","Q2"])
    }
    
    func test_startAndAnswerFirstAndSecondQuestion_withThreeQuestion(){
        let sut = makeSUT(questions: ["Q1","Q2","Q3"])
        sut.start()
        
        router.answerCallback("A1")
        router.answerCallback("A2")

        XCTAssertEqual(router.routedQuestions,["Q1","Q2","Q3"])
    }
    
    func test_startWithNoQuestion_routesToResults(){
        let sut = makeSUT(questions: [])
        sut.start()
        XCTAssertEqual(router.routedResults?.answers,[:])
    }
    
    func test_startWithOneQuestion_DoesNotRoutesToResults(){
        let sut = makeSUT(questions: ["Q1"])
        sut.start()
        XCTAssertNil(router.routedResults?.answers)
    }
    
    func test_start_answerFirstQuestion_withTwoQuestion_DoesNotRoutesToResults(){
        let sut = makeSUT(questions: ["Q1","Q2"])
        sut.start()
        router.answerCallback("A1")
        XCTAssertNil(router.routedResults?.answers)
    }
    
    func test_start_answerFirstAndSecondQuestion_withTwoQuestion_routesToResults(){
        let sut = makeSUT(questions: ["Q1","Q2"])
        sut.start()
        router.answerCallback("A1")
        router.answerCallback("A2")

        XCTAssertEqual(router.routedResults?.answers,["Q1":"A1","Q2":"A2"])
    }
    
    func test_startAndAnswerFirstAndSecondQuestion_withTwoQuestions_score(){
        let sut = makeSUT(questions: ["Q1","Q2"],scoring: {_ in 10})
        sut.start()
        router.answerCallback("A1")
        router.answerCallback("A2")
        XCTAssertEqual(router.routedResults?.score,10)

    }
    
    func test_startAndAnswerFirstAndSecondQuestion_withTwoQuestions_score2(){
        var receivedAnswers = [String:String]()
        let sut = makeSUT(questions: ["Q1","Q2"],scoring: { answers in
            receivedAnswers = answers
            return 20
        })
        sut.start()
        router.answerCallback("A1")
        router.answerCallback("A2")
        XCTAssertEqual(receivedAnswers,["Q1":"A1","Q2":"A2"])
    }
    

    //MARK: - Helper
    func makeSUT(questions : [String],scoring : @escaping ([String:String]) -> Int = {_ in 0}) -> Flow<String, String, RouterSpy>{
        return Flow(router : router,questions : questions,scoring : scoring)
    }
    
}
