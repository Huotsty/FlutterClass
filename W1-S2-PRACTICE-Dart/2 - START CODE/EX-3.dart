void main() {
  // List of student scores
  List<int> scores = [45, 67, 82, 49, 51, 78, 92, 30];

  // You code
 
  
  var passed = scores.where((number) => number >= 50);
  var student = passed.toList();
  var howmany = student.length;
  print("$howmany students passed");
  
}