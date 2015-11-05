local neon = require 'neon._env'
require 'paths'
require 'cutorch'
local ffi = require 'ffi'

neon.C = require 'neon._ffi'
neon._cubin_path = paths.thisfile('cubin') .. '/'

neon.C.nervana_loadKernels(neon._cubin_path)

local bufferBytes = neon.C.nervana_randStateSizeBytes()
neon._randState_t = torch.CudaTensor(math.ceil(tonumber(bufferBytes) / 4))
neon._randState = ffi.cast('unsigned int*', neon._randState_t:data())

local function trans(m1)
   local m1_t = false;
   if m1:stride(1) == 1 and m1:stride(2) ~= 0 then m1_t = true end
   return m1_t
end

function neon.mm(res, mat1, mat2)
   if not mat2 then
      -- (mat1, mat2)
      mat2 = mat1
      mat1 = res
      res = torch.CudaTensor(mat1:size(1), mat2:size(2)):zero()
   end

   neon.C.nervana_sgemm(mat1:data(), mat2:data(), res:data(),
                true, true,
                res:size(1), res:size(2), mat1:size(2),
                mat1:stride(1), mat2:stride(1), res:stride(1),
                1.0, 1.0, neon._randState, false, false, NULL, -1)
   return res
end

return neon
