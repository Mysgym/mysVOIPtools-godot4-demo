## Overview

  This is a demo illustrating the combined use of my godot extensions aiming to provide modular tools to implement quality VOIP within godot.

  - [Resampling](https://github.com/Mysgym/Godot-audio-resampler)
  - [Opus encoding](https://github.com/Mysgym/Godot-opus)
  - [Rnnoise denoiser](https://github.com/Mysgym/Godot-rnnoise)

  The demo uses these three extensions to process sound from the microphone input, resampling, removing background noise then compressing and decompressing creating light packets to send over IP however you see fit.

## Building

  This repo uses scons to build all three extensions at once, using the same godot-cpp folder for efficiency.

  1- Clone this repo, do not recurse submodules to avoid multiplying godot-cpp for each extension
  ```
  git clone https://github.com/Mysgym/mysVOIPtools-godot4-demo && cd https://github.com/Mysgym/mysVOIPtools-godot4-demo
  ```

  2- Initialize extensions and godot-cpp modules
  ```
  git submodule update --init
  ```

  3- Build using scons
  ```
  scons
  ```

  4- Run the project within the demo folder using godot.

  5- Optional : Copy the extensions to your own project by copying the contents of the demo/addons folder to your own.

## Usage

  Detailed usage of each extension is provided in the associated repos README.
