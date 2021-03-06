//
//  File.swift
//  
//
//  Created by mac on 03/04/21.
//

import Foundation

public class Game<Question, Answer, R: Router> where R.Question == Question,R.Answer == Answer{
    var flow : Flow<Question,Answer,R>
    
    init(flow : Flow<Question,Answer,R>) {
        self.flow = flow
    }
}

public func startGame<Question, Answer : Equatable, R: Router>(questions : [Question],router : R,correctAnnswers:[Question:Answer]) -> Game<Question, Answer, R> where R.Question == Question,R.Answer == Answer{
    let flow = Flow(router: router, questions: questions, scoring: { scoring($0,correctAnswers: correctAnnswers)})
    flow.start()
    return Game(flow: flow)
}

private func scoring<Question: Hashable,Answer: Equatable>(_ answers : [Question:Answer],correctAnswers:[Question:Answer]) -> Int{
    return answers.reduce(0) { (score,tuple) in
        return score + (correctAnswers[tuple.key] == tuple.value ? 1 : 0)
    }
}
