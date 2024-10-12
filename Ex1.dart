void main(){
  List<int> scores = [45, 78, 62, 49, 85, 33, 90, 50];
  var passed = scores.where((number) => number >= 50);
  var student = passed.toList();
  var howmany = student.length;
  print("$howmany students passed");
  
}