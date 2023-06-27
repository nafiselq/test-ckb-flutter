import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:karyawan_it/data/services/karyawan_services.dart';

import '../../models/karyawan_model.dart';

part 'karyawan_event.dart';
part 'karyawan_state.dart';

class KaryawanBloc extends Bloc<KaryawanEvent, KaryawanState> {
  KaryawanBloc() : super(KaryawanInitial()) {
    on<KaryawanEvent>((event, emit) async {
      if (event is KaryawanGet) {
        try {
          emit(KaryawanLoading());

          final karyawan = await KaryawanService().getKaryawanModel();

          emit(KaryawanSuccess(karyawan));
        } catch (e) {
          emit(KaryawanFailed(e.toString()));
        }
      }

      if (event is DeletedKaryawan) {
        try {
          emit(KaryawanLoading());

          final delete = await KaryawanService()
              .deleteKaryawan(event.date, event.karyawanId);

          print("ini deleted $delete");
          if (delete == true) {
            final karyawan = await KaryawanService().getKaryawanModel();

            emit(KaryawanSuccess(karyawan));
          } else {
            print("gagal");
          }
        } catch (e) {
          emit(KaryawanFailed(e.toString()));
        }
      }

      if (event is KaryawanAdd) {
        try {
          emit(KaryawanLoading());
          final add = await KaryawanService().createKaryawan(
            event.jobC,
            event.nameC,
            event.nikC,
            event.tempatC,
            event.tglLahirC,
            event.jenisKelaminC,
            event.alamatC,
          );
          print("ini add $add");
        } catch (e) {
          emit(KaryawanFailed(e.toString()));
        }
      }
    });
  }
}
