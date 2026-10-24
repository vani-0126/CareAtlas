import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:google_fonts/google_fonts.dart';

class AiQuestionbuilder extends StatefulWidget {
  const AiQuestionbuilder({super.key});
  @override
  State<AiQuestionbuilder> createState() => _AiQuestionbuilderState();
}

class _AiQuestionbuilderState extends State<AiQuestionbuilder> {
  final TextEditingController _controller = TextEditingController();
  String selectedAppointmentType = "";
  final List<String> appointmentType = [
    "Primary Care",
    "Specialist",
    "Follow-Up",
    "Lab Review",
    "Medication Discussion",
    "New Symptoms",
  ];
  String _aiOutput2 =
      "Select an option above and describe your concerns to build questions.";
  bool _isLoading = false;

  Future<void> fetchQuestions(
    String appointmentType,
    String description,
  ) async {
    setState(() {
      _isLoading = true;
      _aiOutput2 = "Processing and verifying your information. Please wait...";
    });
    try {
      final url = Uri.parse('http://localhost:8080/questions');
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'appointment_type': appointmentType,
          'description': description,
        }),
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          _aiOutput2 = data['questions'] ?? "No questions generated.";
          _isLoading = false;
        });
      } else {
        setState(() {
          _aiOutput2 =
              "Error: Unable to fetch questions. Please try again later.";
          _isLoading = false;
        });
      }
    } catch (error) {
      setState(() {
        _aiOutput2 =
            "Connection Failed. Make sure your Python server is running.";
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 219, 205, 255),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color.fromARGB(255, 219, 205, 255),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Question Builder",
              style: GoogleFonts.inter(
                color: const Color.fromARGB(255, 35, 0, 59),
                fontSize: 30,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "Generate personalized questions for your next appointment",
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: appointmentType.map((type) {
                return ChoiceChip(
                  label: Text(type),
                  selected: selectedAppointmentType == type,
                  onSelected: (selected) {
                    setState(() {
                      selectedAppointmentType = type;
                    });
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(8),
              child: TextField(
                controller: _controller,
                minLines: 4,
                maxLines: 8,
                decoration: const InputDecoration(
                  hintText:
                      "Example: I'm seeing my oncologist to discuss my recent blood work. My RBC count is low and I've been feeling tired.",
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(horizontal: 12),
                  fillColor: Colors.white,
                  filled: true,
                ),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 102, 40, 143),
                foregroundColor: Colors.white,
                minimumSize: const Size(200, 50),
                textStyle: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              onPressed: _isLoading
                  ? null
                  : () {
                      if (selectedAppointmentType.isNotEmpty &&
                          _controller.text.isNotEmpty) {
                        fetchQuestions(
                          selectedAppointmentType,
                          _controller.text,
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              "Please select an appointment type and provide a description.",
                            ),
                          ),
                        );
                      }
                    },
              child: const Text("Generate Questions"),
            ),
            const SizedBox(height: 20),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.4),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                _aiOutput2,
                style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Colors.black87,
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
