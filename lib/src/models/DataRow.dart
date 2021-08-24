class RowData {
  final String? name;
  final String? classification;
  final String? ultimate;
  final String? weapon;

  RowData(this.name, this.classification, this.ultimate, this.weapon);
  bool selected = false;

  RowData.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        classification = json['classification'],
        ultimate = json['ultimate'],
        weapon = json['weapon'];

  Map<String, dynamic> toJson() => {
    'name': name,
    'classification': classification,
    'ultimate': ultimate,
    'weapon': weapon
  };

}