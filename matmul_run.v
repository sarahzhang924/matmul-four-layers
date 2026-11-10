// -----------------------------------------------------------------------------
// matmul_run.v —— 单文件版（模块 + 测试激励写在一起）
//   用法：https://www.jdoodle.com/execute-verilog-online
//         1. 全选编辑器里原有的示例代码，删掉
//         2. 把本文件全部内容粘进去
//         3. 右上角 Verilog 版本选 12（或默认），点 Execute
//   期望输出：
//       30 24 18
//       84 69 54
//       138 114 90
// -----------------------------------------------------------------------------
`timescale 1ns/1ps

// ============================ 设计 ============================
module matmul #(parameter N = 3) (
    input  signed [N*N*8-1:0]  a_pack,
    input  signed [N*N*8-1:0]  b_pack,
    output signed [N*N*16-1:0] c_pack
);

    genvar i, j;
    generate
        for (i = 0; i < N; i = i + 1) begin : row
            for (j = 0; j < N; j = j + 1) begin : col
                assign c_pack[(i*N + j)*16 +: 16] =
                      $signed(a_pack[(i*N + 0)*8 +: 8]) * $signed(b_pack[(0*N + j)*8 +: 8])
                    + $signed(a_pack[(i*N + 1)*8 +: 8]) * $signed(b_pack[(1*N + j)*8 +: 8])
                    + $signed(a_pack[(i*N + 2)*8 +: 8]) * $signed(b_pack[(2*N + j)*8 +: 8]);
            end
        end
    endgenerate

endmodule

// ========================== 测试激励 ==========================
module matmul_tb;

    localparam N = 3;

    reg  signed [N*N*8-1:0]  a_pack;
    reg  signed [N*N*8-1:0]  b_pack;
    wire signed [N*N*16-1:0] c_pack;

    matmul #(.N(N)) uut (
        .a_pack(a_pack),
        .b_pack(b_pack),
        .c_pack(c_pack)
    );

    integer i, j;

    initial begin
        // A = {{1,2,3},{4,5,6},{7,8,9}}，第 0 个元素放在最低 8 位，所以拼接顺序要倒过来
        a_pack = {8'sd9, 8'sd8, 8'sd7, 8'sd6, 8'sd5, 8'sd4, 8'sd3, 8'sd2, 8'sd1};
        // B = {{9,8,7},{6,5,4},{3,2,1}}
        b_pack = {8'sd1, 8'sd2, 8'sd3, 8'sd4, 8'sd5, 8'sd6, 8'sd7, 8'sd8, 8'sd9};

        #10;

        for (i = 0; i < N; i = i + 1) begin
            for (j = 0; j < N; j = j + 1) begin
                $write("%0d ", $signed(c_pack[(i*N + j)*16 +: 16]));
            end
            $write("\n");
        end

        $finish;
    end

endmodule
