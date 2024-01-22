import 'package:flutter/material.dart';

class CustomCircularProgressIndicator extends StatelessWidget {
  final double? size;
  const CustomCircularProgressIndicator({Key? key, this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: SizedBox.square(
      dimension: size,
      child: FittedBox(
        child: CircularProgressIndicator(
          strokeWidth: size != null ? size! * 0.1 : 4,
        ),
      ),
    ));
  }
}
