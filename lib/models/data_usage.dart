class DataUsage {
  int? id;
  DateTime date;
  double usedData;
  double totalData;
  String periodType;

  DataUsage({
    this.id,
    required this.date,
    required this.usedData,
    required this.totalData,
    required this.periodType,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'date': date.millisecondsSinceEpoch,
      'usedData': usedData,
      'totalData': totalData,
      'periodType': periodType,
    };
  }

  factory DataUsage.fromMap(Map<String, dynamic> map) {
    return DataUsage(
      id: map['id'],
      date: DateTime.fromMillisecondsSinceEpoch(map['date']),
      usedData: map['usedData'],
      totalData: map['totalData'],
      periodType: map['periodType'],
    );
  }
}