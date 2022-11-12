class Notes {
  int? id;
  String? title;
  String? description;

  Notes(this.title, this.description);

  Notes.withId(this.id, this.title, this.description);
}
