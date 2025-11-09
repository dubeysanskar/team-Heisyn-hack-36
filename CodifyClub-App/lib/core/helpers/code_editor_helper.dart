import 'package:codifyclub/Core/Constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_code_editor/flutter_code_editor.dart';

String getLanguageKey(
    dynamic currentLanguage, Map<String, dynamic> languageOptions) {
  return languageOptions.entries
      .firstWhere((entry) => entry.value == currentLanguage)
      .key
      .toLowerCase();
}

String getFileExtension(String languageKey) {
  switch (languageKey) {
    case 'python':
      return 'py';
    case 'javascript':
      return 'js';
    case 'java':
      return 'java';
    case 'c++':
      return 'cpp';
    case 'dart':
      return 'dart';
    case 'kotlin':
      return 'kt';
    default:
      return 'txt';
  }
}

//Alert Dialog for Output (Temporary hai)
void showOutputDialog(BuildContext context, String output) {
  if (output == 'Please Connect to Internet to Run Code') {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Please Connect to Internet to Run Code '),
      behavior: SnackBarBehavior.floating,
      backgroundColor: AppColors.pinkRose.withOpacity(0.5),
      duration: Duration(seconds: 2),
      // closeIconColor: AppColors.white,
      // showCloseIcon: true,
    ));
  }
  else {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          scrollable: true,
          title: Text("Output"),
          content: Text(output),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("OK",style: TextStyle(color: AppColors.pinkRose),),
            ),
          ],
        );
      },
    );
  }
}

// Function to insert text at the cursor position in the editor (bug solved usign GPT)
void insertTextAtCursor(CodeController controller, String textToInsert) {
  final oldText = controller.text;
  final selection = controller.selection;
  final newText = oldText.replaceRange(
    selection.start,
    selection.end,
    textToInsert,
  );

  controller.text = newText;
  controller.selection =
      TextSelection.collapsed(offset: selection.start + textToInsert.length);
}
