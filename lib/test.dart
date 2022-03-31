import 'dart:math';

void main() {
  print(distance(0, 0, 100, 100));
  print(distance(0, 0, -100, -100));
}

//caluculate the distance between two points
double distance(double x1, double y1, double x2, double y2) {
  return sqrt(pow(x2 - x1, 2) + pow(y2 - y1, 2));
}
