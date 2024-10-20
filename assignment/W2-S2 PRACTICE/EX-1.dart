enum Skill { FLUTTER, DART, OTHER }

class Address{
  final String _street;
  final String _city;
  final int _zipCode;
  String get street => _street;
  String get city => _city;
  int get zipCode => _zipCode;
  Address(this._street, this._city, this._zipCode);

  @override
  String toString() {
    return 'street: $_street, city: $_city, zipcode: $_zipCode';
  }
}

class Employee {
  final List<Skill> _skills;
  final String _name;
  final double _baseSalary;
  final int _yearsOfExperience;
  final Address _address;
  static const double DART_BONUS = 3000;
  static const double FLUTTER_BONUS = 5000;
  static const double OTHER_BONUS = 1000;
  static const double YEARSOFEXPERIENCE_BONUS = 2000;

  @override
  String toString() {
    return 'Employee: $name, Salary: \$${baseSalary.toStringAsFixed(2)}, Experience: $yearsOfExperience years, '
           'Skills: ${_skills.map((skill) => skill.toString().split('.').last).join(', ')}, '
           'Address: ${address.toString()}';
  }

  Employee(this._name, this._baseSalary, this._yearsOfExperience, this._address, this._skills);

  Employee.mobileDeveloper(this._name, this._baseSalary,this._yearsOfExperience,this._address)
  :_skills = [Skill.FLUTTER, Skill.DART];


  String get name => _name;
  double get baseSalary => _baseSalary; 
  Address get address => _address;
  int get yearsOfExperience => _yearsOfExperience;
  List<Skill> get skill => _skills;

  double computeSalary(){
  double total = _baseSalary + (YEARSOFEXPERIENCE_BONUS * _yearsOfExperience);
  _skills.forEach((skill) => total += _getSkillBonus(skill));
  return total;
  }

double _getSkillBonus(Skill skill) {
  return switch(skill) {
    Skill.DART => DART_BONUS,
    Skill.FLUTTER => FLUTTER_BONUS,
    Skill.OTHER => OTHER_BONUS
  };
}
    void printDetails() {
    print('$this, \n Total Salary: ${computeSalary().toStringAsFixed(2)} \$ \n');
  }

  }

void main() {
  Address address = Address('national road 5', 'Phnom Penh', 120702);

  Employee employee = Employee("huot", 4000, 0, address, [Skill.OTHER]);
  employee.printDetails();

  Employee employee2 = Employee.mobileDeveloper("huot", 40000, 0, address);
  employee2.printDetails();
}