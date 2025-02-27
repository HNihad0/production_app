class ProductDetailResponse {
    int idn;
    int mal;
    String malAdi;
    String name;

    ProductDetailResponse({
        required this.idn,
        required this.mal,
        required this.malAdi,
        required this.name,
    });

    factory ProductDetailResponse.fromJson(Map<String, dynamic> json) => ProductDetailResponse(
        idn: json["idn"],
        mal: json["mal"],
        malAdi: json["mal_adi"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "idn": idn,
        "mal": mal,
        "mal_adi": malAdi,
        "name": name,
    };
}