import 'dart:async';

class Debounce {
  static Timer? _debounce;

  static void debounce(Function() event) {
    if (_debounce?.isActive ?? false) {
      _debounce?.cancel();
    }

    _debounce = Timer(const Duration(milliseconds: 500), event);
  }

  static void close() {
    _debounce?.cancel();
  }
}
