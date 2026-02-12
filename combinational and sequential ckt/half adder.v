/*

3. Mini State Machines
- Traffic Light Controller → Simple FSM with timed transitions.
- Sequence Detector (e.g., detect “1011”) → Teaches FSM design and verification.

4. Practical Small Systems
- ALU (Arithmetic Logic Unit) → Combine add, subtract, AND, OR, XOR into one module.
- FIFO Buffer → Learn about pointers, memory arrays, and overflow/underflow.
- UART Transmitter (basic) → First taste of real-world digital communication.

*/


//gate level modelling
module halfadder(sum,carry,a,b);
input a,b;
output sum,carry;

xor g1(sum,a,b);
and g2(carry,a,b);

endmodule

//data flow modelling
module halfadder(sum,carry,a,b);
input a,b;
output sum,carry;
assign sum=a^b;
assign carry=a&b;

endmodule

//behavioural modelling
module halfadder(sum,carry,a,b);
input a,b;
output reg sum,carry;
@always(*)
begin
    sum=a^b;
    carry=a&b;
end
endmodule

