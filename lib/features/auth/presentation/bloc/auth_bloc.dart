import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/auth_repository.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository repository;

  AuthBloc({required this.repository}) : super(Unauthenticated()) {
    on<LoginRequested>(_onLoginRequested);
    on<LogoutRequested>(_onLogoutRequested);
    on<CheckAuthStatus>(_onCheckAuthStatus);
  }

  Future<void> _onLoginRequested(
    LoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      final token = await repository.login(event.username, event.password);

      // FakeStore login only returns a token, no user ID.
      // Fetch all users and match by username to get the profile.
      final users = await repository.getUsers();
      final user = users.firstWhere(
        (u) => u.username == event.username,
        orElse: () => throw Exception('User not found'),
      );

      emit(Authenticated(user: user, token: token));
    } catch (e) {
      emit(AuthError(e.toString()));
      emit(Unauthenticated());
    }
  }

  void _onLogoutRequested(LogoutRequested event, Emitter<AuthState> emit) {
    emit(Unauthenticated());
  }

  void _onCheckAuthStatus(CheckAuthStatus event, Emitter<AuthState> emit) {
    // No persistent storage — always starts unauthenticated
    if (state is! Authenticated) {
      emit(Unauthenticated());
    }
  }
}
