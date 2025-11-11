import 'package:flutter/material.dart';
import '../services/api_service.dart';

class DataProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();

  List<dynamic> _employees = [];
  List<dynamic> _skills = [];
  List<dynamic> _tasks = [];
  List<dynamic> _assignments = [];

  bool _isLoading = false;
  String? _error;

  // Getters
  List<dynamic> get employees => _employees;
  List<dynamic> get skills => _skills;
  List<dynamic> get tasks => _tasks;
  List<dynamic> get assignments => _assignments;
  bool get isLoading => _isLoading;
  String? get error => _error;

  // EMPLEADOS
  Future<void> loadEmployees() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final data = await _apiService.getEmployees();
      if (data != null) {
        _employees = data;
      } else {
        _error = 'Error al cargar empleados';
      }
    } catch (e) {
      _error = 'Error: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> createEmployee(Map<String, dynamic> employee) async {
    try {
      final result = await _apiService.createEmployee(employee);
      if (result != null) {
        await loadEmployees(); // Recargar lista
        return true;
      }
      return false;
    } catch (e) {
      _error = 'Error al crear empleado: $e';
      notifyListeners();
      return false;
    }
  }

  Future<bool> updateEmployee(int id, Map<String, dynamic> employee) async {
    try {
      final result = await _apiService.updateEmployee(id, employee);
      if (result != null) {
        await loadEmployees(); // Recargar lista
        return true;
      }
      return false;
    } catch (e) {
      _error = 'Error al actualizar empleado: $e';
      notifyListeners();
      return false;
    }
  }

  Future<bool> deleteEmployee(int id) async {
    try {
      final success = await _apiService.deleteEmployee(id);
      if (success) {
        await loadEmployees(); // Recargar lista
      }
      return success;
    } catch (e) {
      _error = 'Error al eliminar empleado: $e';
      notifyListeners();
      return false;
    }
  }

  // SKILLS
  Future<void> loadSkills() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final data = await _apiService.getSkills();
      if (data != null) {
        _skills = data;
      } else {
        _error = 'Error al cargar skills';
      }
    } catch (e) {
      _error = 'Error: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> createSkill(Map<String, dynamic> skill) async {
    try {
      final result = await _apiService.createSkill(skill);
      if (result != null) {
        await loadSkills(); // Recargar lista
        return true;
      }
      return false;
    } catch (e) {
      _error = 'Error al crear skill: $e';
      notifyListeners();
      return false;
    }
  }

  Future<bool> updateSkill(int id, Map<String, dynamic> skill) async {
    try {
      final result = await _apiService.updateSkill(id, skill);
      if (result != null) {
        await loadSkills(); // Recargar lista
        return true;
      }
      return false;
    } catch (e) {
      _error = 'Error al actualizar skill: $e';
      notifyListeners();
      return false;
    }
  }

  Future<bool> deleteSkill(int id) async {
    try {
      final success = await _apiService.deleteSkill(id);
      if (success) {
        await loadSkills(); // Recargar lista
      }
      return success;
    } catch (e) {
      _error = 'Error al eliminar skill: $e';
      notifyListeners();
      return false;
    }
  }

  // TASKS
  Future<void> loadTasks() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final data = await _apiService.getTasks();
      if (data != null) {
        _tasks = data;
      } else {
        _error = 'Error al cargar tasks';
      }
    } catch (e) {
      _error = 'Error: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> createTask(Map<String, dynamic> task) async {
    try {
      final result = await _apiService.createTask(task);
      if (result != null) {
        await loadTasks(); // Recargar lista
        return true;
      }
      return false;
    } catch (e) {
      _error = 'Error al crear task: $e';
      notifyListeners();
      return false;
    }
  }

  Future<bool> updateTask(int id, Map<String, dynamic> task) async {
    try {
      final result = await _apiService.updateTask(id, task);
      if (result != null) {
        await loadTasks(); // Recargar lista
        return true;
      }
      return false;
    } catch (e) {
      _error = 'Error al actualizar task: $e';
      notifyListeners();
      return false;
    }
  }

  Future<bool> deleteTask(int id) async {
    try {
      final success = await _apiService.deleteTask(id);
      if (success) {
        await loadTasks(); // Recargar lista
      }
      return success;
    } catch (e) {
      _error = 'Error al eliminar task: $e';
      notifyListeners();
      return false;
    }
  }

  // ASSIGNMENTS
  Future<void> loadAssignments() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final data = await _apiService.getAssignments();
      if (data != null) {
        _assignments = data;
      } else {
        _error = 'Error al cargar assignments';
      }
    } catch (e) {
      _error = 'Error: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> createAssignment(Map<String, dynamic> assignment) async {
    try {
      final result = await _apiService.createAssignment(assignment);
      if (result != null) {
        await loadAssignments(); // Recargar lista
        return true;
      }
      return false;
    } catch (e) {
      _error = 'Error al crear assignment: $e';
      notifyListeners();
      return false;
    }
  }

  Future<bool> updateAssignment(int id, Map<String, dynamic> assignment) async {
    try {
      final result = await _apiService.updateAssignment(id, assignment);
      if (result != null) {
        await loadAssignments(); // Recargar lista
        await loadTasks(); // Recargar tareas para reflejar cambios en status
        return true;
      }
      return false;
    } catch (e) {
      _error = 'Error al actualizar assignment: $e';
      notifyListeners();
      return false;
    }
  }

  Future<bool> deleteAssignment(int id) async {
    try {
      final success = await _apiService.deleteAssignment(id);
      if (success) {
        await loadAssignments(); // Recargar lista
      }
      return success;
    } catch (e) {
      _error = 'Error al eliminar assignment: $e';
      notifyListeners();
      return false;
    }
  }

  // Método para generar asignación automática
  Future<bool> generateAssignment(int taskId) async {
    try {
      final result = await _apiService.generateAssignment(taskId);
      if (result != null) {
        await loadAssignments(); // Recargar lista
        return true;
      }
      return false;
    } catch (e) {
      _error = 'Error al generar assignment: $e';
      notifyListeners();
      return false;
    }
  }

  // Método para limpiar error
  void clearError() {
    _error = null;
    notifyListeners();
  }

  // Método para cargar todos los datos
  Future<void> loadAllData() async {
    print('DataProvider: Starting to load all data');
    await Future.wait([
      loadEmployees(),
      loadSkills(),
      loadTasks(),
      loadAssignments(),
    ]);
    print('DataProvider: Finished loading all data');
  }
}
