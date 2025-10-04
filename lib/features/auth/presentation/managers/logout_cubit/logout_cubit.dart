import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation/features/auth/domain/repos/auth_repos.dart';

part 'logout_state.dart';

class LogoutCubit extends Cubit<LogoutState> {
  final AuthRepo authRepo;

  LogoutCubit(this.authRepo) : super(LogoutInitial());

  Future<void> signOut() async {
    emit(LogoutLoading());
    await Future.delayed(const Duration(milliseconds: 300));
    final result = await authRepo.signOut();
    result.fold(
      (failure) => emit(LogoutFailure(message: failure.message)),
      (unit) => emit(LogoutSuccess()),
    );
  }
}
