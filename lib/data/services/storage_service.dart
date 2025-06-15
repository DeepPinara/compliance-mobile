import 'package:compliancenavigator/data/models/user.dart';
import 'package:compliancenavigator/utils/enums.dart';

import '/data/clients/storage/storage_provider.dart';

class StorageService {
  final StorageProvider _storageProvider;

  // Storage keys
  static const String _userKey = 'auth_user';
  static const String _accessTokenKey = 'access_token';
  static const String _refreshTokenKey = 'refresh_token';
  static const String _selectmoduleKey = 'selectmodule';

  StorageService(this._storageProvider);

  // logs
  void logger(String message) {
    // log('StorageService: $message');
  }

  // Token Management
  Future<void> setAccessToken(String token) async {
    await _storageProvider.write(_accessTokenKey, token);
    logger('setAccessToken');
  }

  Future<void> setRefreshToken(String token) async {
    await _storageProvider.write(_refreshTokenKey, token);
    logger('setRefreshToken');
  }

  String? getAccessToken() {
    return _storageProvider.read<String>(_accessTokenKey);
  }

  String? getRefreshToken() {
    return _storageProvider.read<String>(_refreshTokenKey);
  }

  bool isTokenAvailable() {
    final accessToken = getAccessToken();
    final refreshToken = getRefreshToken();
    logger('isTokenAvailable: $accessToken, $refreshToken');
    return accessToken != null && refreshToken != null;
  }

  Future<void> clearTokens() async {
    await _storageProvider.delete(_accessTokenKey);
    await _storageProvider.delete(_refreshTokenKey);
    logger('clearTokens');
  }

  /// Clears all authentication related data (user and token)
  Future<void> clearAuthData() async {
    await clearTokens();
    logger('clearAuthData');
  }

  /// Clears all stored data
  Future<void> clearAll() async {
    await _storageProvider.clear();
    logger('clearAll');
  }

  // =============== Selectmodule Management ===============

  // check selectmodule is available
  bool isSelectmoduleAvailable() {
    return _storageProvider.read(_selectmoduleKey) != null;
  }

  Future<void> saveSelectmodule(Selectmodule selectmodule) async {
    await _storageProvider.write(_selectmoduleKey, selectmodule);
    logger('saveSelectmodule');
  }

  Selectmodule? getSelectmodule() {
    return _storageProvider.read<Selectmodule>(_selectmoduleKey);
  }

  Future<void> clearSelectmodule() async {
    await _storageProvider.delete(_selectmoduleKey);
    logger('clearSelectmodule');
  }

  // =============== User Management ===============

  // check user is available
  bool isUserAvailable() {
    return _storageProvider.read(_userKey) != null;
  }

  Future<void> saveUser(User user) async {
    await _storageProvider.write(_userKey, user.toJson());
    logger('saveUser');
  }

  User? getUser() {
    final userJson = _storageProvider.read<Map<String, dynamic>>(_userKey);
    if (userJson != null) {
      return User.fromJson(userJson);
    }
    return null;
  }

  Future<void> clearUser() async {
    await _storageProvider.delete(_userKey);
    logger('clearUser');
  }
}
