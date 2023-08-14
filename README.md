# VSCODE INIT

Automate creation of C/C++ projects with Visual Studio Code \
This automation tool is mainly targetet Linux and MacOS users. \
Clone this project into your HOME directory (or any directory really).

## Requirements

* [Visual Studio Code](https://code.visualstudio.com/)
* [C/C++ for Visual Studio Code](https://marketplace.visualstudio.com/items?itemName=ms-vscode.cpptools) (VSCode plugin)
* [git](https://git-scm.com/)
* gcc, gdb, Make
* clang-format (optional)
* [Valgrind](https://valgrind.org/) (optional)
* [AddressSanitizer](https://github.com/google/sanitizers/wiki/AddressSanitizer) (optional)

## C/C++ for Visual Studio Code

Install the C/C++ for Visual Studio Code plugin
<https://marketplace.visualstudio.com/items?itemName=ms-vscode.cpptools>

## How to run the scripts

After this repo has been cloned to your HOME directory, the following commands
can be used to create C/C++ projects.

To create a C project in the directory /tmp/test1 run:

```sh
~/vscode_init/bin/create-c-app /tmp/test1
```

To create a C++ project in the directory /tmp/test1 run:

```sh
~/vscode_init/bin/create-cpp-app /tmp/test1
```

## Install the scripts

To install the script run:

```sh
make install
```

to uninstall them run:

```sh
make uninstall
```

## Optional shell profile alias

Add to ~/.zshrc (or your shell config of choice) \
These aliases can be added automatically by running ```append_alias.sh```

```sh
alias copy-vsctasks="$HOME/vscode_init/copy_tasks.sh"
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

## Building my project

To build your newly created project run:

```sh
make
```

in the root directory of the project. \
To build a production suitable binary run:

```sh
FINAL=y make
```
