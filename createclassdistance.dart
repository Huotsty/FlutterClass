enum DistanceUnit {
   kilometers,
   meters,
   centimeters
}
class Distance {
  final double _distance;
  final DistanceUnit _unit;
  
  Distance.kms(double kilometers):
    _distance = kilometers, 
    _unit = DistanceUnit.kilometers;

  Distance.ms(double meters): 
    _distance = meters, 
    _unit = DistanceUnit.meters;

  Distance.cms(double centimeters):
    _distance = centimeters,
    _unit = DistanceUnit.centimeters;

  double get distance => _distance;
  DistanceUnit get unit => _unit;

  double _convertToMeters() {
    switch (_unit) {
      case DistanceUnit.kilometers:
        return _distance * 1000;
      case DistanceUnit.meters:
        return _distance;
      case DistanceUnit.centimeters:
        return _distance / 100;
    }
  }

  double toKilometers() {
  return _convertToMeters() / 1000;
  }

  double toCentimeters(){
    return _convertToMeters() * 100;
  }

  Distance operator + (Distance other) {
    return Distance.ms(this._convertToMeters() + other._convertToMeters()); 
  }
  
    @override
  String toString() {
    return '$_distance ${_unit.name}';
  }
}
void main() {
  Distance d1 = Distance.kms(5);  
  Distance d2 = Distance.ms(500); 
  Distance sum = d1 + d2;
  print('Sum: $sum');
  print('sum:  ${sum.toKilometers()} kms');
  print('sum: ${sum.toCentimeters()} cms');
  
}