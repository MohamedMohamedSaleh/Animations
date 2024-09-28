import 'dart:math';

import 'package:animations/home/screens/widgets/my_drawer.dart';
import 'package:flutter/material.dart';

class AnimatedNavigationDrawer extends StatefulWidget {
  const AnimatedNavigationDrawer({super.key});

  @override
  State<AnimatedNavigationDrawer> createState() =>
      _AnimatedNavigationDrawerState();
}

class _AnimatedNavigationDrawerState extends State<AnimatedNavigationDrawer>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  void toggle() => animationController.isDismissed
      ? animationController.forward()
      : animationController.reverse();
  double maxSlide = 200.0;
  late Offset _dragStartOffset;
  bool _canBeDragged = false;
  void _onDragStart(DragStartDetails details) {
    // store the global position of the finger when it starts dragging
    _dragStartOffset = details.globalPosition;
    bool isDragOpenFromLeft = animationController.isDismissed &&
        details.globalPosition.dx < maxSlide &&
        details.globalPosition.dy > 20;
    bool isDragCloseFromRight =
        animationController.isCompleted && details.globalPosition.dx > maxSlide;
    _canBeDragged = (isDragOpenFromLeft || isDragCloseFromRight);
  }

  void _onDragUpdate(DragUpdateDetails details) {
    double dx = details.globalPosition.dx - _dragStartOffset.dx;
    double dy = details.globalPosition.dy - _dragStartOffset.dy;
    if (_canBeDragged && dx.abs() - dy.abs() > 20) {
      double delta = (details.primaryDelta ?? 0) / maxSlide;
      animationController.value += delta;
    }
  }

  void _onDragEnd(DragEndDetails details) {
    if (animationController.isDismissed || animationController.isCompleted) {
      return;
    }
    if (details.velocity.pixelsPerSecond.dx.abs() >= 365.0) {
      double visualVelocity = details.velocity.pixelsPerSecond.dx /
          MediaQuery.of(context).size.width;
      animationController.fling(velocity: visualVelocity);
    } else if (animationController.value < .5) {
      animationController.reverse();
    } else {
      animationController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: animationController,
        builder: (context, _) {
          double offset = maxSlide * animationController.value;
          double scale = 1 - (animationController.value * .3);
          double rotate = animationController.value * -pi / 25;
          double radius = animationController.value * 20;
          return GestureDetector(
            onHorizontalDragStart: _onDragStart,
            onHorizontalDragUpdate: _onDragUpdate,
            onHorizontalDragEnd: _onDragEnd,
            child: Stack(
              children: [
                GestureDetector(
                    onTap: () {
                      toggle();
                    },
                    child: MyDrawer(
                      ontap: () {},
                    )),
                Transform(
                  transform: Matrix4.identity()
                    ..translate(offset)
                    ..scale(scale)
                    ..rotateZ(rotate),
                  alignment: Alignment.centerLeft,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(radius),
                    child: GestureDetector(
                      onTap: () {
                        if (animationController.isCompleted) {
                          toggle();
                        }
                      },
                      child: Scaffold(
                        backgroundColor:
                            Theme.of(context).colorScheme.inversePrimary,
                        appBar: AppBar(
                          backgroundColor:
                              Theme.of(context).colorScheme.inversePrimary,
                          automaticallyImplyLeading: false,
                          title: Row(
                            children: [
                              GestureDetector(
                                  onTap: () {
                                    toggle();
                                  },
                                  child: const Icon(Icons.menu)),
                              const SizedBox(
                                width: 20,
                              ),
                              const Text("Animated Drawer"),
                            ],
                          ),
                        ),
                        body: Center(
                          child: Text("Animated Navigation Drawer",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
