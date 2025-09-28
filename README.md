# DataManager - Suivi de Consommation d'Internet

![Flutter](https://img.shields.io/badge/Flutter-3.7+-blue.svg)
![Dart](https://img.shields.io/badge/Dart-3.7+-blue.svg)
![License](https://img.shields.io/badge/License-MIT-green.svg)

Application Flutter pour le suivi et la gestion de votre consommation de données Internet avec système d'activation sécurisé.

## 📱 Fonctionnalités

### ✨ Fonctionnalités Principales
- 📊 **Suivi en temps réel** de la consommation de données
- 📈 **Visualisation graphique** de l'utilisation quotidienne/mensuelle
- ⚠️ **Alertes automatiques** lorsque vous approchez de votre limite
- 💾 **Stockage local sécurisé** avec SQLite
- 🔐 **Système d'activation** par clé de licence

### 🛡️ Sécurité
- Activation obligatoire au premier lancement
- Protection contre la copie non autorisée
- Données stockées localement sur l'appareil

## 🚀 Installation

### Prérequis

- **Flutter SDK** version 3.7.0 ou supérieure
- **Dart** version 3.7.0 ou supérieure
- Un émulateur ou appareil Android/iOS

### 📥 Installation pas à pas

1. **Cloner le projet**
```bash
git clone <votre-repo>
cd datamanager
```

2. **Installer les dépendances**
```bash
flutter pub get
```

3. **Vérifier la configuration**
```bash
flutter doctor
```

4. **Lancer l'application**
```bash
flutter run
```

## 🔑 Activation

### Premier Lancement
1. À l'ouverture, l'application affichera un écran d'activation
2. Entrez l'une des clés de développement suivantes :
   ```
   DEFAULT_KEY_1234 (default)
   DATAMANAGER2024
   TESTKEY12345678
   ACTIVATION2024
   1234567890123456
   ```

### Processus d'Activation
- La clé doit contenir au moins 8 caractères
- L'activation est valable 1 an
- Une seule activation par appareil

## 📦 Génération de l'APK

### APK de Débogage
```bash
flutter build apk --debug
```
**Emplacement :** `build/app/outputs/flutter-apk/app-debug.apk`

### APK de Production
```bash
flutter build apk --release
```
**Emplacement :** `build/app/outputs/flutter-apk/app-release.apk`

### Signature de l'APK (Optionnel)
```bash
keytool -genkey -v -keystore release-key.keystore -alias datamanager -keyalg RSA -keysize 2048 -validity 10000
flutter build apk --release --split-per-abi
```

## 🎯 Utilisation

### Écran Principal
- **Tableau de bord** : Vue d'ensemble de la consommation
- **Cartes de données** : Utilisation actuelle et restante
- **Statistiques** : Pourcentage d'utilisation et tendances

### Ajout de Données
1. Cliquez sur "Ajouter Données Test" pour simuler l'utilisation
2. Les données sont automatiquement enregistrées
3. Les statistiques se mettent à jour en temps réel

### Paramètres
- Accédez aux paramètres via l'icône ⚙️
- Gérer l'activation de l'application
- Consulter les informations de licence

## 🗃️ Base de Données

### Structure
L'application utilise SQLite avec deux tables principales :

#### Table `data_usage`
| Champ | Type | Description |
|-------|------|-------------|
| id | INTEGER | Clé primaire |
| date | INTEGER | Timestamp de l'utilisation |
| usedData | REAL | Données utilisées (GB) |
| totalData | REAL | Limite totale (GB) |
| periodType | TEXT | Type de période (daily) |

#### Table `activation`
| Champ | Type | Description |
|-------|------|-------------|
| key | TEXT | Clé d'activation |
| activationDate | INTEGER | Date d'activation |
| expirationDate | INTEGER | Date d'expiration |
| isValid | INTEGER | Statut de validité |

## 🔧 Développement

### Structure du Projet
```
lib/
├── main.dart                 # Point d'entrée
├── models/                   # Modèles de données
│   ├── data_usage.dart
│   └── activation.dart
├── database/                 # Gestion base de données
│   └── database_helper.dart
├── services/                 # Logique métier
│   ├── data_usage_service.dart
│   └── activation_service.dart
├── widgets/                  # Composants UI
│   ├── data_usage_card.dart
│   └── activation_dialog.dart
└── screens/                  # Écrans de l'application
    ├── home_screen.dart
    └── settings_screen.dart
```

### Dépendances Utilisées
- **sqflite** : Base de données SQLite
- **path** : Gestion des chemins de fichiers
- **crypto** : Chiffrement pour le système d'activation
- **shared_preferences** : Stockage des préférences

### Personnalisation
Pour adapter l'application à vos besoins :

1. **Modifier les limites de données** :
   - Éditez `_monthlyLimit` dans `home_screen.dart`

2. **Changer la logique d'activation** :
   - Modifiez `_validateKey` dans `activation_service.dart`

3. **Ajouter de nouvelles métriques** :
   - Étendez le modèle `DataUsage`
   - Ajoutez les méthodes dans `DataUsageService`

## 🐛 Dépannage

### Problèmes Courants

#### ❌ "Clé d'activation invalide"
- Vérifiez que la clé fait au moins 8 caractères
- Utilisez l'une des clés de test fournies

#### ❌ Erreur de base de données
- Supprimez l'application et réinstallez
- Vérifiez les permissions de stockage

#### ❌ L'application ne se lance pas
- Exécutez `flutter clean`
- Puis `flutter pub get`
- Redémarrez l'application

### Logs de Débogage
Activez les logs en modifiant `activation_service.dart` :
```dart
bool _validateKey(String key) {
  print('🔑 Clé testée: $key');
  // Votre logique de validation...
}
```

## 📄 Licence

Ce projet est sous licence MIT. Voir le fichier `LICENSE` pour plus de détails.

### Conditions d'Utilisation
- Usage personnel et commercial autorisé
- Modification et distribution permises
- Attribution non requise

## 🤝 Contribution

Les contributions sont les bienvenues ! Pour contribuer :

1. Fork le projet
2. Créez votre branche (`git checkout -b feature/AmazingFeature`)
3. Commit vos changements (`git commit -m 'Add some AmazingFeature'`)
4. Push sur la branche (`git push origin feature/AmazingFeature`)
5. Ouvrez une Pull Request

## 📞 Support

Pour toute question ou problème :
1. Consultez les [Issues GitHub](https://github.com/votre-repo/issues)
2. Créez un nouveau ticket avec une description détaillée
3. Joignez les logs d'erreur si possible

## 🔄 Versions

- **Version 1.0.0** (Current)
  - Suivi basique de consommation
  - Système d'activation
  - Interface utilisateur simple

---

**Développé avec ❤️ en utilisant Flutter & Dart**