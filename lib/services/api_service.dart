import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  static String baseUrl = 'https://skillsync-backend-production-e390.up.railway.app';

  // Método para obtener la URL base desde SharedPreferences
  static Future<String> getBaseUrl() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('api_base_url') ?? baseUrl;
  }

  // Método para establecer la URL base
  static Future<void> setBaseUrl(String url) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('api_base_url', url);
    baseUrl = url;
  }

  // EMPLEADOS
  Future<List<dynamic>?> getEmployees() async {
    try {
      final url = await getBaseUrl();
      print('ApiService: Getting base URL: $url');
      final fullUrl = '$url/api/employees';
      print('ApiService: Calling $fullUrl');
      final response = await http.get(
        Uri.parse(fullUrl),
        headers: {'Content-Type': 'application/json'},
      );
      print('ApiService: Response status: ${response.statusCode}');
      if (response.statusCode == 200) {
        print('ApiService: Successfully got employees data');
        return jsonDecode(response.body);
      } else {
        print('ApiService: Failed to get employees, status: ${response.statusCode}, body: ${response.body}');
      }
    } catch (e) {
      print('ApiService: Error getting employees: $e');
    }
    return null;
  }

  Future<Map<String, dynamic>?> createEmployee(Map<String, dynamic> employee) async {
    try {
      final url = await getBaseUrl();
      final response = await http.post(
        Uri.parse('$url/api/employees'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(employee),
      );
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }
    } catch (e) {
      print('Error creating employee: $e');
    }
    return null;
  }

  Future<Map<String, dynamic>?> updateEmployee(int id, Map<String, dynamic> employee) async {
    try {
      final url = await getBaseUrl();
      final response = await http.put(
        Uri.parse('$url/api/employees/$id'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(employee),
      );
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }
    } catch (e) {
      print('Error updating employee: $e');
    }
    return null;
  }

  Future<bool> deleteEmployee(int id) async {
    try {
      final url = await getBaseUrl();
      final response = await http.delete(Uri.parse('$url/api/employees/$id'));
      return response.statusCode == 204;
    } catch (e) {
      print('Error deleting employee: $e');
      return false;
    }
  }

  // SKILLS
  Future<List<dynamic>?> getSkills() async {
    try {
      final url = await getBaseUrl();
      final response = await http.get(
        Uri.parse('$url/api/skills'),
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }
    } catch (e) {
      print('Error getting skills: $e');
    }
    return null;
  }

  Future<Map<String, dynamic>?> createSkill(Map<String, dynamic> skill) async {
    try {
      final url = await getBaseUrl();
      final response = await http.post(
        Uri.parse('$url/api/skills'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(skill),
      );
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }
    } catch (e) {
      print('Error creating skill: $e');
    }
    return null;
  }

  Future<Map<String, dynamic>?> updateSkill(int id, Map<String, dynamic> skill) async {
    try {
      final url = await getBaseUrl();
      final response = await http.put(
        Uri.parse('$url/api/skills/$id'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(skill),
      );
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }
    } catch (e) {
      print('Error updating skill: $e');
    }
    return null;
  }

  Future<bool> deleteSkill(int id) async {
    try {
      final url = await getBaseUrl();
      final response = await http.delete(Uri.parse('$url/api/skills/$id'));
      return response.statusCode == 204;
    } catch (e) {
      print('Error deleting skill: $e');
      return false;
    }
  }

  // TASKS
  Future<List<dynamic>?> getTasks() async {
    try {
      final url = await getBaseUrl();
      final response = await http.get(
        Uri.parse('$url/api/tasks'),
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }
    } catch (e) {
      print('Error getting tasks: $e');
    }
    return null;
  }

  Future<Map<String, dynamic>?> createTask(Map<String, dynamic> task) async {
    try {
      final url = await getBaseUrl();
      final response = await http.post(
        Uri.parse('$url/api/tasks'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(task),
      );
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }
    } catch (e) {
      print('Error creating task: $e');
    }
    return null;
  }

  Future<Map<String, dynamic>?> updateTask(int id, Map<String, dynamic> task) async {
    try {
      final url = await getBaseUrl();
      final response = await http.put(
        Uri.parse('$url/api/tasks/$id'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(task),
      );
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }
    } catch (e) {
      print('Error updating task: $e');
    }
    return null;
  }

  Future<bool> deleteTask(int id) async {
    try {
      final url = await getBaseUrl();
      final response = await http.delete(Uri.parse('$url/api/tasks/$id'));
      return response.statusCode == 204;
    } catch (e) {
      print('Error deleting task: $e');
      return false;
    }
  }

  // ASSIGNMENTS
  Future<List<dynamic>?> getAssignments() async {
    try {
      final url = await getBaseUrl();
      final response = await http.get(
        Uri.parse('$url/api/assignments'),
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }
    } catch (e) {
      print('Error getting assignments: $e');
    }
    return null;
  }

  Future<Map<String, dynamic>?> createAssignment(Map<String, dynamic> assignment) async {
    try {
      final url = await getBaseUrl();
      final response = await http.post(
        Uri.parse('$url/api/assignments'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(assignment),
      );
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }
    } catch (e) {
      print('Error creating assignment: $e');
    }
    return null;
  }

  Future<Map<String, dynamic>?> updateAssignment(int id, Map<String, dynamic> assignment) async {
    try {
      final url = await getBaseUrl();
      final response = await http.put(
        Uri.parse('$url/api/assignments/$id'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(assignment),
      );
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }
    } catch (e) {
      print('Error updating assignment: $e');
    }
    return null;
  }

  Future<bool> deleteAssignment(int id) async {
    try {
      final url = await getBaseUrl();
      final response = await http.delete(Uri.parse('$url/api/assignments/$id'));
      return response.statusCode == 204;
    } catch (e) {
      print('Error deleting assignment: $e');
      return false;
    }
  }

  // Método para generar asignación automática
  Future<Map<String, dynamic>?> generateAssignment(int taskId) async {
    try {
      final url = await getBaseUrl();
      final response = await http.post(
        Uri.parse('$url/api/assignments/generate/$taskId'),
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }
    } catch (e) {
      print('Error generating assignment: $e');
    }
    return null;
  }
}
