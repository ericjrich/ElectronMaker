#!/bin/bash

# Function to show a zenity error message
function show_error() {
    zenity --error --text="$1" --width=300 --title="⚠️ Error"
}

# Ask for the project name
project_name=$(zenity --entry --title="📛 Enter Project Name" --text="Enter the name of your Electron project:" --width=300)

# Check if a project name was provided
if [[ -z "$project_name" ]]; then
    show_error "Project name cannot be empty!"
    exit 1
fi

# Ask for the project directory
project_dir=$(zenity --file-selection --directory --title="📁 Select Project Directory" --width=300)

# Check if a directory was selected
if [[ -z "$project_dir" ]]; then
    show_error "No directory selected!"
    exit 1
fi

# Ask for the directory containing files and directories to include
content_dir=$(zenity --file-selection --directory --title="📂 Select Content Directory" --text="Select the directory containing your index.html and other files:" --width=300)

# Check if a directory was selected
if [[ -z "$content_dir" ]]; then
    show_error "No content directory selected!"
    exit 1
fi

# Create the project directory
full_path="$project_dir/$project_name"
mkdir -p "$full_path"
cd "$full_path" || exit

# Initialize npm and handle potential errors
npm init -y > npm_init.log 2>&1
if [[ $? -ne 0 ]]; then
    show_error "npm init failed. Check npm_init.log for details."
    exit 1
fi

# Install Electron and handle potential errors
npm install electron --save-dev > npm_install.log 2>&1
if [[ $? -ne 0 ]]; then
    show_error "Failed to install Electron. Check npm_install.log for details."
    exit 1
fi

# Create main.js file
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

# Copy the contents of the selected directory to the project directory
cp -r "$content_dir"/* .

# Safely update package.json to include main and start scripts
# Read current package.json and use jq to update main and scripts section
if command -v jq > /dev/null; then
    jq '.main = "main.js" | .scripts.start = "electron ."' package.json > package_tmp.json && mv package_tmp.json package.json
else
    sed -i 's/"scripts": {/"main": "main.js",\n  "scripts": {\n    "start": "electron .",/' package.json
fi

# Notify user of successful creation
zenity --info --text="Electron project '$project_name' created successfully in $full_path!" --width=300 --title="✅ Success"
