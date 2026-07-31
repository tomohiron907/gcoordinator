import os
import pickle
import urllib.request
import urllib.error

import numpy as np
import msgpack
from gcoordinator.path_generator import flatten_path_list


def preview(full_object, port: int = 5163) -> None:
    """
    Displays the computation result of the given object.

    The destination is chosen automatically:

    * When GCOORDINATOR_EXPORT_FILE / GCOORDINATOR_PICKLE_FILE are set, the
      MessagePack preview data and a pickle of full_object are written to those
      paths. The G-coordinator desktop app sets both.
    * Otherwise the MessagePack data is POSTed to the local HTTP server of the
      gcoordinator VSCode extension.

    The same call therefore works with both frontends.

    Args:
        full_object: A list of Path or PathList objects.
        port: The port number the VSCode extension is listening on (default: 5163).

    Returns:
        None
    """
    data = _pack_paths(full_object)

    export_path = os.environ.get('GCOORDINATOR_EXPORT_FILE')
    pickle_path = os.environ.get('GCOORDINATOR_PICKLE_FILE')

    if export_path:
        with open(export_path, 'wb') as f:
            f.write(data)
    if pickle_path:
        with open(pickle_path, 'wb') as f:
            pickle.dump(full_object, f)
    if export_path or pickle_path:
        return

    url = f"http://127.0.0.1:{port}/preview"
    req = urllib.request.Request(
        url,
        data=data,
        headers={"Content-Type": "application/msgpack"},
        method="POST",
    )
    try:
        with urllib.request.urlopen(req, timeout=5) as resp:
            resp.read()
    except urllib.error.URLError as e:
        print(f"[gcoordinator] preview: Failed to connect to the VSCode extension ({e.reason})")
        print(f"[gcoordinator] preview: Make sure the gcoordinator extension is installed and VSCode is open.")
    except Exception as e:
        print(f"[gcoordinator] preview: Unexpected error: {e}")


def gui_export(full_object, port: int = 5163) -> None:
    """
    Alias of preview(). Kept for backwards compatibility.

    Args:
        full_object: A list of Path or PathList objects.
        port: The port number the VSCode extension is listening on (default: 5163).

    Returns:
        None
    """
    preview(full_object, port=port)


def _pack_paths(full_object) -> bytes:
    """
    Encodes the coordinate data as MessagePack
    (flat Float32 binary + path_lengths list).

    Args:
        full_object: A list of Path or PathList objects.

    Returns:
        bytes: The MessagePack encoded preview data.
    """
    paths = flatten_path_list(full_object)
    if not paths:
        print("[gcoordinator] preview: full_object is empty.")

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

    return msgpack.packb(
        {
            "path_lengths": path_lengths,
            "coords": all_coords.tobytes(),
            "travel_path_lengths": travel_path_lengths,
            "travel_coords": travel_coords,
        },
        use_bin_type=True,
    )
