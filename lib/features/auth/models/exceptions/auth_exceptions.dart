sealed class AuthException implements Exception {
  final String message;
  AuthException(this.message);

  @override
  String toString() => message;
}

/// [Exception] Lançada ao falhar todos os outros checks, ver no log qual foi o problema.
class UnknownAuthException extends AuthException {
  UnknownAuthException([super.message = 'Ocorreu um erro inesperado.']);
}

/// [Exception] Lançada ao exceder o limite de tentativas do Firebase
class TooManyRequestsException extends AuthException {
  TooManyRequestsException([super.message = 'Muitas tentativas. Tente novamente mais tarde.']);
}

/// [Exception] Lançada quando o dispositivo perde acesso a internet e não consegue efetuar a ação
class NetworkException extends AuthException {
  NetworkException([super.message = 'Erro de conexão. Verifique sua internet.']);
}

/// [Exception] Lançada ao não encontrar usuário após sign in
class UserNotFoundException extends AuthException {
  UserNotFoundException([super.message = 'Nenhum usuário encontrado para este e-mail.']);
}

/// [Exception] Lançada ao usuário digitar uma senha incorreta
class InvalidPasswordException extends AuthException {
  InvalidPasswordException([super.message = 'Email ou senha incorretos, tente novamente']);
}

/// [Exception] Lançada ao tentar entrar em conta desativada
class UserDisabledException extends AuthException {
  UserDisabledException([super.message = 'Esta conta foi desativada.']);
}

/// [Exception] Lançada ao tentar fazer sign in/up com email inválido
class InvalidEmailException extends AuthException {
  InvalidEmailException([super.message = 'O formato do e-mail é inválido.']);
}

/// [Exception] Lançada ao tentar fazer sign up com email já cadastrado
class EmailAlreadyInUseException extends AuthException {
  EmailAlreadyInUseException([super.message = 'Este e-mail já está em uso por outra conta.']);
}

/// [Exception] Lançada ao tentar fazer sign up com uma senha insegura
class WeakPasswordException extends AuthException {
  WeakPasswordException([super.message = 'A senha é muito fraca. Use uma senha mais forte.']);
}

/// [Exception] Lançada ao tentar fazer uma operação não permitida
class OperationNotAllowedException extends AuthException {
  OperationNotAllowedException([super.message = 'Operação não permitida']);
}