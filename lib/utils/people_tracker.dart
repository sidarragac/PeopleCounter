class PeopleTracker {
  int _maxInSession = 0;
  final Map<int, int> _maxPerHour = <int, int>{};

  void updateCount(int count) {
    if (count > _maxInSession) {
      _maxInSession = count;
    }

    final int currentHour = DateTime.now().hour;
    if (!_maxPerHour.containsKey(currentHour) || count > _maxPerHour[currentHour]!) {
      _maxPerHour[currentHour] = count;
    }
  }

  void reset() {
    _maxInSession = 0;
    _maxPerHour.clear();
  }

  // Getters
  int get maxInSession => _maxInSession;

  Map<int, int> get maxPerHour => Map.unmodifiable(_maxPerHour);
}