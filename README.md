# AlphaFader

AlphaFader is an Aegisub script that add a **fade effect** to selected lines using \alpha tag. Primarily used for Frame by Frame lines.

Right now the GUI has 3 options. (The FaderIn.lua and the FaderOut.lua can be download and use without gui) 

## How to use

### Fade in
1. Find the first line where your sign is start appear.
2. Find the line where the sign complete visible for the first time.
3. Select the lines between them included the lines from the first 2 step.
4. Run the script.

It's create a fade in effect based on how many line was selected.

### Fade out
Same as Fade in but it makes a fade out effect

### Gradient fade in
Gradient fade in is useful, if you have a Gradient sign that move by a mocha tracking data and you need to add this a fade in effect.

1. Add gradient to a text using [Gradient Everthing](https://github.com/TypesettingTools/lyger-Aegisub-Scripts/blob/master/macros/lyger.GradientEverything.moon) or a similar script.
2. Apply the tracking data to the gradient sign's lines.
3. Selected all the sign's line and open the GUI.
4. Set the frame duration. (Can't be bigger than the tracking data framecount)
5. Run the script.

### Gradient fade out
Will be implemented later.