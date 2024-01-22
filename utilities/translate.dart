import 'dart:convert';
import 'dart:io';
import 'package:translator/translator.dart';

void main() async {
  File willTranslateFile = File('../assets/localization_utilities/will_localizate.json');
  File currentTr = File('../assets/localization_utilities/tr_TR.json');
  Map<String, File> translatedFiles = {
    'tr': File('../assets/locales/tr_TR.json'),
    'en': File('../assets/locales/en_US.json'),
    'ar': File('../assets/locales/ar_AE.json'),
    'nl': File('../assets/locales/nl_NL.json'),
    'ru': File('../assets/locales/ru_RU.json'),
  };
  final willTranslateString = await willTranslateFile.readAsString();

  final Map<String, dynamic> willTranslateJson = jsonDecode(willTranslateString);
  for (var lang in translatedFiles.keys) {
    var translatedJson = await translate(lang, willTranslateJson);
    var readedFile = await translatedFiles[lang]!.readAsString();
    translatedJson = writeForAdd(readedFile, translatedJson);
    translatedFiles[lang]?.writeAsString(translatedJson);
    if (lang == "tr") currentTr.writeAsString(translatedJson);
  }

  processPrint("Complated");
  willTranslateFile.writeAsString("{}");
}

String writeForAdd(String current, String willAdd) {
  if (willAdd.isEmpty) return current + "}";
  current = current.replaceAll("}", "");
  willAdd = willAdd.replaceFirst("{", "");
  willAdd = willAdd.substring(0, willAdd.length - 1);
  if (willAdd.isNotEmpty) willAdd = current + "," + willAdd + "}";
  if (willAdd.isEmpty) willAdd = current + "}";
  return willAdd;
}

Future<String> translate(String lang, Map<String, dynamic> willTranslateJson) async {
  final translator = GoogleTranslator();
  Map<String, dynamic> newJson = {};
  processPrint(lang);
  for (var element in willTranslateJson.entries) {
    try {
      if (element.value is Map<String, dynamic>) {
        newJson[element.key] = await translateMapVariables(element, translator, lang, newJson);
        continue;
      }
      var translation = await translator.translate(element.value, from: 'tr', to: lang);
      print(translation.text);
      newJson.addAll({element.key: translation.text});
    } catch (e) {
      print(e.toString());
    }
  }
  String jsonEncoded = jsonEncodeCustom(newJson);
  return jsonEncoded;
}

Future<Map<String, dynamic>> translateMapVariables(
    MapEntry<String, dynamic> element, GoogleTranslator translator, String lang, Map<String, dynamic> newJson) async {
  Map<String, dynamic> texts = {};
  for (var elementValue in (element.value as Map<String, dynamic>).entries) {
    var translation = await translator.translate(elementValue.value, from: 'tr', to: lang);
    print(translation.text);
    texts[elementValue.key] = translation.text;
  }

  return texts;
}

//*For Custom dynamic type
String jsonEncodeCustom(Map<String, dynamic> newJson) {
  String jsonEncoded = "{";
  newJson.forEach((key, value) {
    jsonEncoded += '"${key}":';
    if (value is! Map<String, dynamic>) jsonEncoded += '"${value}",';
    if (value is Map<String, dynamic>) {
      jsonEncoded += "{";
      value.forEach((key2, value2) {
        jsonEncoded += '"${key2}":';
        jsonEncoded += '"${value2}",';
      });
      jsonEncoded = jsonEncoded.substring(0, jsonEncoded.length - 1);
      jsonEncoded += "},";
    }
  });
  jsonEncoded = jsonEncoded.substring(0, jsonEncoded.length - 1);
  jsonEncoded += "}";
  return jsonEncoded;
}

void processPrint(String str) {
  print("******* ${str.toUpperCase()} *******");
}
