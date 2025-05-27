import 'package:saleko/utils/base_model.dart';

class NavStateProvider extends BaseModel {
  int _currentTabIndex = 0; // Defaults to chat tab

  int get currentTabIndex => _currentTabIndex;

  void setCurrentTabTo({required int newTabIndex}) {
    _currentTabIndex = newTabIndex;
    notifyListeners();
  }

  void resetTab() {
    _currentTabIndex = 0;
  }
}
