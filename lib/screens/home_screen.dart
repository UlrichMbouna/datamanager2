import 'package:datamanager/screens/settings_screen.dart';
import 'package:flutter/material.dart';
import '../widgets/data_usage_card.dart';
import '../services/data_usage_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final DataUsageService _dataService = DataUsageService();
  final double _monthlyLimit = 100.0;
  double _usedData = 0.0;
  double _remainingData = 0.0;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final used = await _dataService.getTotalUsedThisMonth();
    final remaining = await _dataService.getRemainingData(_monthlyLimit);
    
    setState(() {
      _usedData = used;
      _remainingData = remaining;
    });
  }

  Future<void> _addTestData() async {
    // Ajouter des données de test aléatoires
    final randomUsage = 0.5 + (DateTime.now().millisecond % 10) * 0.1;
    await _dataService.addDailyUsage(randomUsage, _monthlyLimit);
    _loadData();
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Données test ajoutées: ${randomUsage.toStringAsFixed(2)} GB'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DataManager'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadData,
            tooltip: 'Actualiser',
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingsScreen()),
              );
            },
            tooltip: 'Paramètres',
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Suivi de Consommation',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            DataUsageCard(
              title: 'Consommation Mensuelle',
              usedData: _usedData,
              totalData: _monthlyLimit,
              color: Colors.blue,
            ),
            const SizedBox(height: 16),
            DataUsageCard(
              title: 'Données Restantes',
              usedData: _remainingData,
              totalData: _monthlyLimit,
              color: Colors.green,
            ),
            const SizedBox(height: 24),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Statistiques du Mois',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    _buildStatRow('Utilisé', '${_usedData.toStringAsFixed(2)} GB'),
                    _buildStatRow('Restant', '${_remainingData.toStringAsFixed(2)} GB'),
                    _buildStatRow('Limite', '${_monthlyLimit.toStringAsFixed(0)} GB'),
                    _buildStatRow('Pourcentage', '${(_usedData / _monthlyLimit * 100).toStringAsFixed(1)}%'),
                  ],
                ),
              ),
            ),
            const Spacer(),
            Center(
              child: ElevatedButton.icon(
                onPressed: _addTestData,
                icon: const Icon(Icons.add),
                label: const Text('Ajouter Données Test'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}