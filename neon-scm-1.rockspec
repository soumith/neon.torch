package = "neon"
version = "scm-1"

source = {
   url = "git://github.com/soumith/neon.torch.git",
}

description = {
   summary = "Torch7 FFI bindings for Nervana Neon kernels!",
   detailed = [[
   All Neon modules exposed as nn.Module derivatives so 
   that they can be used with torch's neural network package
   ]],
   homepage = "https://github.com/soumith/neon.torch",
   license = "BSD"
}

dependencies = {
   "torch >= 7.0",
   "cutorch",
   "nn"
}

build = {
   type = "command",
   build_command = [[
git submodule update --init --recursive
cd neon && make kernels && cd ..
cmake -E make_directory build && cd build && cmake .. -DCMAKE_BUILD_TYPE=Release -DCMAKE_PREFIX_PATH="$(LUA_BINDIR)/.." -DCMAKE_INSTALL_PREFIX="$(PREFIX)" && $(MAKE)
]],
   install_command = "cd build && $(MAKE) install"
}