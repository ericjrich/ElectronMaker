#!/usr/bin/env bash
# 20240829_2006_est_EJR

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

# Function to create a run file
function create_run_file() {
  cat > run.sh << 'EOL'
export NVM_DIR="$HOME/.nvm"; [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
cd $(dirname "$0")
npm start >>/dev/null 2>&1 & disown
EOL
  chmod +x run.sh
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

# Set log file path
log_file="$project_dir/$project_name/error.log"

# Create the project directory
full_path="$project_dir/$project_name"
initialize_project

# Ask the user to choose how to add content
content_choice=$(zenity --list --title="Select Content Option" --text="Choose how to add content to your project:" --radiolist --column "Select" --column "Option" TRUE "Directory" FALSE "File" FALSE "URL" FALSE "Abort" --width=300 --height=250)

# Handle user choice
case $content_choice in
  "Directory")
    content_dir=$(zenity --file-selection --directory --title="📂 Select Content Directory" --text="Select the directory containing your index.html and other files:" --width=300)
    if [ -z "$content_dir" ]; then
      show_error "No directory selected!"
      exit 1
    fi
    cp -r "$content_dir"/* "$full_path"
    ;;
  "File")
    content_file=$(zenity --file-selection --title="📄 Select a File" --text="Please select a file to use as index.html:" --width=300)
    if [ -z "$content_file" ]; then
      show_error "No file selected!"
      exit 1
    fi
    cp "$content_file" "$full_path/index.html"
    ;;
  "URL")
    redirect_url=$(zenity --entry --title="🌐 Enter URL" --text="Please enter a URL to redirect to:" --width=300)
    if [ -z "$redirect_url" ]; then
      show_error "No URL entered!"
      exit 1
    fi
    echo "<!DOCTYPE html><html><head><meta http-equiv=\"refresh\" content=\"0;url=$redirect_url\"></head><body></body></html>" > "$full_path/index.html"
    ;;
  "Abort")
    show_error "Operation aborted by the user."
    exit 1
    ;;
  *)
    show_error "Invalid option selected!"
    exit 1
    ;;
esac

# Install Electron
install_electron

# Create main.js file
create_main_js

# Update package.json to include main and start scripts
update_package_json

# Create the run file (launcher)
create_run_file

# Notify user of successful creation
show_success "Electron project '$project_name' created successfully in $full_path!"
