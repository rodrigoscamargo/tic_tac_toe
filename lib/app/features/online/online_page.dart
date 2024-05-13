import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class OnlinePage extends StatefulWidget {
  const OnlinePage({super.key});

  @override
  State<OnlinePage> createState() => _OnlinePageState();
}

class _OnlinePageState extends State<OnlinePage> {

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () => Modular.to.pushNamed('/online/game'),
            child: const Text('Crie uma sala'),
          ),
          ElevatedButton(
            onPressed: () {},
            child: const Text('Entrar em uma sala'),
          ),
        ],
      ),
    );
  }
}