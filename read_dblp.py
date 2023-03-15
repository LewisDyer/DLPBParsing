import json
import sys
import pprint
from functools import partial


def parse_dblp_file(filename):
    is_first_line = True
    with open(filename) as f:
        for line in f:
            if is_first_line:
                is_first_line = False
                print('first line found')
                continue
            obj = line[:-2]
            #obj = line
            try:
                yield json.loads(obj)
            except json.decoder.JSONDecodeError:
                print("paper skipped due to decoding error")
                continue

i = 0
for paper in parse_dblp_file('dblp_v14.json'):
    #pprint.pprint(paper)
    i += 1
    if i % 100000 == 0:
        print(i)

print(f"number of papers: {i}")
