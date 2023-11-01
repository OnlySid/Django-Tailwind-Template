#! /bin/bash
# Set up django project

echo "Re-initialising GIT..."
rm -rf .git
git init
echo "Enter your project's name:"
read projectname
echo "Setting up environment..."
pipenv install
echo "Creating Django project..."
django-admin startproject $projectname .
echo "Now please follow these instructions:\n"
echo "Go to ./$projectname/settings.py and add the following to the TEMPLATES array:\n"
echo "'DIRS': [BASE_DIR / 'templates'],"
read -n 1 -r -s -p $'(Press any key to continue)\n\n'
echo "Then in the same file, add 'compressor' to the array of INSTALLED_APPS."
read -n 1 -r -s -p $'(Press any key to continue)\n\n'
echo "Also make sure the following compressor settings are added:"
echo "COMPRESS_ROOT = BASE_DIR / 'static'\n\nCOMPRESS_ENABLED = True\n\nSTATICFILES_FINDERS = ('compressor.finders.CompressorFinder',)"
read -n 1 -r -s -p $'(Press any key to continue)\n\n'
echo "Installing dependencies..."
rm ./$projectname/urls.py
mv urls.py ./$projectname
mv views.py ./$projectname
npm install tailwindcss postcss-cli autoprefixer 
npx tailwindcss init
echo "******************************************"
echo "Tailwind CSS and Django are now set up and ready to go!"
echo "Useful commands:\n"
echo "pipenv run server (This sets up the development server)"
echo "pipenv run watch (This watches for CSS updates on file save)"
echo "Happy coding!"
echo "******************************************"
