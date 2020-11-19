class ActivityCategory {
  int id;
  String name;
  String colorName;

  ActivityCategory(this.name, this.colorName);

  int get getId { return this.id; }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'color_name': colorName,
    };
  }
}