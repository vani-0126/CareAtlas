import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:health_bridge/SymptomTracker/symptom_tracker_events.dart';

class SymptomHistoryPage extends StatefulWidget {
  final List<SymptomTrackerEvent> symptoms;

  const SymptomHistoryPage({super.key, required this.symptoms});

  @override
  State<SymptomHistoryPage> createState() => _SymptomHistoryPageState();
}

class _SymptomHistoryPageState extends State<SymptomHistoryPage> {
  String searchQuery = '';
  String? selectedMonth;

  // Get the entries that match the search and month filter.
  List<SymptomTrackerEvent> get filteredSymptoms {
    List<SymptomTrackerEvent> filtered = widget.symptoms.where((symptom) {
      final name = symptom.symptomName ?? '';

      final matchesSearch = name.toLowerCase().contains(
        searchQuery.toLowerCase(),
      );

      final date = symptom.symptomDate;

      final monthKey = date == null
          ? ''
          : '${date.year}-${date.month.toString().padLeft(2, '0')}';

      final matchesMonth = selectedMonth == null || monthKey == selectedMonth;

      return matchesSearch && matchesMonth && date != null;
    }).toList();

    // Sort newest to oldest.
    filtered.sort((a, b) => b.symptomDate!.compareTo(a.symptomDate!));

    return filtered;
  }

  // Get all months that have symptom entries.
  List<String> get availableMonths {
    final months = widget.symptoms
        .where((symptom) => symptom.symptomDate != null)
        .map((symptom) {
          final date = symptom.symptomDate!;
          return '${date.year}-${date.month.toString().padLeft(2, '0')}';
        })
        .toSet()
        .toList();

    months.sort((a, b) => b.compareTo(a));

    return months;
  }

  // Convert a month key into a readable heading.
  String formatMonth(String monthKey) {
    final parts = monthKey.split('-');
    final year = int.parse(parts[0]);
    final month = int.parse(parts[1]);

    const monthNames = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];

    return '${monthNames[month - 1]} $year';
  }

  String formatDate(DateTime date) {
    return '${date.month}/${date.day}/${date.year}';
  }

  // Group filtered entries by month.
  Map<String, List<SymptomTrackerEvent>> get groupedSymptoms {
    final Map<String, List<SymptomTrackerEvent>> groups = {};

    for (final symptom in filteredSymptoms) {
      final date = symptom.symptomDate!;
      final key = '${date.year}-${date.month.toString().padLeft(2, '0')}';

      groups.putIfAbsent(key, () => []);
      groups[key]!.add(symptom);
    }

    return groups;
  }

  Widget buildSymptomCard(SymptomTrackerEvent symptom) {
    final date = symptom.symptomDate;

    return Card(
      color: Colors.white,
      elevation: 1,
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        title: Text(
          symptom.symptomName ?? 'Unnamed symptom',
          style: GoogleFonts.inter(fontWeight: FontWeight.w600),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 5),
          child: Text(
            [
              if (date != null) formatDate(date),
              if (symptom.symptomTime != null &&
                  symptom.symptomTime!.isNotEmpty)
                symptom.symptomTime!,
              if (symptom.symptomDuration != null &&
                  symptom.symptomDuration!.isNotEmpty)
                'Duration: ${symptom.symptomDuration}',
            ].join(' • '),
            style: GoogleFonts.inter(fontSize: 12),
          ),
        ),
        trailing: Text(
          symptom.symptomSeverity ?? 'N/A',
          style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w500),
        ),
        isThreeLine: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final groups = groupedSymptoms;
    final months = availableMonths;

    return Scaffold(
      backgroundColor: const Color(0xFFE7F4EF),
      appBar: AppBar(
        backgroundColor: const Color(0xFFE7F4EF),
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Symptom History',
          style: GoogleFonts.inter(fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Search bar
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    searchQuery = value;
                  });
                },
                decoration: InputDecoration(
                  hintText: 'Search symptoms...',
                  prefixIcon: const Icon(Icons.search),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),

            // Month filter
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: DropdownButtonFormField<String>(
                value: selectedMonth,
                isExpanded: true,
                decoration: InputDecoration(
                  labelText: 'Filter by month',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide.none,
                  ),
                ),
                items: [
                  const DropdownMenuItem<String>(
                    value: null,
                    child: Text('All months'),
                  ),
                  ...months.map((month) {
                    return DropdownMenuItem<String>(
                      value: month,
                      child: Text(formatMonth(month)),
                    );
                  }),
                ],
                onChanged: (value) {
                  setState(() {
                    selectedMonth = value;
                  });
                },
              ),
            ),

            // History grouped by month
            Expanded(
              child: groups.isEmpty
                  ? Center(
                      child: Text(
                        searchQuery.isNotEmpty
                            ? 'No matching symptoms found.'
                            : 'No symptom history yet.',
                        style: GoogleFonts.inter(fontSize: 15),
                      ),
                    )
                  : ListView(
                      padding: const EdgeInsets.only(bottom: 16),
                      children: groups.entries.map((entry) {
                        return Card(
                          margin: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          color: Colors.white,
                          elevation: 1,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: ExpansionTile(
                            initiallyExpanded: true,
                            title: Text(
                              formatMonth(entry.key),
                              style: GoogleFonts.inter(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                              '${entry.value.length} '
                              '${entry.value.length == 1 ? 'entry' : 'entries'}',
                            ),
                            children: entry.value
                                .map(buildSymptomCard)
                                .toList(),
                          ),
                        );
                      }).toList(),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
