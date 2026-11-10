// -----------------------------------------------------------------------------
// matmul.cu —— 一个线程算一个 C[i][j]
//
// 线程数怎么算：
//   block(32,32)  = 每块 1024 个线程
//   grid(1,1)     = 1 个块
//   3x3 只需要 9 个线程，其余 1015 个线程被 if (row<N && col<N) 挡在门外。
//   三个 if 少写一个，就会越界读写，直接崩。
// -----------------------------------------------------------------------------
#include <stdio.h>

#define N 3

__global__ void matmulKernel(const int *a, const int *b, int *c) {
    int row = blockIdx.y * blockDim.y + threadIdx.y;
    int col = blockIdx.x * blockDim.x + threadIdx.x;
    if (row < N && col < N) {
        int sum = 0;
        for (int k = 0; k < N; k++) {
            sum += a[row * N + k] * b[k * N + col];
        }
        c[row * N + col] = sum;
    }
}

int main(void) {
    int h_a[N * N] = {1, 2, 3, 4, 5, 6, 7, 8, 9};
    int h_b[N * N] = {9, 8, 7, 6, 5, 4, 3, 2, 1};
    int h_c[N * N];

    int *d_a, *d_b, *d_c;
    cudaMalloc(&d_a, N * N * sizeof(int));
    cudaMalloc(&d_b, N * N * sizeof(int));
    cudaMalloc(&d_c, N * N * sizeof(int));

    cudaMemcpy(d_a, h_a, N * N * sizeof(int), cudaMemcpyHostToDevice);
    cudaMemcpy(d_b, h_b, N * N * sizeof(int), cudaMemcpyHostToDevice);

    dim3 threads(32, 32);                       // 每块 1024 线程
    dim3 blocks((N + 31) / 32, (N + 31) / 32);  // 3x3 只需 1 块
    matmulKernel<<<blocks, threads>>>(d_a, d_b, d_c);

    cudaMemcpy(h_c, d_c, N * N * sizeof(int), cudaMemcpyDeviceToHost);

    for (int i = 0; i < N; i++) {
        for (int j = 0; j < N; j++) {
            printf("%d ", h_c[i * N + j]);
        }
        printf("\n");
    }

    cudaFree(d_a);
    cudaFree(d_b);
    cudaFree(d_c);
    return 0;
}
