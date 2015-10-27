local neon = require 'neon._env'
require 'paths'
require 'cutorch'

neon.C = require 'neon._ffi'
neon._cubin_path = paths.thisfile('cubin') .. '/'

neon.C.nervana_loadKernels(neon._cubin_path)
