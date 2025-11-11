import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../providers/data_provider.dart';

class CompletedTasksScreen extends StatelessWidget {
  const CompletedTasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Tareas Completadas',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
            letterSpacing: 2.0,
          ),
        ),
        backgroundColor: const Color(0xFF0A0A0F),
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            center: Alignment.center,
            radius: 1.5,
            colors: [
              Color(0xFF0A0A0F),
              Color(0xFF1A1A2E),
            ],
          ),
        ),
        child: Consumer<DataProvider>(
          builder: (context, dataProvider, child) {
            if (dataProvider.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            final completedTasks = dataProvider.tasks.where((task) => task['status'] == 'completed').toList();

            if (completedTasks.isEmpty) {
              return const Center(
                child: Text(
                  'No hay tareas completadas',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              );
            }

            return ListView.builder(
              itemCount: completedTasks.length,
              itemBuilder: (context, index) {
                final task = completedTasks[index];
                return Container(
                  margin: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Colors.green, Colors.teal],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Card(
                    color: Colors.transparent,
                    elevation: 0,
                    child: ListTile(
                      leading: const Icon(Icons.check_circle, color: Colors.white, size: 30),
                      title: Text(
                        task['nombre'] ?? 'Sin nombre',
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          shadows: [Shadow(color: Colors.black, blurRadius: 2)],
                        ),
                      ),
                      subtitle: Text(
                        'Habilidad requerida: ${task['requiredSkill'] ?? 'N/A'}\nPrioridad: ${task['priority'] ?? 'N/A'}\nHoras estimadas: ${task['estimatedHours'] ?? 0}\nFecha inicio: ${task['fechaInicio'] != null ? DateFormat('dd/MM/yyyy').format(DateTime.parse(task['fechaInicio'])) : 'N/A'}\nFecha finalización: ${task['fechaFinalizacion'] != null ? DateFormat('dd/MM/yyyy').format(DateTime.parse(task['fechaFinalizacion'])) : 'N/A'}',
                        style: const TextStyle(color: Colors.white70),
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.white),
                        onPressed: () => _showDeleteDialog(context, 'tarea', int.parse(task['id'].toString()), () => dataProvider.deleteTask(int.parse(task['id'].toString()))),
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  void _showDeleteDialog(BuildContext context, String type, int id, VoidCallback onDelete) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1A1A2E),
        title: Text(
          'Eliminar $type',
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        content: Text(
          '¿Estás seguro de que quieres eliminar este $type?',
          style: const TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar', style: TextStyle(color: Colors.white70)),
          ),
          TextButton(
            onPressed: () {
              onDelete();
              Navigator.pop(context);
            },
            child: const Text('Eliminar', style: TextStyle(color: Colors.redAccent)),
          ),
        ],
      ),
    );
  }
}
