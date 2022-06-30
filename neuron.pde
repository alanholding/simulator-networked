/*

2022-05-03 neuron class

properties:
- id
- position in 2d space
- action potential
- axons

methods:
- add axon
- step axons
- fires
- rests (reduction of increase in action potential whilst resting)
- set action potential value

*/

class Neuron {
  int id;
  PVector position;
  float initial_speed;
  ArrayList<Axon> axons = new ArrayList<Axon>();
  int number_of_axons;
  
  Neuron(int _id, PVector _position, float _initial_speed) {
    id = _id;
    position = _position;
    initial_speed = _initial_speed;
    number_of_axons = 0;
  }
  
  void connectAxon(PVector _end_position) {
    axons.add(new Axon(position, _end_position, initial_speed));
    number_of_axons++;
  }
  
  void drawNeuron() {
    point(position.x, position.y);
  }
  
  void drawAxonInfo() {
    text(id + " (" + number_of_axons + ")", position.x, position.y - 12);
  }

  void drawAxons() {
    for(Axon a: axons) {
      a.drawConnection();
    }
  }
}
