module CSR_Regfile(csr_PC,csr_wdata,intrrupt,csr_inaddr,csr_rdata,epc,clk,csr_reg_wrMW,csr_reg_rdMW,reset);
    input logic[31:0] csr_PC,csr_wdata,csr_inaddr;
    input logic intrrupt,clk,reset,csr_reg_wrMW,csr_reg_rdMW;
    output logic [31:0]csr_rdata, epc;
    logic[31:0] csr_mstatus_ff,csr_mip_ff,csr_mie_ff,csr_mcause_ff,csr_mepc_ff,csr_mtvec_ff;
    logic [31:0] csr_register_memory[0:6];
    logic csr_mstatus_wr_flag,csr_mip_wr_flag,csr_mie_wr_flag,csr_mcause_wr_flag,csr_mtvec_wr_flag,csr_mepc_wr_flag;
    integer i;

        
    always_comb begin
        if (reset) begin
            for (i=0; i<6; i++)begin
                csr_register_memory[i] = 0;
            end
        end
    end
    //CSR Read Operation
    always_comb begin
        csr_rdata = 0;
        if (csr_reg_rdMW)begin
            case (csr_inaddr)
                12'h300 : csr_rdata = csr_mstatus_ff; 
                12'h344 : csr_rdata = csr_mip_ff; 
                12'h304 : csr_rdata = csr_mie_ff; 
                12'h342 : csr_rdata = csr_mcause_ff; 
                12'h305 : csr_rdata = csr_mtvec_ff; 
                12'h341 : csr_rdata = csr_mepc_ff;  
            endcase
        end
    end
    //CSR Write Operation
    always_comb begin 
        csr_mstatus_wr_flag = 1'b0;
        csr_mip_wr_flag     = 1'b0;
        csr_mie_wr_flag     = 1'b0;
        csr_mcause_wr_flag  = 1'b0;
        csr_mtvec_wr_flag   = 1'b0;
        csr_mepc_wr_flag    = 1'b0;
        if (~csr_reg_wrMW)begin
            case (csr_inaddr)
                12'h300 : csr_mstatus_wr_flag = 1'b1; 
                12'h344 : csr_mip_wr_flag     = 1'b1; 
                12'h304 : csr_mie_wr_flag     = 1'b1; 
                12'h342 : csr_mcause_wr_flag  = 1'b1; 
                12'h305 : csr_mtvec_wr_flag   = 1'b1; 
                12'h341 : csr_mepc_wr_flag    = 1'b1;  
            endcase
        end 
    end
    always_ff @( negedge clk, negedge reset ) begin
        if (reset)begin
            csr_mstatus_ff <= 0;
        end
        else if(csr_mstatus_wr_flag)begin
            csr_mstatus_ff <= csr_wdata;
        end
        
    end
    always_ff @( negedge clk, negedge reset ) begin
        if (reset)begin
            csr_mip_ff <= 0;
        end
        else if(csr_mip_wr_flag)begin
            csr_mip_ff <= csr_wdata;
        end
        
    end
    always_ff @( negedge clk, negedge reset ) begin
        if (reset)begin
            csr_mie_ff <= 0;
        end
        else if(csr_mie_wr_flag)begin
            csr_mie_ff <= csr_wdata;
        end
        
    end
    always_ff @( negedge clk, negedge reset ) begin
        if (reset)begin
            csr_mcause_ff <= 0;
        end
        else if(csr_mcause_wr_flag)begin
            csr_mcause_ff <= csr_wdata;
        end
        
    end
    always_ff @( negedge clk, negedge reset ) begin
        if (reset)begin
            csr_mtvec_ff <= 0;
        end
        else if(csr_mtvec_wr_flag)begin
            csr_mtvec_ff <= csr_wdata;
        end
        
    end
    always_ff @( negedge clk, negedge reset ) begin
        if (reset)begin
            csr_mepc_ff <= 0;
        end
        else if(csr_mepc_wr_flag)begin
            csr_mepc_ff <= csr_wdata;
        end
        
    end


endmodule