#code by Max Strul with help from ChatGPT
#Note, to obtain input data you need to first process data using the ImageXpress software running the analysis plugin and analyze all wells
#then you need to export data and obtain well name and "cell value" for "average intensity worm". You may choose to export multiple other values
#such as size, but you need to only input a csv file with just the following:
#this code is made to take in a file the "inputcsv" file which should be a total of two columns:
#Column 1: [Well Name] & Column 2: [Cell: Average Intensity Worm]

#A few more notes:
#When you run this file, be sure to make a copy and rename the output otherwise it will be overwritten as you re-run this.

#you can use this same code for multiple input files but each time you must change the input file and it is recommended to change the output file as well with correct date and replicate number


import pandas as pd

def reshape_csv(input_file, output_file):
    # Read CSV file
    df = pd.read_csv(input_file, header=None, names=["Group", "Value"])
    
    # Pivot data to create separate columns for each group
    df_pivot = df.groupby("Group")["Value"].apply(list).reset_index()
    
    # Find the maximum length of value lists
    max_len = max(df_pivot["Value"].apply(len))
    
    # Expand lists into separate rows
    df_expanded = pd.DataFrame({g: v + [None] * (max_len - len(v)) for g, v in zip(df_pivot["Group"], df_pivot["Value"])} )
    
    # Save to CSV
    df_expanded.to_csv(output_file, index=False)
    
# Example usage:
# reshape_csv("input.csv", "output.csv")

reshape_csv("INSERTCSVFILEherewithcolumn1wellID_column2_averageintensity", "F2_output_DATE_repNUMBER.csv")
