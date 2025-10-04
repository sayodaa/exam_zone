$baseDir = "lib/features/essayAI"

# إنشاء المجلدات
New-Item -ItemType Directory -Force -Path "$baseDir/data/models"
New-Item -ItemType Directory -Force -Path "$baseDir/data/datasources"
New-Item -ItemType Directory -Force -Path "$baseDir/data/repositories"
New-Item -ItemType Directory -Force -Path "$baseDir/domain/entities"
New-Item -ItemType Directory -Force -Path "$baseDir/domain/repositories"
New-Item -ItemType Directory -Force -Path "$baseDir/domain/usecases"
New-Item -ItemType Directory -Force -Path "$baseDir/presentation/cubit"
New-Item -ItemType Directory -Force -Path "$baseDir/presentation/views"

# إنشاء الملفات
New-Item -ItemType File -Force -Path "$baseDir/data/models/essay_correction_model.dart"
New-Item -ItemType File -Force -Path "$baseDir/data/datasources/essay_remote_datasource.dart"
New-Item -ItemType File -Force -Path "$baseDir/data/repositories/essay_repository_impl.dart"
New-Item -ItemType File -Force -Path "$baseDir/domain/entities/essay_correction.dart"
New-Item -ItemType File -Force -Path "$baseDir/domain/repositories/essay_repository.dart"
New-Item -ItemType File -Force -Path "$baseDir/domain/usecases/generate_essay_questions_usecase.dart"
New-Item -ItemType File -Force -Path "$baseDir/domain/usecases/correct_essay_usecase.dart"
New-Item -ItemType File -Force -Path "$baseDir/presentation/cubit/essay_cubit.dart"
New-Item -ItemType File -Force -Path "$baseDir/presentation/cubit/essay_state.dart"
New-Item -ItemType File -Force -Path "$baseDir/presentation/views/essay_ai_view.dart"

Write-Host "✅ Structure for essayAI feature created successfully!"
