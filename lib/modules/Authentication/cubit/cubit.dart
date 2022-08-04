import 'package:al3la_restaurant/models/user_module.dart';
import 'package:al3la_restaurant/modules/Authentication/cubit/states.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthenticationCubit extends Cubit<AuthenticationStates> {
  AuthenticationCubit() : super(AuthenticationInitialState());

  static AuthenticationCubit get(context) => BlocProvider.of(context);

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;

    emit(AddUserChangePasswordVisibilityState());
  }

  // All SingUp function

  void userCreate({
    required String name,
    required String email,
    required String uId,
    required BuildContext context,
    String? image,
  }) {
    emit(CreateUserLoadingState());
    UserModel model = UserModel(
      name: name,
      email: email,
      id: uId,
      type: 'user',
      image: image ??
          'https://img.freepik.com/free-vector/online-assistant-user-help-frequently-asked-questions-call-center-worker-cartoon-character-woman-working-hotline_335657-2336.jpg?w=740',
    );
    FirebaseFirestore.instance
        .collection('User')
        .doc(uId)
        .set(model.toJson())
        .then((value) {
      emit(CreateUserSuccessState(uId));
    }).catchError((error) {
      print('Error create user is ${error.toString()}');
      emit(CreateUserErrorState(error.toString()));
    });
  }

  void signUpWithEmailAndPassword({
    required String name,
    required String email,
    required String password,
    required BuildContext context,
  }) {
    emit(SignUpLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      emit(SignUpSuccessState());
      userCreate(
        name: name,
        email: email,
        uId: '${value.user?.uid}',
        context: context,
      );
    }).catchError((error) {
      emit(SignUpErrorState(error.toString()));
      print('SingUp user with email and password Error is ${error.toString()}');
    });
  }

  void signInWithFacebook(BuildContext context) {
    emit(SignInFacebookLoadingState());
    FacebookAuth.instance.login().then((value) {
      emit(SignInFacebookSuccessState());
      // Create a credential from the access token
      final OAuthCredential facebookAuthCredential =
          FacebookAuthProvider.credential("${value.accessToken?.token}");

      // Once signed in, return the UserCredential
      FirebaseAuth.instance
          .signInWithCredential(facebookAuthCredential)
          .then((value) {
        userCreate(
          name: '${value.user?.displayName}',
          uId: '${value.user?.uid}',
          email: '${value.user?.email}',
          context: context,

          ///ToDo: add image user facebook
          image: '${value.user?.photoURL}',
        );
      });
    }).catchError((error) {
      print("error Sing in facebook is${error.toString()}");
      emit(SignInFacebookErrorState(error.toString()));
    });
  }

  Future<User?> signInWithGoogle({required BuildContext context}) async {
    emit(SignInGoogleLoadingState());
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;

    final GoogleSignIn googleSignIn = GoogleSignIn();

    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();

    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      try {
        final UserCredential userCredential =
            await auth.signInWithCredential(credential);
        emit(SignInGoogleSuccessState());
        user = userCredential.user;
        userCreate(
            email: '${user?.email}',
            uId: '${user?.uid}',
            name: '${user?.displayName}',
            image: '${user?.photoURL}',
            context: context);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'account-exists-with-different-credential') {
          print(e.code);
          emit(SignInGoogleErrorState(e.code));
        } else if (e.code == 'invalid-credential') {
          print(e.code);
          emit(SignInGoogleErrorState(e.code));
        }
      } catch (e) {
        print(e.toString());
        emit(SignInGoogleErrorState(e.toString()));
      }
    }

    return user;
  }

// all function logIn
  void userLogin({
    required String email,
    required String password,
  }) {
    emit(LoginLoadingState());
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      print('Email Login is ${value.user?.email.toString()}');
      emit(LoginSuccessState('${value.user?.uid}'));
    }).catchError((error) {
      print('Error Login is ${error.toString()}');
      emit(LoginErrorState(error.toString()));
    });
  }


}
