sealed class AuthException implements Exception {
  final String message;
  AuthException(this.message);

  @override
  String toString() => message;
}

class UnknownAuthException extends AuthException {
  UnknownAuthException([super.message = 'Ocorreu um erro inesperado.']);
}

class TooManyRequestsException extends AuthException {
  TooManyRequestsException([super.message = 'Muitas tentativas. Tente novamente mais tarde.']);
}

class NetworkException extends AuthException {
  NetworkException([super.message = 'Erro de conexão. Verifique sua internet.']);
}

class UserNotFoundException extends AuthException {
  UserNotFoundException([super.message = 'Nenhum usuário encontrado para este e-mail.']);
}

class InvalidPasswordException extends AuthException {
  InvalidPasswordException([super.message = 'Senha incorreta. Tente novamente.']);
}

class UserDisabledException extends AuthException {
  UserDisabledException([super.message = 'Esta conta foi desativada.']);
}

class InvalidEmailException extends AuthException {
  InvalidEmailException([super.message = 'O formato do e-mail é inválido.']);
}

class EmailAlreadyInUseException extends AuthException {
  EmailAlreadyInUseException([super.message = 'Este e-mail já está em uso por outra conta.']);
}

class WeakPasswordException extends AuthException {
  WeakPasswordException([super.message = 'A senha é muito fraca. Use uma senha mais forte.']);
}

class OperationNotAllowedException extends AuthException {
  OperationNotAllowedException([super.message = 'O cadastro por e-mail/senha não está habilitado.']);
}