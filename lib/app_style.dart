import 'package:flutter/material.dart';
import 'package:pcp/utils/constant.dart';

class AppTheme {
  ThemeData get appStyle => ThemeData(
    primarySwatch: Colors.blue,
  );
  EdgeInsets get themeMarginDefault => const EdgeInsets.only(left: 16.0, right: 16.0);
  TextStyle get titleDefaultTextStyle => const TextStyle(
    fontSize: FONT_SIZE_TITLE_LIST,
    fontWeight: FontWeight.bold,
  );
  TextStyle get itemListTextStyle => const TextStyle(
    fontSize: FONT_SIZE_ITEM_LIST,
  );
  TextStyle get textFieldTextStyle => const TextStyle(
    fontSize: FONT_SIZE_ITEM_LIST,
  );
  EdgeInsets get textFieldMarginDefault => const EdgeInsets.only(left: 16.0, right: 16.0, top: 8.0, bottom: 8.0);
  EdgeInsets get buttonMarginDefault => const EdgeInsets.all(12.0);
}