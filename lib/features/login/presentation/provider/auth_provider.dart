// lib/providers/auth_provider.dart
import 'package:flutter/foundation.dart';
import 'package:ostad/core/constant/app_message.dart';
import 'package:ostad/features/login/data/datasource/auth_service.dart';
import 'package:dio/dio.dart';

enum AuthStatus { initial, authenticated, unauthenticated, loading, error }

class AuthProvider with ChangeNotifier {
  final AuthService _authService;

  AuthStatus _status = AuthStatus.initial;
  String? _errorMessage;
  Response? _response;

  AuthProvider(this._authService) {
    _checkAuthStatus();
  }

  AuthStatus get status => _status;
  String? get errorMessage => _errorMessage;
  bool get isAuthenticated => _status == AuthStatus.authenticated;
  Response? get response => _response;

  Future<void> _checkAuthStatus() async {
    try {
      final isLoggedIn = await _authService.isLoggedIn();
      _status = isLoggedIn ? AuthStatus.authenticated : AuthStatus.unauthenticated;
    } catch (e) {
      _status = AuthStatus.unauthenticated;
    }
    notifyListeners();
  }

  Future<void> login({required String phoneNumber, required String password}) async {
    _status = AuthStatus.loading;
    _errorMessage = null;
    notifyListeners();
    try {
      _response = await _authService.login(phoneNumber: phoneNumber, password: password);
      if (_response != null) {
        _status = AuthStatus.authenticated;
        notifyListeners();
      } else {
        _status = AuthStatus.unauthenticated;
        _errorMessage = AppMessage.unauthorizedError;
        notifyListeners();
      }
    } catch (e) {
      _status = AuthStatus.error;
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  Future<void> logout() async {
    _status = AuthStatus.loading;
    _errorMessage = null;
    notifyListeners();

    try {
      final success = await _authService.logout();
      if (success) {
        _response = null;
        _status = AuthStatus.unauthenticated;
        notifyListeners();
      } else {
        _status = AuthStatus.error;
        _errorMessage = AppMessage.logoutError;
        notifyListeners();
      }
    } catch (e) {
      _status = AuthStatus.error;
      _errorMessage = e.toString();
      notifyListeners();
    }
  }
}
