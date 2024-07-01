class LayananInfo {
  int? id;
  String? user;
  String? judul;
  String? deskripsi;
  String? img;
  String? deskripsi2;
  String? alat;
  int? revisi;
  String? faq;
  String? info;
  double? hargaLayanan;
  String? fitur;
  String? status;
  String? created_at;

  LayananInfo(int id, String user, String judul, String deskripsi, String img,
        String deskripsi2, String alat, int revisi, String faq,
        String info, double hargaLayanan, String fitur,String status, String created_at){
        this.id=id;
        this.user=user; 
        this.judul=judul; 
        this.deskripsi=deskripsi; 
        this.img=img;
        this.deskripsi2=deskripsi2; 
        this.alat=alat;
        this.revisi=revisi; 
        this.faq=faq;
        this.info=info; 
        this.hargaLayanan=hargaLayanan; 
        this.fitur=fitur;
        this.status=status;
        this.created_at=created_at;}

  LayananInfo.fromJson(Map json)
      : id = json['id_layanan'],
        user = json['user'],
        judul = json['judul'],
        deskripsi = json['deskripsi'],
        img = json['img'],
        deskripsi2 = json['deskripsi2'],
        alat = json['alat'],
        revisi = json['revisi'],
        faq = json['faq'],
        info = json['info'],
        hargaLayanan = double.parse(json['harga_layanan']),
        fitur = json['fitur'],
        status = json['status'],
        created_at = json['created_at'];

  Map toJson() {
    return {
      'id_layanan': id,
      'judul': judul,
      'deskripsi': deskripsi,
      'img': img,
      'deskripsi2': deskripsi2,
      'alat': alat,
      'revisi': revisi,
      'faq': faq,
      'info': info,
      'harga_layanan': hargaLayanan,
      'fitur': fitur,
      'status': status,
      'created_at': created_at,
    };
  }
}