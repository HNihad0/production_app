class ProductResponse {
    int idn;
    String adi;
    String kod;
    int nov;
    String? category;

    ProductResponse({
        required this.idn,
        required this.adi,
        required this.kod,
        required this.nov,
        this.category,
    });

    factory ProductResponse.fromJson(Map<String, dynamic> json) => ProductResponse(
        idn: json["idn"],
        adi: json["adi"],
        kod: json["kod"],
        nov: json["nov"],
        category: json["category"],
    );

    Map<String, dynamic> toJson() => {
        "idn": idn,
        "adi": adi,
        "kod": kod,
        "nov": nov,
        "category": category,
    };
}
