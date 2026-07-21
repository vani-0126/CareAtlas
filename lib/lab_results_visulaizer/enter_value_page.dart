import 'package:flutter/material.dart';
import 'lab_results_data.dart';
import 'package:google_fonts/google_fonts.dart';
import 'lab_final_results_page.dart';

class EnterValuePage extends StatefulWidget {
  final LabResult labResult;

  const EnterValuePage({super.key, required this.labResult});

  @override
  State<EnterValuePage> createState() => _EnterValuePageState();
}

class _EnterValuePageState extends State<EnterValuePage> {
  final TextEditingController valueController = TextEditingController();
  @override
  void dispose() {
    valueController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.labResult.testName)),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Enter Your Lab Value",
              style: GoogleFonts.inter(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: Colors.cyan,
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: valueController,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: InputDecoration(
                suffixText: widget.labResult.unit,
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.cyan,
                foregroundColor: Colors.white,
                minimumSize: Size(200, 100),
                textStyle: GoogleFonts.inter(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              onPressed: () {
                double value = double.parse(valueController.text);

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LabResultDetailsPage(
                      term: widget.labResult,
                      value: value,
                    ),
                  ),
                );
              },
              child: Text("Analyze"),
            ),
          ],
        ),
      ),
    );
  }
}
