import '../database/database_helper.dart';
import '../models/data_usage.dart';

class DataUsageService {
  final DatabaseHelper _dbHelper = DatabaseHelper();

  Future<void> addDailyUsage(double usedData, double totalData) async {
    final usage = DataUsage(
      date: DateTime.now(),
      usedData: usedData,
      totalData: totalData,
      periodType: 'daily',
    );
    await _dbHelper.insertDataUsage(usage);
  }

  Future<List<DataUsage>> getWeeklyUsage() async {
    return await _dbHelper.getDataUsagesByPeriod('daily');
  }

  Future<List<DataUsage>> getMonthlyUsage() async {
    return await _dbHelper.getDataUsagesByPeriod('daily');
  }

  Future<double> getTotalUsedThisMonth() async {
    final now = DateTime.now();
    final firstDay = DateTime(now.year, now.month, 1);

    final usages = await _dbHelper.getDataUsages();
    final monthlyUsages = usages.where(
      (usage) => usage.date.isAfter(firstDay) && usage.periodType == 'daily',
    ).toList();

    // ✅ Correction : forcer le type en double
    return monthlyUsages.fold<double>(0.0, (sum, usage) => sum + usage.usedData);
  }

  Future<double> getRemainingData(double monthlyLimit) async {
    final used = await getTotalUsedThisMonth();
    return monthlyLimit - used;
  }
}
