import 'package:equatable/equatable.dart';

class QuestionEntity extends Equatable {
  final String question;
  final Map<String, String> choices;
  final String answer;

  const QuestionEntity({required this.question, required this.choices, required this.answer});
  
  @override
  List<Object?> get props => [question , choices , answer];
}
