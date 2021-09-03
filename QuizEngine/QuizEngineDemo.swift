

class Flow <Question,Answer,R : Router> where R.Question == Question,R.Answer == Answer{
    let router : R
    let questions : [Question]
    var answers : [Question:Answer] = [:]
    var scoring : ([Question:Answer]) -> Int
    
    init(router : R,questions : [Question], scoring : @escaping ([Question:Answer]) -> Int) {
        self.questions = questions
        self.router = router
        self.scoring = scoring
    }
    
    func start(){
        if let firstQuestion = questions.first {
            router.routeTo(question: firstQuestion,answerCallback: nextCallback(question: firstQuestion))
        } else {
            router.routeTo(results: results())
        }
    }
    
    //Refactor
    func nextCallback(question : Question) -> (Answer) -> Void {
        return { [weak self] in self?.routeTo(question: question, answer: $0)}
    }
    
    func routeTo(question: Question,answer : Answer) {
        if let currentQuestionIndex = questions.firstIndex(of: question) {
            answers[question] = answer
            
            if currentQuestionIndex+1 < questions.count {
                let nextQuestion = questions[currentQuestionIndex+1]
                router.routeTo(question: nextQuestion,answerCallback: nextCallback(question: nextQuestion))
            } else {
                router.routeTo(results: results())
            }
        }
    }
    
    private func results() -> Result<Question,Answer> {
        return Result(answers: answers, score: scoring(answers))
    }
    
}
