module counter (
    input  wire clk,       
    input  wire reset,     
    output reg [3:0] count 
);

always @(posedge clk) begin
    if (reset)
        count <= 4'b0000;   
    else
        count <= count + 1; 
end

endmodule

module ringcounter(
    input wire clk,
    input wire reset,
    output reg[3:0] q
);
always @(posedge clk ) begin
    if (reset)begin
        q <= 4'b0001; end
    else
   begin
    q<={q[2:0],q[3]};
   end
    
end
endmodule

module johnsoncounter(
    input wire clk,
    input wire reset,
    output reg[3:0] q
);
always @(posedge clk ) begin
    if (reset)begin
        q <= 4'b0000; end
    else
   begin
    q<={q[2:0],~q[3]};
   end
    
end
endmodule

/*
parameterisation
module johnsoncounter #(parameter N=4) (
    input wire clk,
    input wire reset,
    output reg [N-1:0] q
);
always @(posedge clk or posedge reset) begin
    if (reset)
        q <= {N{1'b0}};
    else
        q <= {q[N-2:0], ~q[N-1]};
end
endmodule
*/