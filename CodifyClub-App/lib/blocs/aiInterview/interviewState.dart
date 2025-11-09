part of 'interviewBloc.dart';

abstract class InterviewState {
  const InterviewState();

  @override
  List<Object?> get props => [];
}

class InterviewInitial extends InterviewState {}

class InterviewLoading extends InterviewState {}

class InterviewLoaded extends InterviewState {
  final List<AiInterviewModel> questionAnswerPairs;
  const InterviewLoaded(this.questionAnswerPairs);
}

// Error state
class InterviewError extends InterviewState {
  final String errorMessage;

  const InterviewError(this.errorMessage);
}
