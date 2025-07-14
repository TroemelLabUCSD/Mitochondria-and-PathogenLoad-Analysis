**Mitochondria Network Analysis Protocol with Mitochondria Analyzer in FIJI** 
By Spencer Gang
Updated: 2-22-2023
Modified from a protocol developed by Dr. Richard Sanchez (Gulcin Pekkurnaz’s Lab)

**Processing raw images**
1. Open .lsm image from Zeiss confocal (63x objective, 3x digital zoom, 33.87 x 33.87.40 uM = 512x512
pixel)
2. Image -> Properties -> Change units to say "microns" instead of "um" - the Mitochondria Analyzer
requires "microns" (change pixel width AND height = 0.0661555 "micron"...Voxel depth = 0). Check
global box ON and should be applied to subsequent images analyzed in the same session.
3. Type -> 8 bit greyscale *if not already 8-bit, depends on how the .lsm file was saved on the Zeiss
software
4. Image -> Stacks -> Stack to Image -> delete the PMT image and just keep fluorescence
5. Select ROI with the polygon selection tool (150pixels x 150pixels = ~10 x 10 uM square area)
6. Image -> Duplicate (should make a separate square image of the ROI)
7. Image -> Duplicate again and use this one to do downstream processing. If a mistake is made, can go
back to image in #6 and repeat the process

**Pre-processing cropped Image**
1. Subtract background ([Process-->subtract background] 1uM rolling ball radius) 15 pixels = 1 uM
2. Sigma Filter Plus ([Plugins-->Sigma Filter Plus] Radius= 0.1uM (1.5 pixels), Use pixels within= 2.0
sigmas Minimum Pixel Fraction= 0.2)
3. Enhance local contrast ([Process-->Enhance Local Contrast (CLACHE)] Blocksize:63, Histogram 256,
Maximum slope:2 (1.25 for 3D), Mask: None), uncheck fast (less accurate) box. *Repeat this step twice (I
found it gives more accurate mito masking below)
4. Gamma correction ([Process--> Math--> Gamma] Value=0.8, 0.9 3D)

**Making binary mask with Mitochondria Analyzer**
1. Plugins -> Mitochondria Analyzer -> Open Analyzer Manager
2. For first image, select 2D Threshold optimize and allow the program to run. Then ID image that best
matches. Use these settings for subsequent images of the same genotype.
3. Select 2D Threshold, use settings below based on thresholding *still may need adjusting: Block size =
1.4 microns C-Value = 7 *all others standard
4. May need to despeckle again (Process -> Noise -> Despeckle) *note, very small speckles will not be
recognized as mitos anyway.
5. May need to fill holes, however be careful that you are not filling holes that are actually part of the mito
network (Process -> Binary -> Fill Holes)
6. 2D analysis -> perform on per-mitochondria basis AND on per-cell(full ROI) basis -> select all on.
Select threshold image as mask to use for analysis
7. Mitochondria Analyzer Manager Window -> Display 2D Mito ROIs -> labels ON -> show all ON
8. Save Analysis Tables to Excel
9. Take a screen shot of image analysis + save to Excel with raw data. Also save the mask as a .png
which can be re-opened in FIJI and analyzed again with MA if needed.
10. Repeat procedure for additional ROIs from the same worm if desired.
