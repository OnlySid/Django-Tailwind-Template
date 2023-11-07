#! /bin/bash
# Set up django project
currentscript="$0"

# Function that is called when the script exits:
function finish {
    echo "Shredding this file! ${currentscript}"; shred -u ${currentscript};
}

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
echo "\n\nAlso make sure the following settings are added:"
echo "STATICFILES_DIRS = [BASE_DIR / 'static',]"
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
echo "\nHead to the following link to find the Readme to find out more about setting up your Django application:"
echo "\nhttps://github.com/OnlySid/Django-Tailwind-Template"
echo "\nHappy coding!\n"
echo "******************************************"
rm -rf CHANGELOG.md
rm -rf README.md
rm -rf setup.sh