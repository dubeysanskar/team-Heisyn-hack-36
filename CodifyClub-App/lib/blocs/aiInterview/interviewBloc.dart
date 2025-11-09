import 'dart:math';

import 'package:codifyclub/data/models/AiInterviewModel.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/services/ai_interview_service.dart';

part 'interviewEvent.dart';
part 'interviewState.dart';

class InterviewBloc extends Bloc<InterviewEvent, InterviewState> {
  final AiInterviewService _aiInterviewService;

  InterviewBloc(this._aiInterviewService) : super(InterviewInitial()) {
    on<FetchInterviewQuestions>(_onFetchInterviewQuestions);
    on<FetchInterviewFeedback>(_onInterviewFeedback);
  }

  Future<void> _onFetchInterviewQuestions(
      FetchInterviewQuestions event, Emitter<InterviewState> emit) async {
    emit(InterviewLoading());
    try {
      final List<AiInterviewModel>? interviewData = await _aiInterviewService
          .gemnicode(event.position, event.description, event.experience);

      if (interviewData != null && interviewData.isNotEmpty) {
        emit(InterviewLoaded(interviewData));
      } else {
        emit(InterviewError('No interview questions returned.'));
      }
    } catch (e) {
      emit(InterviewError('An error occurred: $e'));
    }
  }

  Future<void> _onInterviewFeedback(
      FetchInterviewFeedback event, Emitter<InterviewState> emit) async {
    try {
      if (state is InterviewLoaded && (state as InterviewLoaded).questionAnswerPairs.isNotEmpty) {
        final List<AiInterviewModel> updatedInterviewData =
        List.from((state as InterviewLoaded).questionAnswerPairs);
        emit(InterviewLoading());
        for (int i = 0; i < updatedInterviewData.length; i++) {
          print('Processing question: ${updatedInterviewData[i].getQuestion()}');

          final feedbackData = await _aiInterviewService.getFeedback(
              updatedInterviewData[i].getQuestion(), event.userAnswer[i]);


          if (feedbackData != null) {
            updatedInterviewData[i].addUserAnswer(event.userAnswer[i]);
            updatedInterviewData[i].addFeedback(
                feedbackData['rating']!.toString(), feedbackData['feedback']!);
          } else {
            emit(InterviewError('No feedback returned from the AI service.'));
            return;
          }
        }

        emit(InterviewLoaded(updatedInterviewData));
      } else {
        emit(InterviewError('No interview data available to add feedback.'));
      }
    } catch (e) {
      emit(InterviewError('An error occurred while generating feedback: $e'));
    }
  }
}
