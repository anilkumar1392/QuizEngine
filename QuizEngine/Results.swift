//
//  File.swift
//  
//
//  Created by mac on 28/03/21.
//

import Foundation

public struct Result<Question:Hashable, Answer> {
    public let answers : [Question:Answer]
    public let score : Int
    public init(answers : [Question:Answer],score :Int) {
        self.answers = answers
        self.score = score
    }
}
