import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProgressWidget extends StatelessWidget {
  final bool showLoading;
  final bool hideChild;
  final String message;

  final Widget? child;

  ProgressWidget(
      {Key? key,
      this.showLoading = false,
      this.child,
      this.hideChild = false,
      this.message = ""})
      : assert(child != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child ?? Container(),
        showLoading
            ? Container(
                color: hideChild ? Colors.white : Colors.black45,
                child: Center(
                  child: loader(),
                ),
              )
            : Container(),
      ],
    );
  }

  loader() {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(Get.context!).scaffoldBackgroundColor,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        width: MediaQuery.of(Get.context!).size.width * 0.3,
        height: MediaQuery.of(Get.context!).size.width * 0.3,
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const CircularProgressIndicator(
              strokeWidth: 3.5,
            ),
            Card(
                elevation: 0,
                child: message.isNotEmpty ? Text(message) : Container())
          ],
        ),
      ),
    );
  }
}
