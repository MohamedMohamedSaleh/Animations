import 'package:animations/core/helper_methods.dart';
import 'package:animations/home/screens/animated_navigation_drawer.dart';
import 'package:animations/home/screens/drawer_flip.dart';
import 'package:animations/home/screens/floating_action_button.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Animations App"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            const SizedBox(
              height: 20,
            ),
            AnimationWidget(
              title: "Animated Navigation Drawer",
              onTap: () =>
                  navigateTo(context, toPage: const AnimatedNavigationDrawer()),
            ),
            const SizedBox(
              height: 20,
            ),
            AnimationWidget(
              title: "Animated Flip Drawer",
              onTap: () =>
                  navigateTo(context, toPage: const DrawerFlipAnimation()),
            ),
            const SizedBox(
              height: 20,
            ),
            AnimationWidget(
              title: "Floating Action Button",
              onTap: () => navigateTo(context,
                  toPage: const FloatingActionButtonScreen()),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}

class AnimationWidget extends StatelessWidget {
  const AnimationWidget({super.key, required this.title, required this.onTap});
  final String title;
  final void Function() onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(11),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 16,
                    offset: const Offset(5, 10))
              ]),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                const Icon(
                  Icons.animation_rounded,
                  color: Colors.deepPurpleAccent,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  title,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
