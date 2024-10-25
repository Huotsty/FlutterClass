// ignore_for_file: public_member_api_docs, sort_constructors_first

enum HouseType{Villa('villa'), Mansion('Mansion'),Relax('relax'),simple('simple');
  final String label;
  const HouseType(this.label);
  String toString() => label; 
}
enum RoomType{Bedroom, Bathroom,Kitchen}
enum Roof{
  Flat,
  MonoPitch
}
class Chimney {
  String color;
  String position;
  Chimney({
    required this.color,
    required this.position,
  });
  
}
class Item {
  String? name;
  int? howmany;
  Item({
    this.name,
    this.howmany,
  });
}

class Tree{
  String? treetype;
  int? tree;
}
class Window {
  int size;
  int color;
  String position;
  Window({
    required this.size,
    required this.color,
    required this.position,
  });
}


class Door {
  int size;
  int color; 
  String position;
  Door({
    required this.size,
    required this.color,
    required this.position,
  });
}
  enum Pet{Dog,Cat,Hamster}

class Garden{
  final int numberofPlants;
  final List<String> plants;
  Garden({required this.numberofPlants, required this.plants});
 
}

enum Sports{
  volleyball,
  basketball,
  soccer,
  tennis,

}
class House {

  // List<Window> windows;
  // int room;
  // List <Door> doors;
  // Garden garden;
  // Chimney chimney;

  final String Housecolor = 'yellow'; 
  final int floor;
  final double width;
  final double length;
  final HouseType type;

  House(this.floor, this.width, this.length, this.type);

  
  // House({this.type= HouseType.simple, required this.width, required this.length, required this.floor});
 @override
  String toString() {
    return 'House Color: $Housecolor, There are  $floor, The width: $width, The length: $length, HouseType $type';
  }
}

void main(){
  // House house = House( width: 10, length: 15, floor: 4);
  // print(house.toString());
}