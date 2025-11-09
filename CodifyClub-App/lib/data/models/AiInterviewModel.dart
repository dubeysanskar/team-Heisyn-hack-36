class AiInterviewModel {
  final String? question;
  final String? answer;
  String? userAnswer;

  String? feedback;
  String? rating;

  AiInterviewModel({this.question, this.answer, this.userAnswer, this.feedback, this.rating});

  factory AiInterviewModel.fromJson(Map<String, dynamic> json) {
    return AiInterviewModel(
      question: json['question'],
      answer: json['answer'],
    );
  }

  void addFeedback(String newRating, String newFeedback) {
    rating = newRating;
    feedback = newFeedback;
  }
  void addUserAnswer(String newUserAnswer){
    userAnswer=newUserAnswer;
  }

  @override
  String toString() {
    return 'Question: $question, Answer: $answer, User Answer: $userAnswer, Rating: $rating, Feedback: $feedback';
  }

  String getQuestion() {
    return question.toString();
  }

  String getAnswer() {
    return answer.toString();
  }

  String getUserAnswer() {
    return userAnswer.toString();
  }

  String getFeedback() {
    return feedback.toString();
  }

  String getRating() {
    return rating.toString();
  }
}
