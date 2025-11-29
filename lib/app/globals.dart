import 'package:flutter/material.dart';
import 'package:organizer/core/models/user.dart';

ValueNotifier<Locale> locale = ValueNotifier(const Locale('en'));
User user = User(
  id: -1,
  name: "undefined",
  color: "#ffffffff",
  lastEdit: DateTime.now(),
);
DateTime from = DateTime.now();
DateTime to = DateTime.now();
