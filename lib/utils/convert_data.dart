import 'package:intl/intl.dart';

bool setBool(int state) {
  bool state;
  const map = {0: false, 1: true};
  state = map["state"] ?? false;
  return state;
}

int setInt(bool state) {
  int state;
  const map = {false: 0, true: 1};
  state = map["state"] ?? 0;
  return state;
}

DateFormat formatter = DateFormat('yyyy-MM-dd HH:mm:ss');
