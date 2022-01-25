class Strategy {
  int? id;
  String? name;
  String? image;
  String? text;

  Strategy({this.id, this.name, this.image, this.text});

  Strategy.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    text = json['text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image'] = this.image;
    data['text'] = this.text;
    return data;
  }
}