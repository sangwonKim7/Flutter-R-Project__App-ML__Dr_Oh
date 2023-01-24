class CheckupHistoryModel {
  final DateTime _checkupHistory = DateTime.now();
  final String _checkupName = '당뇨';
  final int _checkupResult = 0;

  DateTime get date => _checkupHistory;
  String get name => _checkupName;
  int get result => _checkupResult;
}
