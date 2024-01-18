
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../constants.dart';

//All functions used by the project for display are placed here to avoid code duplication 
Widget buildHeader() {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Center(
        child: Text(
          'Receipts table',
          style: sectionHeadStyle,
        ),
      ),
    );
  }

  Widget buildSectionTitle(String title, {int? size}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: sectionTitleStyle.copyWith(
            fontSize: size?.toDouble() ?? sectionTitleStyle.fontSize),
      ),
    );
  }

  Widget buildScreenshot({
    String? imagePath,
    required String title,
    required String description,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        imagePath != null
            ? Image.asset(
                imagePath,
                height: 200.0,
                width: double.infinity,
                fit: BoxFit.cover,
              )
            : SizedBox(),
        const SizedBox(height: 12.0),
        Text(
          title,
          style: sectionSubheadStyle,
        ),
        const SizedBox(height: 4.0),
        Text(description, style: sectionExplanationStyle),
        const SizedBox(height: 16.0),
      ],
    );
  }

  Widget buildToolsList(List<String> tools) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: tools
          .map((tool) => Padding(
                padding: const EdgeInsets.only(bottom: 4.0),
                child: Text('• $tool'),
              ))
          .toList(),
    );
  }

  Widget buildLesson(String lesson) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text('• $lesson'),
    );
  }

createLink(String link) {
  return GestureDetector(
    child: Text(
      link,
      style: TextStyle(color: Colors.blue),
    ),
    onTap: () async {
      String url = link;
      if (await canLaunchUrl(Uri.parse(url))) {
        await launchUrl(Uri.parse(url));
      } else {
        throw 'Could not launch $url';
      }
    },
  );
}

Widget spacing({double size=100}) {
  return SizedBox(height: size);
}




  

  Widget buildSectionHead(String title, {int? size}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: sectionTitleStyle.copyWith(
            fontSize: size?.toDouble() ?? sectionTitleStyle.fontSize),
      ),
    );
  }

  
