import io.thp.psmove.*;
import java.util.Set;

MoveManager moveManager;

MoveController move;

color sphereColor;

void setup() {
  moveManager = new MoveManager();     // Initialise move support
  moveManager.debug(true);             // Print debug messages? (messages printed during moveManager's init can't be ignored) 
  move = moveManager.getController(0); // Get the first controller connected
}

void draw() {
  if (move.isMovePressedEvent())
    sphereColor = color(0, 150, 255);
    
  if (move.isMoveReleasedEvent())
    sphereColor = color(0, 0, 0);
    
  move.set_leds(sphereColor);
  moveManager.update(); // Read new input and update actuators (leds & rumble) for all controllers
}

void stop() {
  moveManager.shutdown(); // We clean after ourselves (stop rumble and lights off)
  super.stop();          // Whatever Processing usually does at shutdown
}
