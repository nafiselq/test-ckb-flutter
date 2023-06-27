part of 'karyawan_bloc.dart';

abstract class KaryawanEvent extends Equatable {
  const KaryawanEvent();

  @override
  List<Object> get props => [];
}

class KaryawanGet extends KaryawanEvent {}

class DeletedKaryawan extends KaryawanEvent {
  final int karyawanId;
  final DateTime date;
  const DeletedKaryawan(this.karyawanId, this.date);

  @override
  List<Object> get props => [karyawanId, date];
}

class KaryawanAdd extends KaryawanEvent {
  final String jobC;
  final String nameC;
  final int nikC;
  final String tempatC;
  final DateTime tglLahirC;
  final String jenisKelaminC;
  final String alamatC;
  const KaryawanAdd(
    this.jobC,
    this.nameC,
    this.nikC,
    this.tempatC,
    this.tglLahirC,
    this.jenisKelaminC,
    this.alamatC,
  );

  @override
  List<Object> get props =>
      [jobC, nameC, nikC, tempatC, tglLahirC, jenisKelaminC, alamatC];
}
