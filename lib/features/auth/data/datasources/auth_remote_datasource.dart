import '../../../../core/network/api_client.dart';
import '../../domain/entities/patient_identity.dart';

class AuthRemoteDatasource {
  const AuthRemoteDatasource({required ApiClient apiClient})
    : _apiClient = apiClient;

  final ApiClient _apiClient;

  Future<void> register({
    required String fullName,
    required String email,
    required String phoneNumber,
    required String password,
  }) async {
    await _apiClient.post(
      '/auth/register',
      body: <String, Object?>{
        'Username': fullName,
        'FullName': fullName,
        'Email': email,
        'Phone': phoneNumber,
        'Password': password,
      },
    );
  }

  Future<void> verifyNewUserOtp({
    required String email,
    required String otp,
  }) async {
    await _apiClient.post(
      '/auth/verify-otp-new-user',
      body: <String, Object?>{'Email': email, 'OTP': otp},
    );
  }

  Future<PatientIdentity> setPassword({
    required String email,
    required String password,
  }) async {
    final dynamic response = await _apiClient.post(
      '/auth/set-password',
      body: <String, Object?>{'Email': email, 'Password': password},
    );

    return _identityFromResponse(response);
  }

  Future<void> requestLoginOtp({
    required String identifier,
    required String password,
  }) async {
    await _apiClient.post(
      '/auth/login',
      body: <String, Object?>{
        'Identifier': identifier,
        'Username': identifier,
        'Password': password,
      },
    );
  }

  Future<PatientIdentity> verifyLoginOtp({
    required String identifier,
    required String otp,
  }) async {
    final dynamic response = await _apiClient.post(
      '/auth/verify-otp',
      body: <String, Object?>{'Username': identifier, 'OTP': otp},
    );

    return _identityFromResponse(response);
  }

  Future<void> requestPasswordResetOtp({required String identifier}) async {
    await _apiClient.post(
      '/auth/forgot-password',
      body: <String, Object?>{'Identifier': identifier},
    );
  }

  Future<void> resetPassword({
    required String identifier,
    required String otp,
    required String password,
  }) async {
    await _apiClient.post(
      '/auth/reset-password',
      body: <String, Object?>{
        'Identifier': identifier,
        'OTP': otp,
        'Password': password,
      },
    );
  }

  Future<void> requestMedicalRecordClaim({
    required String email,
    required String password,
    required String noRm,
    required String nik,
    required String birthDate,
  }) async {
    await _apiClient.post(
      '/auth/medical-record/request',
      body: <String, Object?>{
        'Email': email,
        'Password': password,
        'NoRM': noRm,
        'NIK': nik,
        'BirthDate': birthDate,
      },
    );
  }

  Future<PatientIdentity> confirmMedicalRecordClaim({
    required String email,
    required String otp,
  }) async {
    final dynamic response = await _apiClient.post(
      '/auth/medical-record/confirm',
      body: <String, Object?>{'Email': email, 'OTP': otp},
    );

    return _identityFromResponse(response);
  }

  PatientIdentity _identityFromResponse(dynamic response) {
    if (response is Map<String, dynamic>) {
      final dynamic data = response['data'];
      if (data is Map<String, dynamic>) {
        return PatientIdentity.fromJson(data);
      }
    }

    return const PatientIdentity(
      id: '',
      patientId: '',
      fullName: '',
      email: '',
      phoneNumber: '',
      medicalRecordNumber: '',
      familyMembers: <String>[],
    );
  }
}
