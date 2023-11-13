String greetingText() {
  DateTime now = DateTime.now();
  int hour = now.hour;
  String greeting = "";

  if (hour >= 5 && hour < 12) {
    greeting = "Magandang Umaga";
  } else if (hour >= 12 && hour < 18) {
    greeting = "Magandang Hapon";
  } else {
    greeting = "Magandang Gabi";
  }

  return greeting;
}
