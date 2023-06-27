import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:karyawan_it/data/models/karyawan_model.dart';

class KaryawanService {
  String baseUrl = 'https://82c4-180-214-232-19.ngrok-free.app';

  Future<List<KaryawanModel>> getKaryawanModel() async {
    try {
      final res = await http.get(Uri.parse('$baseUrl/karyawans'));

      // print("ini responnya : ${res.body}");

      if (res.statusCode == 200) {
        return List<KaryawanModel>.from(
          jsonDecode(res.body)["data"].map(
            (karyawan) => KaryawanModel.fromJson(karyawan),
          ),
        ).toList();
      } else {
        return jsonDecode(res.body)["message"];
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> deleteKaryawan(DateTime date, int karyawanId) async {
    print("ini integer id : $karyawanId");
    try {
      final res = await http.put(
        Uri.parse('$baseUrl/karyawans/delete/$karyawanId'),
        body: {"deleted_at": date.millisecondsSinceEpoch.toString()},
      );

      print("res status delete : ${res.body}");

      if (res.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> createKaryawan(
      String jobC,
      String nameC,
      int nikC,
      String tempatC,
      DateTime tglLahirC,
      String jenisKelaminC,
      String alamatC) async {
    try {
      var data = {
        'titeJobs': jobC,
        'name': nameC,
        'nik': nikC,
        'tempat': tempatC,
        "tgl_lahir": tglLahirC.toString(),
        'jenisKelamin': jenisKelaminC,
        'alamat': alamatC,
      };

      final res = await http.post(
        Uri.parse('$baseUrl/karyawans'),
        body: data,
      );

      print("ini res : ${res.body}");

      if (res.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print("ini error ${e.toString()}");
      rethrow;
    }
  }
}
