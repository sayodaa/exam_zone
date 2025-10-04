import 'package:equatable/equatable.dart';

class EssayCorrection extends Equatable {
  final int score;
  final String mistakes;
  final String feedback;

  const EssayCorrection({
    required this.score,
    required this.mistakes,
    required this.feedback,
  });

  @override
  List<Object?> get props => [score, mistakes, feedback];
}
