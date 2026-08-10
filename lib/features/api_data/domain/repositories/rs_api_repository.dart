import '../entities/api_collection.dart';
import '../entities/employee_record.dart';
import '../entities/patient_lab_result_record.dart';
import '../entities/patient_medical_summary_record.dart';
import '../entities/patient_prescription_record.dart';
import '../entities/patient_radiology_result_record.dart';
import '../entities/patient_record.dart';
import '../entities/patient_visit_record.dart';
import '../entities/resource_record.dart';
import '../entities/table_metadata.dart';
import '../../../booking/domain/entities/booking_queue_response.dart';
import '../../../booking/domain/entities/booking_calendar.dart';
import '../../../booking/domain/entities/booking_options.dart';
import '../../../booking/domain/entities/queue_records.dart';

abstract class RsApiRepository {
  Future<ApiCollection<PatientRecord>> searchPatients({
    required String query,
    int? limit,
    List<String>? columns,
    List<String>? searchColumns,
    bool withTotal = false,
  });

  Future<PatientRecord> fetchPatientById(String id);

  Future<PatientRecord> fetchLinkedPatientProfile({
    required String email,
    required String noRm,
  });

  Future<ApiCollection<PatientVisitRecord>> fetchPatientVisits({
    required String email,
    required String noRm,
    int? limit,
  });

  Future<ApiCollection<PatientMedicalSummaryRecord>>
  fetchPatientMedicalSummaries({
    required String email,
    required String noRm,
    int? limit,
  });

  Future<ApiCollection<PatientLabResultRecord>> fetchPatientLabResults({
    required String email,
    required String noRm,
    int? limit,
  });

  Future<ApiCollection<PatientRadiologyResultRecord>>
  fetchPatientRadiologyResults({
    required String email,
    required String noRm,
    int? limit,
  });

  Future<ApiCollection<PatientPrescriptionRecord>> fetchPatientPrescriptions({
    required String email,
    required String noRm,
    int? limit,
  });

  Future<ApiCollection<EmployeeRecord>> searchEmployees({
    required String search,
    int? limit,
    List<String>? columns,
    List<String>? searchColumns,
  });

  Future<ApiCollection<ResourceRecord>> searchDoctorSchedules({
    required String search,
    int? limit,
    List<String>? columns,
  });

  Future<ApiCollection<ResourceRecord>> searchPolyclinics({
    required String search,
    int? limit,
    List<String>? columns,
  });

  Future<ApiCollection<ResourceRecord>> searchRooms({
    required String search,
    int? limit,
    List<String>? columns,
  });

  Future<ApiCollection<ResourceRecord>> searchRoomAvailabilities({
    required String search,
    int? limit,
    List<String>? columns,
  });

  Future<ApiCollection<QueueRegistrationRecord>> fetchQueueRegistrations({
    int limit,
  });

  Future<ApiCollection<LocalQueueRecord>> fetchLocalQueues({int limit});

  Future<ApiCollection<GeneralBookingRecord>> fetchGeneralBookings({
    String status,
    String tanggal,
    int limit,
  });

  Future<ApiCollection<GeneralBookingRecord>> fetchMyGeneralBookings({
    required String email,
    required String noRm,
    String tanggal,
    int limit,
    bool allDates,
  });

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
  });

  Future<BookingOptionsResponse> fetchBookingOptions({required int poliId});

  Future<BookingCalendarResponse> fetchBookingCalendar({
    required int year,
    required int month,
    int? poliId,
  });

  Future<TableMetadata> fetchTableMetadata(String tableName);
}
