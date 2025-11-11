import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';
import '../providers/data_provider.dart';
import '../widgets/custom_bottom_navigation_bar.dart';

import 'completed_tasks_screen.dart';

const List<String> cargos = [
  'Desarrollador Junior',
  'Desarrollador Senior',
  'Desarrollador Full-Stack',
  'Desarrollador Front-End',
  'Desarrollador Back-End',
  'Ingeniero DevOps',
  'Ingeniero QA',
  'Gerente de Proyecto',
  'Scrum Master',
  'Analista de Sistemas',
  'Arquitecto de Software',
];

const List<String> disponibilidades = ['25%', '50%', '75%', '100%'];

const List<String> productividades = ['Baja', 'Media', 'Alta'];

const List<String> habilidades = [
  'Python',
  'JavaScript',
  'Java',
  'C++',
  'React',
  'Angular',
  'Django',
  'Node.js',
  'Git',
  'Docker',
  'Agile',
  'Scrum',
  'SQL',
  'MongoDB',
  'AWS',
  'Azure',
  'Linux',
  'Testing',
];

const List<String> tareas = [
  'Desarrollar funcionalidad',
  'Corregir bug',
  'Revisar código',
  'Pruebas unitarias',
  'Despliegue',
  'Documentación',
  'Optimización de rendimiento',
];

const Map<String, String> descripciones = {
  'Desarrollar funcionalidad': 'Implementar una nueva característica en el software.',
  'Corregir bug': 'Identificar y solucionar errores en el código.',
  'Revisar código': 'Realizar revisión de código para asegurar calidad.',
  'Pruebas unitarias': 'Escribir y ejecutar pruebas unitarias.',
  'Despliegue': 'Preparar y ejecutar el despliegue de la aplicación.',
  'Documentación': 'Crear o actualizar documentación del proyecto.',
  'Optimización de rendimiento': 'Mejorar el rendimiento del software.',
};

const Map<String, List<String>> taskCargoMapping = {
  'Desarrollar funcionalidad': ['Desarrollador Junior', 'Desarrollador Senior', 'Desarrollador Full-Stack', 'Desarrollador Front-End', 'Desarrollador Back-End'],
  'Corregir bug': ['Desarrollador Junior', 'Desarrollador Senior', 'Desarrollador Full-Stack', 'Desarrollador Front-End', 'Desarrollador Back-End', 'Ingeniero QA'],
  'Revisar código': ['Desarrollador Junior', 'Desarrollador Senior', 'Desarrollador Full-Stack', 'Desarrollador Front-End', 'Desarrollador Back-End'],
  'Pruebas unitarias': ['Ingeniero QA', 'Desarrollador Junior', 'Desarrollador Senior'],
  'Despliegue': ['Ingeniero DevOps'],
  'Documentación': ['Analista de Sistemas', 'Gerente de Proyecto', 'Arquitecto de Software', 'Scrum Master'],
  'Optimización de rendimiento': ['Desarrollador Senior', 'Desarrollador Full-Stack', 'Arquitecto de Software'],
};

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  int _currentIndex = 0;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<Color?> _gradientAnimation;
  late Animation<Color?> _backgroundAnimation;
  double _dragDistance = 0;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );
    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.elasticOut),
    );
    _slideAnimation = Tween<Offset>(begin: const Offset(0, 0.1), end: Offset.zero).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );
    _gradientAnimation = ColorTween(
      begin: const Color(0xFF0A0A0F),
      end: const Color(0xFF1A1A2E),
    ).animate(_animationController);
    _backgroundAnimation = ColorTween(
      begin: const Color(0xFF0A0A0F),
      end: const Color(0xFF16213E),
    ).animate(CurvedAnimation(parent: _animationController, curve: Curves.easeInOut));
    _animationController.forward();
    // Cargar datos iniciales
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<DataProvider>().loadAllData();
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Widget _getBody(int index, DataProvider dataProvider) {
    switch (index) {
      case 0:
        return Container(key: const ValueKey(0), child: _buildDashboardTab(dataProvider));
      case 1:
        return Container(key: const ValueKey(1), child: _buildEmployeesTab(dataProvider));
      case 2:
        return Container(key: const ValueKey(2), child: _buildSkillsTab(dataProvider));
      case 3:
        return Container(key: const ValueKey(3), child: _buildTasksTab(dataProvider));
      case 4:
        return Container(key: const ValueKey(4), child: _buildAssignmentsTab(dataProvider));
      default:
        return Container(key: const ValueKey(0), child: _buildDashboardTab(dataProvider));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'SkillSync_icon.png',
              width: 40,
              height: 40,
            ),
            const SizedBox(width: 10),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'SKILLSYNC',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2.0,
                  ),
                ),
                Text(
                  'Potenciando Personas, Optimizando Procesos',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 12,
                    color: Colors.white70,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ],
        ),
        backgroundColor: const Color(0xFF0A0A0F),
        elevation: 0,
      ),
      body: Consumer<DataProvider>(
        builder: (context, dataProvider, child) {
          if (dataProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (dataProvider.error != null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Error: ${dataProvider.error}'),
                  ElevatedButton(
                    onPressed: () {
                      dataProvider.clearError();
                      dataProvider.loadAllData();
                    },
                    child: const Text('Reintentar'),
                  ),
                ],
              ),
            );
          }

          return Column(
            children: [
              CustomBottomNavigationBar(
                currentIndex: _currentIndex,
                onTap: (index) => setState(() => _currentIndex = index),
              ),
              Expanded(
                child: GestureDetector(
                  onHorizontalDragStart: (_) => _dragDistance = 0,
                  onHorizontalDragUpdate: (details) => _dragDistance += details.delta.dx,
                  onHorizontalDragEnd: (_) {
                    const double threshold = 50.0;
                    if (_dragDistance.abs() > threshold) {
                      if (_dragDistance < 0) {
                        // Deslizar a la izquierda para ir a la siguiente pestaña
                        setState(() {
                          _currentIndex = (_currentIndex + 1).clamp(0, 4);
                        });
                      } else {
                        // Deslizar a la derecha para ir a la anterior
                        setState(() {
                          _currentIndex = (_currentIndex - 1).clamp(0, 4);
                        });
                      }
                    }
                  },
                  child: AnimatedBuilder(
                    animation: _animationController,
                    builder: (context, child) {
                      return Container(
                        decoration: BoxDecoration(
                          gradient: RadialGradient(
                            center: Alignment.center,
                            radius: 1.5,
                            colors: [
                              _gradientAnimation.value!,
                              _backgroundAnimation.value!,
                              const Color(0xFF1A1A2E),
                              const Color(0xFF16213E),
                              const Color(0xFF0F0F23),
                              const Color(0xFF0A0A0F),
                              const Color(0xFF2D1B69), // Added purple
                              const Color(0xFF1E3A8A), // Added blue
                            ],
                            stops: [0.0, 0.2, 0.4, 0.6, 0.8, 0.9, 0.95, 1.0],
                          ),
                        ),
                        child: child,
                      );
                    },
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      transitionBuilder: (Widget child, Animation<double> animation) {
                        return FadeTransition(
                          opacity: animation,
                          child: SlideTransition(
                            position: Tween<Offset>(
                              begin: const Offset(0.1, 0),
                              end: Offset.zero,
                            ).animate(animation),
                            child: child,
                          ),
                        );
                      },
                      child: _getBody(_currentIndex, dataProvider),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildEmployeesTab(DataProvider dataProvider) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton.icon(
            onPressed: () => _showAddEmployeeDialog(context),
            icon: const Icon(Icons.add),
            label: const Text('Agregar Empleado'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blueAccent,
              foregroundColor: Colors.white,
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: dataProvider.employees.length,
            itemBuilder: (context, index) {
              final employee = dataProvider.employees[index];
              final disponibilidad = (employee['disponibilidad'] ?? 0) * 100;
              final productividad = (employee['productividad'] ?? 0) * 100;
              return Container(
                margin: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.blue.withOpacity(0.7), Colors.purple.withOpacity(0.7)],
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
                    leading: const Icon(Icons.person, color: Colors.white, size: 30),
                    title: Text(
                      employee['nombre'] ?? 'Sin nombre',
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        shadows: [Shadow(color: Colors.black, blurRadius: 2)],
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Cargo: ${employee['cargo'] ?? 'N/A'}',
                          style: const TextStyle(color: Colors.white70),
                        ),
                        Text(
                          'Email: ${employee['email'] ?? 'N/A'}',
                          style: const TextStyle(color: Colors.white70),
                        ),
                        Text(
                          'Teléfono: ${employee['telefono'] ?? 'N/A'}',
                          style: const TextStyle(color: Colors.white70),
                        ),
                        Row(
                          children: [
                            const Text('Disponibilidad: ', style: TextStyle(color: Colors.white70)),
                            Text(
                              '${disponibilidad.toInt()}%',
                              style: TextStyle(
                                color: disponibilidad > 75 ? Colors.greenAccent : disponibilidad > 50 ? Colors.yellowAccent : Colors.redAccent,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Text('Productividad: ', style: TextStyle(color: Colors.white70)),
                            Text(
                              '${productividad.toInt()}%',
                              style: TextStyle(
                                color: productividad > 80 ? Colors.greenAccent : productividad > 60 ? Colors.yellowAccent : Colors.redAccent,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.white),
                          onPressed: () => _showEditEmployeeDialog(context, employee),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.white),
                          onPressed: () => _showDeleteDialog(context, 'empleado', employee['id'] as int, () => dataProvider.deleteEmployee(employee['id'] as int)),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildSkillsTab(DataProvider dataProvider) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton.icon(
            onPressed: () => _showAddSkillDialog(context),
            icon: const Icon(Icons.add),
            label: const Text('Agregar Habilidad'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.greenAccent,
              foregroundColor: Colors.black,
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: dataProvider.skills.length,
            itemBuilder: (context, index) {
              final skill = dataProvider.skills[index];
              final nivel = skill['nivel'] ?? 'N/A';
              Color nivelColor;
              switch (nivel) {
                case 'BASICO':
                  nivelColor = Colors.redAccent;
                  break;
                case 'INTERMEDIO':
                  nivelColor = Colors.yellowAccent;
                  break;
                case 'AVANZADO':
                  nivelColor = Colors.greenAccent;
                  break;
                default:
                  nivelColor = Colors.grey;
              }
              return Container(
                margin: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.green.withOpacity(0.7), Colors.teal.withOpacity(0.7)],
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
                    leading: const Icon(Icons.code, color: Colors.white, size: 30),
                    title: Text(
                      skill['nombre'] ?? 'Sin nombre',
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        shadows: [Shadow(color: Colors.black, blurRadius: 2)],
                      ),
                    ),
                    subtitle: Row(
                      children: [
                        const Text('Nivel: ', style: TextStyle(color: Colors.white70)),
                        Text(
                          nivel,
                          style: TextStyle(
                            color: nivelColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.white),
                          onPressed: () => _showEditSkillDialog(context, skill),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.white),
                          onPressed: () => _showDeleteDialog(context, 'habilidad', skill['id'] as int, () => dataProvider.deleteSkill(skill['id'] as int)),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildTasksTab(DataProvider dataProvider) {
    // Show only active tasks
    final activeTasks = dataProvider.tasks.where((task) => task['status'] != 'completed').toList();

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton.icon(
            onPressed: () => _showAddTaskDialog(context),
            icon: const Icon(Icons.add),
            label: const Text('Agregar Tarea'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orangeAccent,
              foregroundColor: Colors.black,
            ),
          ),
        ),
        Expanded(
          child: ListView(
            children: [
              // Active Tasks Section
              if (activeTasks.isNotEmpty) ...[
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Text(
                    'Tareas Activas',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
                ...activeTasks.map((task) => Container(
                  margin: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Colors.orange, Colors.deepOrange],
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
                      leading: const Icon(Icons.task, color: Colors.white, size: 30),
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
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit, color: Colors.white),
                            onPressed: () => _showEditTaskDialog(context, task),
                          ),
                          IconButton(
                            icon: const Icon(Icons.auto_awesome, color: Colors.white),
                            onPressed: () => _generateAssignment(context, task['id'].toString()),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.white),
                            onPressed: () => _showDeleteDialog(context, 'tarea', task['id'] as int, () => dataProvider.deleteTask(task['id'] as int)),
                          ),
                        ],
                      ),
                    ),
                  ),
                )),
              ],
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAssignmentsTab(DataProvider dataProvider) {
    // Filter out completed assignments
    final activeAssignments = dataProvider.assignments.where((assignment) => assignment['estado'] != 'completed').toList();

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton.icon(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const CompletedTasksScreen()),
            ),
            icon: const Icon(Icons.check_circle),
            label: const Text('Ver Tareas Completadas'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.purpleAccent,
              foregroundColor: Colors.white,
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: activeAssignments.length,
            itemBuilder: (context, index) {
              final assignment = activeAssignments[index];
              return Container(
                margin: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Colors.purple, Colors.indigo],
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
                    leading: const Icon(Icons.assignment, color: Colors.white, size: 30),
                    title: Text(
                      'Tarea: ${assignment['task']?['nombre'] ?? 'N/A'}',
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        shadows: [Shadow(color: Colors.black, blurRadius: 2)],
                      ),
                    ),
                    subtitle: Text(
                      'Empleado: ${assignment['employee']?['nombre'] ?? 'N/A'}\nEstado: ${assignment['estado'] ?? 'N/A'}\nFecha: ${assignment['fechaAsignacion'] ?? 'N/A'}',
                      style: const TextStyle(color: Colors.white70),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (assignment['estado'] != 'completed')
                          IconButton(
                            icon: const Icon(Icons.check, color: Colors.white),
                            onPressed: () => _completeAssignment(context, assignment['id']),
                            tooltip: 'Marcar como completada',
                          ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.white),
                          onPressed: () => _showDeleteDialog(context, 'asignación', int.tryParse(assignment['id'].toString()) ?? 0, () => dataProvider.deleteAssignment(int.tryParse(assignment['id'].toString()) ?? 0)),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildDashboardTab(DataProvider dataProvider) {
    final totalEmployees = dataProvider.employees.length;
    final totalSkills = dataProvider.skills.length;
    final totalAssignments = dataProvider.assignments.length;
    final activeTasks = dataProvider.tasks.where((task) => task['status'] != 'completed').length;
    final completedTasks = dataProvider.tasks.where((task) => task['status'] == 'completed').length;
    final completionRate = dataProvider.tasks.isNotEmpty ? (completedTasks / dataProvider.tasks.length * 100).round() : 0;
    final averageProductivity = dataProvider.employees.isNotEmpty
        ? (dataProvider.employees.map((e) => (e['productividad'] ?? 0.0) as double).reduce((a, b) => a + b) / dataProvider.employees.length * 100).round()
        : 0;

    // Recent assignments: sort by fechaAsignacion descending, take first 5
    final recentAssignments = dataProvider.assignments
        .where((a) => a['fechaAsignacion'] != null)
        .toList()
      ..sort((a, b) => DateTime.parse(b['fechaAsignacion']).compareTo(DateTime.parse(a['fechaAsignacion'])));
    final recentAssignmentsList = recentAssignments.take(5).cast<Map<String, dynamic>>().toList();

    // Generate system summary chart
    final systemSummaryChart = BarChart(
      BarChartData(
        barGroups: [
          BarChartGroupData(
            x: 0,
            barRods: [
              BarChartRodData(
                toY: totalEmployees.toDouble(),
                color: Colors.blue,
                width: 20,
              ),
            ],
          ),
          BarChartGroupData(
            x: 1,
            barRods: [
              BarChartRodData(
                toY: activeTasks.toDouble(),
                color: Colors.orange,
                width: 20,
              ),
            ],
          ),
          BarChartGroupData(
            x: 2,
            barRods: [
              BarChartRodData(
                toY: completionRate.toDouble(),
                color: Colors.green,
                width: 20,
              ),
            ],
          ),
        ],
        titlesData: FlTitlesData(
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                switch (value.toInt()) {
                  case 0:
                    return const Text('Empleados', style: TextStyle(color: Colors.white));
                  case 1:
                    return const Text('Tareas Activas', style: TextStyle(color: Colors.white));
                  case 2:
                    return const Text('Tasa %', style: TextStyle(color: Colors.white));
                  default:
                    return const Text('');
                }
              },
            ),
          ),
          leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        ),
        borderData: FlBorderData(show: false),
        gridData: FlGridData(show: false),
      ),
    );

    // Generate productivity chart (mock data for now)
    final productivityChart = LineChart(
      LineChartData(
        lineBarsData: [
          LineChartBarData(
            spots: [
              const FlSpot(0, 5),
              const FlSpot(1, 7),
              const FlSpot(2, 6),
              const FlSpot(3, 8),
              const FlSpot(4, 9),
            ],
            isCurved: true,
            color: Colors.white,
            barWidth: 4,
            belowBarData: BarAreaData(show: false),
          ),
        ],
        titlesData: FlTitlesData(
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                switch (value.toInt()) {
                  case 0:
                    return const Text('Lun', style: TextStyle(color: Colors.white));
                  case 1:
                    return const Text('Mar', style: TextStyle(color: Colors.white));
                  case 2:
                    return const Text('Mié', style: TextStyle(color: Colors.white));
                  case 3:
                    return const Text('Jue', style: TextStyle(color: Colors.white));
                  case 4:
                    return const Text('Vie', style: TextStyle(color: Colors.white));
                  default:
                    return const Text('');
                }
              },
            ),
          ),
          leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        ),
        borderData: FlBorderData(show: false),
        gridData: FlGridData(show: false),
      ),
    );

    // Generate alerts
    final alerts = _generateAlerts(dataProvider);

    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Container(
          decoration: BoxDecoration(
            gradient: RadialGradient(
              center: Alignment.center,
              radius: 1.5,
              colors: [
                _gradientAnimation.value!,
                const Color(0xFF1A1A2E),
                const Color(0xFF16213E),
                const Color(0xFF0F0F23),
              ],
            ),
          ),
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: SlideTransition(
              position: _slideAnimation,
              child: ScaleTransition(
                scale: _scaleAnimation,
                child: child!,
              ),
            ),
          ),
        );
      },
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Dashboard',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            const SizedBox(height: 20),
            GridView.count(
              crossAxisCount: 1,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              children: [
                _buildDashboardCard(
                  'Resumen del Sistema',
                  'Sistema inteligente de asignación de personal que optimiza la productividad y reduce tiempos muertos.',
                  [
                    _buildStat('$totalEmployees', 'Empleados'),
                    _buildStat('$totalSkills', 'Habilidades'),
                    _buildStat('$totalAssignments', 'Asignaciones'),
                    _buildStat('$activeTasks', 'Tareas Activas'),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Tasa de Finalización', style: TextStyle(color: Colors.white70)),
                        SizedBox(
                          width: 50,
                          height: 50,
                          child: CircularProgressIndicator(
                            value: completionRate / 100,
                            backgroundColor: Colors.white24,
                            valueColor: const AlwaysStoppedAnimation<Color>(Colors.greenAccent),
                          ),
                        ),
                      ],
                    ),
                  ],
                  chart: systemSummaryChart,
                  gradient: const LinearGradient(colors: [Colors.blue, Colors.purple]),
                ),
                _buildDashboardCard(
                  'Asignaciones Recientes',
                  'Vista rápida de las asignaciones más recientes.',
                  [],
                  recentAssignments: recentAssignmentsList,
                  buttonText: 'Asignación Automática',
                  onButtonPressed: () => _autoAssignTasks(context),
                  gradient: const LinearGradient(colors: [Colors.purple, Colors.indigo]),
                ),
                _buildDashboardCard(
                  'Métricas de Productividad',
                  'Indicadores clave de rendimiento del sistema.',
                  [
                    _buildStat('$averageProductivity%', 'Productividad Promedio'),
                    _buildStat('7', 'Días promedio'),
                    _buildStat('15%', 'Reducción tiempos muertos'),
                  ],
                  chart: productivityChart,
                  buttonText: 'Ver Reportes Detallados',
                  onButtonPressed: () => setState(() => _currentIndex = 4), // Navigate to assignments tab
                  gradient: const LinearGradient(colors: [Colors.green, Colors.teal]),
                ),
                _buildDashboardCard(
                  'Alertas del Sistema',
                  'Notificaciones importantes del sistema.',
                  [],
                  alerts: alerts,
                  gradient: const LinearGradient(colors: [Colors.red, Colors.orange]),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: _buildModuleCard(
                    'Gestión de Empleados',
                    'Agregar y gestionar empleados del sistema.',
                    'Agregar Empleado',
                    () => _showAddEmployeeDialog(context),
                    previewItems: dataProvider.employees.take(3).map((e) => e['nombre'] as String).toList(),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildModuleCard(
                    'Gestión de Tareas',
                    'Crear y administrar tareas del proyecto.',
                    'Agregar Tarea',
                    () => _showAddTaskDialog(context),
                    previewItems: dataProvider.tasks.take(3).map((t) => t['nombre'] as String).toList(),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDashboardCard(String title, String description, List<Widget> stats, {String? buttonText, VoidCallback? onButtonPressed, Widget? chart, List<Widget>? alerts, List<Map<String, dynamic>>? recentAssignments, required LinearGradient gradient}) {
    return Container(
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Card(
        color: Colors.transparent,
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(_getIconForTitle(title), color: Colors.white),
                    const SizedBox(width: 8),
                    Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                  ],
                ),
                const SizedBox(height: 8),
                Text(description, style: const TextStyle(color: Colors.white70)),
                if (chart != null) ...[
                  const SizedBox(height: 16),
                  SizedBox(height: 150, child: chart),
                ],
                if (stats.isNotEmpty) ...[
                  const SizedBox(height: 16),
                  ...stats,
                ],
                if (recentAssignments != null && recentAssignments.isNotEmpty) ...[
                  const SizedBox(height: 16),
                  const Text('Asignaciones Recientes:', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  ...recentAssignments.map((assignment) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Text(
                      '${assignment['employee']?['nombre'] ?? 'N/A'} - ${assignment['task']?['nombre'] ?? 'N/A'}',
                      style: const TextStyle(color: Colors.white70),
                    ),
                  )),
                ],
                if (alerts != null && alerts.isNotEmpty) ...[
                  const SizedBox(height: 16),
                  ...alerts,
                ],
                if (buttonText != null && onButtonPressed != null) ...[
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    onPressed: onButtonPressed,
                    icon: Icon(_getButtonIcon(buttonText), color: Colors.white),
                    label: Text(buttonText, style: const TextStyle(color: Colors.white)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white24,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStat(String value, String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Expanded(
            child: Text(label, style: const TextStyle(color: Colors.white70)),
          ),
          Text(value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
        ],
      ),
    );
  }

  Widget _buildModuleCard(String title, String description, String buttonText, VoidCallback onPressed, {List<String>? previewItems}) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue.withOpacity(0.7), Colors.purple.withOpacity(0.7)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Card(
        color: Colors.transparent,
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
              const SizedBox(height: 8),
              Text(description, style: const TextStyle(color: Colors.white70)),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: onPressed,
                icon: const Icon(Icons.add),
                label: Text(buttonText),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  foregroundColor: Colors.white,
                ),
              ),
              if (previewItems != null && previewItems.isNotEmpty) ...[
                const SizedBox(height: 16),
                const Text('Vista Previa:', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white)),
                const SizedBox(height: 8),
                Column(
                  children: previewItems.map((item) => Container(
                    margin: const EdgeInsets.symmetric(vertical: 2),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.cyan.withOpacity(0.3), Colors.teal.withOpacity(0.3)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Card(
                      color: Colors.transparent,
                      elevation: 0,
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Text(item, style: const TextStyle(fontSize: 12, color: Colors.white, fontWeight: FontWeight.bold)),
                      ),
                    ),
                  )).toList(),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  IconData _getIconForTitle(String title) {
    switch (title) {
      case 'Resumen del Sistema':
        return Icons.dashboard;
      case 'Asignaciones Recientes':
        return Icons.assignment;
      case 'Métricas de Productividad':
        return Icons.trending_up;
      case 'Alertas del Sistema':
        return Icons.notifications;
      default:
        return Icons.info;
    }
  }

  IconData _getButtonIcon(String buttonText) {
    switch (buttonText) {
      case 'Asignación Automática':
        return Icons.smart_toy;
      case 'Ver Reportes Detallados':
        return Icons.bar_chart;
      default:
        return Icons.add;
    }
  }

  void _autoAssignTasks(BuildContext context) async {
    final dataProvider = context.read<DataProvider>();

    // Find unassigned tasks
    final unassignedTasks = dataProvider.tasks.where((task) =>
      !dataProvider.assignments.any((assignment) => assignment['task']['id'] == task['id'])
    ).toList();

    if (unassignedTasks.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No hay tareas sin asignar')),
      );
      return;
    }

    int assignedCount = 0;
    for (final task in unassignedTasks) {
      final requiredSkill = task['requiredSkill'];
      if (requiredSkill == null || requiredSkill.isEmpty) continue;

      // Find employees with the required skill
      final eligibleEmployees = dataProvider.employees.where((employee) {
        // Assuming employees have a 'skills' list or similar; for now, check if any skill matches
        // Since backend might not have employee-skills relation, assume skills are global and match by name
        return dataProvider.skills.any((skill) => skill['nombre'] == requiredSkill && employee['cargo'] != null); // Placeholder: adjust based on backend
      }).toList();

      if (eligibleEmployees.isEmpty) continue;

      // Select employee with highest disponibilidad
      eligibleEmployees.sort((a, b) => (b['disponibilidad'] ?? 0).compareTo(a['disponibilidad'] ?? 0));
      final selectedEmployee = eligibleEmployees.first;

      // Create assignment
      final assignment = {
        'taskId': int.parse(task['id'].toString()),
        'employeeId': int.parse(selectedEmployee['id'].toString()),
        'estado': 'pending',
        'fechaAsignacion': DateTime.now().toIso8601String(),
      };

      final success = await dataProvider.createAssignment(assignment);
      if (success) {
        assignedCount++;
      }
    }

    // Reload data to update alerts
    await dataProvider.loadAllData();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('$assignedCount tareas asignadas automáticamente')),
    );
  }

  List<Widget> _generateAlerts(DataProvider dataProvider) {
    final alerts = <Widget>[];

    // Check for unassigned high priority tasks
    final unassignedHighPriorityTasks = dataProvider.tasks.where((task) =>
      task['priority'] == 'CRITICA' || task['priority'] == 'ALTA' &&
      !dataProvider.assignments.any((assignment) => assignment['task']['id'] == task['id'])
    ).length;

    if (unassignedHighPriorityTasks > 0) {
      alerts.add(
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.redAccent.shade400,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              const Icon(Icons.warning, color: Colors.white),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  '$unassignedHighPriorityTasks tareas de alta prioridad sin asignar',
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      );
    }

    // Check for employees with low availability
    final lowAvailabilityEmployees = dataProvider.employees.where((employee) =>
      (employee['disponibilidad'] ?? 0) < 0.5
    ).length;

    if (lowAvailabilityEmployees > 0) {
      alerts.add(
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.orangeAccent.shade400,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              const Icon(Icons.info, color: Colors.white),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  '$lowAvailabilityEmployees empleados con baja disponibilidad',
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      );
    }

    // Check for overassigned employees (more than 3 active tasks)
    final overassignedEmployees = dataProvider.employees.where((employee) {
      final activeAssignments = dataProvider.assignments.where((assignment) =>
        assignment['employee']['id'] == employee['id'] && assignment['estado'] != 'completed'
      ).length;
      return activeAssignments > 3;
    }).length;

    if (overassignedEmployees > 0) {
      alerts.add(
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.purpleAccent.shade400,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              const Icon(Icons.warning, color: Colors.white),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  '$overassignedEmployees empleados con sobrecarga de tareas (más de 3 activas)',
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      );
    }

    // Check for tasks nearing deadline (mock check)
    final tasksNearingDeadline = dataProvider.tasks.where((task) =>
      task['estimatedHours'] != null && task['estimatedHours'] < 5
    ).length;

    if (tasksNearingDeadline > 0) {
      alerts.add(
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.yellowAccent.shade400,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              const Icon(Icons.schedule, color: Colors.white),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  '$tasksNearingDeadline tareas próximas a vencer',
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return alerts;
  }

  void _showAddEmployeeDialog(BuildContext context) {
    final nombreController = TextEditingController();
    final emailController = TextEditingController();
    final telefonoController = TextEditingController();
    String selectedCargo = cargos.first;
    String selectedDisponibilidad = '100%';
    String selectedProductividad = 'Media';

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1A1A2E),
        title: Row(
          children: [
            const Icon(Icons.person_add, color: Colors.blueAccent),
            const SizedBox(width: 8),
            Text(
              'Agregar Empleado',
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        content: Container(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF1A1A2E), Color(0xFF16213E)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nombreController,
                decoration: const InputDecoration(
                  labelText: 'Nombre',
                  labelStyle: TextStyle(color: Colors.white70),
                  enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white70)),
                  focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.blueAccent)),
                ),
                style: const TextStyle(color: Colors.white),
              ),
              TextField(
                controller: emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  labelStyle: TextStyle(color: Colors.white70),
                  enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white70)),
                  focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.blueAccent)),
                ),
                style: const TextStyle(color: Colors.white),
              ),
              TextField(
                controller: telefonoController,
                decoration: const InputDecoration(
                  labelText: 'Teléfono',
                  labelStyle: TextStyle(color: Colors.white70),
                  enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white70)),
                  focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.blueAccent)),
                ),
                style: const TextStyle(color: Colors.white),
              ),
              DropdownButtonFormField<String>(
                dropdownColor: const Color(0xFF1A1A2E),
                initialValue: selectedCargo,
                items: cargos.map((cargo) => DropdownMenuItem(value: cargo, child: Text(cargo, style: const TextStyle(color: Colors.white)))).toList(),
                onChanged: (value) => selectedCargo = value!,
                decoration: const InputDecoration(
                  labelText: 'Cargo',
                  labelStyle: TextStyle(color: Colors.white70),
                  enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white70)),
                  focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.blueAccent)),
                ),
                style: const TextStyle(color: Colors.white),
              ),
              DropdownButtonFormField<String>(
                dropdownColor: const Color(0xFF1A1A2E),
                initialValue: selectedDisponibilidad,
                items: disponibilidades.map((disp) => DropdownMenuItem(value: disp, child: Text(disp, style: const TextStyle(color: Colors.white)))).toList(),
                onChanged: (value) => selectedDisponibilidad = value!,
                decoration: const InputDecoration(
                  labelText: 'Disponibilidad',
                  labelStyle: TextStyle(color: Colors.white70),
                  enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white70)),
                  focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.blueAccent)),
                ),
                style: const TextStyle(color: Colors.white),
              ),
              DropdownButtonFormField<String>(
                dropdownColor: const Color(0xFF1A1A2E),
                initialValue: selectedProductividad,
                items: productividades.map((prod) => DropdownMenuItem(value: prod, child: Text(prod, style: const TextStyle(color: Colors.white)))).toList(),
                onChanged: (value) => selectedProductividad = value!,
                decoration: const InputDecoration(
                  labelText: 'Productividad',
                  labelStyle: TextStyle(color: Colors.white70),
                  enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white70)),
                  focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.blueAccent)),
                ),
                style: const TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar', style: TextStyle(color: Colors.white70)),
          ),
          ElevatedButton(
            onPressed: () async {
              final disponibilidad = double.parse(selectedDisponibilidad.replaceAll('%', '')) / 100;
              final productividad = selectedProductividad == 'Baja' ? 0.5 : selectedProductividad == 'Media' ? 0.8 : 1.0;
              final employee = {
                'nombre': nombreController.text,
                'email': emailController.text,
                'telefono': telefonoController.text,
                'cargo': selectedCargo,
                'disponibilidad': disponibilidad,
                'productividad': productividad,
              };
              await context.read<DataProvider>().createEmployee(employee);
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blueAccent,
              foregroundColor: Colors.white,
            ),
            child: const Text('Agregar'),
          ),
        ],
      ),
    );
  }

  void _showEditEmployeeDialog(BuildContext context, Map<String, dynamic> employee) {
    final nombreController = TextEditingController(text: employee['nombre']);
    final emailController = TextEditingController(text: employee['email']);
    final telefonoController = TextEditingController(text: employee['telefono']);
    String selectedCargo = employee['cargo'] ?? cargos.first;
    String selectedDisponibilidad = '${((employee['disponibilidad'] ?? 1.0) * 100).toInt()}%';
    String selectedProductividad = (employee['productividad'] ?? 0.8) == 0.5 ? 'Baja' : (employee['productividad'] ?? 0.8) == 0.8 ? 'Media' : 'Alta';

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1A1A2E),
        title: Row(
          children: [
            const Icon(Icons.edit, color: Colors.blueAccent),
            const SizedBox(width: 8),
            Text(
              'Editar Empleado',
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        content: Container(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF1A1A2E), Color(0xFF16213E)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nombreController,
                decoration: const InputDecoration(
                  labelText: 'Nombre',
                  labelStyle: TextStyle(color: Colors.white70),
                  enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white70)),
                  focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.blueAccent)),
                ),
                style: const TextStyle(color: Colors.white),
              ),
              TextField(
                controller: emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  labelStyle: TextStyle(color: Colors.white70),
                  enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white70)),
                  focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.blueAccent)),
                ),
                style: const TextStyle(color: Colors.white),
              ),
              TextField(
                controller: telefonoController,
                decoration: const InputDecoration(
                  labelText: 'Teléfono',
                  labelStyle: TextStyle(color: Colors.white70),
                  enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white70)),
                  focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.blueAccent)),
                ),
                style: const TextStyle(color: Colors.white),
              ),
              DropdownButtonFormField<String>(
                dropdownColor: const Color(0xFF1A1A2E),
                initialValue: selectedCargo,
                items: cargos.map((cargo) => DropdownMenuItem(value: cargo, child: Text(cargo, style: const TextStyle(color: Colors.white)))).toList(),
                onChanged: (value) => selectedCargo = value!,
                decoration: const InputDecoration(
                  labelText: 'Cargo',
                  labelStyle: TextStyle(color: Colors.white70),
                  enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white70)),
                  focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.blueAccent)),
                ),
                style: const TextStyle(color: Colors.white),
              ),
              DropdownButtonFormField<String>(
                dropdownColor: const Color(0xFF1A1A2E),
                initialValue: selectedDisponibilidad,
                items: disponibilidades.map((disp) => DropdownMenuItem(value: disp, child: Text(disp, style: const TextStyle(color: Colors.white)))).toList(),
                onChanged: (value) => selectedDisponibilidad = value!,
                decoration: const InputDecoration(
                  labelText: 'Disponibilidad',
                  labelStyle: TextStyle(color: Colors.white70),
                  enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white70)),
                  focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.blueAccent)),
                ),
                style: const TextStyle(color: Colors.white),
              ),
              DropdownButtonFormField<String>(
                dropdownColor: const Color(0xFF1A1A2E),
                initialValue: selectedProductividad,
                items: productividades.map((prod) => DropdownMenuItem(value: prod, child: Text(prod, style: const TextStyle(color: Colors.white)))).toList(),
                onChanged: (value) => selectedProductividad = value!,
                decoration: const InputDecoration(
                  labelText: 'Productividad',
                  labelStyle: TextStyle(color: Colors.white70),
                  enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white70)),
                  focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.blueAccent)),
                ),
                style: const TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar', style: TextStyle(color: Colors.white70)),
          ),
          ElevatedButton(
            onPressed: () async {
              final disponibilidad = double.parse(selectedDisponibilidad.replaceAll('%', '')) / 100;
              final productividad = selectedProductividad == 'Baja' ? 0.5 : selectedProductividad == 'Media' ? 0.8 : 1.0;
              final updatedEmployee = {
                'nombre': nombreController.text,
                'email': emailController.text,
                'telefono': telefonoController.text,
                'cargo': selectedCargo,
                'disponibilidad': disponibilidad,
                'productividad': productividad,
              };
              final employeeId = int.tryParse(employee['id'].toString()) ?? 0;
              await context.read<DataProvider>().updateEmployee(employeeId, updatedEmployee);
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blueAccent,
              foregroundColor: Colors.white,
            ),
            child: const Text('Actualizar'),
          ),
        ],
      ),
    );
  }

  void _showAddSkillDialog(BuildContext context) {
    String selectedNombre = habilidades.first;
    String selectedLevel = 'BASICO';

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1A1A2E),
        title: Row(
          children: [
            const Icon(Icons.add, color: Colors.greenAccent),
            const SizedBox(width: 8),
            Text(
              'Agregar Habilidad',
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        content: Container(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF1A1A2E), Color(0xFF16213E)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButtonFormField<String>(
                dropdownColor: const Color(0xFF1A1A2E),
                initialValue: selectedNombre,
                items: habilidades.map((hab) => DropdownMenuItem(value: hab, child: Text(hab, style: const TextStyle(color: Colors.white)))).toList(),
                onChanged: (value) => selectedNombre = value!,
                decoration: const InputDecoration(
                  labelText: 'Nombre de la Habilidad',
                  labelStyle: TextStyle(color: Colors.white70),
                  enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white70)),
                  focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.greenAccent)),
                ),
                style: const TextStyle(color: Colors.white),
              ),
              DropdownButtonFormField<String>(
                dropdownColor: const Color(0xFF1A1A2E),
                initialValue: selectedLevel,
                items: ['BASICO', 'INTERMEDIO', 'AVANZADO'].map((level) => DropdownMenuItem(value: level, child: Text(level, style: const TextStyle(color: Colors.white)))).toList(),
                onChanged: (value) => selectedLevel = value!,
                decoration: const InputDecoration(
                  labelText: 'Nivel',
                  labelStyle: TextStyle(color: Colors.white70),
                  enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white70)),
                  focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.greenAccent)),
                ),
                style: const TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar', style: TextStyle(color: Colors.white70)),
          ),
          ElevatedButton(
            onPressed: () async {
              final skill = {
                'nombre': selectedNombre,
                'nivel': selectedLevel,
              };
              await context.read<DataProvider>().createSkill(skill);
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.greenAccent,
              foregroundColor: Colors.black,
            ),
            child: const Text('Agregar'),
          ),
        ],
      ),
    );
  }

  void _showEditSkillDialog(BuildContext context, Map<String, dynamic> skill) {
    String selectedNombre = skill['nombre'] ?? habilidades.first;
    String selectedLevel = skill['nivel'] ?? 'BASICO';

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Editar Habilidad'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DropdownButtonFormField<String>(
              initialValue: selectedNombre,
              items: habilidades.map((hab) => DropdownMenuItem(value: hab, child: Text(hab))).toList(),
              onChanged: (value) => selectedNombre = value!,
              decoration: const InputDecoration(labelText: 'Nombre de la Habilidad'),
            ),
            DropdownButtonFormField<String>(
              initialValue: selectedLevel,
              items: ['BASICO', 'INTERMEDIO', 'AVANZADO'].map((level) => DropdownMenuItem(value: level, child: Text(level))).toList(),
              onChanged: (value) => selectedLevel = value!,
              decoration: const InputDecoration(labelText: 'Nivel'),
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancelar')),
          TextButton(
            onPressed: () async {
              final updatedSkill = {
                'nombre': selectedNombre,
                'nivel': selectedLevel,
              };
              final skillId = int.tryParse(skill['id'].toString()) ?? 0;
              await context.read<DataProvider>().updateSkill(skillId, updatedSkill);
              Navigator.pop(context);
            },
            child: const Text('Actualizar'),
          ),
        ],
      ),
    );
  }

  void _showAddTaskDialog(BuildContext context) {
    String selectedNombre = tareas.first;
    final descripcionController = TextEditingController(text: descripciones[selectedNombre]);
    String? selectedRequiredSkill;
    String selectedPriority = 'MEDIA';
    final estimatedHoursController = TextEditingController(text: '8.0');
    DateTime? selectedFechaInicio;
    DateTime? selectedFechaFinalizacion;

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          backgroundColor: const Color(0xFF1A1A2E),
          title: Row(
            children: [
              const Icon(Icons.add_task, color: Colors.orangeAccent),
              const SizedBox(width: 8),
              Text(
                'Agregar Tarea',
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          content: Container(
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF1A1A2E), Color(0xFF16213E)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                DropdownButtonFormField<String>(
                  dropdownColor: const Color(0xFF1A1A2E),
                  initialValue: selectedNombre,
                  items: tareas.map((tarea) => DropdownMenuItem<String>(value: tarea, child: Text(tarea, style: const TextStyle(color: Colors.white)))).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedNombre = value!;
                      descripcionController.text = descripciones[selectedNombre] ?? '';
                    });
                  },
                  decoration: const InputDecoration(
                    labelText: 'Nombre',
                    labelStyle: TextStyle(color: Colors.white70),
                    enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white70)),
                    focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.orangeAccent)),
                  ),
                  style: const TextStyle(color: Colors.white),
                ),
                TextField(
                  controller: descripcionController,
                  decoration: const InputDecoration(
                    labelText: 'Descripción',
                    labelStyle: TextStyle(color: Colors.white70),
                    enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white70)),
                    focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.orangeAccent)),
                  ),
                  style: const TextStyle(color: Colors.white),
                  readOnly: true,
                ),
                DropdownButtonFormField<String>(
                  dropdownColor: const Color(0xFF1A1A2E),
                  initialValue: selectedRequiredSkill,
                  items: context.read<DataProvider>().skills.map((skill) => DropdownMenuItem<String>(value: skill['nombre'] as String, child: Text(skill['nombre'] as String, style: const TextStyle(color: Colors.white)))).toList(),
                  onChanged: (value) => setState(() => selectedRequiredSkill = value),
                  decoration: const InputDecoration(
                    labelText: 'Habilidad Requerida',
                    labelStyle: TextStyle(color: Colors.white70),
                    enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white70)),
                    focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.orangeAccent)),
                  ),
                  style: const TextStyle(color: Colors.white),
                ),
                DropdownButtonFormField<String>(
                  dropdownColor: const Color(0xFF1A1A2E),
                  initialValue: selectedPriority,
                  items: ['BAJA', 'MEDIA', 'ALTA', 'CRITICA'].map((priority) => DropdownMenuItem<String>(value: priority, child: Text(priority, style: const TextStyle(color: Colors.white)))).toList(),
                  onChanged: (value) => setState(() => selectedPriority = value!),
                  decoration: const InputDecoration(
                    labelText: 'Prioridad',
                    labelStyle: TextStyle(color: Colors.white70),
                    enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white70)),
                    focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.orangeAccent)),
                  ),
                  style: const TextStyle(color: Colors.white),
                ),
                TextField(
                  controller: estimatedHoursController,
                  decoration: const InputDecoration(
                    labelText: 'Horas Estimadas',
                    labelStyle: TextStyle(color: Colors.white70),
                    enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white70)),
                    focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.orangeAccent)),
                  ),
                  style: const TextStyle(color: Colors.white),
                ),
                TextField(
                  readOnly: true,
                  decoration: InputDecoration(
                    labelText: 'Fecha Inicio',
                    labelStyle: const TextStyle(color: Colors.white70),
                    hintText: selectedFechaInicio != null ? DateFormat('dd/MM/yyyy').format(selectedFechaInicio!) : 'Seleccionar fecha',
                    hintStyle: const TextStyle(color: Colors.white54),
                    enabledBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.white70)),
                    focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.orangeAccent)),
                  ),
                  style: const TextStyle(color: Colors.white),
                  onTap: () async {
                    final picked = await showDatePicker(
                      context: context,
                      initialDate: selectedFechaInicio ?? DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2101),
                    );
                    if (picked != null) {
                      setState(() => selectedFechaInicio = picked);
                    }
                  },
                ),
                TextField(
                  readOnly: true,
                  decoration: InputDecoration(
                    labelText: 'Fecha Finalización',
                    labelStyle: const TextStyle(color: Colors.white70),
                    hintText: selectedFechaFinalizacion != null ? DateFormat('dd/MM/yyyy').format(selectedFechaFinalizacion!) : 'Seleccionar fecha',
                    hintStyle: const TextStyle(color: Colors.white54),
                    enabledBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.white70)),
                    focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.orangeAccent)),
                  ),
                  style: const TextStyle(color: Colors.white),
                  onTap: () async {
                    final picked = await showDatePicker(
                      context: context,
                      initialDate: selectedFechaFinalizacion ?? DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2101),
                    );
                    if (picked != null) {
                      setState(() => selectedFechaFinalizacion = picked);
                    }
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancelar', style: TextStyle(color: Colors.white70)),
            ),
            ElevatedButton(
              onPressed: () async {
                final task = {
                  'nombre': selectedNombre,
                  'descripcion': descripcionController.text,
                  'requiredSkill': selectedRequiredSkill,
                  'priority': selectedPriority,
                  'estimatedHours': int.tryParse(estimatedHoursController.text) ?? 8,
                  'fechaInicio': selectedFechaInicio?.toIso8601String(),
                  'fechaFinalizacion': selectedFechaFinalizacion?.toIso8601String(),
                  'status': 'pending',
                };
                await context.read<DataProvider>().createTask(task);
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orangeAccent,
                foregroundColor: Colors.black,
              ),
              child: const Text('Agregar'),
            ),
          ],
        ),
      ),
    );
  }

  void _showEditTaskDialog(BuildContext context, Map<String, dynamic> task) {
    String selectedNombre = task['nombre'] ?? tareas.first;
    final descripcionController = TextEditingController(text: task['descripcion']);
    String? selectedRequiredSkill = task['requiredSkill'];
    String selectedPriority = task['priority'] ?? 'MEDIA';
    final estimatedHoursController = TextEditingController(text: task['estimatedHours']?.toString() ?? '8.0');
    DateTime? selectedFechaInicio = task['fechaInicio'] != null ? DateTime.parse(task['fechaInicio']) : null;
    DateTime? selectedFechaFinalizacion = task['fechaFinalizacion'] != null ? DateTime.parse(task['fechaFinalizacion']) : null;

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: const Text('Editar Tarea'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButtonFormField<String>(
                initialValue: selectedNombre,
                items: tareas.map((tarea) => DropdownMenuItem<String>(value: tarea, child: Text(tarea))).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedNombre = value!;
                    descripcionController.text = descripciones[selectedNombre] ?? '';
                  });
                },
                decoration: const InputDecoration(labelText: 'Nombre'),
              ),
              TextField(
                controller: descripcionController,
                decoration: const InputDecoration(labelText: 'Descripción'),
                readOnly: true,
              ),
              DropdownButtonFormField<String>(
                initialValue: selectedRequiredSkill,
                items: context.read<DataProvider>().skills.map((skill) => DropdownMenuItem<String>(value: skill['nombre'] as String, child: Text(skill['nombre'] as String))).toList(),
                onChanged: (value) => setState(() => selectedRequiredSkill = value),
                decoration: const InputDecoration(labelText: 'Habilidad Requerida'),
              ),
              DropdownButtonFormField<String>(
                initialValue: selectedPriority,
                items: ['BAJA', 'MEDIA', 'ALTA', 'CRITICA'].map((priority) => DropdownMenuItem<String>(value: priority, child: Text(priority))).toList(),
                onChanged: (value) => setState(() => selectedPriority = value!),
                decoration: const InputDecoration(labelText: 'Prioridad'),
              ),
              TextField(controller: estimatedHoursController, decoration: const InputDecoration(labelText: 'Horas Estimadas')),
              TextField(
                readOnly: true,
                decoration: InputDecoration(
                  labelText: 'Fecha Inicio',
                  hintText: selectedFechaInicio != null ? DateFormat('dd/MM/yyyy').format(selectedFechaInicio!) : 'Seleccionar fecha',
                ),
                onTap: () async {
                  final picked = await showDatePicker(
                    context: context,
                    initialDate: selectedFechaInicio ?? DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2101),
                  );
                  if (picked != null) {
                    setState(() => selectedFechaInicio = picked);
                  }
                },
              ),
              TextField(
                readOnly: true,
                decoration: InputDecoration(
                  labelText: 'Fecha Finalización',
                  hintText: selectedFechaFinalizacion != null ? DateFormat('dd/MM/yyyy').format(selectedFechaFinalizacion!) : 'Seleccionar fecha',
                ),
                onTap: () async {
                  final picked = await showDatePicker(
                    context: context,
                    initialDate: selectedFechaFinalizacion ?? DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2101),
                  );
                  if (picked != null) {
                    setState(() => selectedFechaFinalizacion = picked);
                  }
                },
              ),
            ],
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancelar')),
            TextButton(
              onPressed: () async {
                final updatedTask = {
                  'nombre': selectedNombre,
                  'descripcion': descripcionController.text,
                  'requiredSkill': selectedRequiredSkill,
                  'priority': selectedPriority,
                  'estimatedHours': int.tryParse(estimatedHoursController.text) ?? 8,
                  'fechaInicio': selectedFechaInicio?.toIso8601String(),
                  'fechaFinalizacion': selectedFechaFinalizacion?.toIso8601String(),
                  'status': task['status'] ?? 'pending',
                };
                final taskId = int.tryParse(task['id'].toString()) ?? 0;
                await context.read<DataProvider>().updateTask(taskId, updatedTask);
                Navigator.pop(context);
              },
              child: const Text('Actualizar'),
            ),
          ],
        ),
      ),
    );
  }

  void _generateAssignment(BuildContext context, String taskId) async {
    final dataProvider = context.read<DataProvider>();
    final matchingTasks = dataProvider.tasks.where((t) => t['id'].toString() == taskId);
    if (matchingTasks.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Tarea no encontrada')),
      );
      return;
    }
    final task = matchingTasks.first;
    final taskName = task['nombre'];
    final suitableCargos = taskCargoMapping[taskName] ?? [];

    if (suitableCargos.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('La tarea no tiene cargos adecuados definidos')),
      );
      return;
    }

    var eligibleEmployees = dataProvider.employees.where((employee) {
      return suitableCargos.contains(employee['cargo']);
    }).toList();

    // Filter out overassigned employees
    eligibleEmployees = eligibleEmployees.where((employee) {
      final activeAssignments = dataProvider.assignments.where((assignment) =>
        assignment['employee']['id'] == employee['id'] && assignment['estado'] != 'completed'
      ).length;
      return activeAssignments <= 3;
    }).toList();

    if (eligibleEmployees.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No hay empleados elegibles para esta tarea')),
      );
      return;
    }

    eligibleEmployees.sort((a, b) => (b['disponibilidad'] ?? 0).compareTo(a['disponibilidad'] ?? 0));
    final selectedEmployee = eligibleEmployees.first;

    final assignment = {
      'taskId': int.parse(taskId),
      'employeeId': int.parse(selectedEmployee['id'].toString()),
      'estado': 'pending',
      'fechaAsignacion': DateTime.now().toIso8601String(),
    };

    final success = await dataProvider.createAssignment(assignment);
    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Asignación generada exitosamente')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error al generar la asignación')),
      );
    }
  }

  void _completeAssignment(BuildContext context, int assignmentId) async {
    final dataProvider = context.read<DataProvider>();
    final success = await dataProvider.updateAssignment(assignmentId, {'estado': 'completed'});
    if (mounted) {
      try {
        if (success) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Asignación completada')),
          );
          // Reload data to update UI
          await dataProvider.loadAllData();
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Error al completar la asignación')),
          );
        }
      } catch (e) {
        // Ignore if context is invalid
      }
    }
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
