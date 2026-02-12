//siso
module siso(
    input wire clk,
    input wire reset,
    input wire serial_in,
    output wire serial_out
);
reg [3:0] shift_reg; 
always @(posedge clk) begin //synch
    if (reset)
        shift_reg <= 4'b0000;           
    else
        shift_reg <= {shift_reg[2:0], serial_in}; 
end
assign serial_out = shift_reg[3]; 
endmodule


//sipo
module sipo(
    input wire clk,
    input wire rest,
    input wire s_in,
    output reg [3:0] p_out
);
reg [3:0] shift_reg; 
always @(posedge clk ) begin
    if (reset)
        shift_reg <= 4'b0000;
    else
      shift_reg <= {shift_reg[2:0], serial_in}; 
end
always @(*) begin
        p_out = shift_reg;
    end
endmodule


//pipo
module pipo(input wire clk,
    input wire reset,
    input [3:0] p_in,
    output reg [3:0] p_out);

always @(posedge clk or posedge reset) begin //asynch
    if (reset)begin
        p_out <= 4'b0000;  
    end        
    else 
    begin
     p_out <= p_in;     
    end  
end

endmodule


//piso
module piso(
    input wire clk,
    input wire reset,
    inout wire load,
    input wire [3:0] p_in,
    output wire s_out
);
reg [3:0] shift_reg;
always @(posedge clk ) begin
  if (reset) begin
            shift_reg <= 4'b0000;
        end else if (load) begin
            shift_reg <= p_in;
        end else begin
            shift_reg <= {shift_reg[2:0], 1'b0};
        end
end 
assign s_out=shift_reg[3];
endmodule