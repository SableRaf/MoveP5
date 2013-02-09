
// http://opensoundcontrol.org/files/osc-best-practices-final.pdf

import oscP5.*;
import netP5.*;  
OscP5 oscP5;
NetAddress myRemoteLocation;
  
OscBundle myBundle;   // Unique container for all the messages
OscMessage myMessage; // Reusable message object

class OscManager {
  
  private boolean debug;

  OscManager(Object sketch, int listeningPort, int sendingPort) {
    init(sketch, listeningPort, sendingPort);
  }
  
  private void init(Object sketch, int listeningPort, int sendingPort) {
    OscProperties properties = new OscProperties();
    properties.setListeningPort(listeningPort);
    properties.setDatagramSize(99999999); // make the datagrampacket byte buffer larger
    
    println("---------------------------------------------------------------------------------------------------");
    oscP5 = new OscP5(sketch, properties);
    println("---------------------------------------------------------------------------------------------------");

    /* myRemoteLocation is a NetAddress. a NetAddress takes 2 parameters,
     * an ip address and a port number. myRemoteLocation is used as parameter in
     * oscP5.send() when sending osc packets to another computer, device, 
     * application. usage see below.
     */
    myRemoteLocation = new NetAddress("127.0.0.1", sendingPort);
    
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
    myMessage.add(serial);
    //println("/move/"+index+"/serial = "+serial);
    myBundle.add(myMessage);
    
    // reset and clear the myMessage object for refill
    myMessage.clear();
    
    // Parse the list to extract the readings
    for(String pattern : data.keySet() ) {
      float value = data.get(pattern); // get the value corresponding to that key
      myMessage = buildFloatMessage(index, pattern, value);
      // add the osc message to the osc bundle
      myBundle.add(myMessage);
      myMessage.clear();
    }
    myBundle.setTimetag(myBundle.now());// + 10000);
    //println("===============================");
  }
  
  protected OscMessage buildFloatMessage(int _index, String _pattern, float _value) {
    int index = _index;
    String pattern = _pattern;
    float value = _value;
    
    // create an new osc message object
    OscMessage floatMessage = new OscMessage("/move/"+index+"/"+pattern);
    //println("/move/"+index+"/"+pattern+" = "+value);
    
    // fill the osc message object with the float
    floatMessage.add(value);
   
    return floatMessage;
  }
  
  public void sendBundle() {
    // send the message
    //if(debug) println("OscManager.sendBundle()");
    
    // send the osc bundle, containing all osc messages, to a remote location.
    oscP5.send(myBundle, myRemoteLocation);
    myBundle.clear();
  }

  
  //--- Setters ------------------------------------
  
  public void debug(boolean b) {
    debug = b;
  }
  
  /*
  public void setSendingPort(int sPort) {
    //sendingPort = sPort;
  }
  
  public void setListeningPort(int lPort) {
    //listeningPort = lPort;
  }
  
  public void setRemoteAddress(String rAddress) {
    //remoteAddress = rAddress;
  }
  
  //--- Getters ------------------------------------
  
  public MoveManager getMoveManager() {
    //return moveManager;
  }
  
  public int getSendingPort() {
    //return sendingPort;
  }
  
  public int getListeningPort() {
    //return listeningPort;
  }
  
  public String getRemoteAddress() {
    //return remoteAddress;
  }
*/
}

// Reading OSC messages (For debug only)


// incoming osc message are forwarded to the oscEvent method.
void oscEvent(OscMessage theOscMessage) {
  // print the address pattern and the typetag of the received OscMessage
  //print("### received an osc message.");
  print(theOscMessage.addrPattern());
  //println(" timetag: "+theOscMessage.timetag());
  if(theOscMessage.checkTypetag("s"))
    println(" value: "+theOscMessage.get(0).stringValue());
  if(theOscMessage.checkTypetag("f"))
    println(" value: "+theOscMessage.get(0).floatValue());
}

