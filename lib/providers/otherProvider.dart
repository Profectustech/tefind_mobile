import 'dart:async';
import 'package:flutter/cupertino.dart';
import '../utils/base_model.dart';


class OtherProvider extends BaseModel{
  late OtherProvider otherProvider;

  int _position=0;
  int get position => _position;
  void regPosition(int index){
    print(index);
    _position=index;
    notifyListeners();
  }


  void updatePosition(int index) {
    print(index);
    _position = index;
    notifyListeners();
  }

  void removPosition(){
    _position=0;
    notifyListeners();
  }

  int _setTransactionPin=0;
  int get setTransactionPin => _setTransactionPin;
  void regSetTransactionPin(int index){
    _setTransactionPin=index;
    notifyListeners();
  }

  void removeTransactionPin(){
    _setTransactionPin=0;
    notifyListeners();
  }

  //routing page for bottom nav
  int selectedIndex = 0;
  void onItemTap(int index) {
    selectedIndex = index;
    notifyListeners();
  }



// bool? activateBiometry= SharedPref.getIsBiometryActivated() ?? false;
// void changeIsAccountUpdateSaved(bool myvalue){
//   valueAccUpdated=myvalue;
//   SharedPref.saveIsAccountUpdateSaved(myvalue);
//   notifyListeners();
// }




}