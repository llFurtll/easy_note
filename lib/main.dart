import 'package:flutter/material.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;

import 'routes/routes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  tz.initializeTimeZones();

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      theme: ThemeData(
        primaryColor: const Color(0xFFA50044),
        scaffoldBackgroundColor: Colors.white,
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Color(0XFFA50044)
        ),
        cardColor: const Color(0XFFFFFFFF),
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: Color(0XFFA50044)
        ),
        colorScheme: ColorScheme.fromSwatch().copyWith(secondary: const Color(0xFFA50044)),
        progressIndicatorTheme: const ProgressIndicatorThemeData(
          color: Color(0xFFA50044),
          circularTrackColor: Colors.white
        ),
        bottomSheetTheme: const BottomSheetThemeData(
          backgroundColor: Colors.transparent
        ),
        fontFamily: "roboto",
      ),
      routes: routes(),
      locale: const Locale('pt', 'BR'),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        quill.FlutterQuillLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('pt', 'BR'),
        ...quill.FlutterQuillLocalizations.supportedLocales,
      ],
    )
  );
}