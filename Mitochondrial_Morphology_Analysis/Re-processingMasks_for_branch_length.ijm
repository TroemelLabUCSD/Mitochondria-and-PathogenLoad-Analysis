input = getDirectory("Select the directory containing the .lsm images");

// Get list of files in the directory
list = getFileList(input);

// Iterate through each image file
for (i = 0; i < list.length; i++) {
    // Open .lsm image
    open(input + list[i]);

    // Get the file name without the extension
    fileName = list[i].substring(0, list[i].lastIndexOf("."));

    // Perform 2D analysis with the specified settings
    run("2D Analysis", "perform count total mean total_0 mean_0 mean_1 mean_2 branches total_1 mean_3 branch branch_0 mean_4 if=Count area perimeter form aspect branches_0 total_2 mean_5 branch_1 branch_2 mean_6 longest mask=None mask_0=Mask second=None second_0=[Channel 2] third=None third_0=[Channel 3] =None to=None then=None");

    // Save the results to a CSV file with the same name as the image
    saveAs("Results", input + fileName + ".csv");

    // Close the image
    close();
}
