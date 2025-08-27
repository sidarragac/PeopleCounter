import 'package:flutter/material.dart';
import 'counting_screen.dart';
import './home_screen.dart';

class InitialInputScreen extends StatefulWidget {
  const InitialInputScreen({super.key});

  @override
  State<InitialInputScreen> createState() => _InitialInputScreenState();
}

class _InitialInputScreenState extends State<InitialInputScreen> {
  final TextEditingController _initialQuorumController = TextEditingController();
  final TextEditingController _requiredQuorumController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/images/repres.png", height: 200),
            const Text(
              "Datos iniciales",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
              child: TextField(
                controller: _initialQuorumController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: "Representantes en la sala",
                ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
              child: TextField(
                controller: _requiredQuorumController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: "Quorum requerido",
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    final inicial = int.tryParse(_initialQuorumController.text) ?? 0;
                    final requerido = int.tryParse(_requiredQuorumController.text) ?? 0;
                    final inicio = DateTime.now();
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) => CountingScreen(
                          initialCount: inicial,
                          startTime: inicio,
                          requiredQuorum: requerido,
                        ),
                      ),
                    );
                  },
                  child: const Text(
                    "Iniciar",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const HomeScreen()),
                    );
                  },
                  child: const Text(
                    "Atrás",  
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
