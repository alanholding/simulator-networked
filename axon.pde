/*

2022-05-03 axon class

properties:
- id
- start and end neurons
- is active
- electron position
- electron transmission speed (global?)

methods:
- update electron position
- set active status

*/

class Axon {
  PVector start_position;
  PVector end_position;
  PVector position;
  float initial_speed;
  float speed;
  float distance;
  float old_distance;
  float lerpy;

  Axon(PVector _start_position, PVector _end_position, float _initial_speed) {
    start_position = _start_position;
    end_position = _end_position;
    initial_speed = _initial_speed;
    lerpy = 0.0;
    
    // initial values
    distance = PVector.dist(start_position, end_position);
    speed = (initial_speed / distance) * distance;
  }
  
  void drawConnection() {
    line(start_position.x, start_position.y, end_position.x, end_position.y);
    //float d = PVector.dist(start_position, end_position);
    //line(start_position.x, start_position.y, end_position.x, end_position.y);
    //ellipse(start_position.x, start_position.y, d * 0.01, d * 0.01);
  }
  
  // probably won't be needed if the neuron doesn't move?
  void recompute() {
    old_distance = distance;
    distance = PVector.dist(start_position, end_position);
    speed = (speed / distance) * distance;
    lerpy = map(lerpy, 0, old_distance, 0, distance); 
  }

  void iterate() {
    lerpy += speed;
    // REFACTOR this is where the fired state is triggered
    if (lerpy >= distance) {
      lerpy = distance - abs(speed);
      speed = -speed;
    } else if (lerpy <= 0.0) {
      lerpy = abs(speed);
      speed = -speed;
    }
    position = PVector.lerp(start_position, end_position, map(lerpy, 0.0, distance, 0.0, 1.0));
  }
}
