import 'package:flutter/material.dart';

class CustomAnimatedWidget extends StatefulWidget {
  final Widget _widget;
  final int duration;

  const CustomAnimatedWidget(this._widget, {this.duration = 1, Key? key})
      : super(key: key);

  @override
  _CustomAnimatedWidgetState createState() => _CustomAnimatedWidgetState();
}

class _CustomAnimatedWidgetState extends State<CustomAnimatedWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: widget.duration),
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(_animationController);
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animation,
      child: widget._widget,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
