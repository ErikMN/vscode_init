# VSCODE INIT

Automate creation of projects with VSCODE \
Clone this project into your HOME directory.

## Requirements

* Visual Studio Code
* git
* gcc, gdb, Make

## C Project creation

Install the C/C++ for Visual Studio Code plugin
<https://marketplace.visualstudio.com/items?itemName=ms-vscode.cpptools>

## Building for ARM

Install the GCC, G++ cross compilers and support programs by typing:

```sh
sudo apt-get install libc6-armel-cross libc6-dev-armel-cross binutils-arm-linux-gnueabi libncurses5-dev build-essential bison flex libssl-dev bc
```

Install GCC for ARM:

```sh
sudo apt-get install gcc-arm-linux-gnueabihf g++-arm-linux-gnueabihf
```

In Makefile

```sh
CC = arm-linux-gnueabihf-gcc
```

## Shell profile alias

Add to ~/.zshrc (or your shell config of choice)

```sh
alias copy-vsctasks="source $HOME/vscode_init/copy_tasks.sh"
```

```sh
alias create-c-app="source $HOME/vscode_init/init_cproject.sh"
```

```sh
alias create-cpp-app="source $HOME/vscode_init/init_cpp_project.sh"
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
