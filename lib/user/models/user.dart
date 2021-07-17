class User {
  int id;
  String name;
  int age;
  String gender;
  double weight;
  double height;
  double bmi;
  String bmiSts;

  userMap() {
    var map = Map<String, dynamic>();
    map['id'] = id;
    map['name'] = name;
    map['age'] = age;
    map['gender'] = gender;
    map['weight'] = weight;
    map['height'] = height;
    map['bmi'] = bmi;
    map['bmiSts'] = bmiSts;

    return map;
  }
}
