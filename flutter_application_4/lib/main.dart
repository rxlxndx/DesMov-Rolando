import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Contador con Historial',
      home: const MyHomePage(title: 'Contador con Historial'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  
  // Variables necesarias según las instrucciones
  List<int> _historial = [];
  bool _mostrarHistorial = false;

  void _incrementCounter() {
    setState(() {
      _counter++;
      // Guardar el valor actual en el historial
      _historial.add(_counter);
    });
  }

  void _decrementCounter() {
    setState(() {
      _counter--;
      // Guardar el valor actual en el historial
      _historial.add(_counter);
    });
  }

  // Método para cambiar la visibilidad del historial
  void _toggleHistorial() {
    setState(() {
      _mostrarHistorial = !_mostrarHistorial;
    });
  }

  // Método para limpiar el historial
  void _limpiarHistorial() {
    setState(() {
      _historial.clear();
    });
  }

  // Método que devuelve un widget con la lista de valores
  Widget _buildHistorial() {
    if (_historial.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(20.0),
        child: Text(
          'No hay historial todavía.',
          style: TextStyle(fontSize: 16),
          textAlign: TextAlign.center,
        ),
      );
    }

    return SizedBox(
      height: 200,
      child: ListView.builder(
        itemCount: _historial.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(4.0),
            child: Text(
              '${index + 1}. Valor: ${_historial[index]}',
              style: const TextStyle(fontSize: 16),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Has presionado el botón estas veces:',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 10),
            
            Text(
              '$_counter',
              style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            ),
            
            const SizedBox(height: 20),
            
            // Botones de sumar y restar
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _decrementCounter,
                  child: const Text('-'),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: _incrementCounter,
                  child: const Text('+'),
                ),
              ],
            ),
            
            const SizedBox(height: 30),
            
            // Botón para mostrar/ocultar historial
            ElevatedButton(
              onPressed: _toggleHistorial,
              child: Text(_mostrarHistorial 
                ? 'Ocultar Historial' 
                : 'Mostrar Historial'
              ),
            ),
            
            const SizedBox(height: 10),
            
            // Botón para limpiar historial
            ElevatedButton(
              onPressed: _limpiarHistorial,
              child: const Text('Limpiar Historial'),
            ),
            
            const SizedBox(height: 20),
            
            // Mostrar historial condicionalmente
            if (_mostrarHistorial) ...[
              const Text(
                'Historial:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              _buildHistorial(),
            ],
          ],
        ),
      ),
    );
  }
}