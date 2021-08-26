class Course {
  String courseCode;
  String courseTitle;

  Course({
    required this.courseCode,
    required this.courseTitle,
  });

  static listFromJson(List list) {
    List<Course> departments = [];
    for (var value in list) {
      departments.add(Course.fromJson(value));
    }
    return departments;
  }

  static fromJson(Map<String, dynamic> json) {
    return Course(
        courseCode: json["courseCode"], courseTitle: json["courseTitle"]);
  }

  Map<String, dynamic> toJson() => {
        'courseCode': courseCode,
        'courseTitle': courseTitle,
      };
  @override
  bool operator ==(Object other) =>
      other is Course && other.courseCode == courseCode;

  @override
  int get hashCode => courseCode.hashCode;
}
