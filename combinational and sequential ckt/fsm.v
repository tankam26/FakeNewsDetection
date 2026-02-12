//mealy and moore fsm to detect 101 pattern
module moore(
    input wire clk,
    input wire reset,
    input wire in,
    output reg detected
);
reg [1:0] current_state,next_state;
parameter s0 = 2'b00;
parameter s1 = 2'b01;
parameter s2 = 2'b10;
parameter s3 = 2'b11;
always @(posedge clk or posedge reset) 
begin
    if(reset)
    current_state<=s0;
    else
    current_state<=next_state
end

always@(*)
begin
case (current_state)
    S0: next_state = in ? S1 : S0;
    S1: next_state = in_bit ? S1 : S2;
    S2: next_state = in_bit ? S3 : S0;
    S3: next_state = in_bit ? S1 : S2;
    default: next_state = S0;
    endcase
end
always @(*) begin
    detected = (current_state == S3);
end

endmodule

module mealy(
    input wire clk,
    input wire reset,
    input wire in_bit,
    output reg detected
);

    parameter S0 = 2'b00; 
    parameter S1 = 2'b01; 
    parameter S2 = 2'b10;  
    parameter S3 = 2'b11;  
    reg [1:0] current_state, next_state;

    always @(posedge clk or posedge reset) begin
        if (reset)
            current_state <= S0;
        else
            current_state <= next_state;
    end

    always @(*) begin
        detected = 0; 
        case (current_state)
            S0: next_state = in_bit ? S1 : S0;
            S1: next_state = in_bit ? S1 : S2;
            S2: next_state = in_bit ? S3 : S0;
            S3: begin
                if (in_bit) begin
                    next_state = S1;
                    detected   = 1; /
                end else begin
                    next_state = S2;
                end
            end
            default: next_state = S0;
        endcase
    end

endmodule