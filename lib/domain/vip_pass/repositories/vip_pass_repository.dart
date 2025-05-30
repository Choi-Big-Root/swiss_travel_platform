/// VIP 패스 관련 repository interface
abstract class VipPassRepository {
  /// VIP 패스 목록 조회
  Future<List<Map<String, dynamic>>> getVipPasses();

  /// VIP 패스 예약
  Future<Map<String, dynamic>> bookVipPass(Map<String, dynamic> bookingData);
} 