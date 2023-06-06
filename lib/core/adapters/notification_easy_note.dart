import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

import '../../features/anotacao/domain/entities/anotacao.dart';
import '../../features/anotacao/presentation/create/view/anotacao_view.dart';
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
  Future<String?> getPayload();
}

class NotificationEasyNoteImpl extends NotificationEasyNote {
  static final _channelID = UniqueKey().hashCode;

  final _notification = FlutterLocalNotificationsPlugin();

  @override
  Future<void> init(BuildContext context) async {
    var config = const AndroidInitializationSettings('icon');
    var initializationSettings = InitializationSettings(
      android: config
    );
    _notification.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (details) {
        Navigator.of(context).pushNamed(
          AnotacaoScreen.routeAnotacao, arguments: int.tryParse(details.payload ?? "")
        );
      },
    );
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
        ticker: 'ticker',
        icon: "icon",
        color: const Color(0xFFA50044),
        colorized: true,
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
      payload: "$id"
    );
  }
  
  @override
  Future<void> cancelNotification({required int id}) async {
    await _notification.cancel(id);
  }

  @override
  Future<String?> getPayload() async {
    final details = await _notification.getNotificationAppLaunchDetails();
    if (details != null && details.didNotificationLaunchApp) {
      return details.notificationResponse?.payload;
    }

    return null;
  }
}