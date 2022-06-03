import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:counter_app/utils/services.dart';

class AuthProvider extends ChangeNotifier {
  late FirebaseAuth auth;
  var _isLoading = false;
  bool get isLoading => _isLoading;
  AuthProvider(this.auth);

  Future<bool> signUp(
      String username, String emailAddress, String password) async {
    _isLoading = true;
    notifyListeners();
    try {
      await auth.createUserWithEmailAndPassword(
          email: emailAddress.trim(), password: password.trim());
      await auth.currentUser!.updateDisplayName(username);
      _isLoading = false;
      notifyListeners();
      return true;
    } on FirebaseAuthException catch (err) {
      showSnackBar(err.toString());
    } catch (_) {
      showSnackBar("something went wrong");
    }
    _isLoading = false;
    notifyListeners();
    return false;
  }

  Future<bool> login(String emailAddress, String password) async {
    _isLoading = true;
    notifyListeners();
    try {
      await auth.signInWithEmailAndPassword(
          email: emailAddress, password: password);
      _isLoading = false;
      notifyListeners();
      return true;
    } on FirebaseAuthException catch (err) {
      showSnackBar(err.toString());
    } catch (_) {
      showSnackBar('something went wrong');
    }
    _isLoading = false;
    notifyListeners();
    return false;
  }

  Future<bool> logout() async {
    try {
      await auth.signOut();
      return true;
    } on FirebaseAuthException catch (err) {
      showSnackBar(err.toString());
    } catch (_) {
      showSnackBar('something went wrong');
    }
    return false;
  }
}
