import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resave_rider/core/storage/token_storage.dart';
import 'package:resave_rider/features/auth/domain/usecases/login_rider.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginRider loginRider;

  AuthBloc(this.loginRider) : super(AuthInitial()) {
    on<LoginRiderEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        final rider = await loginRider(event.email, event.password);
        await TokenStorage.saveToken(rider.token);
        emit(AuthSuccess(rider.token));
      } catch (e) {
        print('AUTH BLOC ERROR => $e');
        emit(AuthError(e.toString()));
      }
    });
  }
}
