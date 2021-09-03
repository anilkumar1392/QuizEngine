//
//  File.swift
//  
//
//  Created by mac on 28/03/21.
//

import Foundation

public class RouterSpy : Router{

    public init() {}

    public var routedQuestions : [String] = []
    public var routedResults : Result<String,String>? = nil

    public var answerCallback : (String) -> Void = {_ in}
    public func routeTo(question: String, answerCallback : @escaping (String) -> Void) {
        self.routedQuestions.append(question)
        self.answerCallback = answerCallback
    }
    
    public func routeTo(results: Result<String,String>) {
        self.routedResults = results
    }
}

