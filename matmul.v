// -----------------------------------------------------------------------------
// matmul.v —— 3x3 矩阵乘法的组合逻辑实现（Verilog-2001）
//
// 端口为什么写成扁平向量：
//   常见的  input signed [7:0] a[0:2][0:2];  是“非压缩数组端口”，属 SystemVerilog
//   语法，Verilog-2001 与多数在线工具都不认。改成扁平向量后到处都能跑：
//   9 个 8 bit 拼成 72 bit，取第 g 个元素就是 a_pack[g*8 +: 8]。
//
// 并行从哪来：
//   generate + genvar 在编译期把 9 个乘加表达式展开成 9 条并行的 assign，
//   仿真时这 9 条同时求值，没有任何先后顺序 —— 这就是电路并行。
// -----------------------------------------------------------------------------
module matmul #(parameter N = 3) (
    input  signed [N*N*8-1:0]  a_pack,   // A 的 9 个元素，按行拼接
    input  signed [N*N*8-1:0]  b_pack,   // B 的 9 个元素，按行拼接
    output signed [N*N*16-1:0] c_pack    // C 的 9 个元素，乘积会变宽所以给 16 bit
);

    genvar i, j;
    generate
        for (i = 0; i < N; i = i + 1) begin : row
            for (j = 0; j < N; j = j + 1) begin : col
                // C[i][j] = A[i][0]*B[0][j] + A[i][1]*B[1][j] + A[i][2]*B[2][j]
                assign c_pack[(i*N + j)*16 +: 16] =
                      $signed(a_pack[(i*N + 0)*8 +: 8]) * $signed(b_pack[(0*N + j)*8 +: 8])
                    + $signed(a_pack[(i*N + 1)*8 +: 8]) * $signed(b_pack[(1*N + j)*8 +: 8])
                    + $signed(a_pack[(i*N + 2)*8 +: 8]) * $signed(b_pack[(2*N + j)*8 +: 8]);
            end
        end
    endgenerate

endmodule
