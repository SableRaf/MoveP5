import io.thp.psmove.*;
import java.util.Set;

MoveManager moveManager;
MoveController move;

int moveCount; 

void setup() {
  moveManager = new MoveManager();     // Initialise move support
  moveManager.debug(true);             // Print debug messages? (won't affect messages printed during moveManager's init) 
  moveCount = moveManager.get_controller_count(); // Number of connected controllers
}

void draw() {
  for(int i=0; i<moveCount; i++) { // Loop through all connected controllers
    move = moveManager.getController(i); // Grab this controller
    if (move.isMovePressedEvent()) {
      move.set_leds(0, 150, 255);
      move.set_rumble(255);
    }
      
    if (move.isMoveReleasedEvent()) {
      move.set_leds(0, 0, 0);
      move.set_rumble(0);
    }
  }
  moveManager.update(); // Read new input and update actuators (leds & rumble) for all controllers
}

void stop() {
  moveManager.shutdown(); // We clean after ourselves (stop rumble and lights off)
  super.stop();          // Whatever Processing usually does at shutdown
}
