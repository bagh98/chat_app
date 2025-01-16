import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'signin_state.dart';

class SigninCubit extends Cubit<SigninState> {
  SigninCubit() : super(SigninInitial());
  Future<void> registerUser(
      {required String email, required String password}) async {
    emit(SigninLoading());
    try {
      var auth = FirebaseAuth.instance;
      UserCredential user = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      emit(SigninSuccess());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        emit(SigninFailure(error: 'No user found for that email.'));
      } else if (e.code == 'wrong-password') {
        emit(SigninFailure(
          error: 'Wrong password provided for that user.',
        ));
      }
    } catch (e) {
      emit(SigninFailure(
        error: 'Something went wrong' + e.toString(),
      ));
    }
  }
}
