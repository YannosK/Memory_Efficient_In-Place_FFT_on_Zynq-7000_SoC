import sys
import generics_lookup as gl

def get_generics(sensor, points, dataset):
    generics = gl.generics_lookup.get(points, None)
    if generics:
        # Format the paths with the dataset value
        generics["RAM_file"] = generics["RAM_file"].format(sensor=sensor, dataset=dataset)
        generics["resultfile"] = generics["resultfile"].format(sensor=sensor, dataset=dataset)
        generics["outfile"] = generics["outfile"].format(sensor=sensor, dataset=dataset)
    return generics

if __name__ == "__main__":
    if len(sys.argv) != 4:
        print("Usage: python generate_generics.py <sensor> <points> <dataset>")
        sys.exit(1)
    
    sensor = int(sys.argv[1])
    points = int(sys.argv[2])
    dataset = int(sys.argv[3])

    generics = get_generics(sensor, points, dataset)
    if generics:
        # Print each generic as "name=value"
        for key, value in generics.items():
            print(f"{key}={value}")
    else:
        print(f"No generics found for points {points} and dataset {dataset}.")