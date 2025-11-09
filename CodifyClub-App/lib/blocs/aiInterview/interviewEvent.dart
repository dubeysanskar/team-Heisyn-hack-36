part of 'interviewBloc.dart';

abstract class InterviewEvent {
  const InterviewEvent();
}

class FetchInterviewQuestions extends InterviewEvent {
  final String position;
  final String description;
  final String experience;

  const FetchInterviewQuestions(
      this.position, this.description, this.experience);
}
class FetchInterviewFeedback extends InterviewEvent {
  final List<String> userAnswer; // Only user answer, no rating or feedback required

  const FetchInterviewFeedback(this.userAnswer);
}
