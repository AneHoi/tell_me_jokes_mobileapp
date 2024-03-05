import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'data_scource.dart';
import 'joke_dto.dart';

class JokeScreen extends StatefulWidget {
  const JokeScreen({super.key})

  @override
  State<JokeScreen> createState() => _JokeScreenState();
}


class _JokeScreenState extends State<JokeScreen> {
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