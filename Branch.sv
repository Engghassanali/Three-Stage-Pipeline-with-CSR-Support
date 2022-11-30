module Branch(forwarded_A,forwarded_B,br_taken,opcode,fun3);
    input logic[31:0]forwarded_A,forwarded_B;
    input logic[6:0]opcode;
    input logic[2:0]fun3;
    output logic[1:0] br_taken;

    always_comb begin 
        br_taken = 2'b0;
        if (opcode == 7'b1100011)begin
            case (fun3)
                3'b000:br_taken = (forwarded_A == forwarded_B) ? 2'b01 : 2'b00;
                3'b001:br_taken = (forwarded_A != forwarded_B) ? 2'b01 : 2'b00;
                3'b100:br_taken = ($signed(forwarded_A) <  $signed(forwarded_B)) ? 2'b01 : 2'b00;
                3'b101:br_taken = ($signed(forwarded_A) >  $signed(forwarded_B)) ? 2'b01 : 2'b00;
                3'b110:br_taken = (forwarded_A <  forwarded_B) ? 2'b01 : 2'b00;
                3'b111:br_taken = (forwarded_A >  forwarded_B) ? 2'b01 : 2'b00;
            endcase
        end
        if (opcode == 7'b1101111)begin
            br_taken = 2'b01;
        end
        if (opcode == 7'b1100111)begin
            br_taken = 2'b01;
        end
    end


endmodule