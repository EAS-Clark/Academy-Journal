#!/usr/bin/python3
import os
import sys

def process_dir(directory, series, season, episode=1, chdir=True):
    counter = episode
    if chdir:
        os.mkdir("Season " + str(season))
    for file in os.listdir():
        if os.path.isfile(file):
            ext = str(file).split('.')[-1]
            src = directory + "/" + file
            new_name = series + " - S" + str(season).rjust(2, '0') + "E" + str(counter).rjust(2, '0') + "." + ext
            if chdir:
                new_name = "Season " + str(season) + "/" + new_name
            dest = directory + "/" + new_name
            os.rename(src, dest)
            counter+=1

if __name__ == "__main__":
    dir = os.getcwd()
    args = sys.argv
    mkdir = True
    if "-nd" in args:
        args.remove("-nd")
        mkdir = False
    if len(args) < 3:
        print("Incorrect Usage: rename [-nd] {Show} {Season} [episode]")
    elif len(args) == 4:
        process_dir(dir, args[1], args[2], int(args[3]), mkdir)
    else:
        process_dir(dir, args[1], args[2], chdir=mkdir)
    print("Task Completed Successfully")
