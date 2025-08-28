import 'package:flutter/material.dart';
import '../utils/people_tracker.dart';

class ResultScreen extends StatelessWidget {
  final DateTime startTime;
  final DateTime endTime;
  final PeopleTracker statistics;

  const ResultScreen({
    super.key,
    required this.startTime,
    required this.endTime,
    required this.statistics,
  });

  Widget _buildMaxPerHour() {
    final maxPerHour = statistics.maxPerHour;

    if (maxPerHour.isEmpty) {
      return const Text("No se registraron datos.");
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Máximo número de personas por hora",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        const SizedBox(height: 10),
        for (final entry in maxPerHour.entries)
          Text(
            "- De ${entry.key}:00 a ${entry.key + 1}:00: ${entry.value} personas",
            style: TextStyle(
              fontSize: 14,
            ),
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final duration = endTime.difference(startTime);
    final maxInSession = statistics.maxInSession;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/images/repres.png", height: 200),
            Text("Estadísticas generales", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Text("Inicio: ${startTime.toString().split('.')[0]}", style: TextStyle(fontSize: 16),),
            Text("Fin: ${endTime.toString().split('.')[0]}", style: TextStyle(fontSize: 16),),
            Text("Duración: ${duration.inHours} horas y ${duration.inMinutes.remainder(60)} minutos", style: TextStyle(fontSize: 16),),
            Text("Máximo número de personas: $maxInSession", style: TextStyle(fontSize: 16),),
            const SizedBox(height: 20),
            _buildMaxPerHour(),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.popUntil(context, (route) => route.isFirst),
              child: const Text("Volver al inicio"),
            ),
          ],
        ),
      ),
    );
  }
}
