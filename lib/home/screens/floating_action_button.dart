import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class FloatingActionButtonScreen extends StatefulWidget {
  const FloatingActionButtonScreen({super.key});

  @override
  State<FloatingActionButtonScreen> createState() =>
      _FloatingActionButtonScreenState();
}

class _FloatingActionButtonScreenState
    extends State<FloatingActionButtonScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("FAB Animation"),
        centerTitle: true,
      ),
      floatingActionButton: const FloatingActionButtonWidget(),
    );
  }
}

class FloatingActionButtonWidget extends StatefulWidget {
  const FloatingActionButtonWidget({super.key});

  @override
  State<FloatingActionButtonWidget> createState() =>
      _FloatingActionButtonWidgetState();
}

class _FloatingActionButtonWidgetState extends State<FloatingActionButtonWidget>
    with SingleTickerProviderStateMixin {
  final double buttonSize = 50;
  late AnimationController animationController;

  IconData ic = Icons.menu;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    animationController.addListener(
      () => setState(() {
        print('ok');
        animationController.value > .5 || animationController.isCompleted
            ? ic = Icons.clear
            : ic = Icons.menu;
      }),
    );
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Flow(
      delegate: FlowMenuDelegate(controller: animationController),
      children: <IconData>[
        Icons.add_call,
        Icons.camera,
        Icons.ondemand_video,
        Icons.sms_rounded,
        ic,
      ].map<Widget>(buildFAB).toList(),
    );
  }

  Widget buildFAB(IconData icon) => SizedBox(
        width: buttonSize,
        height: buttonSize,
        child: FloatingActionButton(
          shape: const CircleBorder(),
          backgroundColor: Colors.deepPurple
              .withOpacity(icon == ic ? 1 : animationController.value),
          heroTag: '$icon',
          elevation: 0,
          onPressed: () {
            if (animationController.isCompleted) {
              animationController.reverse();
            } else {
              animationController.forward();
            }
          },
          child: Icon(
            icon,
            color: Colors.white,
          ),
        ),
      );
}

class FlowMenuDelegate extends FlowDelegate {
  final double buttonSize = 50;
  final Animation<double> controller;
  const FlowMenuDelegate({required this.controller})
      : super(repaint: controller);

  @override
  void paintChildren(FlowPaintingContext context) {
    final n = context.childCount;

    final size = context.size;
    final xStart = size.width - buttonSize;
    final yStart = size.height - buttonSize;

    for (int i = 0; i < n; i++) {
      final isLastItem = i == n - 1;
      setValue(double value) => isLastItem ? 0.0 : value;
      final radius = 150 * controller.value;
      final theta = i * pi * .5 / (n - 2);
      final x = xStart - setValue(radius * cos(theta));
      final y = yStart - setValue(radius * sin(theta));
      context.paintChild(i,
          transform: Matrix4.identity()
            ..translate(x, y, 0)
            ..translate(buttonSize / 3.5, buttonSize / 3.5)
            ..rotateZ(180 * (1 - controller.value) * pi / 180)
            ..scale(isLastItem ? 1.0 : max(controller.value, .6))
            ..translate(-buttonSize / 1.5, -buttonSize / 1.5));
    }
  }

  @override
  bool shouldRepaint(covariant FlowDelegate oldDelegate) {
    return false;
  }
}
