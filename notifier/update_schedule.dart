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