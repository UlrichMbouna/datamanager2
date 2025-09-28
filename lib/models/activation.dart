class Activation {
  String key;
  DateTime activationDate;
  DateTime? expirationDate;
  bool isValid;

  Activation({
    required this.key,
    required this.activationDate,
    this.expirationDate,
    required this.isValid,
  });

  Map<String, dynamic> toMap() {
    return {
      'key': key,
      'activationDate': activationDate.millisecondsSinceEpoch,
      'expirationDate': expirationDate?.millisecondsSinceEpoch,
      'isValid': isValid ? 1 : 0,
    };
  }

  factory Activation.fromMap(Map<String, dynamic> map) {
    return Activation(
      key: map['key'],
      activationDate: DateTime.fromMillisecondsSinceEpoch(map['activationDate']),
      expirationDate: map['expirationDate'] != null 
          ? DateTime.fromMillisecondsSinceEpoch(map['expirationDate'])
          : null,
      isValid: map['isValid'] == 1,
    );
  }
}