import 'package:codifyclub/Core/Constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_code_editor/flutter_code_editor.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/constants/code_editor.dart';
import '../../core/helpers/code_editor_helper.dart';
import '../../core/services/code_execution_service.dart';
import '../widgets/code_editor_toolbar.dart';

class CodeEditor extends StatefulWidget {
  const CodeEditor();

  @override
  _CodeEditorState createState() => _CodeEditorState();
}

class _CodeEditorState extends State<CodeEditor> {
  Map<String, TextStyle> _currentTheme = themeOptions['Night Owl']!;
  dynamic _currentLanguage = languageOptions['Python']!;
  final controller = CodeController(text: '''# Python Code\nprint("Hello, World!")\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n''', language: languageOptions['Python']);

  void _changeTheme(String selectedTheme) {
    setState(() {
      _currentTheme = themeOptions[selectedTheme]!;
    });
  }

  void _changeLanguage(String selectedLanguage) {
    setState(() {
      _currentLanguage = languageOptions[selectedLanguage];
      controller.language = _currentLanguage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final output = await CodeExecutionService().runCode(
            language: getLanguageKey(_currentLanguage, languageOptions),
            fileExtension: getFileExtension(getLanguageKey(_currentLanguage, languageOptions)),
            code: controller.text,
          );
          showOutputDialog(context, output);
        },
        child: Icon(Icons.play_arrow,color:AppColors.policeBlue,size: 35.w,),
        backgroundColor: AppColors.pinkRose,
        shape: CircleBorder(),
      ),
      appBar: AppBar(
        backgroundColor:AppColors.policeBlue,
        title: Text(getLanguageKey(_currentLanguage, languageOptions).toUpperCase(),style: TextStyle(color: AppColors.seaBlue),),
        actions: [
          _buildPopupMenu(Icons.color_lens_outlined, themeOptions.keys, _changeTheme),
          _buildPopupMenu(Icons.code_outlined, languageOptions.keys, _changeLanguage),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: CodeTheme(
              data: CodeThemeData(styles: _currentTheme),
              child: SingleChildScrollView(
                child: CodeField(
                  controller: controller,
                  textStyle: TextStyle(fontFamily: 'monospace', fontSize: 16),
                  gutterStyle: GutterStyle(width: 80.w),
                ),
              ),
            ),
          ),
          CodeToolbar(controller: controller),
        ],
      ),
    );
  }

  PopupMenuButton<String> _buildPopupMenu(IconData icon, Iterable<String> options, Function(String) onSelected) {
    return PopupMenuButton<String>(
      icon: Icon(icon),
      onSelected: onSelected,
      itemBuilder: (BuildContext context) {
        return options.map((String choice) {
          return PopupMenuItem<String>(
            value: choice,
            child: Text(choice),
          );
        }).toList();
      },
    );
  }
}
