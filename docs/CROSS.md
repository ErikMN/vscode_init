# Building for ARM (Debian/Ubuntu)

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
