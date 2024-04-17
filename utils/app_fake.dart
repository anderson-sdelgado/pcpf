import 'package:flutter/material.dart';

class AppFake {

  Widget buildTestableWidget(Widget widget) => MaterialApp(
    home: widget,
  );

}
