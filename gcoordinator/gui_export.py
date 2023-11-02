import pickle

def gui_export(full_object):
    """
    Exports the given object to a pickle file.
    This method is called from the GUI editor.
    The generated full_object is saved as a pickle file in the buffer directory
    for processing in the G-coordinator (GUI).

    Args:
        full_object: A list of Path or PathList objects.

    Returns:
        None
    """
    # buffer is a directry in G-coordinator (GUI)
    with open('buffer/full_object.pickle', 'wb') as f:
        pickle.dump(full_object, f)