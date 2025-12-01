import 'dart:convert';
import 'package:organizer/core/models/compensation_info.dart';

class JsonUtil {
  static String? compensation2String(Map<int, CompensationInfo>? data) {
    if (data == null) return null;
    final jsonMap = data.map((key, value) => MapEntry(key.toString(), value.toJson()));
    return jsonEncode(jsonMap);
  }

  static Map<int, CompensationInfo>? string2CompensationInfo(String? data) {
    if (data == null || data.isEmpty) return null;
    final Map<String, dynamic> decoded = jsonDecode(data);
    return decoded.map(
      (key, value) => MapEntry(int.parse(key), CompensationInfo.fromJson(value)),
    );
  }
}