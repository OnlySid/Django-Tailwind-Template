#!/bin/bash

# Save the current directory
script_dir=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)

# a) Install pipenv if not already installed
if ! command -v pipenv &> /dev/null; then
    echo "Installing pipenv..."
    pip install pipenv
fi

# b) Check if pyenv is installed
if ! command -v pyenv &> /dev/null; then
    echo "Error: pyenv is not installed. Please install pyenv before running this script."
    exit 1
fi

# c) Get the latest Python version
latest_python_version=$(pyenv install --list | grep -E "^\s*[0-9]+\.[0-9]+\.[0-9]+$" | tail -n 1)

if [ -z "$latest_python_version" ]; then
    echo "Error: Unable to determine the latest Python version."
    exit 1
fi

# d) Start a virtual environment in pipenv with the latest Python version
echo "Updating Python version in Pipfile to $latest_python_version..."
pipenv --python $latest_python_version

# e) Run pipenv install
echo "Installing dependencies..."
pipenv install

# f) Check if npm is installed
if ! command -v npm &> /dev/null; then
    echo "Error: npm is not installed. Please install npm before running this script."
    exit 1
fi

# g) Ask the user for a project name
read -p "Enter the project name: " project_name

# h) Start a Django project with the provided project name in the current directory
while true; do
    if [[ $project_name =~ ^[a-zA-Z_][a-zA-Z0-9_]*$ ]]; then
        echo "Creating Django project: $project_name"
        pipenv run django-admin startproject $project_name .
        break
    else
        echo "Invalid project name. Please use only letters, numbers, and underscores, and start with a letter or underscore."
        read -p "Enter a valid project name: " project_name
    fi
done

# i) Remove existing urls.py file
echo "Removing existing urls.py file..."
rm -f "$project_name/urls.py"

# j) Create new urls.py file with provided content
echo "Creating new urls.py file..."
echo "from django.contrib import admin
from django.urls import path
from .views import index

urlpatterns = [
    path('admin/', admin.site.urls),
    path('', index, name='index')
]" > "$project_name/urls.py"

# k) Create new views.py file with provided content
echo "Creating new views.py file..."
echo "from django.shortcuts import render

def index(request):
    return render(request, 'index.html')" > "$project_name/views.py"

# l) Add lines to settings.py
settings_path="$project_name/settings.py"
echo "Updating $settings_path..."

replacement_text="'DIRS': [BASE_DIR / 'templates'],"
awk -v repl="$replacement_text" '
    /'\''DIRS'\'': \[\],/ {
        sub(/'\''DIRS'\'': \[\],/, repl);
    }
    {print}
' "$settings_path" > temp && mv temp "$settings_path"

# Add STATICFILES_DIRS line
echo >> "$settings_path"
echo "STATICFILES_DIRS = [BASE_DIR / 'static']" >> "$settings_path"

# m) Move back to the script directory
cd "$script_dir"

# n) Check if npm is installed
if ! command -v npm &> /dev/null; then
    echo "Error: npm is not installed. Please install npm before running this script."
    exit 1
fi

# o) Install tailwindcss, postcss-cli, and autoprefixer with npm in the project directory
echo "Installing tailwindcss, postcss-cli, and autoprefixer in the project directory..."
pipenv run npm init -y
pipenv run npm install tailwindcss postcss-cli autoprefixer

# p) Remove existing git repository information, initialize a new git repo, and delete the script file
echo "Removing existing git repository information..."
rm -rf .git
echo "Initializing new git repository..."
git init
echo "Adding files to git repository..."
git add .
git commit -m "Initial commit"
echo "Git repository initialized."

# q) Delete the script file and other miscellaneous files
echo "Deleting the script file..."
rm -- "$0"
rm -rf CHANGELOG.md
rm -rf README.md

# r) Open a new terminal and run "pipenv run watch"
echo "Open a new terminal and run the following command:"
echo "pipenv run watch"

echo "Setup complete!"

# s) Launch Django development server
echo "Launching Django development server..."
pipenv run server
