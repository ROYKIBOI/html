import 'package:flutter/foundation.dart';

class UserSession  extends ChangeNotifier  {
  String? userEmail;

  String? getUserEmail() {
    return userEmail;
  }

  void setUserEmail(String email) {
    userEmail = email;
    notifyListeners();
  }

  void clearSession() {
    userEmail = null;
    notifyListeners();
  }
}