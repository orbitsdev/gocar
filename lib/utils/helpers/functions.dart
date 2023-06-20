
String toCamelCase(String text) {
  List<String> words = text.split(' ');

  String result = '';

  for (int i = 0; i < words.length; i++) {
    String word = words[i];

    if (i == 0) {
      result += word.toLowerCase();
    } else {
      result += word[0].toUpperCase() + word.substring(1).toLowerCase();
    }
  }

  return result;
}



String capitalize(String name) {
  List<String> words = name.split(' ');

  for (int i = 0; i < words.length; i++) {
    String word = words[i];
    if (word.isNotEmpty) {
      words[i] = word[0].toUpperCase() + word.substring(1);
    }
  }

  return words.join(' ');
}