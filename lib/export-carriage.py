#!/usr/bin/env python3

import numpy as np
import subprocess
import sys


class SVGObject:
    def __init__(self, attrlist):
        self.id = attrlist[0]
        self.x = float(attrlist[1])
        self.y = float(attrlist[2])
        self.w = float(attrlist[3])
        self.h = float(attrlist[4])
        self.x_ = self.x + self.w
        self.y_ = self.y + self.h

    def is_path(self):
        return self.id.startswith("path")

    def is_tspan(self):
        return self.id.startswith("tspan")

    def __repr__(self):
        return "{}<x={}, y={}, w={}, h={}>".format(
            self.id, self.x, self.y, self.w, self.h
        )


def main(infile, outfile):
    ret = subprocess.run(
        ["inkscape", "--query-all", infile], capture_output=True, check=True
    )

    objects = ret.stdout.decode("ascii").split("\n")

    # remove last (empty) line
    objects.pop()

    # objects = [[ID, X, Y, W, H], ... ]
    objects = list(map(lambda x: x.split(","), objects))
    objects = list(map(lambda x: SVGObject(x), objects))

    ys = list()
    for o in objects:
        if o.is_path() and o.h > 2 and o.h < 4 and o.w > 10:
            ys.append(o.y)
    bins = np.bincount(ys)

    candidates = list(filter(lambda i: bins[i] > 2, range(len(bins))))

    crop_y_min = np.min(candidates) - 1
    crop_y_max = np.max(candidates) + 4

    objects_to_delete = list()
    x_positions = list()

    for o in objects:
        if (o.is_path or o.is_tspan) and (o.y < crop_y_min or o.y_ > crop_y_max):
            objects_to_delete.append(o.id)
        elif o.is_path and o.y >= crop_y_min and o.y_ <= crop_y_max:
            x_positions.append(o.x)
            x_positions.append(o.x_)

    crop_x_min = int(np.min(x_positions))
    crop_x_max = int(np.max(x_positions)) + 1

    objects_to_delete = ",".join(objects_to_delete)

    export_area = f"--export-area={crop_x_min}:{crop_y_min}:{crop_x_max}:{crop_y_max}"
    select_objects = f"--select={objects_to_delete}"

    subprocess.run(
        [
            "xvfb-run",
            "inkscape",
            export_area,
            select_objects,
            "--verb=EditDelete",
            "--batch-process",
            "--export-dpi=600",
            "-o",
            outfile,
            infile,
        ]
    )


if __name__ == "__main__":
    main(*sys.argv[1:])
