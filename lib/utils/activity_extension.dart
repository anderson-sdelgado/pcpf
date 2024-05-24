import 'package:flutter/material.dart';
import 'package:pcp/app_style.dart';
import 'package:pcp/utils/enum.dart';

Future<void> showDialogDefault(BuildContext context, String text) async {
  return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            title: const Text("ATENÇÃO"),
            content: Text(text),
            actions: <Widget>[
              // usually buttons at the bottom of the dialog
              TextButton(
                child: const Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ]
        );
      }
  );
}

Future<void> showDialogDefaultFunction(BuildContext context, String text, Future<void> function) async {
  return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            title: const Text("ATENÇÃO"),
            content: Text(text),
            actions: <Widget>[
              // usually buttons at the bottom of the dialog
              TextButton(
                child: const Text("OK"),
                onPressed: () async {
                  Navigator.of(context).pop();
                  await function;
                },
              )
            ]
        );
      }
  );
}


Widget buildKeyboardButton(String label, double sizeFont, Function setText,
    {int flex = 1, TypeButton type = TypeButton.NUMERIC}) {
  return Expanded(
    flex: flex,
    child: Padding(
      padding: const EdgeInsets.all(2),
      child: ElevatedButton(
        style: ButtonStyle(
          shape: MaterialStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
        ),
        child: Text(
          label,
          style: TextStyle(fontSize: sizeFont, fontWeight: FontWeight.bold),
        ),
        onPressed: () {
          setText(label, type);
        },
      ),
    ),
  );
}

Widget buildKeyboard(Function setText) {
  AppTheme style = AppTheme();
  const SIZE_FONT_NUM = 24.0;
  const SIZE_FONT_CLEAR = 16.0;
  return Expanded(
    flex: 1,
    child: Padding(
      padding: style.textFieldMarginDefault,
      child: Column(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                buildKeyboardButton('7', SIZE_FONT_NUM, setText),
                buildKeyboardButton('8', SIZE_FONT_NUM, setText),
                buildKeyboardButton('9', SIZE_FONT_NUM, setText),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                buildKeyboardButton('4', SIZE_FONT_NUM, setText),
                buildKeyboardButton('5', SIZE_FONT_NUM, setText),
                buildKeyboardButton('6', SIZE_FONT_NUM, setText),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                buildKeyboardButton('1', SIZE_FONT_NUM, setText),
                buildKeyboardButton('2', SIZE_FONT_NUM, setText),
                buildKeyboardButton('3', SIZE_FONT_NUM, setText),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                buildKeyboardButton('APAGAR', SIZE_FONT_CLEAR, setText, type: TypeButton.CLEAR),
                buildKeyboardButton('0', SIZE_FONT_NUM, setText),
                buildKeyboardButton('OK', SIZE_FONT_NUM, setText, type: TypeButton.OK),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                buildKeyboardButton(
                    'Atualização de Dados', SIZE_FONT_NUM, setText, flex: 3, type: TypeButton.UPDATE),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

void addTextField(TextEditingController textEditingController, String label){
  textEditingController.text += label;
}

void clearTextField(TextEditingController textEditingController){
  final text = textEditingController.text;
  textEditingController.text = text.length > 1 ? text.substring(0, text.length - 1) : '';
}