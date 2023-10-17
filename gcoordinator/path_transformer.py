import numpy as np
from gcoordinator.path_generator import Path, PathList


class Transform:
    def __init__(self):
        pass
    
    @staticmethod
    def stretch(path, x_stretch_ratio, y_stretch_ratio, z_stretch_ratio):
            """
            Stretches a given path by the specified ratios along each axis.

            Args:
                path (Path): The path to be stretched.
                x_stretch_ratio (float): The ratio by which to stretch the path along the x-axis.
                y_stretch_ratio (float): The ratio by which to stretch the path along the y-axis.
                z_stretch_ratio (float): The ratio by which to stretch the path along the z-axis.

            Returns:
                Path: The stretched path.
            """
            x = x_stretch_ratio * path.x
            y = y_stretch_ratio * path.y
            z = z_stretch_ratio * path.z
            output_path = Path(x, y, z)
            return output_path
        
    @staticmethod
    def rotate_xy(path, theta):
            """
            Rotates a 2D path around the origin by a given angle.

            Args:
                path (Path): The path to be rotated.
                theta (float): The angle (in radians) by which to rotate the path.

            Returns:
                Path: The rotated path.
            """
            x = np.cos(theta)*path.x + np.sin(theta)*path.y
            y = -np.sin(theta)*path.x + np.cos(theta)*path.y
            z = path.z
            rotated_path = Path(x, y, z)
            return  rotated_path
    
    @staticmethod
    def move(arg, x=0.0, y=0.0, z=0.0, roll=0.0, pitch=0.0, yaw=0.0):
        """
        Moves a Path or PathList object in 3D space by the specified amounts of translation and rotation.
        
        Args:
            arg (Path or PathList): The Path or PathList object to be transformed.
            x (float): The amount of translation along the x-axis.
            y (float): The amount of translation along the y-axis.
            z (float): The amount of translation along the z-axis.
            roll (float): The amount of rotation around the x-axis, in radians.
            pitch (float): The amount of rotation around the y-axis, in radians.
            yaw (float): The amount of rotation around the z-axis, in radians.
        
        Returns:
            Path or PathList: The transformed Path or PathList object.
        """
        if isinstance(arg, Path):
            path = Transform.move_path(arg, x, y, z, roll, pitch, yaw)
            return path
        elif isinstance(arg, PathList):
            path_list = Transform.move_pathlist(arg, x, y, z, roll, pitch, yaw)
            return path_list
        
    @staticmethod
    def move_path(path, x=0.0, y=0.0, z=0.0, roll=0.0, pitch=0.0, yaw=0.0):
        """
        Moves a given path by a specified translation vector and rotation angles.

        Args:
            path (Path): The path to be moved.
            x (float): The x-component of the translation vector. Defaults to 0.
            y (float): The y-component of the translation vector. Defaults to 0.
            z (float): The z-component of the translation vector. Defaults to 0.
            roll (float): The roll angle in radians. Defaults to 0.
            pitch (float): The pitch angle in radians. Defaults to 0.
            yaw (float): The yaw angle in radians. Defaults to 0.

        Returns:
            Path: The moved path.

        """
        translation_vector = np.array([x, y, z])

        rotation_matrix = np.array([[np.cos(yaw) * np.cos(pitch),
                                    np.cos(yaw) * np.sin(pitch) * np.sin(roll) - np.sin(yaw) * np.cos(roll),
                                    np.cos(yaw) * np.sin(pitch) * np.cos(roll) + np.sin(yaw) * np.sin(roll)],
                                    [np.sin(yaw) * np.cos(pitch),
                                    np.sin(yaw) * np.sin(pitch) * np.sin(roll) + np.cos(yaw) * np.cos(roll),
                                    np.sin(yaw) * np.sin(pitch) * np.cos(roll) - np.cos(yaw) * np.sin(roll)],
                                    [-np.sin(pitch),
                                    np.cos(pitch) * np.sin(roll),
                                    np.cos(pitch) * np.cos(roll)]])

        path_coords = np.array(path.coords)
        translated_coords = path_coords + translation_vector
        transformed_coords = np.dot(rotation_matrix, np.transpose(translated_coords))
        x_coords = transformed_coords[0]
        y_coords = transformed_coords[1]
        z_coords = transformed_coords[2]
        moved_path = Path(x_coords, y_coords, z_coords)
        return moved_path

    @staticmethod
    def move_pathlist(pathlist, x=0, y=0, z=0, roll=0, pitch=0, yaw=0):
        """
        Moves a list of paths in 3D space according to the specified translation and rotation values.

        Args:
            pathlist (PathList): The list of paths to be transformed.
            x (float): The amount to translate the paths along the x-axis.
            y (float): The amount to translate the paths along the y-axis.
            z (float): The amount to translate the paths along the z-axis.
            roll (float): The amount to rotate the paths around the x-axis.
            pitch (float): The amount to rotate the paths around the y-axis.
            yaw (float): The amount to rotate the paths around the z-axis.

        Returns:
            PathList: A new PathList instance containing the transformed paths.
        """
        path_list_buffer = []
        for path in pathlist.paths:
            path = Transform.move_path(path, x, y, z, roll, pitch, yaw)
            path_list_buffer.append(path)
        path_list_instance = PathList(path_list_buffer)
        path_list_buffer = []
        return path_list_instance

    @staticmethod
    def offset(path, offset_distance):
        """
        Computes the offset polygon of a given path by moving each vertex along its normal vector by the offset_distance.

        Args:
            path (Path): The path to offset.
            offset_distance (float): The distance to offset the path by.

        Returns:
            Path: The offset path.
        
        """
        # Generate the offset polygon by computing the normal vectors of each vertex
        # and moving each vertex along its normal vector by the distance d
        polygon = path.coords
        offset_polygon = np.array([])
        offset_point_x = []
        offset_point_y = []
        offset_point_z = []
        for i in range( len(polygon)):
            # Compute the normal vector of the current vertex
            if np.allclose(polygon[0] , polygon[-1]):
                # closed curve
                p1 = polygon[(i-1)%(len(polygon)-1)]
                p2 = polygon[i%(len(polygon)-1)]
                p3 = polygon[(i+1)%(len(polygon)-1)]
            else:
                # open curve
                if i == 0:
                    # Processing of the starting point of an open curve
                    p1 = 2 * polygon[i] - polygon[i+1]
                    p2 = polygon[i]
                    p3 = polygon[i+1]
                elif i == len(polygon)-1:
                    # End of open curve
                    p1 = polygon[i-1]
                    p2 = polygon[i]
                    p3 = 2 * polygon[i] - polygon[i-1]
                else:
                    # Midpoint of open curve
                    p1 = polygon[i-1]
                    p2 = polygon[i]
                    p3 = polygon[i+1]
            v1 = np.array([p2[0]-p1[0], p2[1]-p1[1]])
            v2 = np.array([p3[0]-p2[0], p3[1]-p2[1]])
            n = np.array([v1[1], -v1[0]])
            m = np.array([v2[1], -v2[0]])
            n /= np.linalg.norm(n)
            m /= np.linalg.norm(m)
            if np.dot(n, m) > 1:
                n_dot_m = 1
            elif np.dot(n, m) < -1:
                n_dot_m = -1
            else:
                n_dot_m = np.dot(n, m)
            phi = np.arccos(n_dot_m)
            theta = 2 * np.pi - phi - np.pi
            l = offset_distance / np.sin(theta /2)

            normal = n + m
            normal /= np.linalg.norm(normal)
            # Move the current vertex along its normal vector by the distance l
            offset_point = np.array([p2[0], p2[1]]) + l*normal
            offset_point_x.append(offset_point[0])
            offset_point_y.append(offset_point[1])
            offset_point_z.append(polygon[i, 2])
        offset_path = Path(offset_point_x, offset_point_y, offset_point_z)

        return offset_path
