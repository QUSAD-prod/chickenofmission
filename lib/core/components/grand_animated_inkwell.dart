import 'package:flutter/material.dart';

class GrandAnimatedInkWell extends StatefulWidget {
  const GrandAnimatedInkWell({
    super.key,
    required this.child,
    required this.onTap,
    this.duration,
    this.animated = true,
  });

  final Widget child;
  final void Function() onTap;
  final Duration? duration;
  final bool animated;

  @override
  State<GrandAnimatedInkWell> createState() => GrandAnimatedInkWellState();
}

class GrandAnimatedInkWellState extends State<GrandAnimatedInkWell> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 100));
    _animation = Tween<double>(begin: 1, end: 0.9).animate(CurvedAnimation(parent: _animationController, curve: Curves.fastOutSlowIn))
      ..addListener(
        () => setState(() {}),
      );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: _animation.value,
      child: InkWell(
        focusColor: Colors.transparent,
        hoverColor: Colors.transparent,
        splashColor: Colors.transparent,
        overlayColor: WidgetStateProperty.all(Colors.transparent),
        highlightColor: Colors.transparent,
        hoverDuration: Duration.zero,
        radius: 0,
        onTap: () async {
          widget.animated
              ? _animationController.forward().whenComplete(
                  () {
                    _animationController.reverse();
                    widget.onTap();
                  },
                )
              : widget.onTap();
        },
        child: widget.child,
      ),
    );
  }
}
