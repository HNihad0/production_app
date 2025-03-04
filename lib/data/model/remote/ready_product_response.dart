class ReadyProductResponse {
  String? senNo;
  DateTime? tarix;
  double? esasMebleg;
  dynamic stat;
  String? elKod;
  int? elMal;
  String? elMalAdi;
  int? elMiqdar;
  dynamic elCeki;
  String? silKod;
  int? silMal;
  String? silMalAdi;
  num? silMiqdar;

  ReadyProductResponse({
    this.senNo,
    this.tarix,
    this.esasMebleg,
    this.stat,
    this.elKod,
    this.elMal,
    this.elMalAdi,
    this.elMiqdar,
    this.elCeki,
    this.silKod,
    this.silMal,
    this.silMalAdi,
    this.silMiqdar
  });

  factory ReadyProductResponse.fromJson(Map<String, dynamic> json) =>
      ReadyProductResponse(
        senNo: json["sen_no"],
        tarix: json["tarix"] != null ? DateTime.parse(json["tarix"]) : null,
        esasMebleg:
            json["esasMebleg"] != null ? json["esasMebleg"]?.toDouble() : null,
        stat: json["stat"],
        elKod: json["elKod"],
        elMal: json["elMal"],
        elMalAdi: json["elMalAdi"],
        elMiqdar: json["elMiqdar"],
        elCeki: json["elCeki"],
        silKod: json["silKod"],
        silMal: json["silMal"],
        silMalAdi: json["silMalAdi"],
        silMiqdar: json["silMiqdar"],
      );

  Map<String, dynamic> toJson() => {
        "sen_no": senNo,
        "tarix": tarix?.toIso8601String(),
        "esasMebleg": esasMebleg,
        "stat": stat,
        "elKod": elKod,
        "elMal": elMal,
        "elMalAdi": elMalAdi,
        "elMiqdar": elMiqdar,
        "elCeki": elCeki,
        "silKod": silKod,
        "silMal": silMal,
        "silMalAdi": silMalAdi,
        'silMiqdar':silMiqdar
      };
}
