`define RISCV_INPS(idx) \
    input  [ 31:0]  mem_d_data_rd_i_``idx \
    ,input           mem_d_accept_i_``idx \
    ,input           mem_d_ack_i_``idx \
    ,input           mem_d_error_i_``idx \
    ,input  [ 10:0]  mem_d_resp_tag_i_``idx \
    ,input           mem_i_accept_i_``idx \
    ,input           mem_i_valid_i_``idx \
    ,input           mem_i_error_i_``idx \
    ,input  [ 31:0]  mem_i_inst_i_``idx \
    ,input           intr_i_``idx \
    ,input  [ 31:0]  reset_vector_i_``idx \
    ,input  [ 31:0]  cpu_id_i_``idx

`define RISCV_OUTS(idx) \
    output [ 31:0]  mem_d_addr_o_``idx \
    ,output [ 31:0]  mem_d_data_wr_o_``idx \
    ,output          mem_d_rd_o_``idx \
    ,output [  3:0]  mem_d_wr_o_``idx \
    ,output          mem_d_cacheable_o_``idx \
    ,output [ 10:0]  mem_d_req_tag_o_``idx \
    ,output          mem_d_invalidate_o_``idx \
    ,output          mem_d_writeback_o_``idx \
    ,output          mem_d_flush_o_``idx \
    ,output          mem_i_rd_o_``idx \
    ,output          mem_i_flush_o_``idx \
    ,output          mem_i_invalidate_o_``idx \
    ,output [ 31:0]  mem_i_pc_o_``idx

`define CORE_MODULE(idx) \
    riscv_core c_``idx ( \
        clk_i, \
        rst_i, \
        mem_d_data_rd_i_``idx, \
        mem_d_accept_i_``idx, \
        mem_d_ack_i_``idx, \
        mem_d_error_i_``idx, \
        mem_d_resp_tag_i_``idx, \
        mem_i_accept_i_``idx, \
        mem_i_valid_i_``idx, \
        mem_i_error_i_``idx, \
        mem_i_inst_i_``idx, \
        intr_i_``idx, \
        reset_vector_i_``idx, \
        cpu_id_i_``idx, \
        mem_d_addr_o_``idx, \
        mem_d_data_wr_o_``idx, \
        mem_d_rd_o_``idx, \
        mem_d_wr_o_``idx, \
        mem_d_cacheable_o_``idx, \
        mem_d_req_tag_o_``idx, \
        mem_d_invalidate_o_``idx, \
        mem_d_writeback_o_``idx, \
        mem_d_flush_o_``idx, \
        mem_i_rd_o_``idx, \
        mem_i_flush_o_``idx, \
        mem_i_invalidate_o_``idx, \
        mem_i_pc_o_``idx \
    )

module riscv_top
//-----------------------------------------------------------------
// Ports
//-----------------------------------------------------------------
(
    // Inputs
     input clk_i
    ,input rst_i
    ,`RISCV_INPS(1)    
    ,`RISCV_INPS(2)
    ,`RISCV_INPS(3)
    ,`RISCV_INPS(4)
    ,`RISCV_INPS(5)
    ,`RISCV_INPS(6)
    ,`RISCV_INPS(7)
    ,`RISCV_INPS(8)
    ,`RISCV_INPS(9)
    ,`RISCV_INPS(10)
    ,`RISCV_INPS(11)
    ,`RISCV_OUTS(12)
    ,`RISCV_OUTS(13)
    ,`RISCV_OUTS(14)
    ,`RISCV_OUTS(15)
    ,`RISCV_OUTS(16)
    ,`RISCV_OUTS(17)
    ,`RISCV_OUTS(18)
    ,`RISCV_OUTS(19)
    ,`RISCV_OUTS(20)
    ,`RISCV_INPS(21)    
    ,`RISCV_INPS(22)
    ,`RISCV_INPS(23)
    ,`RISCV_INPS(24)
    ,`RISCV_INPS(25)
    ,`RISCV_INPS(26)
    ,`RISCV_INPS(27)
    ,`RISCV_INPS(28)
    ,`RISCV_INPS(29)
    ,`RISCV_INPS(30)
    ,`RISCV_INPS(31)
    ,`RISCV_OUTS(32)
    ,`RISCV_OUTS(33)
    ,`RISCV_OUTS(34)
    ,`RISCV_OUTS(35)
    ,`RISCV_OUTS(36)
    ,`RISCV_OUTS(37)
    ,`RISCV_OUTS(38)
    ,`RISCV_OUTS(39)
    ,`RISCV_OUTS(40)

    // Outputs
    ,`RISCV_OUTS(1)
    ,`RISCV_OUTS(2)
    ,`RISCV_OUTS(3)
    ,`RISCV_OUTS(4)
    ,`RISCV_OUTS(5)
    ,`RISCV_OUTS(6)
    ,`RISCV_OUTS(7)
    ,`RISCV_OUTS(8)
    ,`RISCV_OUTS(9)
    ,`RISCV_OUTS(10)
    ,`RISCV_OUTS(11)
    ,`RISCV_OUTS(12)
    ,`RISCV_OUTS(13)
    ,`RISCV_OUTS(14)
    ,`RISCV_OUTS(15)
    ,`RISCV_OUTS(16)
    ,`RISCV_OUTS(17)
    ,`RISCV_OUTS(18)
    ,`RISCV_OUTS(19)
    ,`RISCV_OUTS(20)
    ,`RISCV_OUTS(21)
    ,`RISCV_OUTS(22)
    ,`RISCV_OUTS(23)
    ,`RISCV_OUTS(24)
    ,`RISCV_OUTS(25)
    ,`RISCV_OUTS(26)
    ,`RISCV_OUTS(27)
    ,`RISCV_OUTS(28)
    ,`RISCV_OUTS(29)
    ,`RISCV_OUTS(30)
    ,`RISCV_OUTS(31)
    ,`RISCV_OUTS(32)
    ,`RISCV_OUTS(33)
    ,`RISCV_OUTS(34)
    ,`RISCV_OUTS(35)
    ,`RISCV_OUTS(36)
    ,`RISCV_OUTS(37)
    ,`RISCV_OUTS(38)
    ,`RISCV_OUTS(39)
    ,`RISCV_OUTS(40)
);

    `CORE_MODULE(1);
    `CORE_MODULE(2);
    `CORE_MODULE(3);
    `CORE_MODULE(4);
    `CORE_MODULE(5);
    `CORE_MODULE(6);
    `CORE_MODULE(7);
    `CORE_MODULE(8);
    `CORE_MODULE(9);
    `CORE_MODULE(10);
    `CORE_MODULE(11);
    `CORE_MODULE(12);
    `CORE_MODULE(13);
    `CORE_MODULE(14);
    `CORE_MODULE(15);
    `CORE_MODULE(16);
    `CORE_MODULE(17);
    `CORE_MODULE(18);
    `CORE_MODULE(19);    
    `CORE_MODULE(20);
    `CORE_MODULE(21);
    `CORE_MODULE(22);
    `CORE_MODULE(23);
    `CORE_MODULE(24);
    `CORE_MODULE(25);
    `CORE_MODULE(26);
    `CORE_MODULE(27);
    `CORE_MODULE(28);
    `CORE_MODULE(29);
    `CORE_MODULE(30);
    `CORE_MODULE(31);
    `CORE_MODULE(32);
    `CORE_MODULE(33);
    `CORE_MODULE(34);
    `CORE_MODULE(35);
    `CORE_MODULE(36);
    `CORE_MODULE(37);
    `CORE_MODULE(38);
    `CORE_MODULE(39);    
    `CORE_MODULE(40);
endmodule
