import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthHelper {
  AuthHelper._();

  static AuthHelper authHelper = AuthHelper._();
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  bool success = false;

  Future<UserCredential?> createNewAccount(
      String email, String password) async {
    try {
      UserCredential userCredential = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      verifyEmail();
      return userCredential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw ('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        throw ('The account already exists for that email.');
      }
    } catch (e) {}
  }

  Future<UserCredential?> signIn(String email, String password) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      success = true;
      log('don success');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        log('No user found for that email.');
        success = false;

        // print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        success = false;
        log('Wrong password provided for that user.');
      }
    }
  }

  logout() async {
    await firebaseAuth.signOut();
  }

  forgetPassword(String email) async {
    firebaseAuth.sendPasswordResetEmail(email: email);
  }

  verifyEmail() async {
    firebaseAuth.currentUser!.sendEmailVerification();
  }
}
