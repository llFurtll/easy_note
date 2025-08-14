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
    required Anotacao anotacao,
  });
  Future<void> cancelNotification({ required int id });
  Future<String?> getPayload();
}

class NotificationEasyNoteImpl extends NotificationEasyNote {
  static final _channelID = UniqueKey().hashCode;

  final _notification = FlutterLocalNotificationsPlugin();

  @override
  Future<void> init(BuildContext context) async {
    const androidInit = AndroidInitializationSettings('icon'); // mantenha seu recurso
    final initSettings = InitializationSettings(android: androidInit);

    await _notification.initialize(
      initSettings,
      onDidReceiveNotificationResponse: (details) {
        final id = int.tryParse(details.payload ?? '');
        if (id != null) {
          Navigator.of(context).pushNamed(
            AnotacaoScreen.routeAnotacao,
            arguments: id,
          );
        }
      },
      // Se quiser tratar quando app está em background:
      // onDidReceiveBackgroundNotificationResponse: yourCallback,
    );

    // Android 13+ precisa de permissão de notificação em runtime
    await _notification
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();
  }

  @override
  Future<void> createNotification({
    required int id,
    required DateTime dateTime,
    required Anotacao anotacao,
  }) async {
    final details = NotificationDetails(
      android: AndroidNotificationDetails(
        '$_channelID', // precisa ser String
        'Lembretes de anotação',
        channelDescription: 'Todos os lembretes configurados no EasyNote.',
        importance: Importance.max,
        priority: Priority.high,
        ticker: 'ticker',
        icon: 'icon',
        color: const Color(0xFFA50044),
        colorized: true,
      ),
    );

    // Usa o tamanho real da lista para evitar RangeError
    final rndIndex = Random().nextInt(mensagens.length);
    final messageNotification = mensagens[rndIndex];

    await _notification.zonedSchedule(
      id,
      '${anotacao.titulo}',
      messageNotification,
      tz.TZDateTime.from(dateTime, tz.local),
      details,
      // Novo parâmetro OBRIGATÓRIO em versões recentes
      // Se o lembrete puder ser "flexível", prefira inexactAllowWhileIdle (menor consumo).
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      payload: '$id',
      // Se fosse recorrente, você usaria `matchDateTimeComponents`.
      // matchDateTimeComponents: DateTimeComponents.time, // exemplo
    );
  }

  @override
  Future<void> cancelNotification({ required int id }) async {
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
