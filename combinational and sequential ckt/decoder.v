module decoder(a,b,e,d);
input a,b,e;
output[3,:0] d;
assign d[3]=~(~a&~b&~e);
assign d[2]=~(~a&b&~e);
assign d[1]=~(a,~b&~e);
assign d[0]=~(a&b&~e);
endmodule

