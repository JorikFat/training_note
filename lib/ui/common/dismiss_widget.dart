import 'package:flutter/material.dart';

class DismissWidget extends StatelessWidget {
  const DismissWidget(
      {super.key, required this.child, required this.childKey, this.delete});
  final Key childKey;
  final Widget child;
  final Function(DismissDirection)? delete;
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      crossAxisEndOffset: 0,
      key: childKey,
      onDismissed: delete,
      background: Container(
        color: Colors.red,
      ),
      child: child,
    );
  }
}
