import 'package:flutter/material.dart';
import 'package:units/dreams/utils/dreams_constant.dart';
import 'dart:math';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

List<dynamic> calculator(double hour, double minute, double sleepHour, double sleepMinute, UnitType uniType, UnitType unitTypeTime) {

  List result = new List.filled(3, null, growable: false);
  double tempHour = 0.0;
  double tempMinute = 0.00;

  if(uniType == UnitType.BED) {
    tempHour = hour + sleepHour;
    tempMinute = minute + sleepMinute;

    if (tempMinute >= 60) {
      tempMinute -= 60;
      tempHour += 1;
    }
  }
  if (uniType == UnitType.WAKE) {
    tempHour = hour - sleepHour;
    tempMinute = minute - sleepMinute;

    if(tempMinute < 0){
      tempMinute += 60.00;
      tempHour -= 1;
    }
  }

  if(tempHour > 12 || tempHour < 0) {
    switch(unitTypeTime) {
      case UnitType.AM: { unitTypeTime = UnitType.PM; }
      break;
      case UnitType.PM: { unitTypeTime = UnitType.AM; }
      break;
      default: {}
      break;
    }

    tempHour %= 12;
  }
  if(tempHour ==0){
    tempHour = 12;
  }

  //result = tempHour + (tempMinute/100);
  result[0] = (tempHour + (tempMinute/100));
  result[1] = unitTypeTime;
  result[2] = uniType;
  return result;
}

bool isEmptyString(String string){
  return string == null || string.length == 0;
}

Future<int> loadValue() async{
  SharedPreferences preferences = await SharedPreferences.getInstance();
  int? data = preferences.getInt('data');
  if( data != null ) {
    return data;
  } else {
    return 0;
  }

}

void saveValue(int value) async{
  SharedPreferences preferences = await SharedPreferences.getInstance();
  preferences.setInt('data', value);
}