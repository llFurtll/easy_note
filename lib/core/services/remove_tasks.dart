import 'dart:async';

import 'package:screen_manager/screen_mediator.dart';

import '../adapters/shared_preferences_easy_note.dart';

class RemoveTasks {
  final _shared = SharedPreferencesEasyNoteImpl();

  Timer? _timer;

  void execute() {
    _timer ??= Timer.periodic(const Duration(seconds: 10), (timer) {
      List<String>? tasks = _shared.getKeys();
      if (tasks.isNotEmpty) {
        for (String task in tasks) {
          final date = DateTime.tryParse(_shared.getString(identity: task)!);
          if (date != null && date.isBefore(DateTime.now())) {
            _shared.remove(identity: task);
            ScreenMediator.callScreen("Home", "update", null);
          }
        }
      }
    });
  }

  void dispose() {
    _timer?.cancel();
  }
}