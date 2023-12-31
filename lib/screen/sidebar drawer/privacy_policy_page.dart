import 'package:flutter/material.dart';

class PrivacyPolicyPageWidget extends StatelessWidget {
  const PrivacyPolicyPageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Privacy & Policy',
          style: TextStyle(color: Colors.black),
        ),
        elevation: 1,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(40),
        child: ListView(
          children: [
            buildHeading('Privacy policy'),
            buildSpacing(10),
            buildText(
                'At Recipe Plate, we are committed to protecting your privacy and ensuring the security of your personal information. This Privacy Policy outlines the types of information we collect, how we use it, and the measures we take to safeguard your data.'),
            buildSpacing(15),
            buildHeading('Information we collect'),
            buildSpacing(10),
            buildText(
                '• User Data : We may collect and store information that you provide when using our app, including but not limited to your name, email address, and profile information.'),
            buildText(
                '• Recipe Data : We collect and store the recipes you save and any information you add to your shopping list within the app.'),
            buildText(
                '• Usage Data : We may collect data about how you interact with the app, such as the recipes you view and the features you use.'),
            buildSpacing(15),
            buildHeading('How we use your information'),
            buildSpacing(10),
            buildText(
                '• Personalization : We use your data to personalize your experience within the app, such as recommending recipes based on your preferences.'),
            buildText(
                '• Communication : We may use your email address to send you updates, newsletters, or important announcements related to the app.'),
            buildText(
                '• Improvement : Your data helps us improve our app by understanding how you use it and what features you find most valuable.'),
            buildSpacing(15),
            buildHeading('Data security'),
            buildSpacing(10),
            buildText(
                'We take security seriously and employ industry-standard measures to protect your data from unauthorized access, disclosure, alteration, or destruction.'),
            buildSpacing(15),
            buildHeading('Third-party services'),
            buildSpacing(10),
            buildText(
                'Our app may link to or integrate with third-party services. Please review their privacy policies as we are not responsible for their practices.'),
            buildSpacing(15),
            buildHeading('Changes to this privacy policy'),
            buildSpacing(10),
            buildText(
                'We reserve the right to update this Privacy Policy from time to time. Any changes will be posted within the app, and it is your responsibility to review them.'),
            buildSpacing(15),
            buildHeading('Contact us'),
            buildSpacing(10),
            buildText(
                'If you have any questions or concerns about this Privacy Policy or the app\'s privacy practices, please contact us at contact@recipeplateapp.com.'),
            buildSpacing(15),
          ],
        ),
      ),
    );
  }

  Widget buildHeading(String text) {
    return Text(
      text,
      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    );
  }

  Widget buildText(String text) {
    return Text(text);
  }

  Widget buildSpacing(double height) {
    return SizedBox(height: height);
  }
}
