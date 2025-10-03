import 'package:get_it/get_it.dart';
import 'package:graduation/core/services/data_service.dart';
import 'package:graduation/core/services/firebase_auth_service.dart';
import 'package:graduation/core/services/firestore_service.dart';
import 'package:graduation/core/services/generated_choises_services/generate_choise_quations_servise.dart';
import 'package:graduation/features/auth/data/repos/auth_repo_impl.dart';
import 'package:graduation/features/auth/domain/repos/auth_repos.dart';
import 'package:graduation/features/generate_choise/data/repositories/exam_choise_repo_impl.dart';
import 'package:graduation/features/generate_choise/domain/repo/exam_choise_repo.dart';

final getIt = GetIt.instance;

void setupGetIt() {
  getIt.registerSingleton<DatabaseServices>(FirestoreServices());
  getIt.registerSingleton<FirebaseAuthService>(FirebaseAuthService());
  getIt.registerSingleton<AuthRepo>(
    AuthRepoImpl(
      firebaseAuthService: getIt<FirebaseAuthService>(),
      databaseServices: getIt<DatabaseServices>(),
    ),
  );
  getIt.registerLazySingleton<ExamChoiseRepo>(
    () => ExamChoiseRepoImpl(
      remoteDataSourseExamGenerateChoises:
          getIt<RemoteDataSourseExamGenerateChoises>(),
    ),
  );
  getIt.registerLazySingleton<RemoteDataSourseExamGenerateChoises>(
    () => RemoteDataSourseExamGenerateChoises(),
  );
}
