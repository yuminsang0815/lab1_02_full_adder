`timescale 1ns/1ps
module tb_full_adder;
    reg a,b,cin; wire s,cout; full_adder dut(a,b,cin,s,cout);
    integer n, checked = 0;
    reg [1:0] expected;
initial begin
    $dumpfile("wave.vcd"); $dumpvars(0,tb_full_adder);

    for(n=0;n<8;n=n+1) begin
        {a,b,cin}=n;
        expected=int'(a)+int'(b)+int'(cin);
        #10;
            if ({cout,s} !== expected)
                $fatal(1, "FAIL full_adder vector=%0d expected=%h actual=%h", n, expected, {cout,s});
            checked=checked+1;
        end
        if (checked!=8) $fatal (1, "Incomplete test");
        $display("LAB1_PASS full_adder cases=%0d", checked);
        $finish;
    end
    initial begin #100000; $fatal (1, "Watchdog"); end
endmodule