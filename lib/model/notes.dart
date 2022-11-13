class Notes {
  int? id;
  String? title;
  String? description;
  int? personId;

  Notes(this.title, this.description);

  Notes.withId(this.id, this.title, this.description);

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();

    map["id"] = id;
    map["title"] = title;
    map["description"] = description;
    map["personId"] = personId;

    return map;
  }

  Notes.fromMap(Map<String, dynamic> map) {
    id = map["id"];
    title = map["title"];
    description = map["description"];
    personId = map["personId"];
  }
}
