import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _loadingWidget();
  }

  /// Widget function which gives the ui for the loading widget whenever the loader is true
  Widget _loadingWidget() {
    return const Center(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.blueAccent),
      ),
    );
  }
}
