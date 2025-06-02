import 'package:te_find/utils/enums.dart';
import 'package:te_find/app/widgets/custom_toast_notification.dart';

class DialogService {
  DialogService._internal();
  static final DialogService _instance = DialogService._internal();
  factory DialogService() => _instance;

  showSnackBar(String message,
      {required AppToastType appToastType, Duration? duration}) {
    ToastType toastType;

    switch (appToastType) {
      case AppToastType.success:
        toastType = ToastType.success;
        break;
      case AppToastType.error:
        toastType = ToastType.error;
        break;
      case AppToastType.warning:
        toastType = ToastType.warning;
        break;
      default:
        toastType = ToastType.success;
    }

    return CustomToastNotification.show(message,
        type: toastType, duration: duration);
  }
}
