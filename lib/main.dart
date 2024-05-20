import 'package:flutter/material.dart';
import 'package:pcp/app_module.dart';
import 'package:pcp/app_widget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setup();
  runApp(
    FutureBuilder(
        future: getIt.allReady(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return const AppWidget();
        }),
  );
  // runApp(const AppWidget());
}
