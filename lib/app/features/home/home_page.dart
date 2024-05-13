import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () => Modular.to.pushNamed('/game/vis-a-vis'),
            child: const Text('Cara a Cara'),
          ),
          ElevatedButton(
            onPressed: () => Modular.to.pushNamed('/game/ai'),
            child: const Text('Consegue me derrotar?'),
          ),
          ElevatedButton(
            onPressed: () => Modular.to.pushNamed('/online'),
            child: const Text('Chame um amigo'),
          ),
        ],
      ),
    );
  }
}
