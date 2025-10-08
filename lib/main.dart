import 'package:datamanager/screens/KeyGenerationPage.dart';
import 'package:flutter/material.dart';
import 'services/activation_service.dart';
import 'screens/home_screen.dart';
import 'widgets/activation_dialog.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DataManager',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const ActivationWrapper(),
    );
  }
}

class ActivationWrapper extends StatefulWidget {
  const ActivationWrapper({super.key});

  @override
  State<ActivationWrapper> createState() => _ActivationWrapperState();
}

class _ActivationWrapperState extends State<ActivationWrapper> {
  final ActivationService _activationService = ActivationService();
  bool _isChecking = true;
  bool _isActivated = false;

  @override
  void initState() {
    super.initState();
    _checkActivation();
  }

  Future<void> _checkActivation() async {
    final isActivated = await _activationService.checkActivation();
    setState(() {
      _isActivated = isActivated;
      _isChecking = false;
    });

    if (!isActivated) {
      _showActivationDialog();
    }
  }

  void _showActivationDialog() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => ActivationDialog(
          onActivate: _activateApp,
        ),
      );
    });
  }

  Future<bool> _activateApp(String key) async {
    final success = await _activationService.activateApp(key);
    if (success) {
      setState(() {
        _isActivated = true;
      });
    }
    return success;
  }

  @override
  Widget build(BuildContext context) {
    if (_isChecking) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircularProgressIndicator(),
              const SizedBox(height: 20),
              Text(
                'DataManager',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 10),
              const Text('Vérification de l\'activation...'),
            ],
          ),
        ),
      );
    }

    if (!_isActivated) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.lock, size: 64, color: Colors.red),
              const SizedBox(height: 20),
              Text(
                'Application non activée',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 10),
              const Text('Veuillez activer l\'application'),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _showActivationDialog,  // Bouton pour afficher la boîte de dialogue d'activation
                child: const Text('Activer'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Navigation vers la page de génération de clé (modification ajoutée)
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>  KeyGenerationPage()),
                  );
                },
                child: const Text('Générer une clé'),  // Nouveau bouton pour générer une clé
              ),
            ],
          ),
        ),
      );
    }

    return const HomeScreen();
  }
}
