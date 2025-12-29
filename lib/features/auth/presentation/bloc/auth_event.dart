abstract class AuthEvent {}

class LoginRiderEvent extends AuthEvent {
  final String email;
  final String password;

  LoginRiderEvent(this.email, this.password);
}
