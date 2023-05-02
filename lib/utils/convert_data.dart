import 'package:flutter/material.dart';
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

Color setColor(String json){
  int colorCode = int.parse(json, radix: 16);
  return Color(colorCode);
}

String setCode(Color color){
  String code = color.value.toRadixString(16).padLeft(8, '0').substring(2, 8);
  return code;
}

DateFormat dataFormatter = DateFormat('yyyy-MM-dd HH:mm:ss');

DateFormat dateFormat = DateFormat('MM월 dd일\nHH:mm');

String timePast(DateTime date) {
  DateTime now = DateTime.now();
  Duration difference = now.difference(date);
  if (difference.inSeconds < 60) {
    return "${difference.inSeconds}초 전";
  }
  if (difference.inMinutes < 60) {
    return "${difference.inMinutes}분 전";
  }
  if (difference.inHours < 24) {
    return "${difference.inHours}시간 전";
  }
  if (difference.inDays < 30) {
    return "${difference.inDays}일 전";
  }
  if (difference.inDays < 365) {
    return "${(difference.inDays / 30).floor()}달 전";
  }
  return "${(difference.inDays / 365).floor()}년 전";
}
// https://bangu4.tistory.com/364
// https://velog.io/@yellowtoast/Flutter-%EC%95%B1-%EB%B0%B0%ED%8F%AC-%ED%9B%84-%ED%8A%B9%EC%A0%95-%EC%95%88%EB%93%9C%EB%A1%9C%EC%9D%B4%EB%93%9C-%ED%8F%B0%EC%97%90%EC%84%9C-%EC%95%B1-%EC%8B%A4%ED%96%89%EC%9D%B4-%EB%90%98%EC%A7%80-%EC%95%8A%EB%8A%94-%ED%98%84%EC%83%81-%ED%95%B4%EA%B2%B0-%EC%A4%91

String untilExpire(DateTime end){
  Duration difference = end.difference(DateTime.now());
  int daysLeft = difference.inDays;
  int weeksLeft = (daysLeft / 7).floor();
  int monthsLeft = (daysLeft / 30).floor();
  int hoursLeft = difference.inHours % 24;
  if (difference.inSeconds < 0){
    return "만료됨";
  }
  if (difference.inSeconds < 60) {
    return "${difference.inSeconds}초 남음";
  }
  if (difference.inMinutes < 60) {
    return "${difference.inMinutes}분 남음";
  }
  if (difference.inHours < 24) {
    return "${difference.inHours}시간 남음";
  }
  if (daysLeft < 7) {
    return "$daysLeft일 남음";
  }
  if (daysLeft < 30){
    return "약 $weeksLeft주 남음";
  }
  return "$monthsLeft개월 남음";
}

String intToString(int role) {
  String result;
  const map = {0: "프로젝트장", 1: "관리자", 2: "구성원", 3: "손님"};
  result = map[role] ?? "손님";
  return result;
}

