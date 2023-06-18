
import 'package:flutter/cupertino.dart';
import 'package:motion_toast/motion_toast.dart';

class ShowToast {
  static void displaySuccessToast(BuildContext context, String message) {
    MotionToast.success(description: Text(message)).show(context);
  }

  static void displayErrorToast(BuildContext context, String message) {
    MotionToast.error(description: Text(message)).show(context);
  }

  static void displayWarningToast(BuildContext context, String message) {
    MotionToast.warning(description: Text(message)).show(context);
  }
}
