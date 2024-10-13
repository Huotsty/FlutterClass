bool isBalanced(String input) {
  List<String> stack = [];

  for (int i = 0; i < input.length; i++) {
    String char = input[i];

    if (char == '{' || char == '[' || char == '(') {
      stack.add(char);
    } else if (char == '}' || char == ']' || char == ')') {
      if (stack.isEmpty) {
        return false;
      }
      String last = stack.removeLast();
      if ((char == '}' && last != '{') ||
          (char == ']' && last != '[') ||
          (char == ')' && last != '(')) {
        return false;
      }
    }
  }

  return stack.isEmpty;
}

void main() {
  List<String> inputs = ['{what is (42)}?', '[text}', '{[[(a)b]c]d}'];

  for (String input in inputs) {
    if (isBalanced(input)) {
      print('$input - Balanced');
    } else {
      print('$input - Not balanced');
    }
  }
}
