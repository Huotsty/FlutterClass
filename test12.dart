abstract class Animal {
  // Abstract method (no implementation)
  void eat();

  // Concrete method (with implementation)
  void sleep() {
    print('Sleeping...');
  }
}

class Dog extends Animal {
  @override
  void eat() {
    print('Dog is eating...');
  }
}

void main() {
  // This would cause an error: 'Animal' is abstract and cannot be instantiated.
  // Animal animal = Animal(); 

  // Correct usage: instantiate a subclass
  Dog dog = Dog();
  dog.eat(); // Output: Dog is eating...
  dog.sleep(); // Output: Sleeping...
}
