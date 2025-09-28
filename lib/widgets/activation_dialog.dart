import 'package:flutter/material.dart';

class ActivationDialog extends StatefulWidget {
  final Function(String) onActivate;

  const ActivationDialog({super.key, required this.onActivate});

  @override
  State<ActivationDialog> createState() => _ActivationDialogState();
}

class _ActivationDialogState extends State<ActivationDialog> {
  final _keyController = TextEditingController();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Activation Requise'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Entrez votre clé d\'activation pour utiliser DataManager',
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          TextField(
            controller: _keyController,
            decoration: const InputDecoration(
              labelText: 'Clé d\'activation',
              border: OutlineInputBorder(),
              hintText: 'Entrez votre clé de 16 caractères',
            ),
          ),
        ],
      ),
      actions: [
        if (!_isLoading)
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Annuler'),
          ),
        ElevatedButton(
          onPressed: _isLoading ? null : _activate,
          child: _isLoading 
              ? const SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(),
                )
              : const Text('Activer'),
        ),
      ],
    );
  }

  Future<void> _activate() async {
    if (_keyController.text.isEmpty) return;

    setState(() => _isLoading = true);

    final success = await widget.onActivate(_keyController.text);
    
    if (!mounted) return;
    
    setState(() => _isLoading = false);

    if (success) {
      Navigator.of(context).pop();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Clé d\'activation invalide'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}