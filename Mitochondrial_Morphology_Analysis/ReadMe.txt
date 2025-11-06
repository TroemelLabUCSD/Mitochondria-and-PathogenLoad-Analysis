This subfolder contains all files required for the mitochondrial morphology analysis 

Please review .pdf manual to ensure all Fiji plugins are correctly installed

Please note that .czi files and .lsm files are processed differently. 

For .lsm files please use "save_both_raw_ROI_ver_5..." 

For .czi files please use "

Two notes on using this code for your own analysis: before proceeding with ReadMeStep1.txt to begin analysis - please be aware that different experimental conditions may require slightly modified masking conditions. There are a numner of steps that can be optimized, namely "Block size" and "C-value". Additional steps or less steps of "Enhance local contrast" can also be added or removed depending on imaging conditions. Please be aware that when comparing between treatments, mutants, or different conditions, you can only compare them if the masking was performed the same way. 
Lastly, in the .ijm fiji macro files there are settings for image properties - to properly set image properties you need to consult your image metadata and ensure that the correct sizes are input for your imaging conditions.

Specific settings are explained in more detail in the Mitochondria Analyzer Manual - see for troubleshooting

