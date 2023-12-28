import 'dart:math';

bool equalsIgnoreCase(String? string1, String? string2) {
  return string1?.toLowerCase() == string2?.toLowerCase();
}

String changeString(String original, String needToChange) {
  String newString = original.replaceAll(needToChange, ' _______ ');
  return newString;
}

String changeStringforPino(String original, String needToChange) {
  String newString = original.replaceAll(needToChange, ' blank.. ');
  return newString;
}

String shuffleString(String input) {
  final chars = input.split('');
  chars.shuffle();
  return chars.join();
}

String getRandomString(int length, String title) {
  String letters = "abcdefghijklmnopqrstuvwxyz";
  Random random = Random();

  int numberToAdd = 12 - title.length;

  var generatedLetters = List.generate(
      numberToAdd, (index) => letters[random.nextInt(letters.length)]).join();

  String newText = "$title$generatedLetters";

  var text = shuffleString(newText);

  return text;
}
