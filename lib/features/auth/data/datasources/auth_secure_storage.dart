import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../domain/entities/patient_identity.dart';

class AuthSecureStorage {
  AuthSecureStorage({
    FlutterSecureStorage secureStorage = const FlutterSecureStorage(),
  }) : _secureStorage = secureStorage;

  static const String _identityKey = 'auth_identity';

  final FlutterSecureStorage _secureStorage;

  Future<PatientIdentity?> readIdentity() async {
    final String? rawIdentity;
    try {
      rawIdentity = await _secureStorage.read(key: _identityKey);
    } on MissingPluginException {
      return null;
    }

    if (rawIdentity == null || rawIdentity.isEmpty) {
      return null;
    }

    try {
      final Object? decoded = jsonDecode(rawIdentity);
      if (decoded is! Map<String, dynamic>) {
        return null;
      }

      return PatientIdentity.fromJson(decoded);
    } catch (_) {
      await clearIdentity();
      return null;
    }
  }

  Future<void> saveIdentity(PatientIdentity identity) async {
    try {
      await _secureStorage.write(
        key: _identityKey,
        value: jsonEncode(identity.toJson()),
      );
    } on MissingPluginException {
      return;
    }
  }

  Future<void> clearIdentity() async {
    try {
      await _secureStorage.delete(key: _identityKey);
    } on MissingPluginException {
      return;
    }
  }
}
