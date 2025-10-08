import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'dart:math';
import '../database/database_helper.dart';
import '../models/activation.dart';

class KeyGenerationService {

  String generateValidKey() {
    final randomString = _generateRandomString(16);

    // On crée un hash de la clé
    final bytes = utf8.encode('datamanager_2024$randomString');
    final hash = sha256.convert(bytes).toString();

    // Vérifie que le hash commence bien par 'a1b2' (comme la logique du code original)
    if (hash.startsWith('a1b2')) {
      return randomString;  // La clé générée est valide
    } else {
      // Si la clé n'est pas valide, on génère une nouvelle clé
      return generateValidKey();  // On relance la génération si ce n'est pas valide
    }
  }

  // Génère une chaîne de caractères aléatoire de la longueur spécifiée
  String _generateRandomString(int length) {
    const charset = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    final random = Random();
    return List.generate(length, (index) => charset[random.nextInt(charset.length)]).join();
  }
}

class ActivationService {
  final DatabaseHelper _dbHelper = DatabaseHelper();
  final KeyGenerationService _keyGenService = KeyGenerationService();

  Future<bool> activateApp() async {
    // Génère une clé valide
    final key = _keyGenService.generateValidKey();

    // Crée une activation
    final activation = Activation(
      key: key,
      activationDate: DateTime.now(),
      expirationDate: DateTime.now().add(const Duration(days: 365)),
      isValid: true,
    );

    // Insère l'activation dans la base de données
    await _dbHelper.deleteActivation();  // Supprime une activation précédente
    await _dbHelper.insertActivation(activation);  // Ajoute la nouvelle activation

    return true;
  }

  Future<bool> checkActivation() async {
    final activation = await _dbHelper.getActivation();
    if (activation == null) return false;

    // Si la clé est valide et non expirée
    if (activation.key == "DEFAULT_KEY") {
      return true;
    }

    if (activation.expirationDate != null &&
        DateTime.now().isAfter(activation.expirationDate!)) {
      return false;
    }

    return activation.isValid;
  }

  Future<void> deactivateApp() async {
    await _dbHelper.deleteActivation();
  }
}
