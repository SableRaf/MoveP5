class MoveButton {

  boolean isPressed;
  //boolean isPressedEvent, isReleasedEvent;
  int value, previousValue; // For analog buttons only (triggers)
  PVector analog; // For analog sticks (navigation controller only)
  
  // We store multiple catchers for the event in case we need to make 
  // several queries; the event catcher is set to false after the query 
  // so we can only use each event catcher once. To do so, we can use 
  // isPressedEvent(i) where i is the id of the catcher.
  boolean[] pressedEvents;
  boolean[] releasedEvents;

  MoveButton() {
    isPressed = false;
    pressedEvents = new boolean[64];
    releasedEvents = new boolean[64];
    value = 0;
    analog = new PVector(0,0);
  }

  void press() {
    isPressed = true;
  }

  void release() { 
    isPressed = false;
  }
  
  void eventPress() {
    for(int i=0; i < pressedEvents.length; i++) {
      pressedEvents[i] = true; // update all the event catchers
    }
  }
  
  void eventRelease() {
    for(int i=0; i < releasedEvents.length; i++) {
      releasedEvents[i] = true; // update all the event catchers
    }
  }
  
  boolean isPressedEvent() {
    if(pressedEvents[0]) {
      pressedEvents[0] = false; // Reset the main event catcher
      return true;
    }
    return false;
  }
  
  boolean isReleasedEvent() {
    if(releasedEvents[0]) {
      releasedEvents[0] = false; // Reset the main event catcher
      return true;
    }
    return false;
  }
  
  boolean isPressedEvent(int i) {
    if(pressedEvents[i]) {
      pressedEvents[i] = false; // Reset the selected event catcher
      return true;
    }
    return false;
  }
  
  boolean isReleasedEvent(int i) {
    if(releasedEvents[i]) {
      releasedEvents[i] = false; // Reset the selected event catcher
      return true;
    }
    return false;
  }
  
  boolean isPressed() {
    return isPressed;
  }

  void setValue(int _val) { 
    previousValue = value;
    value = _val;
  }
  
  int getValue() {    
    return value;
  }
  
  void setAnalog(float _x, float _y) {
    analog.x = _x;
    analog.y = _y;
  }
  
  PVector getAnalog() {
    return analog;
  }
}
