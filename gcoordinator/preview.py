import urllib.request
import urllib.error
import numpy as np
import msgpack
from gcoordinator.path_generator import flatten_path_list


def preview(full_object, port: int = 5163) -> None:
    """
    Send path data to the gcoordinator VSCode extension for 3D preview.

    Encodes the coordinate data as MessagePack (flat Float32 binary + path_lengths list)
    and POSTs it to the extension's local HTTP server.

    Args:
        full_object: A list of Path or PathList objects.
        port: The port number the VSCode extension is listening on (default: 5163).

    Returns:
        None
    """
    paths = flatten_path_list(full_object)
    if not paths:
        print("[gcoordinator] preview: full_object is empty, nothing to send.")
        return

    path_lengths = [len(p.coords) for p in paths]
    all_coords = np.concatenate([p.coords.astype(np.float32) for p in paths])

    travel_path_lengths = []
    travel_coords_list = []
    for path in paths:
        if path.travel_path is not None:
            wps = np.asarray(path.travel_path, dtype=np.float32)
            travel_path_lengths.append(len(wps))
            travel_coords_list.append(wps.flatten())
        else:
            travel_path_lengths.append(0)

    travel_coords = np.concatenate(travel_coords_list).tobytes() if travel_coords_list else b''

    data = msgpack.packb(
        {
            "path_lengths": path_lengths,
            "coords": all_coords.tobytes(),
            "travel_path_lengths": travel_path_lengths,
            "travel_coords": travel_coords,
        },
        use_bin_type=True,
    )

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
