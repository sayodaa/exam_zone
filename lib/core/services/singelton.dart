import 'package:get_it/get_it.dart';
import 'package:graduation/features/generate_choise/data/repositories/exam_choise_repo_impl.dart';
import 'package:graduation/core/services/generated_choises_services/generate_choise_quations_servise.dart';
import 'package:graduation/features/generate_choise/domain/repo/exam_choise_repo.dart';

final sl = GetIt.instance;

Future<void> initServiceLocator() async {
  // Remote Data Source
  sl.registerLazySingleton<RemoteDataSourseExamGenerateChoises>(
    () => RemoteDataSourseExamGenerateChoises(),
  );

  // Repository
  sl.registerLazySingleton<ExamChoiseRepo>(
    () => ExamChoiseRepoImpl(
      remoteDataSourseExamGenerateChoises:
          sl<RemoteDataSourseExamGenerateChoises>(),
    ),
  );
}
