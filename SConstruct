#!/usr/bin/env python

# I hate sconstruct

env = SConscript("godot-cpp/SConstruct")

env["buildpath"] = "../demo/addons"

env["rootpath"] = "Godot-opus"
SConscript("Godot-opus/SConstruct", exports="env")
env["rootpath"] = "Godot-rnnoise"
SConscript("Godot-rnnoise/SConstruct", exports="env")
env["rootpath"] = "Godot-audio-resampler"
SConscript("Godot-audio-resampler/SConstruct", exports="env")

