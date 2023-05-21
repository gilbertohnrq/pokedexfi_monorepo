import 'package:flutter/material.dart';

class Bouncing extends StatefulWidget {
  final Widget child;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final HitTestBehavior? behavior;
  final bool? bounce;
  final bool showClickable;

  const Bouncing({
    required this.child,
    this.onLongPress,
    Key? key,
    this.onTap,
    this.behavior,
    this.bounce = true,
    this.showClickable = true,
  })  : assert(onTap != null),
        super(key: key);

  @override
  State<Bouncing> createState() => _BouncingState();
}

class _BouncingState extends State<Bouncing>
    with SingleTickerProviderStateMixin {
  late double _scale;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
      lowerBound: 0.0,
      upperBound: 0.1,
    );
    _controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    widget.bounce != null
        ? _scale = widget.bounce! ? 1 - _controller.value : 1
        : _scale = 1 - _controller.value;

    return (widget.onTap != null || widget.onLongPress != null)
        ? GestureDetector(
            behavior: widget.behavior,
            onLongPress: widget.onLongPress,
            onTap: () async {
              if (widget.onTap != null) {
                _controller.forward();
                await Future.delayed(const Duration(milliseconds: 100));
                widget.onTap!();
                _controller.reverse();
              }
            },
            child: MouseRegion(
              cursor: widget.showClickable
                  ? SystemMouseCursors.click
                  : SystemMouseCursors.basic,
              onEnter: (_) {
                _controller.forward();
              },
              onExit: (event) => _controller.reverse(),
              child: Transform.scale(
                scale: _scale,
                child: widget.child,
              ),
            ),
          )
        : Container();
  }
}
