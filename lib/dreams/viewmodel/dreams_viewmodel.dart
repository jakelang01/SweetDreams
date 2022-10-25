import '../utils/dreams_constant.dart';

class UNITSViewModel {
  double _units = 0.0;
  UnitType _unitType = UnitType.WAKE;
  UnitType _unitTypeTime = UnitType.AM;

  String _timeType = "";
  String _message = "";

  String healthySleepAgeRange = "18 to 60 Years Old";
  String healthySleepAmountPerNight = "7 or more hours per night.";

  double hour = 0.0;
  double minute = 0.0;
  double sleepHour = 0.0;
  double sleepMinute = 0.0;

  double get units => _units;
  set units(double outResult){
    _units = outResult;
  }

  String get timeType => _timeType;
  set timeType(String outResult){
    _timeType = outResult;
  }

  String get message => _message;
  set message(String outResult){
    _message = outResult;
  }

  UnitType get unitTypeTime => _unitTypeTime;
  set unitTypeTime(UnitType setValue){
    _unitTypeTime = setValue;
  }

  UnitType get unitType => _unitType;
  set unitType(UnitType setValue){
    _unitType = setValue;
  }

  int get value => _unitType == UnitType.WAKE?0 : 1; //Set unit type - 1 is KPG
  set value(int value){
    if(value == 0){
      _unitType = UnitType.WAKE;
    } else {
      _unitType = UnitType.BED;
    }
  }

  int get valueTime => _unitTypeTime == UnitType.AM?0 : 1; //Set unit type - 1 is KPG
  set valueTime(int value){
    if(value == 0){
      _unitTypeTime = UnitType.AM;
    } else {
      _unitTypeTime = UnitType.PM;
    }
  }

  String get timeInString => _timeType;
  String get messageInString => _message;
  String get resultInString => units.toStringAsFixed(2);
  String get sleepHourInString => sleepHour != null ? sleepHour.toString():'';
  String get sleepMinuteInString => sleepMinute != null ? sleepMinute.toString():'';

  UNITSViewModel();
}