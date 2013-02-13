MoveP5
=====

Prototype for an extended Processing PS Move lib based on the PS Move API
By Raphael de Courville (Twitter: @sableRaph)


WHY?
----
The standard psmove library is a binding of the PS Move API by Thomas Perl (http://thp.io/2010/psmove/) that gets automatically compiled from the original C code using SWIG. It works great but I wanted to make it more Processing-friendly and abstract the connection to the controllers.

For example, the following code...

long [] pressed = {0};
long [] released = {0};
PSMove.get_button_events(pressed, released);
while (PSMove.poll() != 0) {}
if ((pressed[0] & Button.Btn_SELECT.swigValue()) != 0)
  move.set_leds(0,150,255);


... can be replaced by this:

if (move.isSelectPressedEvent())
  move.set_leds(0,150,255);


This is a work in progress and any feedback is welcome. Feel free to write your comments in the Issues section.

You can read about the functions available in the original Processing lib here: http://goo.gl/hyfQf



TO DO:
------

- Provide a GUI to monitor the controllers
- Add support for camera tracking and sensor fusion
- Build into a real Processing library
- Proper documentation


HOW TO GET YOUR MOVE CONTROLLER TO WORK ON YOUR (MacOS) COMPUTER
----------------------------------------------------------------

Douglas Wilson created a pairing utility for the PS Move. Get it by downloading
uniMove : http://www.copenhagengamecollective.org/projects/unimove/
Extract the package and get to the folder called "Pairing Utility".


COMPATIBILITY
-------------

So far, the psmove lib works on MacOS 10.7.5 only. It will hopefully also be available for Linux and Windows eventually.


MORE INFORMATION
----------------

License: Simplified BSD-style license (see COPYING)