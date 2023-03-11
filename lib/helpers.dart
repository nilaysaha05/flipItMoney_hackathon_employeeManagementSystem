import 'dart:math';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Helpers {
  static final random = Random();

  static String randomPictureUrl() {
    final randomInt = random.nextInt(1000);
    return 'https://picsum.photos/seed/$randomInt/300/300';
  }

  static generateRandomString(int len) {
    var r = Random();
    const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    return List.generate(len, (index) => _chars[r.nextInt(_chars.length)]).join();
  }

  Future<String> getDadJoke() async {
    var url = "https://icanhazdadjoke.com/";
    http.Response response =
    (await http.get(Uri.parse(url), headers: {"Accept": "text/plain"}));
    String body = response.body;
    return body;
  }

  showSnackBar(String content, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(content),
      ),
    );
  }
}