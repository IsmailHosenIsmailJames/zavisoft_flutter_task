import '../../../core/network/api_client.dart';
import '../domain/models/user.dart';

class AuthRepository {
  final ApiClient apiClient;

  AuthRepository({required this.apiClient});

  /// Authenticate user, returns JWT token string.
  Future<String> login(String username, String password) async {
    try {
      final response = await apiClient.dio.post(
        '/auth/login',
        data: {'username': username, 'password': password},
      );
      return response.data['token'] as String;
    } catch (e) {
      throw Exception('Login failed: $e');
    }
  }

  /// Fetch all users from the API.
  Future<List<User>> getUsers() async {
    try {
      final response = await apiClient.dio.get('/users');
      final List<dynamic> data = response.data;
      return data.map((json) => User.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Failed to load users: $e');
    }
  }

  /// Fetch a single user by ID.
  Future<User> getUserById(int id) async {
    try {
      final response = await apiClient.dio.get('/users/$id');
      return User.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to load user: $e');
    }
  }
}
