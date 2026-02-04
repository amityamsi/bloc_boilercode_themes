import 'package:flutter/material.dart';

class AnimatedSlideIn extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final Offset begin;
  final Curve curve;
  final Duration delay;

  const AnimatedSlideIn({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 600),
    this.begin = const Offset(0, 0.2),
    this.curve = Curves.easeOutBack,
    this.delay = Duration.zero,
  });

  @override
  State<AnimatedSlideIn> createState() => _AnimatedSlideInState();
}

class _AnimatedSlideInState extends State<AnimatedSlideIn> {
  bool _visible = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(widget.delay, () {
      if (mounted) setState(() => _visible = true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<Offset>(
      tween: Tween(begin: widget.begin, end: _visible ? Offset.zero : widget.begin),
      duration: widget.duration,
      curve: widget.curve,
      child: widget.child,
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(value.dx * MediaQuery.of(context).size.width, value.dy * MediaQuery.of(context).size.height),
          child: child,
        );
      },
    );
  }
}

class AnimatedScaleIn extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final Curve curve;
  final Duration delay;

  const AnimatedScaleIn({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 500),
    this.curve = Curves.easeOutBack,
    this.delay = Duration.zero,
  });

  @override
  State<AnimatedScaleIn> createState() => _AnimatedScaleInState();
}

class _AnimatedScaleInState extends State<AnimatedScaleIn> {
  bool _visible = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(widget.delay, () {
      if (mounted) setState(() => _visible = true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.8, end: _visible ? 1.0 : 0.5),
      duration: widget.duration,
      curve: widget.curve,
      child: widget.child,
      builder: (context, value, child) {
        return Transform.scale(
          scale: value,
          child: child,
        );
      },
    );
  }
}

class AnimatedFadeIn extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final Curve curve;
  final Duration delay;

  const AnimatedFadeIn({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 500),
    this.curve = Curves.easeIn,
    this.delay = Duration.zero,
  });

  @override
  State<AnimatedFadeIn> createState() => _AnimatedFadeInState();
}

class _AnimatedFadeInState extends State<AnimatedFadeIn> {
  bool _visible = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(widget.delay, () {
      if (mounted) setState(() => _visible = true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: _visible ? 1.0 : 0.0),
      duration: widget.duration,
      curve: widget.curve,
      child: widget.child,
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: child,
        );
      },
    );
  }
} 