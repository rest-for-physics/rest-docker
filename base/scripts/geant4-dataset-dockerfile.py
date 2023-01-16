#!/usr/bin/python3

import os
import subprocess
import argparse


def main():

    parser = argparse.ArgumentParser(
        description="Generate Dockerfile from base dockerfile (input argument) adding Geant4 datasets as ENV variables"
    )

    parser.add_argument(
        "-i",
        "--image",
        help="name of the docker image to use as base (required)",
        required=True,
    )
    parser.add_argument(
        "-o",
        "--output",
        help="path of output Dockerfile (default=./Dockerfile)",
        default="Dockerfile",
    )

    args = parser.parse_args()

    result = subprocess.run(f"docker --version".split(),
                            stdout=subprocess.PIPE)
    version = result.stdout.decode("utf-8")
    print(version)

    docker_image = args.image
    result = subprocess.run(
        f"docker run {docker_image} geant4-config --datasets".split(),
        stdout=subprocess.PIPE,
    )
    datasets = result.stdout.decode("utf-8")

    env_variables = dict()
    # datasets should be a multi-line string with 3 words per line (name, env var, path)
    for line in datasets.split("\n"):
        if not line.strip():
            continue
        words = line.split()
        assert len(words) == 3
        dataset_env_variable = words[1]
        dataset_path = words[2]
        env_variables[dataset_env_variable] = dataset_path

    # create directories in case they do not exist
    dir_path = os.path.dirname(args.output)
    if len(dir_path) != 0 and not os.path.exists(dir_path):
        os.makedirs(dir_path)

    # Create Dockerfile (labels will be inherited), ENTRYPOINT and CMD will be preserved
    with open(args.output, "w") as f:
        f.write(f"FROM {docker_image}\n\n")
        for variable, value in env_variables.items():
            f.write(f"ENV {variable}={value}\n")


if __name__ == "__main__":
    main()
