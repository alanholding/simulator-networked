/*

2022-05-03 brain class

properties:
- neurons

methods:
- steps neurons
- creates neurons in 2d space
- connects nuerons to each other using axons (based on distance? based on)

*/

class Brain {
  int number_of_neurons;
  float brain_size;
  float maximum_connection_distance;
  float maximum_connection_distance_variance;
  float initial_speed;
  int number_of_connections;
  float curvy;
  ArrayList<Neuron> neurons = new ArrayList<Neuron>();
  
  Brain(int _number_of_neurons, float _brain_size, float _maximum_connection_distance, float _maximum_connection_distance_variance, float _initial_speed, float _curvy) {
    number_of_neurons = _number_of_neurons;
    brain_size = _brain_size;
    maximum_connection_distance = _maximum_connection_distance;
    maximum_connection_distance_variance = _maximum_connection_distance_variance;
    initial_speed = _initial_speed;
    curvy = _curvy;
    //createNeurons();
    createNeuronsUsingRandomDistribution();
    //createNeuronsUsingNoiseDistribution();
    connectNeurons();
    removeUnconnectedNeurons();
  }
  
  void createNeurons() {
    for(int i = 0; i < number_of_neurons; i++) {
      neurons.add(new Neuron(i, new PVector(random(brain_size), random(brain_size)), initial_speed));
    }
  }

  void createNeuronsUsingRandomDistribution() {
    for(int i = 0; i < number_of_neurons; i++) {
      neurons.add(new Neuron(i, new PVector(random(brain_size), random(brain_size)), initial_speed));
    }
  }
  
  void createNeuronsUsingNoiseDistribution() {
    float nx, ny = 0;
    for(int i = 0; i < number_of_neurons; i++) {
      nx = noise(sin(frameCount * 0.004 + ny) + i + curvy);
      ny = noise((frameCount + 23) * 0.00011 + i + nx * curvy);
      neurons.add(new Neuron(i, new PVector(nx * brain_size, ny * brain_size), initial_speed));
    }
  }
  
  void connectNeurons() {
    float mcd;
    for(int i = 0; i < neurons.size(); i++) {
      for(int j = 0; j < neurons.size(); j++) {
        if (i != j) {
          Neuron ni = neurons.get(i);
          Neuron nj = neurons.get(j);
          mcd = random(maximum_connection_distance - maximum_connection_distance_variance, maximum_connection_distance + maximum_connection_distance_variance);
          if (floor(PVector.dist(ni.position, nj.position)) <= mcd) {
            ni.connectAxon(nj.position);
            number_of_connections++;
          }
        }
      }
    }
  }
  
  void removeUnconnectedNeurons() {
    int original_size = neurons.size();
    for (int i = neurons.size() - 1; i >= 0; i--) {
      Neuron n = neurons.get(i);
      if (n.number_of_axons < 1) {
        neurons.remove(i);
      }
    }
    // println("seeder: " + seeder);
    // println("number of generated neurons: " + original_size);
    // println("unconnected neurons removed: " + (original_size - neurons.size()));
    // println("number of connected neurons: " + neurons.size());
  }
  
  void scribble() {
    drawAxons();
    //drawNeuronsConnectionDistance();
    //drawAxonConnectionInformation();
    drawNeurons();
  }
  
  void drawAxons() {
    pushStyle();
    noFill();
    strokeWeight(2);
    // strokeWeight(.5);
    stroke(10, 100, 200, 128);
    for(Neuron n: neurons){
      n.drawAxons();
    }
    popStyle();
  }
  
  void drawAxonConnectionInformation() {
    pushStyle();
    fill(0);
    noStroke();
    textAlign(CENTER);
    textSize(12);
    for(Neuron n: neurons){
      n.drawAxonInfo();
    }
    popStyle();
  }

  void drawNeurons() {
    pushStyle();
    noFill();
    stroke(255, 50, 10, 128);
    strokeWeight(16);
    for(Neuron n: neurons){
      //strokeWeight(n.number_of_axons);
      n.drawNeuron();
    }
    popStyle();
  }
  
  void drawNeuronsConnectionDistance() {
    pushStyle();
    fill(128, 100, 100, 32);
    strokeWeight(1);
    stroke(255, 32);
    for(Neuron n: neurons){
      ellipse(n.position.x, n.position.y, maximum_connection_distance * 2, maximum_connection_distance * 2);
    }
    popStyle();
  }

}
