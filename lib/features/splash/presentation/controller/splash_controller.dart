import 'package:flutter/material.dart';
import 'package:screen_manager/screen_controller.dart';
import 'package:screen_manager/screen_injection.dart';

import '../../../../core/adapters/notification_easy_note.dart';
import '../../../../core/adapters/shared_preferences_easy_note.dart';
import '../../../../core/adapters/speech_text_easy_note.dart';
import '../../../../core/arguments/atualizacao_detalhe_view_arguments.dart';
import '../../../../core/failures/failures.dart';
import '../../../../core/result/result.dart';
import '../../../../core/storage/storage.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../atualizacao/domain/usecases/get_existe_atualizacao_without_view.dart';
import '../../../atualizacao/presentation/atualizacao_detalhe/view/atualizacao_detalhe_view.dart';
import '../../../home/presentation/view/home_view.dart';
import '../injection/splash_injection.dart';

class SplashController extends ScreenController {
  final _speech = SpeechTextEasyNoteImpl();
  final _notification = NotificationEasyNoteImpl();
  final _shared = SharedPreferencesEasyNoteImpl();

  @override
  void onInit() {
    super.onInit();

    Future.value()
      .then((_) => StorageImpl().initStorage())
      .then((_) => _init())
      .then((_) => Future.delayed(const Duration(seconds: 2)))
      .then((_) => getVersao())
      .then((response) async {
        return response.fold((left) => null, (idVersao) async {
          if (idVersao != 0) {
            final existe = await getExisteVersaoWithoutView(idVersao);
            return existe.fold((left) => null, (right) {
              if (right) {
                return idVersao;
              }

              return null;
            });
          }

          return null;
        });
      })
      .then((result) async {
        if (result == null) {
          toHome();
          return;
        }

        if (result > 0) {
          toAtualizacao(result);
        }
      });
  }

  Future<Result<Failure, int>> getVersao() async {
    final getFindLastVersao = ScreenInjection.of<SplashInjection>(context).getFindLastVersao;
    return await getFindLastVersao(NoParams());
  }

  Future<Result<Failure, bool>> getExisteVersaoWithoutView(int idVersao) async {
    final getExisteVersaoWithoutView = ScreenInjection.of<SplashInjection>(context).getExisteAtualizacaoWithoutView;
    return await getExisteVersaoWithoutView(GetExisteAtualizacaoWithoutViewParams(idVersao: idVersao));
  }

  void toHome() {
    Navigator.of(context).pushNamed(Home.routeHome);
  }

  void toAtualizacao(int idVersao) {
    Navigator.of(context).pushNamed(
      AtualizacaoDetalhe.routeAtualizacaoDetalhe,
      arguments: AtualizacaoDetalheViewArguments(idVersao: idVersao, isSplash: true)
    );
  }

  Future<void> _init() async {
    Future.value()
      .then((_) => _speech.init())
      // ignore: use_build_context_synchronously
      .then((_) => _notification.init(context))
      .then((_) => _shared.init());
  }
}