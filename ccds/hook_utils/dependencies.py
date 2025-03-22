import tomlkit

packages = [
    "pip",
    "python-dotenv",
]

flake8_black_isort = [
    "black",
    "flake8",
    "isort",
]

ruff = ["ruff"]

basic = [
    "ipython",
    "jupyterlab",
    "matplotlib",
    "notebook",
    "numpy",
    "pandas",
    "scikit-learn",
]

scaffold = [
    "typer",
    "loguru",
    "tqdm",
]


def write_dependencies(
    dependencies, dev_packages, basic_package, pip_only_packages, repo_name, module_name, python_version, environment_manager
):
    packages = dev_packages + basic_package

    if dependencies == "requirements.txt":
        with open(dependencies, "w") as f:
            lines = sorted(packages)

            lines += ["" "-e ."]

            f.write("\n".join(lines))
            f.write("\n")

    elif dependencies == "pyproject.toml":
        with open(dependencies, "r") as f:
            doc = tomlkit.parse(f.read())

        if environment_manager == "poetry":
            # Add packages to dependencies
            for package in sorted(basic_package):
                if package not in doc["tool"]["poetry"]["dependencies"]:
                    doc["tool"]["poetry"]["dependencies"][package] = "*"
            for package in sorted(dev_packages):
                if package not in doc["tool"]["poetry"]["group"]["dev"]["dependencies"]:
                    doc["tool"]["poetry"]["group"]["dev"]["dependencies"][package] = "*"

        else:
            doc["project"].add("dependencies", sorted(packages))
            doc["project"]["dependencies"].multiline(True)

        with open(dependencies, "w") as f:
            f.write(tomlkit.dumps(doc))

    elif dependencies == "environment.yml":
        with open(dependencies, "w") as f:
            lines = [
                f"name: {repo_name}",
                "channels:",
                "  - conda-forge",
                "dependencies:",
            ]

            lines += [f"  - python={python_version}"]
            lines += [f"  - {p}" for p in packages if p not in pip_only_packages]

            lines += ["  - pip:"]
            lines += [f"    - {p}" for p in packages if p in pip_only_packages]
            lines += ["    - -e ."]

            f.write("\n".join(lines))

    elif dependencies == "Pipfile":
        with open(dependencies, "w") as f:
            lines = ["[packages]"]
            lines += [f'{p} = "*"' for p in sorted(packages)]

            lines += [f'"{module_name}" ={{editable = true, path = "."}}']

            lines += ["", "[requires]", f'python_version = "{python_version}"']

            f.write("\n".join(lines))
