module mux2to1(i0,i1,s0,y);

input i0,i1,s0;
output reg y;

always@(*)
begin 
    if(s0)
    y=i1;
    else
    y=i0;
end

endmodule

module 4to1_mux(i0,i1,i2,i3,s0,s1,out);
    input i0, i1, i2, i3,   
    input s0, s1,          
    output out             

    wire s0n, s1n;          
    wire y0, y1, y2, y3;    

    not (s0n, s0);
    not (s1n, s1);

   
    and (y0, i0, s1n, s0n); 
    and (y1, i1, s1n, s0);  
    and (y2, i2, s1, s0n);  
    and (y3, i3, s1, s0);   
   
    or (out, y0, y1, y2, y3);

endmodule

/*
dataflow
assign out = (s1==0 && s0==0) ? i0 :(s1==0 && s0==1) ? i1 :(s1==1 && s0==0) ? i2 :i3;*/

module 8to1_mux(out,i0,i1,i2,i3,i4,i5,i6,i7,s0,s1,s2);
    input i0,i1,i2,i3,i4,i5,i6,i7,s0,s1,s2;
    output reg out;
    always@(*)
    begin
    case({s1,s0})
    3'b000 out=i0;
    3'b001 out=i1;
    3'b010 out=i2;
    3'b011 out=i3;
    3'b100 out=i4;
    3'b101 out=i5;
    3'b110 out=i6;
    3'b111 out=i7;
   
    endcase
    end
endmodule


module 8to1_mux_using2to1_mux(out,i0,i1,i2,i3,i4,i5,i6,i7,s0,s1,s2);
    input i0,i1,i2,i3,i4,i5,i6,i7,s0,s1,s2;
    output out;
    wire y0,y1,y2,y3;
    wire y4,y5;
    mux2to1 m1 (.i0(i0), .i1(i1), .s(s0), .y(y0));
    mux2to1 m2 (.i0(i2), .i1(i3), .s(s0), .y(y1));
    mux2to1 m3 (.i0(i4), .i1(i5), .s(s0), .y(y2));
    mux2to1 m4 (.i0(i6), .i1(i7), .s(s0), .y(y3));
    mux2to1 m5 (.i0(y0), .i1(y1), .s(s1), .y(y4));
    mux2to1 m6 (.i0(y2), .i1(y3), .s(s1), .y(y5));
    mux2to1 m7 (.i0(y4), .i1(y5), .s(s2), .y(out));


endmodule
