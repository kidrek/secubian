import csv 
import glob
import json 
import logging
import os

# Convert csv file to json
def csv_to_json(csvFilePath, jsonFilePath):
    logging.info(f"Convert {csvFilePath} to {jsonFilePath}")
    jsonArray = []
      
    with open(csvFilePath, encoding='utf-8') as csvf: 
        csvReader = csv.DictReader(csvf) 

        for row in csvReader: 
            jsonArray.append(row)
  
    with open(jsonFilePath, 'w', encoding='utf-8') as jsonf: 
        jsonString = json.dumps(jsonArray, indent=4)
        jsonf.write(jsonString)

# List all file with specific extension
def list_file(currentPath:str, extension:str) -> list:
    logging.info(f"List all ({extension}) files in [{currentPath}] directory")
    os.chdir( currentPath )
    return glob.glob( f"*/**.{extension}" )

# Set logging settings
def loggingSetup(currentPath:str) -> None:
    # Set the format for logging info
    logging.basicConfig(filename=f"{cwd}/csv_to_json.log",
                        level=logging.INFO,
                        encoding='utf-8',
                        format='%(asctime)s - %(message)s',
                        datefmt='%Y-%m-%d %H:%M:%S')

if __name__ == "__main__":
    
    # Retrieve current path
    cwd = os.getcwd()
 
    # Define logging settings
    loggingSetup(cwd)
    logging.info('Process is starting')

    # List all csv files in current directory
    for csvFilePath in list_file(cwd, 'csv'):
        jsonFilePath = f"{csvFilePath[:-4]}.json"
        csv_to_json(csvFilePath, jsonFilePath)


    # Logging end of process
    logging.info('Process done')

