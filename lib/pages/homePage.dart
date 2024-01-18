import 'package:flutter/material.dart';
import '../auth.dart';
import '../constants.dart';
import 'projectPage.dart';
import 'projectPage2.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  int screenIndex = 0;
  late bool showNavigationDrawer;

  void handleScreenChanged(int selectedScreen) {
    setState(() {
      screenIndex = selectedScreen;
    });
  }

  void openDrawer() {
    scaffoldKey.currentState!.openEndDrawer();
  }

  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey, 
      appBar: AppBar(
        title: const Text('Portfolio CV'),
      ),
      drawer: _buildDrawer(),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildProfile(),
                _buildProjects(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawer() {
    var user = Auth().currentUser;
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.purple, Colors.blue],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundImage: NetworkImage(user!.photoURL ??
                      'https://www.gravatar.com/avatar/?d=mp'),//default image
                ),
                const SizedBox(height: 10), //spacer
               
                // display the user name
                Text(
                  user.displayName ?? 'Anonymous',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                // display the user email
                Text(
                  user.email ?? 'No email',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home, color: Colors.white),
            title: const Text(
              'Home',
              style: drawerItemTextStyle
            ),
            onTap: () {
              // pop on Home click
              Navigator.pop(context); // Close the drawer
            },
          ),
          
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.white),
            title: const Text(
              'Sign Out',
              style: drawerItemTextStyle,
            ),
            onTap: () async {
              //Pop then signout
              Navigator.pop(context); // Close the drawer
              // this would change the Auth state and cause the app to redirect to the login page
              await Auth().signOut();
            },
          ),
        ],
      ),
    );
  }
//Widgets used only in this file, do not need to extract to another file to avoid code duplication
  Widget _buildProfile() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          FadeTransition(
            opacity:
                Tween<double>(begin: 0, end: 1).animate(_animationController),
            child: const CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/profile_picture.jpg'),
            ),
          ),
          const SizedBox(height: 16),
          SlideTransition(
            position: Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero)
                .animate(_animationController),
            child: const Column(
              children: [
                Text(
                  'Anthony Olori',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  'Software Developer',
                  style: TextStyle(
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProjects() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Projects',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.tealAccent,
            ),
          ),
          const SizedBox(height: 16),
          _buildProject('Fitwork', 'A Run Tracking application',
              'assets/project1_image.jpg', const Fitwork()),
          _buildProject(
              'Receipts table',
              'A part of a application worked on for an internship',
              'assets/project2_image.jpg',
              ReceiptsTable()),
          
        ],
      ),
    );
  }

  Widget _buildProject(
      String title, String description, String imagePath, Widget pageBuilder) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => pageBuilder,
          ),
        );
      },
      child: Card(
        color: Colors.white70,
        elevation: 3,
        margin: const EdgeInsets.symmetric(vertical: 8),
        child: ListTile(
          leading: CircleAvatar(
            radius: 30,
            backgroundImage: AssetImage(imagePath),
          ),
          title: Text(
            title,
            style: const TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            description,
            style: const TextStyle(
              color: Colors.black54,
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
