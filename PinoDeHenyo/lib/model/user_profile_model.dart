class Model {
  final String name;
  final int age;

  Model({required this.name, required this.age});

  Map<String, dynamic> toJson() => {'name': name, 'age': age};

  factory Model.fromJson(Map<String, dynamic> json) {
    return Model(name: json['name'], age: json['age']);
  }
}
