import io.thp.psmove.*;
import java.util.Set;

MoveManager moveManager;
MoveController move;

int moveCount; 

void setup() {
  //frameRate(25);
  moveManager = new MoveManager(1);              // Enable move support (pass 1 to activate debug messages)
  moveManager.stream(this, 12000, 12000);        // Send the data via OSC (sketch instance, listening port, sending port)
  moveManager.enable_orientation();              // Activate sensor fusion for all controllers
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
    
    if (move.isSelectPressedEvent()) {
      move.reset_orientation(); // Set the orientation quaternions to their start values [1, 0, 0, 0]
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
  
