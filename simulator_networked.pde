/*

 2022-04-18
 
 - want to do brain neuron pulse travel time again
 - DONE started with point travelling along straight line between two other points.
 
 2022-04-25
 
 - DONE building on this by making the end point movable by mouse
 - TODO i will make the transition between old and new positions of the end point an s-curve next
 - DONE change speed so that it is constant regardless of the distance between the two points
 
 2022-05-03
 
 - DONE starting work to add brain management object
 - DONE connection mapping
 
 2022-05-05
 
 - 3D?
 
 2022-05-23
 
 - FIXED if then bug in neuron connection method which was exiting the loop before completing connections
 
 */

int seeder = 1;
int number_of_neurons = 10;
float brain_size = 512;
float maximum_connection_distance = 250.0;
float maximum_connection_distance_variance = 0.0;
float initial_speed = 1.0;
float curvy = 1;
Brain brain;
PVector display_offset;
float display_scale = 1.0;

void setup() {
  size(720, 576);
  //size(800, 800);
  randomSeed(seeder);
  noiseSeed(seeder);
  smooth();
  //noLoop();
  brain = new Brain(number_of_neurons, brain_size, maximum_connection_distance, maximum_connection_distance_variance, initial_speed, curvy);
  display_offset = new PVector((width / 2) - ((brain_size * display_scale) / 2), (height / 2) - ((brain_size * display_scale) / 2));
}

void draw() {
  background(10, 10, 30);
  //pushStyle();
  //noStroke();
  //fill(24, 20, 50, 64);
  //rect(0, 0, width, height);
  //popStyle();
  
  pushMatrix();
  translate(display_offset.x, display_offset.y);
  scale(display_scale);
  brain.scribble();
  popMatrix();
}
