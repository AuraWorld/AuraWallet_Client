class NftList {
  NftList({
      required this.id,
      required this.name,
      required this.address,
      required this.title,
      required this.img,
      required this.metadata,});

  NftList.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    address = json['address'];
    title = json['title'];
    img = json['img'];
    metadata = json['metadata'];
  }
  String? id;
  String? name;
  String? address;
  String? title;
  String? img;
  String? metadata;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['address'] = address;
    map['title'] = title;
    map['img'] = img;
    map['metadata'] = metadata;
    return map;
  }

}