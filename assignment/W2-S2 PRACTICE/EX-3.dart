class MyDuration {
  final int _durationInMilliseconds;
  
  // MyDuration(this._milliseconds);	
  MyDuration.fromHours( int duration): _durationInMilliseconds = duration * 3600000;
  MyDuration.fromMinutes( int duration): _durationInMilliseconds = duration * 60000;
  MyDuration.seconds( int duration): _durationInMilliseconds = duration * 1000;
  MyDuration(int milliseconds): _durationInMilliseconds = (milliseconds >=0 ? milliseconds : 0);
  int get milliseconds => _durationInMilliseconds;
  int get minutes => (_durationInMilliseconds / 60000).floor();
  int get seconds => (_durationInMilliseconds/1000).floor();
  int get hours => (_durationInMilliseconds / 3600000).floor();
//   // Display the duration in a readable format
  @override
  String toString() {
    int seconds = (milliseconds / 1000).round();
    int minutes = (seconds / 60).floor();
    seconds = seconds % 60;
    int hours = (minutes / 60).floor();
    minutes = minutes % 60;
    return '$hours hours, $minutes minutes, $seconds seconds';
  }
  MyDuration operator +(MyDuration other) {	
   return MyDuration(_durationInMilliseconds + other._durationInMilliseconds);
  }
  MyDuration operator -(MyDuration other) {
   int result = _durationInMilliseconds - other._durationInMilliseconds;
    if (result < 0) {
      throw Exception('Resulting duration cannot be negative.');
    }
    return MyDuration(result);
  }
  bool operator >(MyDuration other) {
      return _durationInMilliseconds > other._durationInMilliseconds;
  }
  }


void main() {
  MyDuration duration1 = MyDuration.fromHours(3); // 3 hours
  MyDuration duration2 = MyDuration.fromMinutes(45); // 45 minutes
  print(duration1 + duration2); // 3 hours, 45 minutes, 0 seconds
  print(duration1>duration2); //true

  try {
    print(duration2 - duration1); // This will throw an exception
  } catch (e) {
    print(e); 
  }
}
