class Person {
  int? id;
  String? name;
  String? lastname;
  String? title;

  Person(this.name, this.lastname, this.title);

  Person.withId(this.id, this.name, this.lastname, this.title);

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};

    map["id"] = id;
    map["name"] = name;
    map["lastname"] = lastname;
    map["title"] = title;

    return map;
  }

  Person.getMap(Map<String, dynamic> map) {
    id = map["id"];
    name = map["name"];
    lastname = map["lastname"];
    title = map["title"];
  }
}
