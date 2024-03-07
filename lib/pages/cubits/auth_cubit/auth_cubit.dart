import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  Future<void> registerUser(
      {required String email, required String password}) async {
    emit(RegisterLoading());
    try {
      UserCredential user = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      emit(RegisterSuccess());
    } on FirebaseAuthException catch (ex) {
      if (ex.code == 'weak-password') {
        emit(RegisterFailure(errMsg: 'weak password'));
      } else if (ex.code == 'email-already-in-use') {
        emit(RegisterFailure(errMsg: 'email already exists'));
      }
    } catch (ex) {
      emit(RegisterFailure(errMsg: ex.toString()));
    }
  }

  Future<void> loginUser(
      {required String email, required String password}) async {
    emit(LoginLoading());
    try {
      UserCredential user = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      emit(LoginSuccess());
    } on FirebaseAuthException catch (ex) {
      if (ex.code == 'user-not-found') {
        emit(LoginFailure(errMsg: 'user not found'));
      } else if (ex.code == 'wrong-password') {
        emit(LoginFailure(errMsg: 'wrong password'));
      }
    } catch (ex) {
      emit(LoginFailure(errMsg: ex.toString()));
    }
  }
}
