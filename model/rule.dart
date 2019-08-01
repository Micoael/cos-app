import 'dart:convert';

import 'package:cos_method/helper/database.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class ToDoRules {
  bool isSingle;
  String startTime;
  String endTime;
  DateTime startDate;
  DateTime endDate;
  String lastDoneDate = "2000-01-01";

  /// pass in [[3,2],[5,1]]
  /// 3 means `3 days per notifation`
  /// 2 means `every notifation lasts for 2 days`
  /// in all, it will look like this:
  /// `√ √ X √ X X X X`
  List<dynamic> repeat = [];
  ToDoRules({bool isSingle, String startTime,String endTime, List<dynamic> repeat}) {
    if (isSingle) {
      this.isSingle = true;
      this.repeat = [
        [1, 1]
      ];
      this.startTime = DateTime.now().toString().substring(0, 10);
      this.endTime = DateTime.now().toString().substring(0, 10);
      startDate = DateTime.parse(this.startTime);
      endDate = DateTime.parse(this.endTime);
    } else {
      startDate = DateTime.parse(startTime);
      endDate = DateTime.parse(endTime);
      this.isSingle = false;
      //repeat
      for (int i = 0; i < repeat.length; i++) {
        if (repeat[i][1] <= repeat[i][0]) {
          this.repeat = repeat;
        } else {
          this.repeat.add([repeat[i][1], repeat[i][0]]);
        }
      }
    }
  }

  setDone(ToDoRules rules) {
    if (isSingle) {
      return rules;
    } else {
      this.lastDoneDate =
          DateTime.now().toString().substring(0, 10); //2019-02-05
      return /*RulesJson.getJson(rule: rules);*/
        rules;
    }
  }

  static toVisibleCharts(List<dynamic> repeat) {
    int offset = 0;
    List<String> resultArray = [];
    String wrongMsg="";
    bool isWrong = false;
    StringBuffer buff = new StringBuffer();
    try {
      for (var i = 0; i < repeat.length; i++) {
        int repeatation = (int.parse(repeat[i][0].toString()));
        int duration = (int.parse(repeat[i][1].toString()));
        StringBuffer singleValueBuffer = new StringBuffer();

        if (repeatation != 0) {
          for (int i = 0; i < repeatation; i++) {
            resultArray.add("X");
          }
          for (int i = 0; i < duration; i++) {
            if (duration <= repeatation) {
              resultArray[offset + i] = "√";
            } else {
              wrongMsg = 'The duration is larger than value!';
              isWrong = true;
            }
          }
        }
        if (i == repeat.length - 1) {
          for (String result in resultArray) {
            singleValueBuffer..write(" $result ");
          }
        }
        buff..write("$singleValueBuffer");
        offset = offset + repeat[i][0];
      }
    } catch (Exception) {
      isWrong = true;
    }

    return isWrong ? "There's something wrong: $wrongMsg" : buff.toString();
  }

  ToDoRules.fromJson(Map<String, dynamic> json)
      : isSingle = json['isSingle'] as bool,
        startTime = json['startTime'] as String,
        endTime = json['endTime'] as String,
        repeat = json['repeat'] as List<dynamic>,
        lastDoneDate = json['lastDoneDate'] as String;

  Map toJson() {
    Map map = new Map();
    map['isSingle'] = this.isSingle;
    map['startTime'] = this.startDate.toString().substring(0, 10);
    map['endTime'] = this.endDate.toString().substring(0, 10);
    map['repeat'] = this.repeat; // <------ i am an idiot
    map['lastDoneDate'] = this.lastDoneDate;
    return map;
  }
}

class RulesJson {
  static ToDoRules formJson(String jsonStr) {
    try{
      Map userMap = jsonDecode(jsonStr);
    ToDoRules result = new ToDoRules.fromJson(userMap);
    return result;
    }catch (FormatException){
      debugPrint('Sorry! wrong format!');
    }
  }

  static String getJson({ToDoRules rule}) {
    ToDoRules rules = rule;
    rules = rule;
    String json = jsonEncode(rules);
    return json;
  }
}

class DisplayToDoList {
  bool _getIsToday(DateTime time) {
    DateTime currT = DateTime.now();
    return time.year == currT.year &&
        time.month == currT.month &&
        time.day == currT.day;
  }

  _toBoolArray(List<dynamic> repeat) {
    int offset = 0;
    List<bool> resultArray = [];
    String wrongMsg;
    bool isWrong = false;
    StringBuffer buff = new StringBuffer();
    try {
      for (var i = 0; i < repeat.length; i++) {
        int repeatation = (int.parse(repeat[i][0].toString()));
        int duration = (int.parse(repeat[i][1].toString()));
        StringBuffer singleValueBuffer = new StringBuffer();

        if (repeatation != 0) {
          for (int i = 0; i < repeatation; i++) {
            resultArray.add(false);
          }
          for (int i = 0; i < duration; i++) {
            if (duration <= repeatation) {
              resultArray[offset + i] = true;
            } else {
              wrongMsg = 'The duration is larger than value!';
              isWrong = true;
            }
          }
        }
        offset = offset + repeat[i][0];
      }
    } catch (Exception) {
      isWrong = true;
    }

    return resultArray;
  }

  markDate(
      DateTime start, DateTime end, List<dynamic> repeat, ToDoRules trule) {
    List<bool> boolList = _toBoolArray(repeat);
    bool hasEnded = !(end.isAfter(DateTime.now()));
    var difference = DateTime.now().difference(start); 
    int deltaDays = hasEnded ? -1: difference.inDays;
    if (deltaDays != -1) {
      if (boolList[deltaDays % boolList.length]) {
        if (!_getIsToday(DateTime.parse(trule.lastDoneDate))) {
          return true;
        } else {
          return false;
        }
      } else {
        debugPrint("has ended.");
        return false;
      }
    }else{
      return false;
    }
  }

  getIsDisplayToDoList(ToDoRules trule) {
    // Display an event has the following situations
    // 1. single task
    // 2.mutiple task
    // 2a. Is between the duration (start time and end time)
    // 2b. Legalify the repeat
    // 2c. Has done today?
    // --> what to do:
    // number the start and stop days.
    // pass in a repeat and analysis
    bool isSingle = trule.isSingle;
    List<dynamic> repeat = trule.repeat;
    DateTime start = DateTime.parse(trule.startTime);
    DateTime end = DateTime.parse(trule.endTime);
    if (isSingle) {
      return true;
    } else {
      return markDate(start, end, repeat, trule);
    }
  }
}
