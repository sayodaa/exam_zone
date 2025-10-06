import 'package:get_it/get_it.dart';
import 'package:graduation/core/services/generated_choises_services/generate_choise_quations_servise.dart';
import 'package:graduation/features/essayAI/data/datasources/essay_remote_datasource.dart';
import 'package:graduation/features/essayAI/data/repositories/essay_repository_impl.dart';
import 'package:graduation/features/essayAI/domain/repositories/essay_repository.dart';
import 'package:graduation/features/essayAI/domain/usecases/correct_essay_usecase.dart';
import 'package:graduation/features/essayAI/domain/usecases/generate_essay_questions_usecase.dart';
import 'package:graduation/features/essayAI/presentation/cubit/essay_cubit.dart';
import 'package:graduation/features/generate_choise/data/repositories/exam_choise_repo_impl.dart';
import 'package:graduation/features/generate_choise/domain/repo/exam_choise_repo.dart';
import 'package:http/http.dart' as http;
import 'package:graduation/core/services/firebase_auth_service.dart';
import 'package:graduation/core/services/data_service.dart';
import 'package:graduation/core/services/firestore_service.dart';
import 'package:graduation/features/auth/domain/repos/auth_repos.dart';
import 'package:graduation/features/auth/data/repos/auth_repo_impl.dart';

final sl = GetIt.instance;

bool _serviceLocatorInitialized = false;

Future<void> initServiceLocator() async {
  if (_serviceLocatorInitialized) return;
  // External
  sl.registerLazySingleton(() => http.Client());

  // Data sources
  sl.registerLazySingleton<EssayRemoteDataSource>(
    () => EssayRemoteDataSourceImpl(client: sl()),
  );

  // Core services
  sl.registerLazySingleton<FirebaseAuthService>(() => FirebaseAuthService());
  sl.registerLazySingleton<DatabaseServices>(() => FirestoreServices());

  // Repository for essay feature
  sl.registerLazySingleton<EssayRepository>(
    () => EssayRepositoryImpl(remoteDataSource: sl<EssayRemoteDataSource>()),
  );

  // Auth repository
  sl.registerLazySingleton<AuthRepo>(
    () => AuthRepoImpl(
      firebaseAuthService: sl<FirebaseAuthService>(),
      databaseServices: sl<DatabaseServices>(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(
    () => GenerateEssayQuestionsUseCase(sl<EssayRepository>()),
  );
  sl.registerLazySingleton(() => CorrectEssayUseCase(sl<EssayRepository>()));

  // Cubit (بعد الـ use cases)
  sl.registerFactory(
    () => EssayCubit(generateQuestionsUseCase: sl(), correctEssayUseCase: sl()),
  );

  // Remote Data Source for choices
  sl.registerLazySingleton<RemoteDataSourseExamGenerateChoises>(
    () => RemoteDataSourseExamGenerateChoises(),
  );

  // Repository for choices
  sl.registerLazySingleton<ExamChoiseRepo>(
    () => ExamChoiseRepoImpl(
      remoteDataSourseExamGenerateChoises:
          sl<RemoteDataSourseExamGenerateChoises>(),
    ),
  );

  _serviceLocatorInitialized = true;
}
