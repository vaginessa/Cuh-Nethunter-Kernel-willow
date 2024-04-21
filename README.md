# Ginkgo Nethunter Kernel

#### `WILLOW (REDMI NOTE 8T) IS UNTESTED!`

Based on the [Cuh-Kernel](https://github.com/tejas101k/Cuh-Kernel) for Android 14 support and applied with patches for Nethunter support. Optimization patches or similar won't be added.

*Everything should work, I didn't tested it completely though.*

## Build
Have **Ubuntu 20.04**. *(You can use [distrobox](https://wiki.archlinux.org/title/Distrobox))* 

 1. Run `setup_environment.sh` for downloading the compiler etc.
 2. Run `build.sh` for building the kernel.
 3. Run `produce_flashable_kernel.sh`  for creating a AnyKernel zip which you can flash in TWRP, OrangeFox etc.

Run `make clean && make mrproper` for cleaning the environment.
