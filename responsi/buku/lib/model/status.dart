class Status {
  int? id;
  String? availability;
  String? borrower_name;
  int? due_days;
  Status({this.id, this.availability, this.borrower_name, this.due_days});
  factory Status.fromJson(Map<String, dynamic> obj) {
    return Status(
        id: obj['id'],
        availability: obj['availability'],
        borrower_name: obj['borrower_name'],
        due_days: obj['due_days']);
  }
}
