enum Direction { north, east, south, west }
 // 0 1 2 3 
void main() {
  // Initial position {7, 3} and facing north
  int x = 7;
  int y = 3;
  Direction direction = Direction.north;
 
  // Example instruction sequence
  const instructions = "RAALAL";
  
  // Process the instructions and get the final position and direction
 Direction.north;

  for (String instruction in instructions.split('')) {
    if (instruction == 'A') {
      switch (direction) {
        case Direction.north: y += 1; break;
        case Direction.east: x += 1; break;
        case Direction.south: y -= 1; break;
        case Direction.west: x -= 1; break;
      }
    } else if (instruction == 'R') {
      direction = Direction.values[(direction.index + 1) % 4];
    } else if (instruction == 'L') {
      direction = Direction.values[(direction.index + 3) % 4];
    }
  
  }
  // Print the final position and direction
  print("Final position: ($x, $y)");
  print("Facing: $direction ");

}