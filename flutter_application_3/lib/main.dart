import 'package:flutter/material.dart';
import 'worker.dart'; // Importamos la clase Worker

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gestor de Trabajadores',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const WorkerManagerPage(),
    );
  }
}

class WorkerManagerPage extends StatefulWidget {
  const WorkerManagerPage({super.key});

  @override
  State<WorkerManagerPage> createState() => _WorkerManagerPageState();
}

class _WorkerManagerPageState extends State<WorkerManagerPage> {
  // Lista de trabajadores de tipo Worker
  List<Worker> workers = [];
  
  // Controladores para los campos de texto
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _apellidosController = TextEditingController();
  final TextEditingController _edadController = TextEditingController();

  @override
  void dispose() {
    _idController.dispose();
    _nombreController.dispose();
    _apellidosController.dispose();
    _edadController.dispose();
    super.dispose();
  }

  // Método para agregar un trabajador
  void _addWorker() {
    // Obtener valores de los campos
    String id = _idController.text.trim();
    String nombre = _nombreController.text.trim();
    String apellidos = _apellidosController.text.trim();
    String edadText = _edadController.text.trim();

    // Validar campos vacíos
    if (id.isEmpty || nombre.isEmpty || apellidos.isEmpty || edadText.isEmpty) {
      _showAlert('Error', 'Todos los campos son obligatorios');
      return;
    }

    // Validar edad
    int? edad = int.tryParse(edadText);
    if (edad == null) {
      _showAlert('Error', 'Ingrese una edad válida (solo números)');
      return;
    }
    
    if (edad < 18) {
      _showAlert('Error', 'Solo se admiten mayores de edad (18 años o más)');
      return;
    }

    // Verificar ID duplicado
    for (Worker worker in workers) {
      if (worker.id == id) {
        _showAlert('Error', 'Ya existe un trabajador con el ID: $id');
        return;
      }
    }

    // Crear y agregar nuevo trabajador
    Worker newWorker = Worker(
      id: id,
      nombre: nombre,
      apellidos: apellidos,
      edad: edad,
    );

    setState(() {
      workers.add(newWorker);
    });

    // Limpiar campos
    _idController.clear();
    _nombreController.clear();
    _apellidosController.clear();
    _edadController.clear();
    
    _showAlert('Éxito', 'Trabajador agregado correctamente');
  }

  // Método para eliminar el último trabajador
  void _removeLastWorker() {
    if (workers.isEmpty) {
      _showAlert('Error', 'No hay trabajadores para eliminar');
      return;
    }
    
    setState(() {
      workers.removeLast();
    });
    
    _showAlert('Éxito', 'Último trabajador eliminado correctamente');
  }

  // Mostrar alertas simples
  void _showAlert(String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gestor de Trabajadores'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Título
            const Text(
              'Registro de Trabajadores',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),

            // Formulario
            Column(
              children: [
                // Campo ID
                TextField(
                  controller: _idController,
                  decoration: const InputDecoration(
                    labelText: 'ID',
                  ),
                ),
                const SizedBox(height: 10),
                
                // Campo Nombre
                TextField(
                  controller: _nombreController,
                  decoration: const InputDecoration(
                    labelText: 'Nombre',
                  ),
                ),
                const SizedBox(height: 10),
                
                // Campo Apellidos
                TextField(
                  controller: _apellidosController,
                  decoration: const InputDecoration(
                    labelText: 'Apellidos',
                  ),
                ),
                const SizedBox(height: 10),
                
                // Campo Edad
                TextField(
                  controller: _edadController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Edad',
                  ),
                ),
                const SizedBox(height: 15),
                
                // Botones
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: _addWorker,
                        child: const Text('Agregar'),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: _removeLastWorker,
                        child: const Text('Eliminar Último'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            
            const SizedBox(height: 20),
            
            // Título de la lista
            Text(
              'Lista de Trabajadores (${workers.length})',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            
            // Lista de trabajadores
            Expanded(
              child: workers.isEmpty
                  ? const Center(
                      child: Text(
                        'No hay trabajadores registrados',
                        style: TextStyle(fontSize: 16),
                      ),
                    )
                  : ListView.builder(
                      itemCount: workers.length,
                      itemBuilder: (context, index) {
                        final worker = workers[index];
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            '${index + 1}. ID: ${worker.id} - ${worker.nombre} ${worker.apellidos} - Edad: ${worker.edad} años',
                            style: const TextStyle(fontSize: 16),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}