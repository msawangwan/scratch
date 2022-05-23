#!/usr/bin/env python
"""see:
https://kokes.github.io/blog/2018/11/25/merging-streams-python.html
https://docs.python.org/3/library/itertools.html#itertools.groupby
"""

import heapq
import random
import string
import itertools
from uuid import uuid4


def get_dict_data():
    frac = random.random()
    j = 0
    while True:
        j += 1
        if random.random() < frac:
            continue
        yield {
            'id': j,
            'name': ''.join(random.choices(string.ascii_lowercase, k=10)),
            'project': uuid4(),
        }


def infinite_seq():
    frac = random.random()
    j = 0
    while True:
        r = random.random()
        j += 1
        if r < frac:
            continue
        yield j


def subsequence_of(gen, length=10):
    return list(itertools.islice(gen, length))


def case1():
    stream_a = infinite_seq()
    stream_b = infinite_seq()

    a = subsequence_of(stream_a)
    b = subsequence_of(stream_b)

    merged = heapq.merge(a, b)
    grouped = itertools.groupby(merged)

    # print(list(itertools.islice(merged, 10)))
    # print(list(itertools.islice(grouped, 10)))

    group_id, group_contents = next(grouped)
    print(list(group_contents))  # materialise it


def case2():
    stream_a = infinite_seq()
    stream_b = infinite_seq()

    for group, data in itertools.groupby(heapq.merge(stream_a, stream_b)):
        print(f"{group=}")
        print(f"{data=}")
        break  # process `data` for a given `group`


def case3():
    print(next(get_dict_data()))


if __name__ == "__main__":
    case3()
