import 'package:flutter_highlight/themes/dark.dart';
import 'package:flutter_highlight/themes/github-gist.dart';
import 'package:flutter_highlight/themes/mono-blue.dart';
import 'package:flutter_highlight/themes/monokai-sublime.dart';
import 'package:flutter_highlight/themes/monokai.dart';
import 'package:flutter_highlight/themes/night-owl.dart';
import 'package:highlight/languages/python.dart';
import 'package:highlight/languages/javascript.dart';
import 'package:highlight/languages/java.dart';
import 'package:highlight/languages/cpp.dart';
import 'package:highlight/languages/dart.dart';
import 'package:highlight/languages/kotlin.dart';

final themeOptions = {
  'Night Owl': nightOwlTheme,
  'Monokai': monokaiTheme,
  'Monokai Sublime': monokaiSublimeTheme,
  'GitHub Gist': githubGistTheme,
  'Mono Blue': monoBlueTheme,
  'Dark': darkTheme,
};
final languageOptions = {
  'Python': python,
  'JavaScript': javascript,
  'Java': java,
  'C++': cpp,
  'Dart': dart,
  'Kotlin': kotlin,
};