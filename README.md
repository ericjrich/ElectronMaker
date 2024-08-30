# Electron Project Setup Script

<p>This repository contains a Bash script to automate the setup of a basic Electron project. The script uses Zenity for graphical prompts and handles everything from project initialization to Electron installation and file creation.</p>

<hr>

## Prerequisites

<p>Before running the script, ensure that you have the following installed on your system:</p>

<ul>
    <li><strong>Node.js</strong> and <strong>npm</strong>: Required to initialize the project and install dependencies.</li>
    <li><strong>Zenity</strong>: Used for graphical dialogs to interact with the user.</li>
    <li><strong>jq</strong> (optional but recommended): Used to modify <code>package.json</code> more safely.</li>
</ul>

<hr>

## How to Use the Script

<ol>
    <li>
        <strong>Clone this repository</strong> to your local machine:
        <pre><code>
git clone &lt;repository-url&gt;
cd &lt;repository-directory&gt;
        </code></pre>
    </li>
    <li>
        <strong>Make the script executable:</strong>
        <pre><code>
chmod +x electronmaker.sh
        </code></pre>
    </li>
    <li>
        <strong>Run the script:</strong>
        <pre><code>
./electronmaker.sh
        </code></pre>
        <ul>
            <li>You will be prompted to enter the project name.</li>
            <li>You will be prompted to select a directory where the project should be created.</li>
            <li>You can optionally select a directory containing your <code>index.html</code> and other necessary files. If you skip this step, you will be asked to select a specific file to use as <code>index.html</code>.</li>
        </ul>
    </li>
    <li>
        <strong>The script will:</strong>
        <ul>
            <li>Create a new project directory.</li>
            <li>Initialize a Node.js project with <code>npm init</code>.</li>
            <li>Install Electron as a development dependency.</li>
            <li>Create a basic <code>main.js</code> file.</li>
            <li>Update <code>package.json</code> to include the main file and start script.</li>
            <li>Create a <code>run.sh</code> file for launching the application.</li>
        </ul>
    </li>
    <li>
        <strong>Success:</strong> Once the script completes, you will receive a success message indicating that the Electron project has been created.
    </li>
</ol>

<hr>

## Running Your Electron Project

<ol>
    <li>
        <strong>Navigate to your project directory:</strong>
        <pre><code>
cd /path/to/your/project
        </code></pre>
    </li>
    <li>
        <strong>Run the application:</strong>
        <pre><code>
./run.sh
        </code></pre>
        <p>This will start your Electron application using the configuration created by the script.</p>
    </li>
</ol>

<hr>

## Troubleshooting

<ul>
    <li>
        <strong>Error Messages:</strong> Any errors encountered during the setup will be shown via Zenity and logged into <code>error.log</code> within the project directory.
    </li>
    <li>
        <strong>Missing Zenity:</strong> If you do not have Zenity installed, you can install it using your package manager:
        <pre><code>
sudo apt-get install zenity   # For Debian/Ubuntu
sudo dnf install zenity       # For Fedora
        </code></pre>
    </li>
    <li>
        <strong>jq Not Found:</strong> If <code>jq</code> is not installed, the script will use <code>sed</code> to update <code>package.json</code>. Install <code>jq</code> for more reliable JSON processing:
        <pre><code>
sudo apt-get install jq   # For Debian/Ubuntu
sudo dnf install jq       # For Fedora
        </code></pre>
    </li>
</ul>

<hr>

## Notes

<p>The script is designed for Unix-based systems (Linux/macOS). Windows users may need to adapt the script or run it in a compatible environment like WSL (Windows Subsystem for Linux).</p>

<hr>


## Author

<p>Created by <strong>EJR</strong>.</p>
