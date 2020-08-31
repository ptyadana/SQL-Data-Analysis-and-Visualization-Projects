# Update Character Name in uppercase for every line in plays
# example: "Now, fair Hippolyta, our nuptial hour" => Now, fair HIPPOLYTA, our nuptial hour


import pymysql
import time

myConnection = pymysql.connect(
    host="localhost", user="root", password="root", db="shakespeare")

cur = myConnection.cursor()
start_time = time.time()

# Part 1: Update Character Name in uppercase for every line in plays
updateSQL = "UPDATE amnd SET play_text = REPLACE(play_text, %s, %s);"

with open("datasets/characters.txt", "r") as char:
    for character in char.read().splitlines():
        print("capitalizing occurences of ", character)
        updateStrings = character.capitalize(), character.upper()
        cur.execute(updateSQL, updateStrings)

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
insertPerformanceSQL = "INSERT INTO performance VALUES('UPDATE',%s);"
cur.execute(insertPerformanceSQL, queryTimePerLine)

myConnection.commit()
myConnection.close()
