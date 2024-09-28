
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key, required this.ontap});
  final void Function() ontap;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurpleAccent,
      body: Padding(
        padding: const EdgeInsets.only(left: 16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
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
                leading:
                    const Icon(Icons.description_sharp, color: Colors.white),
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
        ),
      ),
    );
  }
}
