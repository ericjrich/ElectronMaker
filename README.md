# Electron Project Setup Script

This project provides a simple setup script for creating and initializing an Electron project. It allows users to create an Electron project with content sourced from a directory, a file, or a URL.

## Features

- **Project Initialization**: Creates a new Electron project with a specified name and directory.
- **Flexible Content**: Option to include content from a directory, a single file, or a URL.
- **Error Handling**: User-friendly error messages and prompts using Zenity.
- **Automated Setup**: Installs Electron, creates necessary files, and sets up basic project configurations.

## Prerequisites

- **Node.js**: Make sure you have Node.js installed. You can download it from [nodejs.org](https://nodejs.org/).
- **Zenity**: This script uses Zenity for GUI prompts. Install Zenity if it's not already available on your system.

## Installation

1. **Clone the Repository**: 

    ```
    git clone https://github.com/yourusername/your-repo-name.git
    ```

2. **Navigate to the Project Directory**:

    ```
    cd your-repo-name
    ```

3. **Run the Setup Script**:

    Make the script executable:

    ```
    chmod +x setup_script.sh
    ```

    Execute the script:

    ```
    ./setup_script.sh
    ```

## Usage

1. **Enter Project Name**: The script will prompt you to enter a name for your Electron project.
2. **Select Project Directory**: Choose the directory where you want to create your project.
3. **Add Content**: Choose one of the following options for adding content:
    - **Directory**: Select a directory containing your `index.html` and other files.
    - **File**: Select a single file to be used as `index.html`.
    - **URL**: Enter a URL, and the script will create an `index.html` that redirects to the specified URL.
4. **Run the Project**: Once the setup is complete, use the `run.sh` script to start your Electron application.

    ```
    ./run.sh
    ```

## Contributing

Feel free to fork this project, submit issues, or contribute via pull requests. Contributions are always welcome!

## Contact

For questions or suggestions, please create an issue in this repository.
