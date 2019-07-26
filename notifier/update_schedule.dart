import 'package:cos_method/helper/database.dart';
import 'package:cos_method/model/todo.dart';
import 'package:flutter/foundation.dart';
class UpdateManager with ChangeNotifier {
  bool _isUpdate;
  UpdateManager(this._isUpdate);
 
  void refresh() {
    _isUpdate=true;
    notifyListeners();
  }

  void understood() {
    _isUpdate=false;
  }
  get isUpdate => _isUpdate;
}



class ToDosAssetManager with ChangeNotifier {

  ToDosAssetManager({this.allList});


  List<ToDos> allList=[];
  List<ToDos> listOf0=[];
  List<ToDos> listOf1=[];
  List<ToDos> listOf2=[];
  List<ToDos> listOf3=[];
  List<ToDos> listOfDefault=[];
  // in order to prevent dataase lock when geting datas
  
  get listOfAll => allList;
  get listOfZero => listOf0;
  get listOfOne => listOf1;
  get listOfTwo => listOf2;
  get listOfTherr =>listOf3;

  

  getSpecialList(int id,bool isWakeUpListener){
    if(id == 1){
      return listOf1;
    }else if(id==2){
      return listOf2;
    }else if(id==3){
      return listOf3;
    }else if(id==0){
      return listOf0;
    }
    if(isWakeUpListener){
      notifyListeners();
    }
  }
  
  Future<List<List<ToDos>>> refreshData() async {
    
    debugPrint('in');
      await _communicate().whenComplete((){
        _pickData();
        notifyListeners();
      });
      debugPrint(listOfAll.toString());
      List<List<ToDos>> returnVal = [listOf0,listOf1,listOf2,listOf3,listOfDefault];
      return returnVal;
    }

    Future _communicate() async{
      DatabaseCollection collection = new DatabaseCollection();
      allList = new List<ToDos>();
      allList = await collection.getAllToDos();
    }
  // piority as 0 1 2 3.
  _pickData(){
    for(ToDos todo in allList){
      switch (todo.piority) {
        case 0:
          listOf0.add(todo);
          break;
        case 1:
          listOf1.add(todo);
          break;
        case 2:
          listOf2.add(todo);
          break;
        case 3:
          listOf3.add(todo);
          break;
        default:
          listOfDefault.add(todo);
          break;
          
      }
    }
  }
}




