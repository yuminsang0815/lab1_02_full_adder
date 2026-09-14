module full_adder(input wire a,b,cin, output wire s,cout);
wire partial_sum, carry_ab, carry_cin;
half_adder first(.a(a), .b(b), .s(partial_sum), .c(carry_ab));
half_adder second(.a(partial_sum), .b(cin), .s(s), .c(carry_cin));
assign cout = carry_ab | carry_cin;
endmodule