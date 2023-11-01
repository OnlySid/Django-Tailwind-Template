#! /bin/bash
# Set up django project

echo "******************************************\n"
echo "Re-initialising GIT..."
rm -rf .git
git init
echo "\n******************************************\n"
echo "Enter your project's name:"
read projectname
echo "\nSetting up environment..."
pipenv install
echo "Creating Django project..."
django-admin startproject $projectname .
echo "******************************************\n"
echo "Now please follow these instructions:\n"
echo "Go to ./$projectname/settings.py and add the following to the TEMPLATES array:"
echo "'DIRS': [BASE_DIR / 'templates'],\n"
read -n 1 -r -s -p $'(Press any key to continue)'
echo "\n\nThen in the same file, add 'compressor' to the array of INSTALLED_APPS."
read -n 1 -r -s -p $'(Press any key to continue)'
echo "\n\nAlso make sure the following compressor settings are added:"
echo "COMPRESS_ROOT = BASE_DIR / 'static'\nCOMPRESS_ENABLED = True\nSTATICFILES_FINDERS = ('compressor.finders.CompressorFinder',)"
read -n 1 -r -s -p $'(Press any key to continue)'
echo "\n\nInstalling dependencies..."
rm ./$projectname/urls.py
mv urls.py ./$projectname
mv views.py ./$projectname
npm install tailwindcss postcss-cli autoprefixer 
npx tailwindcss init
echo "\n******************************************\n"
echo "Tailwind CSS and Django are now set up and ready to go!"
echo "Useful commands:\n"
echo "- pipenv run server (This sets up the development server)"
echo "- pipenv run watch (This watches for CSS updates on file save)"
echo "\nHappy coding!\n"
echo "******************************************"
