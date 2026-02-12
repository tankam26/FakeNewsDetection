module SR_latch (S, R, En,Q, Qbar);
input S, R, En;
output reg Q, Qbar;
    always @(*) 
    begin
        if (En) 
        begin
            case ({S,R})
                2'b01: begin Q=1; Qbar=0; end // Reset
                2'b10: begin Q=0; Qbar=1; end // Set
                2'b11: ;                      // Hold state
                2'b00: begin Q=1'bx; Qbar=1'bx; end // Invalid
            endcase
        end
    end
endmodule

module SR_ff(S,R,clk,Q,Qbar);
input S,R,clk
output Q,Qbar
wire Qm,Qmbar;

SR_latch master(
    .S(S),.R(R),.En(clk),.Q(Qmbar),Qbar(Qm)
);

SR_latch slave(
    .S(Qmbar),.R(Qm),.En(~clk),.Q(Q),Qbar(Qbar)
);

endmodule




/* 
module sr_latch_nand (
    input S, R, En,
    output Q, Qbar
);
    wire S_en, R_en;

    nand n1(S_en, S, En);   
    nand n2(R_en, R, En);   

    nand n3(Q, S_en, Qbar); 
    nand n4(Qbar, R_en, Q); 
endmodule

module sr_latch_nand_dataflow (
    input S, R, En,
    output Q, Qbar
);
    wire S_en, R_en;

    assign S_en = ~(S & En);
    assign R_en = ~(R & En);

    assign Q    = ~(S_en & Qbar);
    assign Qbar = ~(R_en & Q);
endmodule
*/
