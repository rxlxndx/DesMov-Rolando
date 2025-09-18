class Worker {
  final String id;
  final String nombre;
  final String apellidos;
  final int edad;

  Worker({
    required this.id,
    required this.nombre,
    required this.apellidos,
    required this.edad,
  });

  @override
  String toString() {
    return 'ID: $id - $nombre $apellidos (${edad} años)';
  }
}