# ElectronMaker

📦 **ElectronMaker** is a simple bash script to automate the setup of an Electron project. It uses `zenity` for user-friendly graphical prompts and allows the inclusion of custom HTML files and directories into the Electron project.

## 📋 Prerequisites

Before using the `ElectronMaker` script, make sure you have the following installed on your system:

- **Node.js** and **npm**: These are required to run and install Electron. You can install them using `nvm` or directly from the Node.js website.
- **Zenity**: This is used for graphical prompts. Install it using the following command:

  ```bash
  sudo apt-get install zenity
  ```

- **nvm (Node Version Manager)** (optional but recommended): For managing Node.js versions. Install it using the official install script:

  ```bash
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
  ```

## 🔧 How to Use

1. **Download the Script**: Download the `electronmaker.sh` script to your local machine.

2. **Make the Script Executable**: Run the following command to make the script executable:

    ```bash
    chmod +x electronmaker.sh
    ```

3. **Run the Script**: Execute the script from your terminal:

    ```bash
    ./electronmaker.sh
    ```

4. **Follow the Prompts**: The script will guide you through the following steps using `zenity` graphical prompts:

    - 📛 **Enter Project Name**: Enter a name for your Electron project.
    - 📁 **Select Project Directory**: Choose the directory where you want the project to be created.
    - 📂 **Select Content Directory**: Select a directory containing your `index.html` and any other files or directories you want to include in your Electron project.

5. **Completion**: The script will set up the Electron project, copy the selected files, and notify you of successful project creation with a ✅ **Success** message.

## 🚀 Running the Final Product

Once the Electron project has been set up successfully, you can run the Electron application using the following steps:

1. **Navigate to the Project Directory**: Use the terminal to navigate to the project directory you specified during setup. For example:

    ```bash
    cd /path/to/your/project-directory
    ```

2. **Start the Electron Application**: Run the following command to start your Electron app:

    ```bash
    npm start
    ```

   This command will use the start script defined in the `package.json` to launch the Electron application, opening a new window with your custom HTML content.

## 📝 What the Script Does

- Initializes an Electron project using `npm`.
- Installs Electron as a development dependency.
- Creates a basic `main.js` file to launch the Electron app.
- Copies the contents of the user-selected directory (containing `index.html` and other files) into the project directory.
- Updates the `package.json` to set the correct entry point (`main.js`) and the start script (`electron .`).

## ⚠️ Error Handling

If there are any issues during the setup process (e.g., missing project name, npm initialization failure), the script will show an ⚠️ **Error** message and provide information on what went wrong.

## ✅ Success

Upon successful setup, a notification will confirm that the Electron project has been created successfully.

## 📚 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🛠 Contributing

Contributions are welcome! Please feel free to submit a Pull Request or open an issue.

## 🙏 Acknowledgments

- Thanks to the developers of [Electron](https://electronjs.org/) for making desktop app development easy and accessible.
- Inspired by the need for easy project setup and automation.
