# Building for ARM (Debian/Ubuntu)

Install the GCC, G++ cross compilers and support programs by typing:

```sh
sudo apt install libc6-armel-cross libc6-dev-armel-cross binutils-arm-linux-gnueabi libncurses5-dev build-essential bison flex libssl-dev bc
```

## Install GCC for ARM

### 32-bit ARM

```sh
sudo apt install gcc-arm-linux-gnueabihf g++-arm-linux-gnueabihf
```

### 64-bit ARM

```sh
sudo apt install gcc-aarch64-linux-gnu
```

### Makefile

```sh
CC = arm-linux-gnueabihf-gcc

CC = aarch64-linux-gnu-gcc
```
