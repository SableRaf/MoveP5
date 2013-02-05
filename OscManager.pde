
// Good 
// http://opensoundcontrol.org/files/osc-best-practices-final.pdf

import oscP5.*;
import netP5.*;

class OscManager {
  
  private boolean debug;
  
  OscBundle myBundle;    // Unique container for all the messages
  OscMessage myMessage; // Reusable message object
  
  int listeningPort = 8000; // Where do we expect messages to be sent to us?

  String remoteAddress = "127.0.0.1"; // Address (IP) of the receiver
  int sendingPort = 9000; // The port the receiver is listening to
  
  OscP5 oscP5;
  NetAddress myRemoteLocation;

  OscManager() {    
    oscP5 = new OscP5(this, listeningPort);
    myRemoteLocation = new NetAddress(remoteAddress, sendingPort);
    myBundle = new OscBundle();
  }
  
  OscManager(int lPort, String rAddress, int sPort) {
    setRemoteAddress(rAddress);
    setSendingPort(sPort);
    setListeningPort(lPort);
    
    oscP5 = new OscP5(this, listeningPort);
    myRemoteLocation = new NetAddress(remoteAddress, sendingPort);
    
    myBundle = new OscBundle();
    myMessage = new OscMessage("");
  }
  
  // Parse the readings and build the messages for one controller
  public void createBundle(int _index, String _serial, HashMap _data) {
    int index = _index;
    String serial = _serial;
    HashMap<String, Float> data = _data;
    
    // Add the serial message
    OscMessage myMessage = new OscMessage("/move/"+index+"/serial");
    myBundle.add(myMessage);
    
    // reset and clear the myMessage object for refill
    myMessage.clear();
    
    // Parse the list to extract the readings
    for(String pattern : data.keySet() ) {
      float value = data.get(pattern); // get the value corresponding to that key
      myMessage = buildFloatMessage(index, pattern, value);
      // add the osc message to the osc bundle
      myBundle.add(myMessage);
    }
  }
  
  protected OscMessage buildFloatMessage(int _index, String _pattern, float _value) {
    int index = _index;
    String pattern = _pattern;
    float value = _value;
    
    // create an new osc message object
    OscMessage floatMessage = new OscMessage("/move/"+index+"/"+pattern);
    
    // fill the osc message object with the float
    floatMessage.add(value);
   
    return floatMessage;
  }
  
  public void sendBundle() {
    // send the message
    if(debug) println("OscManager.sendBundle() (not actually sending anything yet)");
    //oscP5.send(myMessage, myRemoteLocation);
  }

  
  //--- Setters ------------------------------------
  
  public void setSendingPort(int sPort) {
    sendingPort = sPort;
  }
  
  public void setListeningPort(int lPort) {
    listeningPort = lPort;
  }
  
  public void setRemoteAddress(String rAddress) {
    remoteAddress = rAddress;
  }
  
  public void debug(boolean b) {
    debug = b;
  }
  
  //--- Getters ------------------------------------
  
  public MoveManager getMoveManager() {
    return moveManager;
  }
  
  public int getSendingPort() {
    return sendingPort;
  }
  
  public int getListeningPort() {
    return listeningPort;
  }
  
  public String getRemoteAddress() {
    return remoteAddress;
  }

}
