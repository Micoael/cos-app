
class Rule{
  Rule(String str){
    _dealWithStr(str);
  }
  final bool isDebug = true; 
  /// What do I expect about the rule corventer is 
  /// when we input something split with ','
  /// the program will automatically separate it with
  /// ',' and returns the right value in order to 
  /// decide whether it needs to be shown.
  /// varabies are as follows:
  /// [creation date];[show at every `weekday`];[show per `days`];
  /// [last per show];[show from which day];
  /// [date];;3;
  var intro;
  ///should be `DateTime`
  ///the time it creates uses `ISO8601 `
  DateTime creationDate; 
  ///determines whether it will show weekly.
  ///use `1 2 3 4 5 6 7` to indicate different level.
  List<int> showPerWeek=[];
  int showPerDays;
  int showFromWhichDay;
  int showDuration;
  get creationDateValue{if(creationDate!=null)return creationDate;}
  get showPerDaysValue{if(showPerDays!=null) return showPerDays;}
  get showPerWeekValue{if(showPerWeek!=null)return showPerWeek;}
  get showDurationValue{if(showDuration!=null)return showDuration;}

  bool _dealWithStr(String str){
    bool isLegal=true;
    //must be used inside this cls.
    var processor = str.split(";");     // split it with ';'
    if(processor.length!=5){
      isLegal=false;
    }
    // Deal with creationDate
    if(isLegal){
      try{
        creationDate = DateTime.parse(processor[1]);
      }catch(Exception){
        isLegal=false;
      }
      if (!DateTime.now().isAfter(creationDate)){ isLegal = false; }
    }
    //deal with showPerDats
    if(isLegal){
      try{
        isLegal= (int.parse(processor[3])>=1||int.parse(processor[3])==null)?true:false;
        if(isLegal) showPerDays = int.parse(processor[3]);
      }catch(Exception){
        isLegal=false;
      }
    }
    return isLegal;
  }

}