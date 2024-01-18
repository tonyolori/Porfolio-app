import 'package:flutter/material.dart';
import '../constants.dart';
import '../widgets/Pages.dart';

class Fitwork extends StatelessWidget {
  const Fitwork({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Title 
            buildHeader(),
            const Text('A mobile application by Anthony Olori'),
            // Screenshots and Explanations
            buildSectionHead('Features'),
            const Text(
                'The project follows a modular approach to track user fitness activities and provide an engaging experience. The following modules are implemented:',
                style: sectionExplanationStyle),
            
            spacing(),
            buildScreenshot(
              imagePath: 'assets/project1/image1.png',
              title: 'Run Tracker',
              description:
                  """This module stores the real time location data gotten from the device's gps for analysis and displays a travel path on the map using the Google maps api.

    • It uses location data to track and store the users speed and distance travelled in real time.

    • It uses the google maps api to display travel path as the user travels, emulating the google maps experience for convienience""",
            ),
            spacing(),
            buildScreenshot(
              imagePath: 'assets/project1/image.png',
              title: 'Location Calculator Module',
              description:
                  "When a run is completed, this module takes the stored locations of a running session and uses the information to derive information about distance traveled, speed and travel time, which it then stores in the device as an object",
            ),
            spacing(),
            buildScreenshot(
              title: "Firebase Authentication Module",
              description:
                  "As an addition, this app is able to support user login and interaction between users, this is carried out using the Firebase Auth package, interaction with this package is handled by a specific Auth file, all modules/classes would then communicate with this auth file.",
            ),
            spacing(),
            buildScreenshot(
              imagePath: 'assets/project1/image2.png',
              title: "Firebase Firestore Module",
              description:
                  """Using information gotten from Auth, this module Stores basic information about a user's run as well as user data, including exercise history and calculated calories, in the cloud using Firebase Firestore. Allowing user interactions. it allows a user to:

      • View a list of users in their area.
      • Add a friend from their area.
      • Send a friend request to another user.
      • View Recent/Top runs of their friends.
 """,
            ),
            // Tools Used
            buildSectionHead('Tools Used'),
            buildToolsList([
              'Flutter',
              'Dart',
              'Firebase',
              'Flutter Provider',
            ]),
            spacing(size: 20),
            // Things Learned
            buildSectionHead('Things Learned'),
            buildLesson(
                'Effective use of Flutter for cross-platform development.'),
            buildLesson('Integration with Firebase for backend services.'),
            buildLesson('CRUD methodology for database handling, .'),
          ],
        ),
      ),
    );
  }
}