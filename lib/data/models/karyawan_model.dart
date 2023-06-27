class KaryawanModel {
  final int? id;
  final String? titleJob;
  final int? nik;
  final String? name;
  final String? tempat;
  final DateTime? tglLahir;
  final String? jenisKelamin;
  final String? alamat;
  final String? deletedAt;

  KaryawanModel({
    this.id,
    this.titleJob,
    this.name,
    this.nik,
    this.tempat,
    this.tglLahir,
    this.jenisKelamin,
    this.alamat,
    this.deletedAt,
  });

  factory KaryawanModel.fromJson(Map<String, dynamic> json) => KaryawanModel(
        id: json['id'],
        titleJob: json['title_job'],
        name: json['name'],
        nik: json['nik'],
        tempat: json['tempat'],
        tglLahir: DateTime.parse(json['tgl_lahir']),
        jenisKelamin: json['jenis_kelamin'],
        alamat: json['alamat'],
        deletedAt: json['deleted_at'] == null ? '' : json['deleted_at'],
      );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title_job': titleJob,
      'name': name,
      'nik': nik,
      'tempat': tempat,
      'tgl_lahir': tglLahir!.toIso8601String(),
      'jenis_kelamin': jenisKelamin,
      'alamat': alamat,
      'deleted_at': deletedAt,
    };
  }
}
