import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DrawerFlipAnimation extends StatefulWidget {
  const DrawerFlipAnimation({super.key});

  @override
  State<DrawerFlipAnimation> createState() => _DrawerFlipAnimationState();
}

class _DrawerFlipAnimationState extends State<DrawerFlipAnimation>
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

  void toggle() {
    if (animationController.isDismissed) {
      animationController.forward();
    } else if (animationController.isCompleted) {
      animationController.reverse();
    } else {
      animationController.forward();
    }
  }

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
      builder: (context, child) => GestureDetector(
        onTap: () => toggle(),
        onHorizontalDragStart: _onDragStart,
        onHorizontalDragUpdate: _onDragUpdate,
        onHorizontalDragEnd: _onDragEnd,
        child: ColoredBox(
          color: Colors.white,
          child: Stack(
            children: [
              Transform.translate(
                offset: Offset(
                    MediaQuery.of(context).size.width *
                        .80 *
                        (animationController.value - 1),
                    0),
                child: Transform(
                    transform: Matrix4.identity()
                      ..setEntry(3, 2, 0.001)
                      ..rotateY(pi / 2 * (1 - animationController.value)),
                    alignment: Alignment.centerRight,
                    child: const MyDrawerNow()),
              ),
              Transform.translate(
                offset: Offset(
                    MediaQuery.of(context).size.width *
                        .80 *
                        animationController.value,
                    0),
                child: Transform(
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.001)
                    ..rotateY(-pi * animationController.value / 2),
                  alignment: Alignment.centerLeft,
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
                                print("object");
                                toggle();
                              },
                              child: const Icon(Icons.menu)),
                          const SizedBox(
                            width: 20,
                          ),
                          const Text("Animated Flip Drawer"),
                        ],
                      ),
                    ),
                    body: Center(
                      child: Text("Animated Flip Navigation Drawer",
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(fontWeight: FontWeight.bold)),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MyDrawerNow extends StatelessWidget {
  const MyDrawerNow({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      shape: const RoundedRectangleBorder(),
      width: MediaQuery.of(context).size.width * .80,
      backgroundColor: Theme.of(context).primaryColor,
      child: Column(
        children: [
          const SizedBox(
            height: 70,
          ),
          // Drawer Header
          Container(
            alignment: Alignment.center,
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: const Color.fromARGB(255, 101, 51, 238),
            ),
            child: const Text(
              'Menu',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          // Drawer Menu Items
          ListTile(
            leading: const Icon(Icons.home, color: Colors.white),
            title: const Text(
              'Home',
              style: TextStyle(color: Colors.white),
            ),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.settings, color: Colors.white),
            title: const Text(
              'Settings',
              style: TextStyle(color: Colors.white),
            ),
            onTap: () {
              // Add your onTap code here
            },
          ),
          ListTile(
            leading: const Icon(Icons.contact_page, color: Colors.white),
            title: const Text(
              'Contact',
              style: TextStyle(color: Colors.white),
            ),
            onTap: () {
              // Add your onTap code here
            },
          ),
          ListTile(
            leading: const Icon(Icons.description_sharp, color: Colors.white),
            title: const Text(
              'About Us',
              style: TextStyle(color: Colors.white),
            ),
            onTap: () {
              // Close the drawer and navigate

              // Add your onTap code here (e.g., navigate to another screen)
            },
          ),
          ListTile(
            leading: const Icon(Icons.dark_mode, color: Colors.white),
            title: const Text(
              'Theme',
              style: TextStyle(color: Colors.white),
            ),
            onTap: () {
              // Add your onTap code here
            },
          ),
          ListTile(
            leading: const Icon(Icons.contact_page, color: Colors.white),
            title: const Text(
              'Contact',
              style: TextStyle(color: Colors.white),
            ),
            onTap: () {
              // Add your onTap code here
            },
          ),
        ],
      ),
    );
  }
}
