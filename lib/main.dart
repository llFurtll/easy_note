import 'package:flutter/material.dart';

import 'routes/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

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
      ),
      routes: routes(),
    )
  );
}