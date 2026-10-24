import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SafetyPrivacyPage extends StatefulWidget {
  const SafetyPrivacyPage({super.key});
  @override
  State<SafetyPrivacyPage> createState() => _SafetyPrivacyPageState();
}

class _SafetyPrivacyPageState extends State<SafetyPrivacyPage> {
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8FAFC),
      appBar: AppBar(
        title: Text(
          "Privacy and Safety",
          style: GoogleFonts.inter(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Medical Disclaimer",
              style: GoogleFonts.inter(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 8),
            Text(
              "CareAtlas provides educational information to help users understand health topics and prepare for medical appointments. It does not provide medical advice, diagnosis, or treatment. Always consult a qualified healthcare professional about your care.",
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: const Color.fromARGB(115, 4, 4, 4),
              ),
            ),
            SizedBox(height: 24),
            Text(
              "AI Limitations",
              style: GoogleFonts.inter(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 8),
            Text(
              "AI-generated explanations may be inaccurate or incomplete. Verify important information with a healthcare professional.",
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: const Color.fromARGB(115, 4, 4, 4),
              ),
            ),
            SizedBox(height: 24),
            Text(
              "Privacy & Personal Information",
              style: GoogleFonts.inter(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 8),
            Text(
              "To help protect your privacy, avoid entering names, contact information, or other personally identifying details into AI-powered features. Be mindful of the health information you choose to enter into CareAtlas.",
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: const Color.fromARGB(115, 4, 4, 4),
              ),
            ),
            SizedBox(height: 24),
            Text(
              "Data Storage & Handling",
              style: GoogleFonts.inter(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 8),
            Text(
              "CareAtlas stores certain health information locally on the device using its database. When users access AI-powered features, the text entered may be sent to Groq's API to generate a response. Avoid including personally identifying information in AI prompts. Please review the applicable third-party privacy practices to understand how submitted information may be processed.",
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: const Color.fromARGB(115, 4, 4, 4),
              ),
            ),
            SizedBox(height: 24),
            Text(
              "Emergency",
              style: GoogleFonts.inter(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 8),
            Text(
              "CareAtlas is not an emergency service. If you believe you are experiencing a medical emergency, contact emergency services immediately.",
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: const Color.fromARGB(115, 4, 4, 4),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
