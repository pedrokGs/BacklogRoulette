import 'package:backlog_roulette/features/auth/data/exceptions/auth_exceptions.dart';
import 'package:backlog_roulette/features/auth/data/extensions/firebase_mapper.dart';
import 'package:backlog_roulette/features/auth/domain/entities/app_user.dart';
import 'package:backlog_roulette/features/auth/domain/notifiers/auth_notifier.dart';
import 'package:firebase_auth/firebase_auth.dart';

/// Essa classe é responsável por gerenciar a autenticação do sistema, incluindo: sign up, sign out e sign in.
/// Não é recomendado instanciar essa classe durante o código, o método correto é utilizar o [AuthNotifier]
/// e trabalhar a stream que escuta [authStateChanges]
class AuthService {
  final FirebaseAuth firebaseAuth;
  const AuthService({required this.firebaseAuth});

  /// Retorna uma stream que imita a [authStateChanges] do firebase auth, porém mapeando os eventos para a classe
  /// de domínio
  Stream<AppUser?> get authStateChanges {
    return firebaseAuth.authStateChanges().map(
      (firebaseUser) => firebaseUser?.toDomain(),
    );
  }

  /// Retorna um [AppUser] caso tenha um usuário cadastrado, caso contrário retorna null
  AppUser? get currentUser => (firebaseAuth.currentUser?.toDomain());

  /// Tenta efetuar sign in com [String] email e [String] password.
  ///
  /// Tenta efetuar sign in no firebase com email e senha, caso algo de errado, lança uma [Exception] customizada.
  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'user-not-found':
          throw UserNotFoundException(
            'Nenhum usuário encontrado para este e-mail.',
          );
        case 'wrong-password':
          throw InvalidPasswordException('Senha incorreta. Tente novamente.');
        case 'user-disabled':
          throw UserDisabledException('Esta conta foi desativada.');
        case 'invalid-email':
          throw InvalidEmailException('O formato do e-mail é inválido.');
        case 'too-many-requests':
          throw TooManyRequestsException(
            'Muitas tentativas. Tente mais tarde.',
          );
        default:
          throw UnknownAuthException(
            'Ocorreu um erro inesperado ao fazer login.',
          );
      }
    }
  }

  /// Tenta efetuar sign up com [String] email e [String] password.
  ///
  /// Tenta efetuar sign up no firebase com email e senha, caso algo de errado, lança uma [Exception] customizada.
  Future<void> signUpWithEmailAndPassword({
    required String email,
    required String password,
    required String username,
  }) async {
    try {
      final credential = await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (credential.user != null) {
        await credential.user!.updateDisplayName(username);
        await credential.user!.reload();
      }
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'email-already-in-use':
          throw EmailAlreadyInUseException(
            'Este e-mail já está sendo usado por outra conta.',
          );
        case 'invalid-email':
          throw InvalidEmailException('O e-mail inserido não é válido.');
        case 'operation-not-allowed':
          throw OperationNotAllowedException(
            'O cadastro por e-mail/senha não está habilitado.',
          );
        case 'weak-password':
          throw WeakPasswordException('A senha inserida é muito fraca.');
        default:
          throw UnknownAuthException('Erro ao criar conta. Tente novamente.');
      }
    }
  }

  /// Da Sign out no usuário e encerra a sessão
  Future<void> signOut() async {
    try {
      await firebaseAuth.signOut();
    } catch (e) {
      throw UnknownAuthException();
    }
  }
}
