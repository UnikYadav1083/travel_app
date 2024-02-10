class ChecklistItem {
  String id;
  String title;

  ChecklistItem({
    required this.id,
    required this.title,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ChecklistItem && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}