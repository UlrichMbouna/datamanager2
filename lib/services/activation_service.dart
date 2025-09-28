import 'dart:convert';
import 'package:crypto/crypto.dart';
import '../database/database_helper.dart';
import '../models/activation.dart';

class ActivationService {
  final DatabaseHelper _dbHelper = DatabaseHelper();


  static const String DEFAULT_KEY = "DEFAULT_KEY_1234";

  bool _validateKey(String key) {
    if (key == DEFAULT_KEY) return true;


    final bytes = utf8.encode('datamanager_2024$key');
    final hash = sha256.convert(bytes).toString();

    
    return key.length == 16 && hash.startsWith('a1b2');
  }

  Future<bool> activateApp(String key) async {
    if (!_validateKey(key)) {
      return false;
    }

    final activation = Activation(
      key: key,
      activationDate: DateTime.now(),
      expirationDate: DateTime.now().add(const Duration(days: 365)),
      isValid: true,
    );

    await _dbHelper.deleteActivation();
    await _dbHelper.insertActivation(activation);
    return true;
  }

  Future<bool> checkActivation() async {
    final activation = await _dbHelper.getActivation();
    if (activation == null) return false;

    // Si c’est la clé par défaut -> toujours valide et sans expiration
    if (activation.key == DEFAULT_KEY) {
      return true;
    }

    if (activation.expirationDate != null &&
        DateTime.now().isAfter(activation.expirationDate!)) {
      return false;
    }

    return activation.isValid && _validateKey(activation.key);
  }

  Future<void> deactivateApp() async {
    await _dbHelper.deleteActivation();
  }
}
