import 'package:flutter/material.dart';

class TermsConditionsPageWidget extends StatelessWidget {
  const TermsConditionsPageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Terms & Conditions',
            style: TextStyle(color: Colors.black),
          ),
          elevation: 1,
          backgroundColor: Colors.white,
          iconTheme: const IconThemeData(color: Colors.black),
        ),
        body: Padding(
          padding: const EdgeInsets.all(40.20),
          child: ListView(
            children: [
              buildHeading('Terms and conditions'),
              buildSpacing(10),
              buildText(
                  'By using the Recipe Plate app, you agree to the following terms and conditions:'),
              buildSpacing(15),
              buildSection('1. Acceptance of terms',
                  '• By downloading, installing, or using the Recipe Plate app, you agree to be bound by these terms and conditions.'),
              buildSection('2. Use of the app', [
                '• You may use the Recipe Plate app for personal, non-commercial purposes only.',
                '• You agree not to use the app for any unlawful or prohibited purposes.',
              ]),
              buildSection(
                '3. User accounts',
                '• You may be required to create a user account to access certain features of the app. You are responsible for maintaining the confidentiality of your account information.',
              ),
              buildSection('4. Privacy',
                  '• Your use of the app is subject to our Privacy Policy, which outlines how we collect, use, and protect your personal information.'),
              buildSection('5. Updates and changes',
                  '• Recipe Plate reserves the right to update, modify, or discontinue the app or any part of it without notice.'),
              buildSection('6. Disclaimer',
                  '• The Recipe Plate app is provided "as is" without any warranties, express or implied, including but not limited to the implied warranties of merchantability and fitness for a particular purpose.'),
              buildSection('7. Limitation of Liability',
                  '• Recipe Plate and its affiliates shall not be liable for any direct, indirect, incidental, special, or consequential damages arising out of or in any way connected with your use of the app.'),
              buildSpacing(15),
            ],
          ),
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

  Widget buildSection(String heading, dynamic content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildHeading(heading),
        buildSpacing(10),
        if (content is String)
          buildText(content)
        else if (content is List)
          ...content.map((text) => buildText(text)),
        buildSpacing(15),
      ],
    );
  }
}
