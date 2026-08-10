import '../entities/patient_identity.dart';

abstract class AuthRepository {
  Future<PatientIdentity?> getCurrentSession();

  Future<void> requestLoginOtp({
    required String identifier,
    required String password,
  });

  Future<PatientIdentity> verifyLoginOtp({
    required String identifier,
    required String otp,
  });

  Future<void> register({
    required String fullName,
    required String email,
    required String phoneNumber,
    required String password,
  });

  Future<void> verifyNewUserOtp({required String email, required String otp});

  Future<PatientIdentity> setPassword({
    required String email,
    required String password,
  });

  Future<void> requestPasswordResetOtp({required String identifier});

  Future<void> resetPassword({
    required String identifier,
    required String otp,
    required String password,
  });

  Future<void> requestMedicalRecordClaim({
    required String email,
    required String password,
    required String noRm,
    required String nik,
    required String birthDate,
  });

  Future<PatientIdentity> confirmMedicalRecordClaim({
    required String email,
    required String otp,
  });

  Future<void> signOut();
}
