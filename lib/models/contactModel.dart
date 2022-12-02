class ContactModel {
  ContactModel({
    required this.id,
    required this.name,
    required this.value,
  });
  final int id; 
  final String name;
  final String value;
  

  factory ContactModel.fromJson(Map<String, dynamic> json) {
    return ContactModel(
      id: json['id'],
      name: json['name'],
      value: json['value'],
    
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'value': value,
    };
  }
}
