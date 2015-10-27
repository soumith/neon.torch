local ffi = require 'ffi'

ffi.cdef[[
typedef struct CUstream_st *CUstream;

bool nervana_loadKernels(const char* const base_path);
bool nervana_unloadKernels();
size_t nervana_randStateSizeBytes();
bool nervana_sgemm(float *A, float *B, float *C,
                    bool a_t, bool b_t,
                    int m, int n, int k,
                    int lda, int ldb, int ldc,
                    float alpha, float beta,
                    unsigned int *rand_state,
                    bool stochastic_round, bool apply_relu,
                    CUstream stream, int grid
                    );

bool nervana_hgemm(short *A, short *B, short *C,
                    bool a_t, bool b_t,
                    int m, int n, int k,
                    int lda, int ldb, int ldc,
                    float alpha, float beta,
                    unsigned int *rand_state,
                    bool stochastic_round, bool apply_relu,
                    CUstream stream, int grid
                    );
]]

return ffi.load(package.searchpath('libneon', package.cpath))
