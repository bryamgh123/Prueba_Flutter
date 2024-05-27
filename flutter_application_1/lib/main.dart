import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/graficas.dart';
import 'package:flutter_application_1/pages/list.dart';
import 'package:flutter_application_1/pages/save.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: ListPage.ROUTE,
      routes: {
        ListPage.ROUTE: (_) => ListPage(),
        SavePage.ROUTE: (_) => SavePage(),
        GraficasPage.ROUTE: (_) => GraficasPage()
      },
    );
  }
}
