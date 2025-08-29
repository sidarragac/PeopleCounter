import 'package:flutter/material.dart';
import 'counting_screen.dart';
import './home_screen.dart';

class InitialInputScreen extends StatefulWidget {
  final String userId;

  const InitialInputScreen({super.key, required this.userId});

  @override
  State<InitialInputScreen> createState() => _InitialInputScreenState();
}

class _InitialInputScreenState extends State<InitialInputScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _initialQuorumController = TextEditingController();
  final TextEditingController _requiredQuorumController = TextEditingController();
  final TextEditingController _undergraduateController = TextEditingController();

  void _redirect() {
    final inicial = int.tryParse(_initialQuorumController.text) ?? 0;
    final requerido = int.tryParse(_requiredQuorumController.text) ?? 0;
    final inicio = DateTime.now();
    final pregrado = _undergraduateController.text;

    if (_formKey.currentState!.validate()) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => CountingScreen(
            initialCount: inicial,
            startTime: inicio,
            requiredQuorum: requerido,
            undergraduate: pregrado,
            userId: widget.userId,
          ),
        ),
      );
    }

  }

  String? _validate(value) {
    if (value == null || value.isEmpty) {
      return "Este campo es obligatorio";
    }
    return null;
  }

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
            SizedBox(
              width: 700,
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
                      child: TextFormField(
                        controller: _undergraduateController,
                        decoration: InputDecoration(
                          labelText: "Pregrado",
                        ),
                        validator: _validate,
                      ),
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
                      child: TextFormField(
                        controller: _initialQuorumController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: "Representantes en la sala",
                        ),
                        validator: _validate,
                      ),
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
                      child: TextFormField(
                        controller: _requiredQuorumController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: "Quórum requerido",
                        ),
                        validator: _validate,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (_) => HomeScreen(userId: widget.userId)),
                            );
                          },
                          child: const Text(
                            "Atrás",  
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: _redirect,
                          child: const Text(
                            "Iniciar",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                )
              )
            ),
          ],
        ),
      ),
    );
  }
}
