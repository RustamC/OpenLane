module test_macro
#( parameter size = 32)
(
    clk, rst, y, p_end,
    x0,
    x1, x2, x3, x4, x5, x6, x7, x8, x9,
    //x0, x1, x2, x3, x4, x5, x6, x7, x8, x9, x10,
    //x11, x12, x13, x14, x15, x16, x17, x18, x19
);
    input rst;
    input y;
    input [size-1:0] x0;
    input [size-2:0] x1, x2, x3, x4, x5, x6, x7, x8, x9;
    //input [size-2:0] x0, x1, x2, x3, x5, x6, x7, x8, x9, x10,
    //x11, x12, x13, x14, x15, x16, x17, x18, x19;
    input clk;
    output p_end;
    
    wire [9:0] p;

    spm spm_start_0 (.clk(clk), .rst(rst), .y(y), .x(x0),  .p(p[0]));
    
    spm spm_01 (.clk(clk), .rst(rst), .y(p[0]), .x({p[0], x1[size-2:0]}), .p(p[1]));
    spm spm_02 (.clk(clk), .rst(rst), .y(p[1]), .x({x2[size-2], p[1], x2[size-3:0]}), .p(p[2]));
    spm spm_03 (.clk(clk), .rst(rst), .y(p[2]), .x({x3[size-2:size-3], p[2], x3[size-4:0]}), .p(p[3]));
    spm spm_04 (.clk(clk), .rst(rst), .y(p[3]), .x({x4[size-2:size-4], p[3], x4[size-5:0]}), .p(p[4]));
    spm spm_05 (.clk(clk), .rst(rst), .y(p[4]), .x({x5[size-2:size-5], p[4], x5[size-6:0]}), .p(p[5]));
    spm spm_06 (.clk(clk), .rst(rst), .y(p[5]), .x({x6[size-2:size-6], p[5], x6[size-7:0]}), .p(p[6]));
    spm spm_07 (.clk(clk), .rst(rst), .y(p[6]), .x({x7[size-2:size-7], p[6], x7[size-8:0]}), .p(p[7]));
    spm spm_08 (.clk(clk), .rst(rst), .y(p[7]), .x({x8[size-2:size-8], p[7], x8[size-9:0]}), .p(p[8]));
    
    spm spm_end_0 (.clk(clk), .rst(rst), .y(p[8]), .x({x9[size-2:size-9], p[8], x9[size-10:0]}), .p(p_end));

endmodule

(* blackbox *)
module spm(clk, rst, x, y, p);
    parameter size = 32;
    input clk, rst;
    input y;
    input[size-1:0] x;
    output p;
endmodule
