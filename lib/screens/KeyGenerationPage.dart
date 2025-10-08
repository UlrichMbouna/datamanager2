import 'package:datamanager/services/KeyGenerationService.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class KeyGenerationPage extends StatefulWidget {
  @override
  _KeyGenerationPageState createState() => _KeyGenerationPageState();
}

class _KeyGenerationPageState extends State<KeyGenerationPage> {
  final KeyGenerationService _keyService = KeyGenerationService();
  String _generatedKey = '';
  bool _isCopied = false;

  void _generateKey() {
    setState(() {
      _generatedKey = _keyService.generateValidKey();
      _isCopied = false;
    });
  }

  void _copyToClipboard() {
    if (_generatedKey.isNotEmpty) {
      Clipboard.setData(ClipboardData(text: _generatedKey));
      setState(() {
        _isCopied = true;
      });
      
      // Réinitialiser l'état après 2 secondes
      Future.delayed(Duration(seconds: 2), () {
        if (mounted) {
          setState(() {
            _isCopied = false;
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Générateur de Clé',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue.shade700,
        elevation: 2,
        shadowColor: Colors.blue.shade200,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.blue.shade50,
              Colors.grey.shade100,
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Icône illustrative
              Icon(
                Icons.vpn_key_rounded,
                size: 64,
                color: Colors.blue.shade700,
              ),
              SizedBox(height: 16),
              
              // Titre principal
              Text(
                'Générateur de Clé Sécurisée',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: Colors.blue.shade900,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 8),
              
              // Description
              Text(
                'Générez une clé cryptographique sécurisée en un clic',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey.shade600,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 40),
              
              // Carte pour la clé générée
              Card(
                elevation: 4,
                shadowColor: Colors.blue.shade100,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Colors.white,
                  ),
                  child: Column(
                    children: [
                      Text(
                        'Clé Générée',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey.shade700,
                        ),
                      ),
                      SizedBox(height: 16),
                      
                      // Container pour la clé avec fond stylisé
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade50,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Colors.grey.shade300,
                            width: 1,
                          ),
                        ),
                        child: SelectableText(
                          _generatedKey.isEmpty ? 'Aucune clé générée' : _generatedKey,
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'Monospace',
                            fontWeight: FontWeight.w500,
                            color: _generatedKey.isEmpty ? Colors.grey.shade500 : Colors.blue.shade800,
                            height: 1.4,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(height: 20),
                      
                      // Boutons en ligne
                      Row(
                        children: [
                          // Bouton Générer
                          Expanded(
                            child: ElevatedButton(
                              onPressed: _generateKey,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue.shade600,
                                foregroundColor: Colors.white,
                                padding: EdgeInsets.symmetric(vertical: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                elevation: 2,
                                shadowColor: Colors.blue.shade300,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.autorenew_rounded, size: 20),
                                  SizedBox(width: 8),
                                  Text(
                                    'Générer',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(width: 12),
                          
                          // Bouton Copier
                          if (_generatedKey.isNotEmpty)
                            Expanded(
                              child: ElevatedButton(
                                onPressed: _copyToClipboard,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: _isCopied ? Colors.green.shade600 : Colors.teal.shade600,
                                  foregroundColor: Colors.white,
                                  padding: EdgeInsets.symmetric(vertical: 16),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  elevation: 2,
                                  shadowColor: _isCopied ? Colors.green.shade300 : Colors.teal.shade300,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      _isCopied ? Icons.check_rounded : Icons.copy_rounded,
                                      size: 20,
                                    ),
                                    SizedBox(width: 8),
                                    Text(
                                      _isCopied ? 'Copié !' : 'Copier',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              
              // Informations supplémentaires
              SizedBox(height: 30),
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.blue.shade100.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Colors.blue.shade200,
                    width: 1,
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.info_outline_rounded,
                      color: Colors.blue.shade700,
                      size: 20,
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Votre clé est générée localement et ne quitte jamais votre appareil.',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.blue.shade800,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}