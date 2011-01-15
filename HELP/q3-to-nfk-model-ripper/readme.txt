Quake 3 Model Loader
--------------------

This program is designed to load and display the quake 3 model files (.MD3 files). It loads all model data, textures and animation sequences.

With Quake 3 models the upper and lower sections of the models behave separately. So you can get you model to walk run or swim while changing the torso animation from gesture, attack or idle.

I have attached a MD3 file format article (don’t know the original author) incase you want to find out more about the file format.

I have placed the project up on my site, but I still plan to make some changes because there are a few things that I am still not happy about.
 1.) There is a slight vibration in the head animation. Don’t know why.
 2.) With the current procedure for drawing the model, there is good interpolation for the torso and head, but not for the legs. When doing the backwards jump it is quite evident.
 3.) The upper and lower sections don’t always stick together. This can be seen when the model is jumping.

I should also mention the MD3loader implementation that lonerunner did, because without his matrix to quaternion and quaternion to matrix conversions and the drawing using interpolation, it would have taken much longer to get this working.


Keys :
 - A and S : Select next and previous Torso animation
 - Z and X : Select next and previous Legs animation
 - F : Enable/Disable text display for current frame
 - W : Toggle wireframe / Textures drawing


If you have any queries or bug reports, please mail me

Code : Jan Horn
Mail : jhorn@global.co.za
Web  : http://www.sulaco.co.za
       http://home.global.co.za/~jhorn
