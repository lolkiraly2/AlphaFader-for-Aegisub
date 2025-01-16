# AlphaFader

AlphaFader is an Aegisub script that add a **fade effect** to selected lines using \alpha tag. Primarily used for Frame by Frame lines.

Right now it has 3 options.

## AlphaFaderIn
1. Find the first line when your sign is start appear.
2. Find the line where the sign complete visible after the fade in.
3. Select the lines between them included the lines from the first 2 to step.
4. Run the script.

It's create a fade in effect based on how many line was selected.

## AlphaFaderOut
Same as AlphaFaderIn but it make a fade out effect

## AlphaFaderGrad
AlphaFaderGrad can be used when you have a Gradient sign that has movement from mocha track data and you need to add this a fade in effect.
How it looks like step by step:
1. Add gradient to a text using [Gradient Everthing](https://github.com/TypesettingTools/lyger-Aegisub-Scripts/blob/master/macros/lyger.GradientEverything.moon) or a similar script.
2. Apply the tracking data to the gradient sign's lines.
3. Now you have to modify the **frame** variable number (on line 22) to the duration of the fade effect (like in the first 2 case it was the selected lines count)
4. Selected all the sign's line and run the script.
