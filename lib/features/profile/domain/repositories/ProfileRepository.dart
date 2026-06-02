import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

class Profilerepository {
  static const String cloudName = "logocloudname";
  static const String uploadPreset = "Product_preset";

  Future<String?> uploadImage(File file) async {
    try {
      final uploadUrl = Uri.parse(
        "https://api.cloudinary.com/v1_1/$cloudName/image/upload",
      );

      final request = http.MultipartRequest("POST", uploadUrl)
        ..fields['upload_preset'] = uploadPreset;

      request.files.add(await http.MultipartFile.fromPath('file', file.path));

      final response = await request.send();
      if (response.statusCode == 200) {
        final body = await response.stream.bytesToString();
        final data = jsonDecode(body);

        return data["secure_url"];
      }
      return null;
    } catch (e) {
      print(e);
      return null;
    }
  }
}
