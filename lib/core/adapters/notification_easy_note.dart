import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

import '../../features/anotacao/domain/entities/anotacao.dart';
import '../storage/mensagens.dart';

abstract class NotificationEasyNote {
  Future<void> init(BuildContext context);
  Future<void> createNotification({
    required int id,
    required DateTime dateTime,
    required Anotacao anotacao
  });
  Future<void> cancelNotification({
    required int id
  });
}

class NotificationEasyNoteImpl extends NotificationEasyNote {
  static final _channelID = UniqueKey().hashCode;

  final _notification = FlutterLocalNotificationsPlugin();

  @override
  Future<void> init(BuildContext context) async {
    var config = const AndroidInitializationSettings('app_icon');
    var initializationSettings = InitializationSettings(
      android: config
    );
    _notification.initialize(initializationSettings);
    _notification
      .resolvePlatformSpecificImplementation
        <AndroidFlutterLocalNotificationsPlugin>()?.requestPermission();
  }
  
  @override
  Future<void> createNotification({
    required int id,
    required DateTime dateTime,
    required Anotacao anotacao
  }) async {
    final details = NotificationDetails(
      android: AndroidNotificationDetails(
        "$_channelID",
        "Lembretes de anotação",
        channelDescription: 'Todos os lembretes configurados no EasyNote.',
        importance: Importance.max,
        priority: Priority.high,
        ticker: 'ticker'
      )
    );

    int random = Random().nextInt(50);
    if (random == 0) {
      random++;
    }
    final messageNotification = mensagens[random];

    await _notification.zonedSchedule(
      id,
      "${anotacao.titulo}",
      messageNotification,
      tz.TZDateTime.from(dateTime, tz.local),
      details,
      uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime,
      androidAllowWhileIdle: true,
      payload: "{ id: $id }"
    );
  }
  
  @override
  Future<void> cancelNotification({required int id}) async {
    await _notification.cancel(id);
  }
}