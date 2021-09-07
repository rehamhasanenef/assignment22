class CountryModel {
  String id;
  String name;
  List<dynamic> cites;
  CountryModel(this.name, this.cites);
  CountryModel.fromJson(Map map) {
    this.id = map['id'];
    this.name = map['name'];
    this.cites = map['cites'];
  }
}
