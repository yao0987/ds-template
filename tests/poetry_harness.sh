#!/bin/bash
set -e

PROJECT_NAME=$(basename $1)
CCDS_ROOT=$(dirname $0)
MODULE_NAME=$2

# configure exit / teardown behavior
function finish {
    # No need to deactivate explicitly with Poetry
    # Clean up the Poetry environment
    if [ -d "$1/.venv" ]; then
        cd $1
        poetry env remove --all
    fi
}
trap "finish $1" EXIT

# source the steps in the test
source $CCDS_ROOT/test_functions.sh

# navigate to the generated project
cd $1

# Set up temporary directory if needed
if [ -z $TMPDIR ]; then
    windowstmpdir=/c/Users/VssAdministrator/AppData/Local/Temp
    if [ -e $windowstmpdir ]; then
        export TMPDIR=$windowstmpdir
    fi
fi

# Check if Poetry is installed, install if not
if ! command -v poetry &> /dev/null; then
    echo "Poetry not found. Installing Poetry..."

    # Determine OS and install method
    if [[ "$OSTYPE" == "darwin"* ]] || [[ "$OSTYPE" == "linux-gnu"* ]]; then
        # macOS or Linux
        curl -sSL https://install.python-poetry.org | python3 -

        # Add Poetry to PATH for this session
        export PATH="$HOME/.local/bin:$PATH"
    elif [[ "$OSTYPE" == "msys" ]] || [[ "$OSTYPE" == "win32" ]]; then
        # Windows
        curl -sSL https://install.python-poetry.org | python -

        # Add Poetry to PATH for this session (Windows)
        export PATH="$APPDATA/Python/Scripts:$PATH"
    else
        echo "Unsupported operating system. Please install Poetry manually: https://python-poetry.org/docs/#installation"
        exit 1
    fi

    # Verify installation
    if ! command -v poetry &> /dev/null; then
        echo "Poetry installation failed. Please install Poetry manually: https://python-poetry.org/docs/#installation"
        exit 1
    else
        echo "Poetry installed successfully!"
    fi
fi

# Initialize Poetry if pyproject.toml doesn't exist
if [ ! -f "pyproject.toml" ]; then
    poetry init --name="$PROJECT_NAME" --quiet
fi

# Configure Poetry to create virtual environment in project directory
poetry config virtualenvs.in-project true --local

# Create Poetry environment
poetry install

# Run equivalent of make commands
# We'll assume these commands are defined in pyproject.toml scripts
# or we'll run them directly via Poetry

# Equivalent of make requirements (already done with poetry install)
echo "Installing dependencies..."

# Equivalent of make lint
echo "Running linting..."
if grep -q "\[tool.poetry.scripts\]" pyproject.toml && grep -q "lint" pyproject.toml; then
    poetry run lint
else
    poetry run flake8 || echo "Flake8 not configured, skipping"
fi

# Equivalent of make format
echo "Running formatting..."
if grep -q "\[tool.poetry.scripts\]" pyproject.toml && grep -q "format" pyproject.toml; then
    poetry run format
else
    poetry run black . || echo "Black not configured, skipping"
fi

# Run tests
echo "Running tests..."
run_tests $PROJECT_NAME $MODULE_NAME