import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:te_find/utils/locator.dart';
import 'package:te_find/utils/progress_bar_manager/dialog_models.dart';
import 'package:te_find/utils/progress_bar_manager/dialog_service.dart';

class BaseModel extends ChangeNotifier {
  final ProgressService _dialogService = locator<ProgressService>();
  late ProgressResponse hh;
  bool _busy = false;
  bool get busy => _busy;

  void setBusy(bool value,) {
    _busy = value;
    locator<BaseModel>()._busy = value;
    notifyListeners();
    if (value == true) {
      _dialogService.showDialog(description: '', title: '');
    } else {
      _dialogService.dialogComplete();
    }
  }
}
