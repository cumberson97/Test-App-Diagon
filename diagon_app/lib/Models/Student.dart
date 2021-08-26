import 'Course.dart';

class Student implements Comparable {
  String name;
  int id;
  int age;
  List<Course> courses;

  Student({
    required this.name,
    required this.id,
    required this.age,
    required this.courses,
  });

  static Student fromJson(json) => Student(
        name: json['name'],
        age: json['age'],
        id: json['id'],
        //courses: json['courses'],
        courses: Course.listFromJson(json['courses']),
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'id': id,
        'age': age,
        'courses': List<dynamic>.from(courses.map((x) => x.toJson())),
      };

  void addCourse(Course course) {
    this.courses.add(course);
  }

  int numberOfCourses() => courses.length;

  @override
  bool operator ==(Object other) => other is Student && other.id == id;

  @override
  int get hashCode => id.hashCode;

  @override
  int compareTo(other) {
    return this.name.compareTo(other.name);
  }
}
