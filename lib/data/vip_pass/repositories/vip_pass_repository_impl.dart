import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:swiss_travel_platform/domain/vip_pass/repositories/vip_pass_repository.dart';

class VipPassRepositoryImpl implements VipPassRepository {
  final String baseUrl = 'http://localhost:5000/api';  // Flask 서버 주소

  @override
  Future<List<Map<String, dynamic>>> getVipPasses() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/vip-passes'));
      
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.cast<Map<String, dynamic>>();
      } else {
        throw Exception('Failed to load VIP passes');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  @override
  Future<Map<String, dynamic>> bookVipPass(Map<String, dynamic> bookingData) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/vip-passes/book'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(bookingData),
      );
      
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to book VIP pass');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
} 