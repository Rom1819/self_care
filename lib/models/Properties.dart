class Properties {
  final int id;
  final String image, title;

  Properties({this.id, this.image, this.title});
}

List<Properties> property = [
  Properties(id: 0, image: "assets/icons/bmi.png", title: "Body Mass Index"),
  Properties(id: 1, image: "assets/icons/med_remind.png", title: "Medic Alert"),
  Properties(
      id: 2, image: "assets/icons/health_tips.png", title: "Health Tips"),
  Properties(id: 3, image: "assets/icons/manworkout.png", title: "Man Workout"),
  Properties(
      id: 4, image: "assets/icons/womanworkout.png", title: "Woman Workout"),
  Properties(
      id: 5, image: "assets/icons/hospitals.png", title: "Nearest Hospitals")
];
