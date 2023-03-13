import json
import sys
import pprint
from functools import partial

# def read_json(filename):
#     with open(filename) as f:
#         parser = ijson.items(f, '')
#         print("passed this")
#         for obj in parser:
#             print("got it")
#             yield obj

# def read_json(filename):
#     with open(filename) as f:
#         parser = ijson.parse(f)
#         obj = {}
#         for prefix, event, value in parser:
#             if event == 'map_key':
#                 obj[value] = next(parser)[1]
#             elif event == 'end_map':
#                 yield obj
#                 obj = {}

def json_parse(fileobj, decoder=json.JSONDecoder(), buffersize=2048):
    buffer = ''
    for chunk in iter(partial(fileobj.read, buffersize), ''):
         buffer += chunk
         while buffer:
             try:
                 result, index = decoder.raw_decode(buffer)
                 yield result
                 buffer = buffer[index:].lstrip()
             except ValueError:
                 # Not enough data to decode, read more
                 break


i = 0
with open('dblp_v14.json') as f:

    for paper in json_parse(f):
        pprint.pprint(paper)
        i += 1
        if i == 10:
            sys.exit()