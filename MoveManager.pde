
class MoveManager {
  
  int total_connected, unique_connected;
  
  private boolean debug = true; // Print debug messages?
  
  // This is the list where we will store the connected 
  // controllers and their id (MAC address) as a Key.
  private HashMap<String, MoveController> controllers;
  
  // List of connected controllers by index
  // This provides an easier access to the controllers
  // but doesn't allow to identify a controller over
  // several runs of the program.
  private ArrayList<MoveController> ordered_controllers;
  
  // The same controller connected via USB and Bluetooth 
  // shows twice. If priority_bluetooth is enabled, USB 
  // controllers will be replaced with their Bluetooth 
  // counterpart when one is found. 
  // Otherwise, it is "first in first served".
  boolean priority_bluetooth = true;
  
  MoveManager() {
    init();
  }
  
  void init() {
    if(debug) println("Looking for controllers...");
    if(debug) println("");
    
    total_connected = psmoveapi.count_connected();
    unique_connected = 0; // Number of actual controllers connected (without duplicates)
    
    controllers = new HashMap<String, MoveController>(); // Create the list of controllers
    
    ordered_controllers = new ArrayList<MoveController>();

    // This is only fun if we actually have controllers
    if (total_connected == 0) {
      if(debug) println("WARNING: No controllers connected.");
    }

    // Filter via connection type to avoid duplicates
    for (int i = 0; i<total_connected; i++) {
  
      MoveController move = new MoveController(i);

      String serial = move.get_serial();
      String connection = move.get_connection_name();
  
      if (!controllers.containsKey(serial)) { // Check for duplicates
        try { 
          controllers.put(serial, move);        // Add the id (MAC address) and controller to the list
          ordered_controllers.add(move);        // Also add the controller to the indexed array
          if(debug) println("Found "+serial+" via "+connection);
        }
        catch (Exception ex) {
          if(debug) println("Error trying to register Controller #"+i+" with address "+serial);
          ex.printStackTrace();
        }
        unique_connected++; // We just added one unique controller
      }
      else {
        if(connection == "Bluetooth" && priority_bluetooth) {
          MoveController duplicate_move = controllers.get(serial);
          String duplicate_connection = duplicate_move.get_connection_name(); // 
          overwrite(serial,move);
          if(debug) println("Found "+serial+" via "+connection+" (overwrote "+duplicate_connection+")");
        }
        else {
          if(debug) println("Found "+serial+" via "+connection+" (duplicate ignored)");
        }
      }
    }
    //init_serial_array(controllers);
  }
  
  // Replace the duplicate of the specified controller in all lists
  void overwrite(String serial, MoveController move) {
    controllers.put(serial, move);     // Overwrite the controller at this id
    // Find the controller with the same serial in ordered_list and overwrite it
    for(int i=0; i<ordered_controllers.size(); i++) { // Loop through the ordered controllers
      MoveController m = ordered_controllers.get(i);
      String registeredSerial = m.get_serial();
      if (registeredSerial.equals(serial)) { // Is it the same controller?
        ordered_controllers.set(i,move); // replace the controller at this position by the new one
      }  
  }
  }
  
  void update() {
    if(!controllers.isEmpty()) { // Do we actually have controllers to update?
      for (String id: controllers.keySet()) {
        MoveController move = controllers.get(id);     // Give me the controller with that MAC address
        move.update();
      }
    }
  }
  
  void shutdown() {
    if(!controllers.isEmpty()) { // Do we actually have controllers to shut down?
      for (String id: controllers.keySet()) {
        MoveController move = controllers.get(id);     // Give me the controller with that MAC address
        move.shutdown();
      }
    }
  }
  
   // Print debug messages?
  void debug(boolean b) {
    debug = b;
      for (String id: controllers.keySet()) {
        MoveController move = controllers.get(id);     // Give me the controller with that MAC address
        move.debug(b);
      }
  }

  // --- Getters & Setters ----------------------
  
  int get_controller_count() {
   return unique_connected;
  }
  
  // Return the Mac adress of a given controller
  String get_serial(int i) {
    int iterator = 0;
    String serial = "";
    for (String id: controllers.keySet()) {
      if(iterator==i)
        serial = id;
      else
        if(debug) serial = "error in get_serial()";
      iterator++;
    }
    return serial;
  }
  
  Set get_serials() {
   Set serials = controllers.keySet();
   return serials; 
  }
  
  // Get the controller with a given MAC adress
  MoveController getController(String id) {
    if(controllers.containsKey(id)) { // Did we register a controller with that serial?
      MoveController m = controllers.get(id);
      return m;
    }
    if(debug) println("Error in getController(String id): no MoveController with serial "+id);
    return ordered_controllers.get(0);
  }
  
  // Get the controller at a given index
  MoveController getController(int i) {
    if(i>=0 && i < ordered_controllers.size()) { // Is the index valid?
      MoveController m = ordered_controllers.get(i);
      return m;
    }
    if(debug) println("Error in getController(int i): index is out of range (i = "+i+") while ordered_controllers.size() = "+ordered_controllers.size());
    if(debug) println("Returning first connected.");
    return ordered_controllers.get(0);
  }

}
