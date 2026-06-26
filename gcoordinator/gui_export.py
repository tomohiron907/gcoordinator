import os
import pickle

import numpy as np
import msgpack
from gcoordinator.path_generator import flatten_path_list


def gui_export(full_object):
    """
    Exports the given object for downstream processing.

    When GCOORDINATOR_EXPORT_FILE is set, writes a MessagePack preview file
    to that path. When GCOORDINATOR_PICKLE_FILE is set, writes a pickle of
    full_object to that path. Both env vars are used together by the Tauri
    desktop app. When neither is set, falls back to the legacy PyQt behavior.

    Args:
        full_object: A list of Path or PathList objects.

    Returns:
        None
    """
    export_path = os.environ.get('GCOORDINATOR_EXPORT_FILE')
    pickle_path = os.environ.get('GCOORDINATOR_PICKLE_FILE')

    if export_path:
        _write_msgpack(full_object, export_path)
    if pickle_path:
        with open(pickle_path, 'wb') as f:
            pickle.dump(full_object, f)
    if not export_path and not pickle_path:
        with open('buffer/full_object.pickle', 'wb') as f:
            pickle.dump(full_object, f)


def _write_msgpack(full_object, path):
    paths = flatten_path_list(full_object)

    path_lengths = [len(p.coords) for p in paths]
    all_coords = (
        np.concatenate([p.coords.astype(np.float32) for p in paths])
        if paths else np.array([], dtype=np.float32)
    )

    travel_path_lengths = []
    travel_coords_list = []
    for p in paths:
        if p.travel_path is not None:
            tp = p.travel_path
            wps = np.column_stack([
                np.atleast_1d(tp[0]),
                np.atleast_1d(tp[1]),
                np.atleast_1d(tp[2]),
            ]).astype(np.float32)
            travel_path_lengths.append(len(wps))
            travel_coords_list.append(wps.flatten())
        else:
            travel_path_lengths.append(0)

    travel_coords = (
        np.concatenate(travel_coords_list).tobytes()
        if travel_coords_list else b''
    )

    data = msgpack.packb(
        {
            "path_lengths": path_lengths,
            "coords": all_coords.tobytes(),
            "travel_path_lengths": travel_path_lengths,
            "travel_coords": travel_coords,
        },
        use_bin_type=True,
    )

    with open(path, 'wb') as f:
        f.write(data)
