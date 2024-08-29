
# 📦 Electron Project Setup Script

Welcome to the **Electron Project Setup Script**! This bash script will help you quickly set up an Electron project with ease. Just follow the steps, and you'll have your project ready in no time!

## 🎉 Features

- **Interactive GUI** using Zenity for seamless user input.
- **Error Handling** with log files to trace back any issues.
- **Modular Structure** with functions for better organization and readability.
- **Customizable Setup**: Choose a directory or file for your project content.
- **Automatic Project Initialization** with `npm` and Electron setup.

## 🚀 How It Works

The script guides you through the creation of an Electron project by:

1. **Asking for the Project Name**: 
   - Provides a text input to enter the name of your new project.

2. **Selecting the Project Directory**: 
   - Lets you choose where you want to create the project directory.

3. **Choosing Content for the Project**:
   - Offers an option to select a content directory (containing `index.html` and other files).
   - If you don't select a directory, you can select a specific file, which will be copied and renamed as `index.html`.

4. **Installing Electron**: 
   - Initializes the project with `npm init`.
   - Installs Electron as a development dependency.

5. **Creating Necessary Files**:
   - Generates a `main.js` file for Electron.
   - Creates a `run` script to easily start your Electron app.

6. **Updating `package.json`**:
   - Adds the main script and start script entries using `jq` or `sed`.

7. **Displaying Success Message**: 
   - Once everything is done, a success message is shown.

## 📋 Prerequisites

Make sure you have the following installed:

- **Zenity**: For GUI dialogs.
- **Node.js** and **npm**: Required for Electron setup.
- **jq** (optional but recommended): For safe JSON editing.

## 🛠 How to Use the Script

1. **Clone or Download the Script**: First, get the script onto your local machine.

2. **Make the Script Executable**: 
   \`\`\`bash
   chmod +x create_electron_project.sh
   \`\`\`

3. **Run the Script**:
   \`\`\`bash
   ./create_electron_project.sh
   \`\`\`

4. **Follow the Prompts**: The script will guide you through the following:

   - Entering the project name.
   - Selecting a directory for the project.
   - Choosing a content directory or a specific file to use as `index.html`.

5. **Check for Success**: After running the script, you will receive a success message. Your project is now set up and ready!

## 🏃‍♂️ How to Run Your Electron Project

Once the script has completed, you can run your Electron project easily:

1. **Navigate to Your Project Directory**:
   \`\`\`bash
   cd /path/to/your/project
   \`\`\`

2. **Run the Project**:
   \`\`\`bash
   ./run
   \`\`\`

This will start your Electron application!

## 📦 Example Project Setup

Here's a step-by-step example to illustrate how it works:

1. **Run the Script**:

   \`\`\`bash
   ./create_electron_project.sh
   \`\`\`

2. **Enter the Project Name**:
   ```
   📛 Enter Project Name: MyCoolElectronApp
   ```

3. **Select the Project Directory**:
   ```
   📁 Select Project Directory: /home/user/projects/
   ```

4. **Select Content Directory or File**:
   - If you choose a directory, it might look like this:
     ```
     📂 Select Content Directory: /home/user/content/
     ```
   - If you cancel directory selection, choose a file:
     ```
     📄 Select a File: /home/user/single_page.html
     ```

   (The file will be renamed to `index.html` and placed in the project directory.)

5. **Check for Success**:
   ```
   ✅ Success: Electron project 'MyCoolElectronApp' created successfully in /home/user/projects/MyCoolElectronApp!
   ```

## 📝 Notes

- If you encounter any errors during the installation or setup process, check the `error.log` file located in your project directory for more details.
- The script automatically creates a `main.js` file and a `run` script to start your Electron application.
- Ensure you have the necessary permissions to create directories and run scripts in your chosen project directory.

## 📚 More Info

Electron is a framework that allows you to build cross-platform desktop applications using web technologies. For more details on Electron, visit the official [Electron website](https://www.electronjs.org/).

---

🌟 Happy coding with Electron! 🌟
