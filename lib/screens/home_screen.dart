import 'package:flutter/material.dart';
import 'initial_input_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/images/repres.png", height: 200),
            Column(
              children: [
                const Text(
                  "Asambleas Estudiantiles",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const Text(
                  "Conteo de Aforo",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                )
              ] 
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const InitialInputScreen()),
                );
              },
              child: const Text("Iniciar nuevo conteo", style: TextStyle(
                color: Colors.black,
                fontSize: 18,
              )),
            )
          ],
        ),
      ),
    );
  }
}
