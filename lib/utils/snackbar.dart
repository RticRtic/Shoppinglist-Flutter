import 'package:flutter/material.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class SnackbarUtil {
  void snackbar(context, String enterText) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: Text(enterText),
        behavior: SnackBarBehavior.floating,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        margin:
            EdgeInsets.only(bottom: MediaQuery.of(context).size.height - 800),
        action: SnackBarAction(
            label: "Ok", onPressed: scaffold.hideCurrentSnackBar),
      ),
    );
  }

  void topSnackBarError(
      context, String enterText, AnimationController localAnimationController) {
    showTopSnackBar(context, CustomSnackBar.error(message: enterText),
        onAnimationControllerInit: (controller) =>
            localAnimationController = controller);
  }

  void topSnackBarSuccess(
      context, String enterText, AnimationController localAnimationController) {
    showTopSnackBar(context, CustomSnackBar.success(message: enterText),
        onAnimationControllerInit: (controller) =>
            localAnimationController = controller);
  }

  void topSnackBarInfo(
      context, String enterText, AnimationController localAnimationController) {
    showTopSnackBar(context, CustomSnackBar.info(message: enterText),
        onAnimationControllerInit: (controller) =>
            localAnimationController = controller);
  }
}
