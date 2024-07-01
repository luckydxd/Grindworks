class KategoriInfo {
  int? id;
  String? nama;
  String? img;
  String? deskripsi;
  int? urutan;
  String? created_at;

  KategoriInfo(int id, String nama,String img, String deskripsi,int urutan, String created_at) {
    this.id = id;
    this.nama = nama;
    this.img = img;
    this.deskripsi = deskripsi;
    this.urutan = urutan;
    this.created_at = created_at;
  }

  KategoriInfo.fromJson(Map json)
      : id = json['id_kategori'],
        nama = json['nama'],
        img = json['img'],
        deskripsi = json['deskripsi'],
        urutan = json['urutan'],
        created_at = json['created_at'];

  Map toJson() {
    return {
      'id_kategori': id,
      'nama': nama,
      'img': img,
      'deskripsi': deskripsi,
      'urutan': urutan,
      'created_at': created_at,
    };
  }
}