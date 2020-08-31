# read data from two text files and load the data into databases

import pymysql
import time

myConnection = pymysql.connect(
    host="localhost", user="root", password="root", db="shakespeare")

cur = myConnection.cursor()

# read character file and get all characters
with open("datasets/characters.txt", "r") as char:
    characterList = char.read().splitlines()

# as first character is unknown in Play file, initialize as Unknown
currentCharacter = "Unknown"

start_time = time.time()

createSQL = "INSERT INTO amnd(char_name, play_text) VALUES(%s, %s);"

# Part 1: process Play file text
# to Create a Record for each line in the play
# The character who is speaking
# The line number
# The phrase itself, trimmed of spaces
with open("datasets/A_Midsummer_Nights_Dream.txt", "r") as playlines:
    for line in playlines:
        if line.upper().strip() in characterList:
            currentCharacter = line.upper().strip()
            print("changing character to : ", currentCharacter)
        else:
            sql_values = currentCharacter, line.strip()
            print("writing line : ", sql_values)
            cur.execute(createSQL, sql_values)

myConnection.commit()
end_time = time.time()


# Part 2: process for Query Performance Calculation
cur.execute('SELECT COUNT(line_number) FROM amnd;')
numPlayLines = cur.fetchall()[0][0]
print(numPlayLines, 'rows')

# calculate query execution time
queryExecTime = end_time - start_time
print("Total query time: ", queryExecTime)

queryTimePerLine = queryExecTime / numPlayLines
print("Query time per line: ", queryTimePerLine)

# record query execution time into performance table
insertPerformanceSQL = "INSERT INTO performance VALUES('CREATE',%s);"
cur.execute(insertPerformanceSQL, queryTimePerLine)

myConnection.commit()
myConnection.close()
