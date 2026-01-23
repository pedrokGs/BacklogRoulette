import 'package:backlog_roulette/features/auth/models/exceptions/auth_exceptions.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService{
  final FirebaseAuth firebaseAuth;
  const AuthService({required this.firebaseAuth});

  User? get currentUser => firebaseAuth.currentUser;

  Future<void> signInWithEmailAndPassword({required String email, required String password}) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'user-not-found':
          throw UserNotFoundException(
              'Nenhum usuário encontrado para este e-mail.');
        case 'wrong-password':
          throw InvalidPasswordException('Senha incorreta. Tente novamente.');
        case 'user-disabled':
          throw UserDisabledException('Esta conta foi desativada.');
        case 'invalid-email':
          throw InvalidEmailException('O formato do e-mail é inválido.');
        case 'too-many-requests':
          throw TooManyRequestsException(
              'Muitas tentativas. Tente mais tarde.');
        default:
          throw UnknownAuthException('Ocorreu um erro inesperado ao fazer login.');
      }
    }
  }

    Future<void> signUpWithEmailAndPassword({required String email, required String password, required String username}) async{
      try {
        await firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      } on FirebaseAuthException catch (e) {
        switch (e.code) {
          case 'email-already-in-use':
            throw EmailAlreadyInUseException('Este e-mail já está sendo usado por outra conta.');
          case 'invalid-email':
            throw InvalidEmailException('O e-mail inserido não é válido.');
          case 'operation-not-allowed':
            throw OperationNotAllowedException('O cadastro por e-mail/senha não está habilitado.');
          case 'weak-password':
            throw WeakPasswordException('A senha inserida é muito fraca.');
          default:
            throw UnknownAuthException('Erro ao criar conta. Tente novamente.');
        }
      }
    }

  Future<void> signOut() async {
    try{
      await firebaseAuth.signOut();
    } catch(e){
      throw UnknownAuthException();
    }
  }
}