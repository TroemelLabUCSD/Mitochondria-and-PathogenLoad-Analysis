// Prompt user for file directory
input = getDirectory("Select the directory containing the .czi images");



// Get list of files in the directory
list = getFileList(input);

// Iterate through each image file
for (i = 0; i < list.length; i++) {
    // Open .lsm image
    open(input + list[i]);
    //This assumes images were taken with GFP as channel =0, and TMPT=1
// The brightfield image is not needed. Thus we close it- because FIJI cannot obtain file names, it opens the brightfield last.
// Thus we can just close it:
    close();

    // Get image name and save as image_number
    image_number = getTitle();

    // Set X unit to microns
    run("Set Scale...", "distance=1 known=0.06761 unit=microns");

    // Set image properties
    run("Properties...", "channels=1 slices=1 frames=1 pixel_width=0.06761 pixel_height=0.06761 voxel_depth=0");

   
    // Convert to 8-bit
    run("8-bit");

    // Iterate twice for each image
    for (j = 0; j < 2; j++) {
        // Prompt user to create a rectangle ROI
        showMessage("Please create a rectangle ROI on the image.");
        run("ROI Manager...");
        roiManager("reset");

        // Wait for the user to create the rectangle ROI
        waitForUser("Create ROI");

        // Duplicate ROI
        run("Duplicate...", "title=roi");

        // Duplicate the image and save as roi_raw
        selectWindow("roi");
        run("Duplicate...", "title=" + image_number + "_roi_raw");
        saveAs("Tiff", input + "file_" + image_number + "_" + (j + 1) + "_roi_raw" + ".tif");
        selectWindow("roi");

        // Subtract background
        run("Subtract Background...", "rolling=13");

        // Apply Sigma Filter
        run("Sigma Filter Plus", "radius=1.5 use=2 minimum=0.2");

        // Enhance Local Contrast (CLAHE)
        run("Enhance Local Contrast (CLAHE)", "blocksize=71 histogram=256 maximum=2 mask=*None*");
        run("Enhance Local Contrast (CLAHE)", "blocksize=71 histogram=256 maximum=2 mask=*None*");

        // Apply 2D Threshold
        run("2D Threshold", "subtract rolling=2 sigma radius=2 enhance max=2 adjust gamma=0.80 method=[Weighted Mean] block=1.85 c-value=1.9 despeckle remove outlier=1.5");

        // Select thresholded ROI window
        selectWindow("roi thresholded");

        // Prompt the user whether to run Despeckle
        despeckle = getBoolean("Perform Despeckle?");
        if (despeckle) {
            run("Despeckle");
        }

        // Prompt user to choose Fill Holes option
        fillHoles = getBoolean("Perform Fill Holes?");
        if (fillHoles) {
            run("Fill Holes");
        }

        // Perform 2D Analysis
        run("2D Analysis", "perform count total mean total_0 mean_0 mean_1 mean_2 branches total_1 mean_3 branch branch_0 mean_4 if=Count perform_0 area perimeter form aspect branches_0 total_2 mean_5 branch_1 branch_2 mean_6 longest mask=None mask_0=Mask second=None second_0=[Channel 2] third=None third_0=[Channel 3] =None to=None then=None");

        // Select thresholded ROI window
        selectWindow("roi thresholded");

        // Save ROI thresholded window as file_number.tif
        saveAs("Tiff", input + "file_" + image_number + "_" + (j + 1) + ".tif");

        // Select 2D Analysis Data
        selectWindow("2D Analysis Data - per Cell");

        // Save 2D Analysis Data window as file_number_2d_analysis_per_cell.csv
        saveAs("Results", input + "file_" + image_number + "_" + (j + 1) + "_2d_analysis_per_cell.csv");
        selectWindow(image_number);
        // Close all windows except the original image
        close("\\Others");

        // Wait for a short period before proceeding to the next iteration
        wait(1000);
        //test
    }

    // Close the original image
    close();
}
