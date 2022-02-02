#!/usr/bin/python3
from pymediainfo import *
import os
import sys
import csv

allowed_files = ['.mkv', '.mp4']


def process_dataset(dataset, header=True):
    dual, eng, jp, err = None, None, None, False
    res = [['Series', 'Season', 'Total Episodes', 'Dual Audio', 'English', 'Japanese', 'Errored']]
    episode_count = 0
    curr_series = ""
    curr_season = -1
    for row in dataset:
        if header:
            header = False
            continue
        print("Processing data for: " + row[0] + ": Season " + row[1] + ", Episode " + row[2])
        # If On Different Series
        if row[0] != curr_series and curr_series != "":
            res.append([curr_series, curr_season, episode_count, dual, eng, jp, err])
            dual, eng, jp, err = None, None, None, False
            curr_season = -1
            episode_count = 0
            curr_series = ""
        # If No Series is Set
        if curr_series == "":
            curr_series = row[0]
        # If On Different Season
        if curr_season != row[1] and curr_season != -1:
            res.append([curr_series, curr_season, episode_count, dual, eng, jp, err])
            dual, eng, jp, err = None, None, None, False
            episode_count = 0
            curr_season = -1
        if curr_season == -1:
            curr_season = row[1]
        episode_count += 1
        if dual is None or eng is None or jp is None:
            eng = row[6] == 'True'
            jp = row[7] == 'True'
            dual = eng and jp
        elif err:
            continue
        else:
            if eng != (row[6] == 'True') or jp != (row[7] == 'True'):
                err = True
    res.append([curr_series, curr_season, episode_count, dual, eng, jp, err])
    with open('processed.csv', 'w+', newline='') as f:
        writer = csv.writer(f)
        writer.writerows(res)


def extract_from_name(filename):
    ext = filename.rsplit('.', 1)[1]
    name = filename.rsplit('.', 1)[0]
    # noinspection PyTypeChecker
    series = name.rsplit(' - ', 1)[0].strip()
    # noinspection PyTypeChecker
    season = name.rsplit(' - ', 1)[1][1:3].strip()
    # noinspection PyTypeChecker
    episode = name.rsplit(' - ', 1)[1][-2:].strip()
    return [series, season, episode, ext]


def process_dir(directory):
    # Setup Header #
    res = [['Series', 'Season', 'Episode', 'Extension', 'Width', 'Height', 'English', 'Japanese']]
    for r, d, f in os.walk(directory):
        for file in f:
            for ext in allowed_files:
                if ext in file:
                    print("Processing File: " + file)
                    f_info = MediaInfo.parse(os.path.join(r, file))
                    info = extract_from_name(file)
                    lang_arr = []
                    w, h = 0, 0
                    for track in f_info.tracks:
                        if track.track_type == 'Audio':
                            lang_arr.append(track.language)
                        elif track.track_type == 'Video':
                            w = str(track.width)
                            h = str(track.height)
                    res.append([info[0], info[1], info[2], info[3], w, h, 'en' in lang_arr, 'ja' in lang_arr])
                    break
    with open('raw_data.csv', 'w+', newline='') as f:
        writer = csv.writer(f)
        writer.writerows(res)
    process_dataset(res)


if __name__ == "__main__":
    args = sys.argv
    if len(args) < 2:
        process_dir(os.getcwd())
    else:
        process_dir(args[1])

