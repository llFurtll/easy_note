import 'package:flutter/material.dart' hide DatePickerTheme;
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';

class LocaleTypeEasyNote {
  const LocaleTypeEasyNote._(this.locale);

  final LocaleType locale;

  static const en = LocaleTypeEasyNote._(LocaleType.en);
  static const fa = LocaleTypeEasyNote._(LocaleType.fa);
  static const zh = LocaleTypeEasyNote._(LocaleType.zh);
  static const nl = LocaleTypeEasyNote._(LocaleType.nl);
  static const ru = LocaleTypeEasyNote._(LocaleType.ru);
  static const it = LocaleTypeEasyNote._(LocaleType.it);
  static const fr = LocaleTypeEasyNote._(LocaleType.fr);
  static const gr = LocaleTypeEasyNote._(LocaleType.gr);
  static const es = LocaleTypeEasyNote._(LocaleType.es);
  static const pl = LocaleTypeEasyNote._(LocaleType.pl);
  static const pt = LocaleTypeEasyNote._(LocaleType.pt);
  static const ko = LocaleTypeEasyNote._(LocaleType.ko);
  static const kk = LocaleTypeEasyNote._(LocaleType.kk);
  static const ar = LocaleTypeEasyNote._(LocaleType.ar);
  static const tr = LocaleTypeEasyNote._(LocaleType.tr);
  static const az = LocaleTypeEasyNote._(LocaleType.az);
  static const jp = LocaleTypeEasyNote._(LocaleType.jp);
  static const de = LocaleTypeEasyNote._(LocaleType.de);
  static const da = LocaleTypeEasyNote._(LocaleType.da);
  static const mn = LocaleTypeEasyNote._(LocaleType.mn);
  static const bn = LocaleTypeEasyNote._(LocaleType.bn);
  static const vi = LocaleTypeEasyNote._(LocaleType.vi);
  static const hy = LocaleTypeEasyNote._(LocaleType.hy);
  static const id = LocaleTypeEasyNote._(LocaleType.id);
  static const bg = LocaleTypeEasyNote._(LocaleType.bg);
  static const eu = LocaleTypeEasyNote._(LocaleType.eu);
  static const cat = LocaleTypeEasyNote._(LocaleType.cat);
  static const th = LocaleTypeEasyNote._(LocaleType.th);
  static const si = LocaleTypeEasyNote._(LocaleType.si);
  static const no = LocaleTypeEasyNote._(LocaleType.no);
  static const sq = LocaleTypeEasyNote._(LocaleType.sq);
  static const sv = LocaleTypeEasyNote._(LocaleType.sv);
  static const kh = LocaleTypeEasyNote._(LocaleType.kh);
  static const tw = LocaleTypeEasyNote._(LocaleType.tw);
  static const fi = LocaleTypeEasyNote._(LocaleType.fi);
}

abstract class DateTimePickerEasyNote {
  Future<void> show({
    required BuildContext context,
    bool showTitleActions,
    DateTime? minTime,
    DateTime? maxTime,
    Function(DateTime? date)? onChanged,
    Function(DateTime? date)? onConfirm,
    Function()? onCancel,
    DateTime? currentTime,
    LocaleTypeEasyNote? locale
  });
}

class DateTimePickerEasyNoteImpl extends DateTimePickerEasyNote {
  @override
  Future<void> show({
    required BuildContext context,
    bool showTitleActions = false,
    DateTime? minTime,
    DateTime? maxTime,
    Function(DateTime? date)? onChanged,
    Function(DateTime? date)? onConfirm,
    Function()? onCancel,
    DateTime? currentTime,
    LocaleTypeEasyNote? locale
  }) async {
    await DatePicker.showDateTimePicker(
      context,
      theme: DatePickerTheme(
        backgroundColor: Colors.blueGrey.shade50,
        doneStyle: const TextStyle(
          color: Colors.green
        ),
        cancelStyle: const TextStyle(
          color: Colors.red
        )
      ),
      showTitleActions: showTitleActions,
      minTime: minTime,
      maxTime: maxTime,
      onChanged: onChanged,
      onConfirm: onConfirm,
      onCancel: onCancel,
      currentTime: currentTime,
      locale: locale?.locale,
    );
  }
}