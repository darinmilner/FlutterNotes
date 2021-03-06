class Note {
  String id;
  String body;

  static const String DEFAULTNOTE = "New Note";

  Note({
    this.id,
    this.body = "",
  });

  String get noteBody {
    return this.body.isNotEmpty ? this.body : Note.DEFAULTNOTE;
  }

  int get characters {
    return this.body.length;
  }

  int get words {
    if (this.body.length == 0) {
      return 0;
    }
    return this.body.split(" ").length;
  }
}
