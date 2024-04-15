# Project_SIR-Disease-model
Models the spread of a virus among an arbitrary population. Code is in MatLab.

To run, simply execute run_project3.m. 

Parameters are currently set to what the technical report and executive summary were based on. You can change the beta, gamma, delta, epsilon, q, and v parameters as you wish. Parameters S0, I0, R0, D0 should always be set such that S0+I0+R0+D0=100, though. 

As output, you should have sensitivities of parameters output to terminal, 8 figures representing the ODEs with current parameter levels, and 8 gif files representing the ODEs with varied beta, delta, and epsilon levels. 

ERROR CHECKING:
One of the main errors you get when running this is that either the figures OR the gifs don't output. 
This is most likely happening because you're trying to run this program in MATLAB online. Download MATLAB's offline version and try to run the program again. It should work. 
If you're already running on the offline version of MATLAB, you could be having permission errors.
