import 'package:flutter/widgets.dart';

class AnimatedSizeWidget extends StatefulWidget {
  final Widget child;
  final Duration duration;

  const AnimatedSizeWidget({
    Key? key,
    required this.child,
    required this.duration,
  }) : super(key: key);

  @override
  State<AnimatedSizeWidget> createState() => _AnimatedSizeWidgetState();
}

class _AnimatedSizeWidgetState extends State<AnimatedSizeWidget> {
  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      duration: widget.duration,
      curve: Curves.easeInOut,
      child: widget.child,
    );
  }
}
