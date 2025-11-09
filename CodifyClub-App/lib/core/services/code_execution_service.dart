import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CodeExecutionService {
  static const pistonUrl = "https://emkc.org/api/v2/piston/execute";

  Future<String> runCode({
    required String language,
    required String fileExtension,
    required String code,
  }) async {
    try {
      final response = await http.post(
        Uri.parse(pistonUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "language": language,
          "version": "*",
          "files": [
            {"name": "main.$fileExtension", "content": code}
          ],
        }),
      );
      if (response.statusCode == 200) {
        return jsonDecode(response.body)['run']['output'];
      } else {
        return 'Error: Unable to run the code';
      }
    } on SocketException catch (e) {
      return 'Please Connect to Internet to Run Code';
    } catch (e) {
      return e.toString();
    }
  }
}
