# BME 271 Final Project
## Multi-Image Super-Resolution
### Reed Chen, Andrew Liu, Advaita Singh

In this project, 4 datasets are provided: Stars, Circles, Skeletons, and Pictures. To run the code, go to main.m and uncomment one line in lines 9-12 corresponding to the desired dataset.

The scaling factor, or the factor you want to upsample by, is set to a default of 2 but can be modified by changing line 17. 

Running main.m yields 3 figures, where figure 3, the "Final Averaged Image", is the super-resolved image.

Analysis code is also included in this project. To run analysis.m, first run main.m. After running main.m, and without clearing any workspace variables, go to analysis.m and uncomment one line in lines 8-11 corresponding to the dataset used in main.m. The analysis works best for image datasets that have
the same size. This includes the star dataset, skeleton dataset, and picture dataset, but not the circle dataset. Additionally, the FRC analysis only works for square images with the same dimensions, so only the star dataset. 

The FSC.m and kaizer_bessel.m files used for FRC analysis were taken from the following github repo: https://github.com/bionanoimaging/cellSTORM-MATLAB/blob/master/Functions/FSC.m
