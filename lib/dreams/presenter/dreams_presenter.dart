

import 'package:cloud_firestore/cloud_firestore.dart';

import '../views/dreams_view.dart';
import '../viewmodel/dreams_viewmodel.dart';
import '../utils/dreams_constant.dart';
import '../utils/dreams_utils.dart';

class UNITSPresenter {
  void onCalculateClicked(String hourString, String minuteString, String sleepMinuteString, String sleepHourString){

  }
  void onOptionChanged(int value, {required String sleepMinuteString, required String sleepHourString}) {

  }
  void onTimeOptionChanged(int value) {

  }
  set unitsView(UNITSView value){}

  void onHourSubmitted(String hour){}
  void onMinuteSubmitted(String minute){}
  void onSleepHourSubmitted(String sleepHour){}
  void onSleepMinuteSubmitted(String sleepMinute){}
}

class BasicPresenter implements UNITSPresenter{
  UNITSViewModel _viewModel = UNITSViewModel();
  UNITSView _view = UNITSView();

  BasicPresenter() {
    this._viewModel = _viewModel;
    _loadUnit();
  }

  void _loadUnit() async{
    _viewModel.value = await loadValue();
    _viewModel.valueTime = await loadValue();
    _view.updateUnit(_viewModel.value);
    _view.updateTimeUnit(_viewModel.valueTime);
  }

  @override
  set unitsView(UNITSView value) {
    _view = value;
    _view.updateUnit(_viewModel.value);
    _view.updateTimeUnit(_viewModel.valueTime);
  }

  @override
  void onCalculateClicked(String hourString, String minuteString, String sleepMinuteString, String sleepHourString) {
    var hour = 0.0;
    var minute = 0.0;
    var sleepHour = 0.0;
    var sleepMinute = 0.0;
    try {
      hour = double.parse(hourString);
    } catch (e){

    }
    try {
      minute = double.parse(minuteString);
    } catch (e){

    }
    try {
      sleepHour = double.parse(sleepHourString);
    } catch (e){

    }
    try {
      sleepMinute = double.parse(sleepMinuteString);
    } catch (e) {

    }

    List temp = new List.filled(3, null, growable: false);
    _viewModel.hour = hour;
    _viewModel.minute = minute;
    _viewModel.sleepHour = sleepHour;
    _viewModel.sleepMinute = sleepMinute;
    temp = calculator(hour,minute,sleepHour, sleepMinute, _viewModel.unitType, _viewModel.unitTypeTime);
    //  temp returns a List of the time, AM or PM, and WAKE or BED.
    //  The time that is returned is in the format of a double ex) 12.30 is 12:30.

    _viewModel.units = temp[0];
    UnitType tempTime = temp[1];
    UnitType tempMessage = temp[2];

    if(tempTime == UnitType.AM) {
      _viewModel.timeType = "AM";
    } else if (tempTime == UnitType.PM) {
      _viewModel.timeType = "PM";
    }

    if(tempMessage == UnitType.BED) {
      _viewModel.message = "You should wake up at";
    } else if (tempMessage == UnitType.WAKE) {
      _viewModel.message = "You should go to bed at";
    }
    _view.updateMessage(_viewModel.message);
    _view.updateTimeString(_viewModel.timeType);
    _view.updateResultValue(_viewModel.resultInString);
  }

  @override
  void onOptionChanged(int value, {required String sleepMinuteString, required String sleepHourString})  {

    if (value != _viewModel.value) {
      _viewModel.value = value;
      saveValue(_viewModel.value);
      var curOdom = 0.0;
      var fuelUsed = 0.0;
      if (!isEmptyString(sleepHourString)) {
        try {
          curOdom = double.parse(sleepHourString);
        } catch (e) {
        }
      }
      if (!isEmptyString(sleepMinuteString)) {
        try {
          fuelUsed = double.parse(sleepMinuteString);
        } catch (e) {

        }
      }
      _view.updateUnit(_viewModel.value);
      _view.updateSleepHour(sleepHour: _viewModel.sleepHourInString);
      _view.updateSleepMinute(sleepMinute: _viewModel.sleepMinuteInString);
    }
  }

  @override
  void onTimeOptionChanged(int value)  {

    if (value != _viewModel.valueTime) {
      _viewModel.valueTime = value;
      saveValue(_viewModel.valueTime);

      _view.updateTimeUnit(_viewModel.valueTime);
    }
  }

  @override
  void onHourSubmitted(String hour) {
    try{
      _viewModel.hour = double.parse(hour);
    }catch(e){

    }
  }

  @override
  void onMinuteSubmitted(String minute) {
    try{
      _viewModel.minute = double.parse(minute);
    }catch(e){

    }
  }

  @override
  void onSleepHourSubmitted(String sleepHour) {
    try {
      _viewModel.sleepHour = double.parse(sleepHour);
    } catch (e){

    }
  }

  @override
  void onSleepMinuteSubmitted(String sleepMinute) {
    try {
      _viewModel.sleepMinute = double.parse(sleepMinute);
    } catch (e){

    }
  }
}
class RecordNewNight implements UNITSViewModel{
//total sleep might need to be formatted differently
  final databaseReference = FirebaseFirestore.instance.collection('Example User');

  void createNight(int count, String bedtime, int quality, String wakeUp, String description){
  databaseReference.doc("Night" + count.toString()).set({"Bedtime": bedtime, "Quality of Sleep (1-5)": quality,
      "Total Sleep": calculateSleep(bedtime, wakeUp).toString(), "Wake-Up Time": wakeUp, "Description": description});
  }

  Future<void> getNight(String night) async {
    DocumentSnapshot data = await retrieveData(night);
    print(data.data().toString());
  }

  Future<DocumentSnapshot> retrieveData(String night) async{
    return databaseReference.doc(night).get();
  }

  void removeNight(int night) async {
    databaseReference.doc("Night" + night.toString()).delete();
  }

  Future<String> getBedtime(String night) async {
    String nightDoc = night;
    DocumentSnapshot data =  await databaseReference.doc(nightDoc).get();
    String nightNumber = data.get('Bedtime');
    return Future.value(nightNumber);
  }

  Future<String> getDescription(String night) async {
    String nightDoc = night;
    DocumentSnapshot data =  await databaseReference.doc(nightDoc).get();
    String nightNumber = data.get('Description');
    return Future.value(nightNumber);
  }

  Future<int> getQuality(String night) async {
    String nightDoc = night;
    DocumentSnapshot data =  await databaseReference.doc(nightDoc).get();
    int nightNumber = data.get('Quality of Sleep (1-5)');
    return Future.value(nightNumber);
  }

  Future<String> getTotalSleep(String night) async {
    String nightDoc = night;
    DocumentSnapshot data =  await databaseReference.doc(nightDoc).get();
    String nightNumber = data.get('Total Sleep');
    return Future.value(nightNumber);
  }

  Future<String> getWakeUp(String night) async {
    String nightDoc = night;
    DocumentSnapshot data =  await databaseReference.doc(nightDoc).get();
    String nightNumber = data.get('Wake-Up Time');
    return Future.value(nightNumber);
  }


  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

//takes in bedtime and wakeup time and calculates total amount of sleep
double calculateSleep(String bed, String wake){
  List bedSplit = bed.split(":");
  double bedHour = double.parse(bedSplit[0]);
  double bedMinute = double.parse(bedSplit[1])/60;
  List wakeSplit = wake.split(":");
  double wakeHour = double.parse(wakeSplit[0]);
  double wakeMinute = double.parse(wakeSplit[1])/60;

  double bedtime = bedHour + bedMinute;
  double wakeup = wakeHour + wakeMinute;
  if(bedtime <= 12){
    double total = 12-bedtime+wakeup;
    return total;
    }else{
      double total = wakeup-bedtime;
      return total;
    }
}