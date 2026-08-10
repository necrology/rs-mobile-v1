import '../../../../core/network/api_client.dart';
import '../../domain/entities/api_collection.dart';
import '../../domain/entities/employee_record.dart';
import '../../domain/entities/patient_lab_result_record.dart';
import '../../domain/entities/patient_medical_summary_record.dart';
import '../../domain/entities/patient_prescription_record.dart';
import '../../domain/entities/patient_radiology_result_record.dart';
import '../../domain/entities/patient_record.dart';
import '../../domain/entities/patient_visit_record.dart';
import '../../domain/entities/resource_record.dart';
import '../../domain/entities/table_metadata.dart';
import '../../../booking/domain/entities/booking_queue_response.dart';
import '../../../booking/domain/entities/booking_calendar.dart';
import '../../../booking/domain/entities/booking_options.dart';
import '../../../booking/domain/entities/queue_records.dart';

class RsApiRemoteDatasource {
  const RsApiRemoteDatasource({required ApiClient apiClient})
    : _apiClient = apiClient;

  final ApiClient _apiClient;

  Future<ApiCollection<PatientRecord>> searchPatients({
    required String query,
    int? limit,
    List<String>? columns,
    List<String>? searchColumns,
    bool withTotal = false,
  }) async {
    final dynamic response = await _apiClient.get(
      '/pasiens',
      queryParameters: <String, Object?>{
        'q': query,
        'limit': limit,
        'columns': columns?.join(','),
        'search_columns': searchColumns?.join(','),
        'with_total': withTotal ? 'true' : null,
      },
    );

    return ApiCollection<PatientRecord>.fromResponse(
      response,
      PatientRecord.fromJson,
    );
  }

  Future<PatientRecord> fetchPatientById(String id) async {
    final dynamic response = await _apiClient.get('/pasiens/$id');
    return PatientRecord.fromJson(ApiResponseReader.findMap(response));
  }

  Future<PatientRecord> fetchLinkedPatientProfile({
    required String email,
    required String noRm,
  }) async {
    final dynamic response = await _apiClient.get(
      '/mobile/patient/profile',
      queryParameters: <String, Object?>{'email': email, 'no_rm': noRm},
    );

    return PatientRecord.fromJson(ApiResponseReader.findMap(response));
  }

  Future<ApiCollection<PatientVisitRecord>> fetchPatientVisits({
    required String email,
    required String noRm,
    int? limit,
  }) async {
    final dynamic response = await _apiClient.get(
      '/mobile/patient/visits',
      queryParameters: <String, Object?>{
        'email': email,
        'no_rm': noRm,
        'limit': limit,
      },
    );

    return ApiCollection<PatientVisitRecord>.fromResponse(
      response,
      PatientVisitRecord.fromJson,
    );
  }

  Future<ApiCollection<PatientMedicalSummaryRecord>>
  fetchPatientMedicalSummaries({
    required String email,
    required String noRm,
    int? limit,
  }) async {
    final dynamic response = await _apiClient.get(
      '/mobile/patient/medical-summaries',
      queryParameters: <String, Object?>{
        'email': email,
        'no_rm': noRm,
        'limit': limit,
      },
    );

    return ApiCollection<PatientMedicalSummaryRecord>.fromResponse(
      response,
      PatientMedicalSummaryRecord.fromJson,
    );
  }

  Future<ApiCollection<PatientLabResultRecord>> fetchPatientLabResults({
    required String email,
    required String noRm,
    int? limit,
  }) async {
    final dynamic response = await _apiClient.get(
      '/mobile/patient/laboratory-results',
      queryParameters: <String, Object?>{
        'email': email,
        'no_rm': noRm,
        'limit': limit,
      },
    );

    return ApiCollection<PatientLabResultRecord>.fromResponse(
      response,
      PatientLabResultRecord.fromJson,
    );
  }

  Future<ApiCollection<PatientRadiologyResultRecord>>
  fetchPatientRadiologyResults({
    required String email,
    required String noRm,
    int? limit,
  }) async {
    final dynamic response = await _apiClient.get(
      '/mobile/patient/radiology-results',
      queryParameters: <String, Object?>{
        'email': email,
        'no_rm': noRm,
        'limit': limit,
      },
    );

    return ApiCollection<PatientRadiologyResultRecord>.fromResponse(
      response,
      PatientRadiologyResultRecord.fromJson,
    );
  }

  Future<ApiCollection<PatientPrescriptionRecord>> fetchPatientPrescriptions({
    required String email,
    required String noRm,
    int? limit,
  }) async {
    final dynamic response = await _apiClient.get(
      '/mobile/patient/prescriptions',
      queryParameters: <String, Object?>{
        'email': email,
        'no_rm': noRm,
        'limit': limit,
      },
    );

    return ApiCollection<PatientPrescriptionRecord>.fromResponse(
      response,
      PatientPrescriptionRecord.fromJson,
    );
  }

  Future<ApiCollection<EmployeeRecord>> searchEmployees({
    required String search,
    int? limit,
    List<String>? columns,
    List<String>? searchColumns,
  }) async {
    final dynamic response = await _apiClient.get(
      '/pegawais',
      queryParameters: <String, Object?>{
        'search': search,
        'limit': limit,
        'columns': columns?.join(','),
        'search_columns': searchColumns?.join(','),
      },
    );

    return ApiCollection<EmployeeRecord>.fromResponse(
      response,
      EmployeeRecord.fromJson,
    );
  }

  Future<ApiCollection<ResourceRecord>> searchDoctorSchedules({
    required String search,
    int? limit,
    List<String>? columns,
  }) async {
    final dynamic response = await _apiClient.get(
      '/jadwaldokters',
      queryParameters: <String, Object?>{
        'q': search,
        'limit': limit,
        'columns': columns?.join(','),
        'search_columns': 'dokter,poli,hari',
        'with_total': 'true',
      },
    );

    return ApiCollection<ResourceRecord>.fromResponse(
      response,
      ResourceRecord.fromJson,
    );
  }

  Future<ApiCollection<ResourceRecord>> searchPolyclinics({
    required String search,
    int? limit,
    List<String>? columns,
  }) async {
    final dynamic response = await _apiClient.get(
      '/polis',
      queryParameters: <String, Object?>{
        'q': search,
        'limit': limit,
        'columns': columns?.join(','),
        'search_columns': 'nama,kode_ruangan,kelas,kelompok',
        'with_total': 'true',
      },
    );

    return ApiCollection<ResourceRecord>.fromResponse(
      response,
      ResourceRecord.fromJson,
    );
  }

  Future<ApiCollection<ResourceRecord>> searchRooms({
    required String search,
    int? limit,
    List<String>? columns,
  }) async {
    final dynamic response = await _apiClient.get(
      '/mobile/hospital/room-availabilities',
      queryParameters: <String, Object?>{'q': search, 'limit': limit},
    );

    return ApiCollection<ResourceRecord>.fromResponse(
      response,
      ResourceRecord.fromJson,
    );
  }

  Future<BookingQueueResponse> createGeneralBooking({
    required String identifier,
    required int poliId,
    required String tanggal,
    required String bayar,
    required String jenisPasien,
    required String doctorId,
    required String queueGroup,
    required bool isJkn,
    String? email,
    String? noRm,
  }) async {
    final dynamic response = await _apiClient.post(
      '/mobile/booking/general',
      body: <String, Object?>{
        'identifier': identifier,
        'email': email,
        'no_rm': noRm,
        'poli_id': poliId,
        'tanggal': tanggal,
        'bayar': bayar,
        'jenis_pasien': jenisPasien,
        'dokter_id': doctorId,
        'queue_group': queueGroup,
        'is_jkn': isJkn,
      },
    );

    return BookingQueueResponse.fromJson(
      ApiResponseReader.findMap(response)['data'] is Map<String, dynamic>
          ? ApiResponseReader.findMap(response)['data'] as Map<String, dynamic>
          : ApiResponseReader.findMap(response),
    );
  }

  Future<BookingOptionsResponse> fetchBookingOptions({
    required int poliId,
  }) async {
    final dynamic response = await _apiClient.get(
      '/mobile/booking/options/$poliId',
    );

    return BookingOptionsResponse.fromJson(ApiResponseReader.findMap(response));
  }

  Future<BookingCalendarResponse> fetchBookingCalendar({
    required int year,
    required int month,
    int? poliId,
  }) async {
    final dynamic response = await _apiClient.get(
      '/mobile/booking/calendar',
      queryParameters: <String, Object?>{
        'year': year,
        'month': month,
        'poli_id': poliId != null && poliId > 0 ? poliId : null,
      },
    );

    return BookingCalendarResponse.fromJson(
      ApiResponseReader.findMap(response),
    );
  }

  Future<ApiCollection<ResourceRecord>> searchRoomAvailabilities({
    required String search,
    int? limit,
    List<String>? columns,
  }) async {
    final dynamic response = await _apiClient.get(
      '/setting_ketersediaan_kamar',
      queryParameters: <String, Object?>{
        'q': search,
        'limit': limit,
        'columns': columns?.join(','),
        'search_columns': 'keterangan',
        'with_total': 'true',
      },
    );

    return ApiCollection<ResourceRecord>.fromResponse(
      response,
      ResourceRecord.fromJson,
    );
  }

  Future<ApiCollection<QueueRegistrationRecord>> fetchQueueRegistrations({
    int limit = 50,
  }) async {
    final dynamic response = await _apiClient.get(
      '/registrasis_dummy/search',
      queryParameters: <String, Object?>{
        'limit': limit,
        'with_total': 'true',
        'search_columns':
            'kodebooking,nomorkartu,no_rm,nama,tglperiksa,kode_poli,kode_dokter,request,jenisrequest',
      },
    );

    final ApiCollection<QueueRegistrationRecord> queueRegistrations =
        ApiCollection<QueueRegistrationRecord>.fromResponse(
          response,
          QueueRegistrationRecord.fromJson,
        );

    final List<QueueRegistrationRecord> filteredItems = queueRegistrations.items
        .where((QueueRegistrationRecord item) => item.isJkn)
        .toList();

    return ApiCollection<QueueRegistrationRecord>(
      items: filteredItems,
      total: filteredItems.length,
      raw: queueRegistrations.raw,
    );
  }

  Future<ApiCollection<LocalQueueRecord>> fetchLocalQueues({
    int limit = 50,
  }) async {
    final dynamic response = await _apiClient.get(
      '/antrians/search',
      queryParameters: <String, Object?>{'limit': limit, 'with_total': 'true'},
    );

    return ApiCollection<LocalQueueRecord>.fromResponse(
      response,
      LocalQueueRecord.fromJson,
    );
  }

  Future<ApiCollection<GeneralBookingRecord>> fetchGeneralBookings({
    String status = '',
    String tanggal = '',
    int limit = 80,
  }) async {
    final dynamic response = await _apiClient.get(
      '/mobile/booking/general',
      queryParameters: <String, Object?>{
        'status': status,
        'tanggal': tanggal,
        'limit': limit,
      },
    );

    return ApiCollection<GeneralBookingRecord>.fromResponse(
      response,
      GeneralBookingRecord.fromJson,
    );
  }

  Future<ApiCollection<GeneralBookingRecord>> fetchMyGeneralBookings({
    required String email,
    required String noRm,
    String tanggal = '',
    int limit = 30,
    bool allDates = false,
  }) async {
    final dynamic response = await _apiClient.get(
      '/mobile/booking/general/mine',
      queryParameters: <String, Object?>{
        'email': email,
        'no_rm': noRm,
        'tanggal': tanggal,
        'all_dates': allDates ? '1' : null,
        'limit': limit,
      },
    );

    return ApiCollection<GeneralBookingRecord>.fromResponse(
      response,
      GeneralBookingRecord.fromJson,
    );
  }

  Future<TableMetadata> fetchTableMetadata(String tableName) async {
    final dynamic response = await _apiClient.get('/tables/$tableName');

    return TableMetadata.fromResponse(tableName: tableName, response: response);
  }
}
