import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'data_scource.dart';
import 'joke_dto.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (context) => DataSource(),
      child: MaterialApp(
        home: const JokePage(),
      ),
    );
  }
}

class JokePage extends StatefulWidget {
  const JokePage({super.key});

  @override
  State<JokePage> createState() => _JokePageState();
}

class _JokePageState extends State<JokePage> {
  JokeDto? joke;

  @override
  void initState() {
    super.initState();
    _loadJoke();
  }

  _loadJoke() async {
    setState(() {
      joke = null;
    });
    final newJoke = await context.read<DataSource>().getJoke();
    setState(() {
      joke = newJoke;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Jokes")),
      body: Column(
        children: [
          if (joke == null) const CircularProgressIndicator(),
          if (joke?.joke != null) Text(joke!.joke!),
          if (joke?.setup != null) Text(joke!.setup!),
          if (joke?.delivery != null) Text(joke!.delivery!),
          TextButton(onPressed: _loadJoke, child: const Text("Show another")),
        ],
      ),
    );
  }
}