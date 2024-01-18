import 'package:flutter/material.dart';
import '../constants.dart';
import '../widgets/Pages.dart';

class ReceiptsTable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Screenshots and Explanations
            buildHeader(),
            const Text('Part of a larger desktop application,this is a Gui built to interact with an api and diplay information received. Built using a flutter library downloaded and customized to fit specific requirements regarding navigation'),
            buildSectionTitle('Table Features'),
            const Text(
                'The project follows a modular approach to track user fitness activities and provide an engaging experience. The following modules are implemented:',
                style: sectionExplanationStyle),
            spacing(),
            buildScreenshot(
              imagePath: 'assets/project2/receipts.png',
              title: '',
              description:
                  """Custom defined functions exist for every action, examples include:
      • Adding a new row
      • Deleting a row
      • Navigation to the end of the table using focus
      • Navigation between elements in the table(made possible using custom definitions)

""",            ),
            // Tools Used
            buildSectionTitle('Tools Used'),
            buildToolsList([
              'Flutter',
            ]),

            // Things Learned
            buildSectionTitle('Takeaway'),
            buildLesson(
                'This Project was built alongside the main application as part of a 3 month internship, here i learnt about flutter coding practices and got to learn from a superior during my development time'),
            buildSectionTitle('Live Demo'),
            createLink('https://tonyolori.github.io/flutter-receipts-table/'),
            buildSectionTitle('Project Code'),
            createLink('https://tonyolori.github.io/flutter-receipts-table/'),
          ],
        ),
      ),
    );
  }
}
