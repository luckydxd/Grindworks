class Pesanan {
  final int idPesanan;
  final int userId;
  final int layananId;
  final String deskripsi;
  final String tanggal;
  final String status;
  final String? fileProject;
  final String createdAt;
  final String updatedAt;

  Pesanan({
    required this.idPesanan,
    required this.userId,
    required this.layananId,
    required this.deskripsi,
    required this.tanggal,
    required this.status,
    this.fileProject,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Pesanan.fromJson(Map<String, dynamic> json) {
    return Pesanan(
      idPesanan: json['id_pesanan'] ?? 0,
      userId: json['user_id'] ?? 0,
      layananId: json['layanan_id'] ?? 0,
      deskripsi: json['deskripsi'] ?? '',
      tanggal: json['tanggal'] ?? '',
      status: json['status'] ?? '',
      fileProject: json['file_project'],
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
    );
  }
}
