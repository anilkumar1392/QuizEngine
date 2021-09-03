//
//  File.swift
//  
//
//  Created by mac on 28/03/21.
//

import Foundation

public protocol  Router {
    associatedtype Question : Hashable
    associatedtype Answer
    func routeTo(question : Question,answerCallback : @escaping (Answer) -> Void)
    func routeTo(results : Result<Question,Answer>)
}
