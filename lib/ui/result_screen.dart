import 'package:flutter/material.dart';
import 'package:flutter_neat_and_clean_calendar/flutter_neat_and_clean_calendar.dart';
import 'package:fyp_calendar_2/controllers/task_controller.dart';
import 'package:fyp_calendar_2/ui/widgets/button.dart';
import 'package:get/get.dart';
import 'add_event_page.dart';
import 'ocr_scanner.dart';

class ResultScreen extends StatelessWidget {
  final String text;

  const ResultScreen({super.key, required this.text});

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Text('Result'),
      actions: [
        IconButton(
          icon: const Icon(Icons.browse_gallery),
          tooltip: 'Open gallery',
          onPressed: () async {
          await Get.to(() => AddEvent());
        },
        ),
      ],
    ),
    body: Container(
      padding: const EdgeInsets.all(30.0),
      child: Text(text),
    ),
  );
}