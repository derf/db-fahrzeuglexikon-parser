#!/usr/bin/env python3

import numpy as np
import os
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


def main(infile, *outfiles):
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
        if o.is_path() and o.h > 2 and o.h < 4 and o.w > 9:
            ys.append(o.y)

    ys = np.array(ys, dtype=np.int64)

    if "double_decker_export" in os.environ:
        # the first object is the "svg2" element describing the entire document
        split = objects[0].h * 0.6
        if os.environ["double_decker_export"] == "lower":
            ys = ys[ys >= split]
        else:
            ys = ys[ys <= split]

    bins = np.bincount(ys)

    candidates = list(filter(lambda i: bins[i] > 2, range(len(bins))))

    crop_y_min = np.min(candidates) - 1
    crop_y_max = np.max(candidates) + 5

    objects_to_delete = list()
    x_positions = list()

    for o in objects:
        if (o.is_path() or o.is_tspan()) and (o.y < crop_y_min or o.y_ > crop_y_max):
            objects_to_delete.append(o.id)

    objects_to_delete = ",".join(objects_to_delete)

    select_objects = f"--select={objects_to_delete}"

    for outfile in outfiles:
        if outfile.endswith(".png"):
            subprocess.run(
                [
                    "xvfb-run",
                    "-a",
                    "inkscape",
                    "--export-area-drawing",
                    select_objects,
                    "--verb=EditDelete",
                    "--batch-process",
                    "--export-dpi=600",
                    "-o",
                    outfile,
                    infile,
                ]
            )
        elif outfile.endswith(".svg"):
            subprocess.run(
                [
                    "xvfb-run",
                    "-a",
                    "inkscape",
                    "--export-area-drawing",
                    select_objects,
                    "--verb=EditDelete",
                    "--batch-process",
                    "-o",
                    outfile,
                    infile,
                ]
            )
        else:
            raise RuntimeError(f"Unsupported export format: {outfile}")


if __name__ == "__main__":
    main(*sys.argv[1:])
