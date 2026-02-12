module halfadder (
    input A, B,
    output Sum, Carry
);
    assign Sum   = A ^ B;  
    assign Carry = A & B;  
endmodule

module fulladder (
    input A, B, Cin,
    output Sum, Cout
);
    wire x1, c1, c2;

    halfadder h1 (
        .A(A), .B(B),
        .Sum(x1), .Carry(c1)
    );

    halfadder h2 (
        .A(x1), .B(Cin),
        .Sum(Sum), .Carry(c2)
    );

    assign Cout = c1 | c2;
endmodule