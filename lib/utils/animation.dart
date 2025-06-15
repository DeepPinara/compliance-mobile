import 'package:flutter/material.dart';

class AppAnimations {
  // Slide transition for pages
  // static Route createRoute(Widget page) {
  //   return PageRouteBuilder(
  //     pageBuilder: (context, animation, secondaryAnimation) => page,
  //     transitionsBuilder: (context, animation, secondaryAnimation, child) {
  //       const begin = Offset(1.0, 0.0);
  //       const end = Offset.zero;
  //       const curve = Curves.easeInOut;
  //       var tween =
  //           Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
  //       var offsetAnimation = animation.drive(tween);
  //       return SlideTransition(position: offsetAnimation, child: child);
  //     },
  //   );
  // }

  // // Fade in animation
  // static Widget fadeIn(Widget child, {Duration? duration}) {
  //   return FadeTransition(
  //     opacity: CurvedAnimation(
  //       parent: const AlwaysStoppedAnimation(1.0),
  //       curve: const Interval(0.0, 1.0, curve: Curves.easeIn),
  //     ),
  //     child: child,
  //   );
  // }

  // Animated container for cards
  static Widget animatedCard(Widget child, {Function()? onTap}) {
    return AnimatedCardWidget(onTap: onTap, child: child);
  }
}

// Animated Card Widget with hover effect
class AnimatedCardWidget extends StatefulWidget {
  final Widget child;
  final Function()? onTap;

  const AnimatedCardWidget({super.key, required this.child, this.onTap});

  @override
  AnimatedCardWidgetState createState() => AnimatedCardWidgetState();
}

class AnimatedCardWidgetState extends State<AnimatedCardWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.03).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onHover(bool isHovered) {
    setState(() {
      _isHovered = isHovered;
    });
    isHovered ? _controller.forward() : _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => _onHover(true),
      onExit: (_) => _onHover(false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: ScaleTransition(
          scale: _scaleAnimation,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            decoration: BoxDecoration(
              boxShadow: _isHovered
                  ? [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 8.0,
                          spreadRadius: 1.0)
                    ]
                  : [
                      const BoxShadow(
                          color: Colors.transparent, blurRadius: 0.0)
                    ],
            ),
            child: widget.child,
          ),
        ),
      ),
    );
  }
}

// Staggered list animation
class StaggeredListAnimation extends StatefulWidget {
  final List<Widget> children;
  final Axis scrollDirection;
  final ScrollController? controller;
  final bool shrinkWrap;
  final ScrollPhysics? physics;
  final EdgeInsetsGeometry? padding;
  final bool resetAnimation;
  final int defaultDurationMilliSeconds;
  final int perItemDurationMilliSeconds;

  const StaggeredListAnimation({
    super.key,
    required this.children,
    this.scrollDirection = Axis.vertical,
    this.controller,
    this.shrinkWrap = false,
    this.physics,
    this.padding,
    this.resetAnimation = false,
    this.defaultDurationMilliSeconds = 450,
    this.perItemDurationMilliSeconds = 100,
  });

  @override
  StaggeredListAnimationState createState() => StaggeredListAnimationState();
}

class StaggeredListAnimationState extends State<StaggeredListAnimation>
    with TickerProviderStateMixin {
  late final List<AnimationController> _controllers = [];
  late final List<Animation<double>> _animations = [];

  bool _previousResetValue = false;

  @override
  void initState() {
    super.initState();
    _initAnimations();
    _previousResetValue = widget.resetAnimation;
  }

  @override
  void didUpdateWidget(StaggeredListAnimation oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Check if resetAnimation changed from false to true
    if (widget.resetAnimation && !_previousResetValue) {
      _resetAnimations();
    }

    _previousResetValue = widget.resetAnimation;

    // Also handle child count changes as before
    if (oldWidget.children.length != widget.children.length) {
      for (var controller in _controllers) {
        controller.dispose();
      }
      _controllers.clear();
      _animations.clear();

      _initAnimations();
    }
  }

  void _resetAnimations() {
    // Reset all controllers
    for (var controller in _controllers) {
      controller.reset();
      controller.forward();
    }
  }

  void _initAnimations() {
    for (int i = 0; i < widget.children.length; i++) {
      final controller = AnimationController(
        duration: Duration(
            milliseconds: widget.defaultDurationMilliSeconds +
                (i * widget.perItemDurationMilliSeconds)),
        vsync: this,
      );

      final animation = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: controller, curve: Curves.easeInOut),
      );

      _controllers.add(controller);
      _animations.add(animation);

      // Start animations with staggered delay
      Future.delayed(
          Duration(milliseconds: widget.perItemDurationMilliSeconds * i), () {
        if (mounted) {
          controller.forward();
        }
      });
    }
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.scrollDirection == Axis.vertical
        ? ListView.builder(
            padding: widget.padding,
            shrinkWrap: widget.shrinkWrap,
            physics: widget.physics,
            controller: widget.controller,
            itemCount: widget.children.length,
            itemBuilder: (context, index) {
              return FadeTransition(
                opacity: _animations[index],
                child: SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(0, 0.25),
                    end: Offset.zero,
                  ).animate(_animations[index]),
                  child: widget.children[index],
                ),
              );
            },
          )
        : SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            controller: widget.controller,
            physics: widget.physics,
            padding: widget.padding,
            child: Row(
              children: List.generate(
                widget.children.length,
                (index) => FadeTransition(
                  opacity: _animations[index],
                  child: SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(0.25, 0),
                      end: Offset.zero,
                    ).animate(_animations[index]),
                    child: widget.children[index],
                  ),
                ),
              ),
            ),
          );
  }
}


// How to use

// // Animated Horizontal Scroll for Availability Cards
// StaggeredListAnimation(
// scrollDirection: Axis.horizontal,
//children: List.generate(
// 5,
// (index) => Container(),
// ),
//),

// // Animated Vertical Scroll for Availability Cards
// StaggeredListAnimation(
// children: List.generate(
// 5,
// (index) => Container(),
// ),
//),

// // Animated Card
// AnimatedCardWidget(
// onTap: () {},
// child: Container(),
//),