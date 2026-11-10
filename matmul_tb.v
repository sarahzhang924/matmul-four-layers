// -----------------------------------------------------------------------------
// matmul_tb.v —— 测试平台
//   在 EDA Playground 里粘到 Testbench 那一栏，Language 选 SystemVerilog，
//   Simulator 选 Icarus Verilog，点 Run。
//   期望输出（与 C 版逐位一致）：
//       30 24 18
//       84 69 54
//       138 114 90
// -----------------------------------------------------------------------------
`timescale 1ns/1ps

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
        // a_pack 里第 g 个 8 bit 对应 a[g/N][g%N]，拼接顺序是从高位到低位
        // A = {{1,2,3},{4,5,6},{7,8,9}}
        a_pack = { 8'sd9, 8'sd8, 8'sd7, 8'sd6, 8'sd5, 8'sd4, 8'sd3, 8'sd2, 8'sd1 };
        // B = {{9,8,7},{6,5,4},{3,2,1}}
        b_pack = { 8'sd1, 8'sd2, 8'sd3, 8'sd4, 8'sd5, 8'sd6, 8'sd7, 8'sd8, 8'sd9 };

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
