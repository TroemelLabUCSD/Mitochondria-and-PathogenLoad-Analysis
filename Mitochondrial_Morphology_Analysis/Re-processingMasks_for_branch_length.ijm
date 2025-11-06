input = getDirectory("Select the directory containing the .lsm images");

// Get list of files in the directory
list = getFileList(input);

// Iterate through each image file
for (i = 0; i < list.length; i++) {
    // Open .lsm image
    open(input + list[i]);

    // Get the file name without the extension
    fileName = list[i].substring(0, list[i].lastIndexOf("."));

    // Set X unit to microns 
    // NOTE: the scale/ distance is specific to a microscope and objective - please check your image meta data for the scale before processing your own images
    run("Set Scale...", "distance=1 known=0.0661555 unit=microns");
    // Unit needs to be "microns" not "um" - please be aware

    // Set image properties
    // Note: Please double check your image metadata for the correct scaling/ size
    run("Properties...", "channels=1 slices=1 frames=1 pixel_width=0.0661555 pixel_height=0.0661555 voxel_depth=0");

    // Perform 2D analysis with the specified settings
    run("2D Analysis", "perform count total mean total_0 mean_0 mean_1 mean_2 branches total_1 mean_3 branch branch_0 mean_4 if=Count area perimeter form aspect branches_0 total_2 mean_5 branch_1 branch_2 mean_6 longest mask=None mask_0=Mask second=None second_0=[Channel 2] third=None third_0=[Channel 3] =None to=None then=None");

    // Save the results to a CSV file with the same name as the image
    saveAs("Results", input + fileName + ".csv");

    // Close the image
    close();
}
