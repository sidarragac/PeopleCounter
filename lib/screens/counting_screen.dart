import 'dart:async';
import 'package:flutter/material.dart';
import 'result_screen.dart';
import '../utils/people_tracker.dart';

class CountingScreen extends StatefulWidget {
  final int initialCount;
  final DateTime startTime;
  final int requiredQuorum;
  final String undergraduate;

  final String userId;

  const CountingScreen({
    super.key,
    required this.initialCount,
    required this.startTime,
    required this.requiredQuorum,
    required this.undergraduate,
    required this.userId,
  });

  @override
  State<CountingScreen> createState() => _CountingScreenState();
}

class _CountingScreenState extends State<CountingScreen> {
  late int _count;
  late DateTime _startTime;
  late Timer _timer;
  Duration _elapsed = Duration.zero;

  final PeopleTracker _peopleTracker = PeopleTracker();

  @override
  void initState() {
    super.initState();
    _count = widget.initialCount;
    _startTime = widget.startTime;
    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      setState(() {
        _elapsed = DateTime.now().difference(_startTime);
      });
    });
  }

  void _incrementCount() {
    setState(() {
      _count++;
      _peopleTracker.updateCount(_count);
    });
  }

  void _decrementCount() {
    setState(() {
      _count--;
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _finish() {
    final endTime = DateTime.now();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => ResultScreen(
          startTime: _startTime,
          endTime: endTime,
          statistics: _peopleTracker,
          undergraduate: widget.undergraduate,
          userId: widget.userId,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    String elapsedStr =
        "${_elapsed.inHours.toString().padLeft(2, '0')}:${(_elapsed.inMinutes % 60).toString().padLeft(2, '0')}:${(_elapsed.inSeconds % 60).toString().padLeft(2, '0')}";

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/images/repres.png", height: 200),
            Text(
              "Asamblea de ${widget.undergraduate}",
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
            Text(
              "Tiempo: $elapsedStr",
              style: const TextStyle(
                fontSize: 20
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [  
                const SizedBox(width: 10),
                Text(
                  "Quorum mínimo: ${widget.requiredQuorum}",
                  style: const TextStyle(
                    fontSize: 15
                  )
                ),
              ],
            ),
            Text(
              "Personas: $_count",
              style: const TextStyle(
                fontSize: 32
              )
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    if (_count > widget.initialCount) _decrementCount();
                  }, 
                  child: const Text(
                    "-",
                    style: TextStyle(
                      fontSize: 24
                    ),
                  )
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: _incrementCount,
                  child: const Text(
                    "+",
                    style: TextStyle(
                      fontSize: 20
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [  
                if (_count < widget.requiredQuorum) ...[
                  const Icon(Icons.warning, color: Colors.yellow, size: 24),
                  const SizedBox(width: 10),
                  Text("Registrar en el Excel no está permitido", style: const TextStyle(color: Colors.yellow, fontSize: 16)),
                ] else ...[
                  const Icon(Icons.check_circle, color: Colors.green, size: 24),
                  const SizedBox(width: 10),
                  Text("Registrar en el Excel está permitido", style: const TextStyle(color: Colors.green, fontSize: 16)),
                ],
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _finish, 
              child: const Text(
                "Finalizar conteo",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                )
              ),
            ),
          ],
        ),
      ),
    );
  }
}
