#!/usr/bin/env bash

# Function to show a zenity error message and log it
function show_error() {
  local message="$1"
  echo -e "\e[31mError: $message\e[0m" | tee -a "$log_file"
  zenity --error --text="$message" --width=300 --title="⚠️ Error"
}

# Function to show a success message
function show_success() {
  local message="$1"
  echo -e "\e[32m$message\e[0m"
  zenity --info --text="$message" --width=300 --title="✅ Success"
}

# Function to initialize the project directory
function initialize_project() {
  mkdir -p "$full_path"
  cd "$full_path" || exit
  npm init -y > npm_init.log 2>&1
  if [[ $? -ne 0 ]]; then
    show_error "npm init failed. Check npm_init.log for details."
    exit 1
  fi
}

# Function to install Electron
function install_electron() {
  npm install electron --save-dev > npm_install.log 2>&1
  if [[ $? -ne 0 ]]; then
    show_error "Failed to install Electron. Check npm_install.log for details."
    exit 1
  fi
}

# Function to create main.js file
function create_main_js() {
  cat > main.js << EOL
const { app, BrowserWindow } = require('electron');

let mainWindow;

function createWindow() {
    mainWindow = new BrowserWindow({
        width: 800,
        height: 600,
        webPreferences: {
            nodeIntegration: true,
        },
    });

    mainWindow.loadFile('index.html');

    mainWindow.on('closed', () => {
        mainWindow = null;
    });
}

app.on('ready', createWindow);

app.on('window-all-closed', () => {
    if (process.platform !== 'darwin') {
        app.quit();
    }
});

app.on('activate', () => {
    if (mainWindow === null) {
        createWindow();
    }
});
EOL
}

# Function to create run script
function create_run_script() {
  cat > run << EOL
#!/bin/bash
npm start
EOL
  chmod +x run
}

# Function to update package.json safely
function update_package_json() {
  if command -v jq > /dev/null; then
    jq '.main = "main.js" | .scripts.start = "electron ."' package.json > package_tmp.json && mv package_tmp.json package.json
  else
    sed -i 's/"scripts": {/"main": "main.js",\n  "scripts": {\n    "start": "electron .",/' package.json
  fi
}

# Start of the script

# Ask for the project name
project_name=$(zenity --entry --title="📛 Enter Project Name" --text="Enter the name of your Electron project:" --width=300)
[ -z "$project_name" ] && show_error "Project name cannot be empty!" && exit 1

# Ask for the project directory
project_dir=$(zenity --file-selection --directory --title="📁 Select Project Directory" --width=300)
[ -z "$project_dir" ] && show_error "No directory selected!" && exit 1

# Ask for the directory containing files and directories to include
content_dir=$(zenity --file-selection --directory --title="📂 Select Content Directory" --text="Select the directory containing your index.html and other files:" --width=300)

# Set log file path
log_file="$project_dir/$project_name/error.log"

# Create the project directory
full_path="$project_dir/$project_name"
initialize_project

# If content directory is not selected, ask for a specific file
if [ -z "$content_dir" ]; then
  content_file=$(zenity --file-selection --title="📄 Select a File" --text="No content directory selected. Please select a file to use as index.html:" --width=300)
  if [ -z "$content_file" ]; then
    show_error "No content file selected!"
    exit 1
  fi
  # Copy and rename the file to index.html in the project directory
  cp "$content_file" "$full_path/index.html"
else
  # Copy the contents of the selected directory to the project directory
  cp -r "$content_dir"/* "$full_path"
fi

# Install Electron
install_electron

# Create main.js file
create_main_js

# Create a run script to easily launch the Electron app
create_run_script

# Update package.json to include main and start scripts
update_package_json

# Notify user of successful creation
show_success "Electron project '$project_name' created successfully in $full_path!"
