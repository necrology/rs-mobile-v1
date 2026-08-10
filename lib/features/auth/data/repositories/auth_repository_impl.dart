import '../../domain/entities/patient_identity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_datasource.dart';
import '../datasources/auth_secure_storage.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl({
    required AuthRemoteDatasource remoteDatasource,
    required AuthSecureStorage secureStorage,
  }) : _remoteDatasource = remoteDatasource,
       _secureStorage = secureStorage;

  final AuthRemoteDatasource _remoteDatasource;
  final AuthSecureStorage _secureStorage;
  PatientIdentity? _cachedIdentity;

  @override
  Future<PatientIdentity?> getCurrentSession() async {
    _cachedIdentity ??= await _secureStorage.readIdentity();
    return _cachedIdentity;
  }

  @override
  Future<void> register({
    required String fullName,
    required String email,
    required String phoneNumber,
    required String password,
  }) {
    return _remoteDatasource.register(
      fullName: fullName,
      email: email,
      phoneNumber: phoneNumber,
      password: password,
    );
  }

  @override
  Future<void> requestLoginOtp({
    required String identifier,
    required String password,
  }) {
    return _remoteDatasource.requestLoginOtp(
      identifier: identifier,
      password: password,
    );
  }

  @override
  Future<PatientIdentity> verifyLoginOtp({
    required String identifier,
    required String otp,
  }) async {
    _cachedIdentity = await _remoteDatasource.verifyLoginOtp(
      identifier: identifier,
      otp: otp,
    );
    await _secureStorage.saveIdentity(_cachedIdentity!);

    return _cachedIdentity!;
  }

  @override
  Future<void> verifyNewUserOtp({required String email, required String otp}) {
    return _remoteDatasource.verifyNewUserOtp(email: email, otp: otp);
  }

  @override
  Future<PatientIdentity> setPassword({
    required String email,
    required String password,
  }) async {
    _cachedIdentity = await _remoteDatasource.setPassword(
      email: email,
      password: password,
    );
    await _secureStorage.saveIdentity(_cachedIdentity!);

    return _cachedIdentity!;
  }

  @override
  Future<void> requestPasswordResetOtp({required String identifier}) {
    return _remoteDatasource.requestPasswordResetOtp(identifier: identifier);
  }

  @override
  Future<void> resetPassword({
    required String identifier,
    required String otp,
    required String password,
  }) {
    return _remoteDatasource.resetPassword(
      identifier: identifier,
      otp: otp,
      password: password,
    );
  }

  @override
  Future<void> requestMedicalRecordClaim({
    required String email,
    required String password,
    required String noRm,
    required String nik,
    required String birthDate,
  }) {
    return _remoteDatasource.requestMedicalRecordClaim(
      email: email,
      password: password,
      noRm: noRm,
      nik: nik,
      birthDate: birthDate,
    );
  }

  @override
  Future<PatientIdentity> confirmMedicalRecordClaim({
    required String email,
    required String otp,
  }) async {
    _cachedIdentity = await _remoteDatasource.confirmMedicalRecordClaim(
      email: email,
      otp: otp,
    );
    await _secureStorage.saveIdentity(_cachedIdentity!);

    return _cachedIdentity!;
  }

  @override
  Future<void> signOut() async {
    _cachedIdentity = null;
    await _secureStorage.clearIdentity();
  }
}
