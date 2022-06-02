import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp(missatge: 'Uep provider!'));
}

// A aquest exercici anem a proveïr un objecte d'aquesta classe, no una variable
// Per això mantenim aquesta jerarquia de Widgets i mostrarem l'estat de loaded
class Service {
  late bool loaded;

  Service() {
    print('Initializing service...');
    loaded = true;
  }

  void dispose() {
    print('Disposing service...');
  }
}

class MyApp extends StatelessWidget {
  final String missatge;
  const MyApp({Key? key, required this.missatge}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // A aquest cas emprarem el Provider indicant el tipus d'objecte que empra
    // No utilitzarem el .value, sinò el constructor per defecte i definirem el create
    return Provider<Service>(
      create: (_) => Service(),
      // No podrem comprovar la funcionalitat del dispose, ja que sortim de l'app.
      dispose: (context, service) => service.dispose(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Page(),
      ),
    );
  }
}

class Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
    );
  }
}

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Texte(),
    );
  }
}

class Texte extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final service = Provider.of<Service>(context);
    return Text(service.loaded ? 'Loaded!' : 'Not loaded',
        style: TextStyle(fontSize: 30));
  }
}
