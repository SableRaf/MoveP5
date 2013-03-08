This is a first draft of a standard for OSC transmission address patterns for the Playstation Move Controller.

Tracker-global properties
-------------------------
/tracker/controllers  [integer, 0..n]

Serial (type String) [MAC address in the format: "xx:xx:xx:xx:xx:xx"]
--------------------------------------------
/move/0/serial

Buttons (type Float)  [0.0 = released, 1.0 = pressed]
--------------------------------------------
/move/0/buttons/square 
/move/0/buttons/move 
/move/0/buttons/ps 
/move/0/buttons/select 
/move/0/buttons/triangle 
/move/0/buttons/circle
/move/0/buttons/start 
/move/0/buttons/cross 

Trigger (type Float) [between 0.0 and 255.0]
--------------------------------------------
/move/0/buttons/triggerValue 

Sensors (type Float) [between -1.0 and 1.0]
--------------------------------------------
/move/0/sensors/acc/x 
/move/0/sensors/acc/y 
/move/0/sensors/acc/z 

/move/0/sensors/mag/x
/move/0/sensors/mag/y
/move/0/sensors/mag/z 

/move/0/sensors/gyro/x
/move/0/sensors/gyro/y
/move/0/sensors/gyro/z 

Orientation (Float) [not available yet]
--------------------------------------------
/move/0/orientation/quat/0
/move/0/orientation/quat/1 
/move/0/orientation/quat/2 
/move/0/orientation/quat/3

Raw Position (type Float) [not yet implemented]
-----------------------------------------------
/move/0/position/raw/x
/move/0/position/raw/y
/move/0/position/raw/r

3D Position (type Float) [not yet implemented]
----------------------------------------------
/move/0/position/3d/x
/move/0/position/3d/y
/move/0/position/3d/z

Note:
The zero in /move/0/ is the order number of the controllers.
It then goes /move/1/, /move/2/, /move/3/, etc.

The number of currently-connected controllers is broadcast
using /tracker/controllers.

