part of 'karyawan_bloc.dart';

abstract class KaryawanState extends Equatable {
  const KaryawanState();

  @override
  List<Object> get props => [];
}

class KaryawanInitial extends KaryawanState {}

class KaryawanLoading extends KaryawanState {}

class KaryawanFailed extends KaryawanState {
  final String e;
  const KaryawanFailed(this.e);

  @override
  List<Object> get props => [e];
}

class KaryawanSuccess extends KaryawanState {
  final List<KaryawanModel> karyawans;
  const KaryawanSuccess(this.karyawans);

  @override
  List<Object> get props => [karyawans];
}

class KaryawanDeleted extends KaryawanState {
  final bool isSuccess;
  const KaryawanDeleted(this.isSuccess);

  @override
  List<Object> get props => [isSuccess];
}
