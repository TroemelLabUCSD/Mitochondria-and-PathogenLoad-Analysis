First step is to download all nesecary code files, specifically the fiji macros or files ending with .ijm

These confocal images MUST be TWO channel only, bight field "T PMT" and a single fluorecent channel, in this case green was used so it is listed as "Ch2 (G)"

Next, you will create a new folder. You can title this "Analysis_folder_1_experimentINformation" where you can replace experiment information with any other relevent information for your own experiment.

Next, copy your zeiss confocal files into this folder. these should be in the .lsm format.

Next, you can open a fiji macro by draging and dropping the fiji macro into fiji.

Step 1:
drag in the macro: save_both_raw_ROI_ver_5_mitochondria_analyzer_macro_not_used_7_25_2023.ijm #update for ver5 or ver4 after testing on multiple OS systems --> as of 07/11/2025 ver 5 works well.
# update 07-14-2025: ver_5 file name was updated because this file was tested and works best on listed software and OS. 

Click "Run" and it should open up a dialogue to select the folder of images. 

Double click on the folder to open the directory.

You should see all your .lsm files here.

Then you will click "open" in the bottom right

Then it will open the first image in the stack.

It will bright to the front the "Ch2 (G)" which should be your fluorescent channel. 

It will ask you "Please create a rectangle ROI on the image"

Click "OK"

Then it will open up an "ROI" manager. and it will prompt "Create ROI" - DO NOT click OKAY on the next diaglogue yet 

To select your region of interest, you can hold down shift to create a square of the desired size anywhere in your image. Once you are satisfied with the square, click OK.

Then it will process which the time will vary based on OS and system resources.

There should be a small window called 'roi' which should show the mask image that is currently being generated. 

Next it will prompt you to "Perform despeckle?" which you can do if your image has too much background noise and looks like lots of little dots. In most cases if your image settins are good you can click "no". You should click yes if you see lots of little dots that don't correstpond to signal

Next it will ask "Perform fill holes?" which similarly can be performed if there was a poor signal to noise in which case your image migth show lots of holes which you may not want because its not accurately depicting the mask

Then when you click yes or no for perform fill holes, the mitochondrial morphology analyzer should complete the processing and will save the ROI raw, the ROI mask, and the ROI csv for the morphology. 


Repeat the steps where each image will be prompted to make two ROIs.
Once you process all your ROIs for all your images proceed to use the next fiji macro which will re-process the masks from the raw files to ensure all CSV components are saved properly.

Then afterwardss you can use the R script. to concatinate all your csv files into one larger csv file for easier data visualization.

