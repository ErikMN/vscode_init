# VSCODE INIT <img src="vscode.svg" width="32" alt="logo"/>

Automate creation of C/C++ projects with Visual Studio Code <br/>
This automation tool is mainly targetet **Linux** and **macOS** users. <br/>
Clone this project into your ```$HOME``` directory (or any directory really).

## Elevator pitch

* Simple to setup and use
* No need to install (but possible)
* No hidden configuration files
* No modification of your system
* Inspired by [Create React App](https://create-react-app.dev/)
* Tested and maintained for Linux and macOS

## Requirements

**Bash** is really the only true requirement to run the script. <br/>
The list below is additional software to get the most out of **VSCODE INIT**.

* [Bash](https://www.gnu.org/software/bash/) or [Zsh](https://www.zsh.org/)
* [Visual Studio Code](https://code.visualstudio.com/)
* [C/C++ for Visual Studio Code](https://marketplace.visualstudio.com/items?itemName=ms-vscode.cpptools) (VSCode plugin)
* gcc, gdb, clang, lldb, Make, Meson
* clang-format (optional)
* [git](https://git-scm.com/) (optional)
* [Valgrind](https://valgrind.org/) (optional)
* [AddressSanitizer](https://github.com/google/sanitizers/wiki/AddressSanitizer) (optional)

## C/C++ for Visual Studio Code

Install the C/C++ for Visual Studio Code plugin
<https://marketplace.visualstudio.com/items?itemName=ms-vscode.cpptools>

## How to run the scripts

After this repo has been cloned to your ```$HOME``` directory, the following commands
can be used to create C/C++ projects.

To create a C project in the directory ```/tmp/test1``` run:

```sh
~/vscode_init/bin/create-c-app /tmp/test1
```

To create a C++ project in the directory /tmp/test1 run:

```sh
~/vscode_init/bin/create-cpp-app /tmp/test1
```

## Install the scripts

To install the scripts run (as root):

```sh
make install
```

default location is ```/usr/local/``` <br/>
to uninstall the scripts run (as root):

```sh
make uninstall
```

Use **PREFIX** to specify your own installation directory:

```sh
make install PREFIX=/usr/local
```

## Optional shell profile alias

If you don't want to install the scripts, they can be run directly. <br/>
Add to ```~/.zshrc``` (or your shell config of choice). <br/>
These aliases can be added automatically by running ```append_alias.sh```

```sh
alias copy-vsctasks="$HOME/vscode_init/utils/copy_tasks.sh"
```

```sh
alias create-c-app="$HOME/vscode_init/bin/create-c-app"
```

```sh
alias create-cpp-app="$HOME/vscode_init/bin/create-cpp-app"
```

```sh
alias create-shared-lib-c-app="$HOME/vscode_init/bin/create-shared-lib-c-app"
```

```sh
alias create-c-meson-app="$HOME/vscode_init/bin/create-c-meson-app"
```

In a directory of choice then run:

```sh
create-c-app <name-of-my-app>
```

to setup a C project with VScode tasks.

Or run:

```sh
copy-vsctasks
```

in an existing project to copy VScode tasks to that directory.

## Building my created project

To build your newly created C project run:

```sh
make
```

in the root directory of the project. <br/>
To build a production suitable binary run:

```sh
FINAL=y make
```

## Custom project workspace settings

Edit `settings.json` to add custom project workspace settings. <br/>
Example: source a script for zsh at terminal startup.

```sh
{
  "terminal.integrated.profiles.linux": {
    "zsh": {
      "path": "zsh",
      "args": [
        "-c",
        "source ${workspaceFolder}/my_script.sh; zsh"
      ]
    }
  }
}
```
