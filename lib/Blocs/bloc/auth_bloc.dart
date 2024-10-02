import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthEvent>((event, emit) async {
      if (event is LoginEvent) {
        emit(LoginLoading());
        try {
          var auth = FirebaseAuth.instance;
          await auth.signInWithEmailAndPassword(
              email: event.email, password: event.password);
          emit(LoginSuccess());
        } on FirebaseAuthException catch (e) {
          if (e.code == 'user-not-found') {
            emit(LoginFailure(message: 'No user found for that email.'));
          } else if (e.code == 'wrong-password') {
            emit(LoginFailure(
                message: 'Wrong password provided for that user.'));
          }
        } catch (ex) {
          emit(LoginFailure(message: 'There was an error'));
        }
      } else if (event is RegisterEvent) {
        emit(RegisterLoading());
        try {
          var auth = FirebaseAuth.instance;
          await auth.createUserWithEmailAndPassword(
              email: event.email, password: event.password);
          emit(RegisterSuccess());
        } on FirebaseAuthException catch (e) {
          if (e.code == 'weak-password') {
            emit(
                RegisterFailure(message: 'The password provided is too weak.'));
          } else if (e.code == 'email-already-in-use') {
            emit(RegisterFailure(
                message: 'The account already exists for that email.'));
          }
        } catch (ex) {
          emit(RegisterFailure(message: 'There was an error'));
        }
      }
    });
  }
}
