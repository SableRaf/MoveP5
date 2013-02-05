import io.thp.psmove.*;
import java.util.Set;

MoveManager moveManager;
MoveController move;

int moveCount; 

void setup() {
  moveManager = new MoveManager(1);               // Initialise move support (pass 1 to enable debug messages)
  moveManager.stream(false);                      // Send the data via OSC? (Needs bug fixing. Don't use yet.)
  moveCount = moveManager.get_controller_count(); // Number of connected controllers
}

void draw() {  
  for(int i=0; i<moveCount; i++) { // Loop through all connected controllers
    move = moveManager.getController(i); // Grab each controller
   
    if (move.isMovePressedEvent()) { // What happens the moment I press the MOVE button?
      int r = (int)random(255); // Define random color values
      int g = (int)random(255);
      int b = (int)random(255);
      move.set_leds(r,g,b); // Apply color to the leds
      move.set_rumble(255); // Vibration at maximum
    }
      
    if (move.isMoveReleasedEvent()) { // What happens them moment I release the MOVE button?
      move.set_leds(0, 0, 0); // Leds off
      move.set_rumble(0); // Vibration off
    }
    
  }
  moveManager.update(); // Read new input and update actuators (leds & rumble) for all controllers
}

void keyPressed() {
   if(key=='b'|| key=='B')
      moveManager.printAllControllers(); // print the info about all connected controllers
}

void exit() {
  moveManager.shutdown(); // We clean after ourselves (stop rumble and lights off)
  super.exit();           // Whatever Processing usually does at shutdown
}
