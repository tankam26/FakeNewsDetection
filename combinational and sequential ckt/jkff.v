module jk_ff (
    input J, K, clk, reset,
    output reg Q, Qbar
);
    always @(posedge clk or posedge reset) 
    begin
        if (reset) 
        begin
            Q <= 0;
            Qbar <= 1;
        end
        else 
        begin
            case ({J,K})
                2'b00: Q <= Q;      
                2'b01: Q <= 0;       
                2'b10: Q <= 1;      
                2'b11: Q <= ~Q;        
            endcase
            Qbar <= ~Q;
        end
    end
endmodule

//using sr latch
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


module JK_flipflop(J,K,clk,Q,Qbar);
input J,K,clk;
output Q,Qbar;
wire s_in,r_in;
wire Qm,Qmbar;

assign S_int = J & Qbar; 
assign R_int = K & Q;

SR_latch master(
    .S(s_in),.R(r_in),.En(clk),.Q(Qm),Qbar(Qmbar)
);

SR_latch slave(
    .S(Qm),.R(Qmbar),.En(~clk),.Q(Q),Qbar(Qbar)
);

endmodule

/*testbench
`timescale 1ns/1ps

module tb_jk_ff;
    reg J, K, clk;
    wire Q, Qbar;

    // Instantiate the JK flip-flop
    jk_ff uut (
        .J(J),
        .K(K),
        .clk(clk),
        .Q(Q),
        .Qbar(Qbar)
    );

    // Clock generation: 10ns period
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // Toggle every 5ns
    end

    // Stimulus
    initial begin
        // Monitor signals
        $monitor("Time=%0t | J=%b K=%b clk=%b | Q=%b Qbar=%b", 
                  $time, J, K, clk, Q, Qbar);

        // Initial values
        J = 0; K = 0;

        // Case 1: Hold
        #10 J=0; K=0;

        // Case 2: Reset
        #10 J=0; K=1;

        // Case 3: Set
        #10 J=1; K=0;

        // Case 4: Toggle
        #10 J=1; K=1;

        // Repeat toggle to see effect
        #20 J=1; K=1;

        // Back to Hold
        #10 J=0; K=0;

        // Finish simulation
        #50 $finish;
    end
endmodule*/