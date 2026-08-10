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
import '../../domain/repositories/rs_api_repository.dart';
import '../datasources/rs_api_remote_datasource.dart';

class RsApiRepositoryImpl implements RsApiRepository {
  const RsApiRepositoryImpl({required RsApiRemoteDatasource remoteDatasource})
    : _remoteDatasource = remoteDatasource;

  final RsApiRemoteDatasource _remoteDatasource;

  @override
  Future<PatientRecord> fetchPatientById(String id) {
    return _remoteDatasource.fetchPatientById(id);
  }

  @override
  Future<PatientRecord> fetchLinkedPatientProfile({
    required String email,
    required String noRm,
  }) {
    return _remoteDatasource.fetchLinkedPatientProfile(
      email: email,
      noRm: noRm,
    );
  }

  @override
  Future<ApiCollection<PatientVisitRecord>> fetchPatientVisits({
    required String email,
    required String noRm,
    int? limit,
  }) {
    return _remoteDatasource.fetchPatientVisits(
      email: email,
      noRm: noRm,
      limit: limit,
    );
  }

  @override
  Future<ApiCollection<PatientMedicalSummaryRecord>>
  fetchPatientMedicalSummaries({
    required String email,
    required String noRm,
    int? limit,
  }) {
    return _remoteDatasource.fetchPatientMedicalSummaries(
      email: email,
      noRm: noRm,
      limit: limit,
    );
  }

  @override
  Future<ApiCollection<PatientLabResultRecord>> fetchPatientLabResults({
    required String email,
    required String noRm,
    int? limit,
  }) {
    return _remoteDatasource.fetchPatientLabResults(
      email: email,
      noRm: noRm,
      limit: limit,
    );
  }

  @override
  Future<ApiCollection<PatientRadiologyResultRecord>>
  fetchPatientRadiologyResults({
    required String email,
    required String noRm,
    int? limit,
  }) {
    return _remoteDatasource.fetchPatientRadiologyResults(
      email: email,
      noRm: noRm,
      limit: limit,
    );
  }

  @override
  Future<ApiCollection<PatientPrescriptionRecord>> fetchPatientPrescriptions({
    required String email,
    required String noRm,
    int? limit,
  }) {
    return _remoteDatasource.fetchPatientPrescriptions(
      email: email,
      noRm: noRm,
      limit: limit,
    );
  }

  @override
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
  }) {
    return _remoteDatasource.createGeneralBooking(
      identifier: identifier,
      poliId: poliId,
      tanggal: tanggal,
      bayar: bayar,
      jenisPasien: jenisPasien,
      doctorId: doctorId,
      queueGroup: queueGroup,
      isJkn: isJkn,
      email: email,
      noRm: noRm,
    );
  }

  @override
  Future<BookingOptionsResponse> fetchBookingOptions({required int poliId}) {
    return _remoteDatasource.fetchBookingOptions(poliId: poliId);
  }

  @override
  Future<BookingCalendarResponse> fetchBookingCalendar({
    required int year,
    required int month,
    int? poliId,
  }) {
    return _remoteDatasource.fetchBookingCalendar(
      year: year,
      month: month,
      poliId: poliId,
    );
  }

  @override
  Future<TableMetadata> fetchTableMetadata(String tableName) {
    return _remoteDatasource.fetchTableMetadata(tableName);
  }

  @override
  Future<ApiCollection<EmployeeRecord>> searchEmployees({
    required String search,
    int? limit,
    List<String>? columns,
    List<String>? searchColumns,
  }) {
    return _remoteDatasource.searchEmployees(
      search: search,
      limit: limit,
      columns: columns,
      searchColumns: searchColumns,
    );
  }

  @override
  Future<ApiCollection<ResourceRecord>> searchDoctorSchedules({
    required String search,
    int? limit,
    List<String>? columns,
  }) {
    return _remoteDatasource.searchDoctorSchedules(
      search: search,
      limit: limit,
      columns: columns,
    );
  }

  @override
  Future<ApiCollection<ResourceRecord>> searchPolyclinics({
    required String search,
    int? limit,
    List<String>? columns,
  }) {
    return _remoteDatasource.searchPolyclinics(
      search: search,
      limit: limit,
      columns: columns,
    );
  }

  @override
  Future<ApiCollection<ResourceRecord>> searchRooms({
    required String search,
    int? limit,
    List<String>? columns,
  }) {
    return _remoteDatasource.searchRooms(
      search: search,
      limit: limit,
      columns: columns,
    );
  }

  @override
  Future<ApiCollection<ResourceRecord>> searchRoomAvailabilities({
    required String search,
    int? limit,
    List<String>? columns,
  }) {
    return _remoteDatasource.searchRoomAvailabilities(
      search: search,
      limit: limit,
      columns: columns,
    );
  }

  @override
  Future<ApiCollection<QueueRegistrationRecord>> fetchQueueRegistrations({
    int limit = 50,
  }) {
    return _remoteDatasource.fetchQueueRegistrations(limit: limit);
  }

  @override
  Future<ApiCollection<LocalQueueRecord>> fetchLocalQueues({int limit = 50}) {
    return _remoteDatasource.fetchLocalQueues(limit: limit);
  }

  @override
  Future<ApiCollection<GeneralBookingRecord>> fetchGeneralBookings({
    String status = '',
    String tanggal = '',
    int limit = 80,
  }) {
    return _remoteDatasource.fetchGeneralBookings(
      status: status,
      tanggal: tanggal,
      limit: limit,
    );
  }

  @override
  Future<ApiCollection<GeneralBookingRecord>> fetchMyGeneralBookings({
    required String email,
    required String noRm,
    String tanggal = '',
    int limit = 30,
    bool allDates = false,
  }) {
    return _remoteDatasource.fetchMyGeneralBookings(
      email: email,
      noRm: noRm,
      tanggal: tanggal,
      limit: limit,
      allDates: allDates,
    );
  }

  @override
  Future<ApiCollection<PatientRecord>> searchPatients({
    required String query,
    int? limit,
    List<String>? columns,
    List<String>? searchColumns,
    bool withTotal = false,
  }) {
    return _remoteDatasource.searchPatients(
      query: query,
      limit: limit,
      columns: columns,
      searchColumns: searchColumns,
      withTotal: withTotal,
    );
  }
}
