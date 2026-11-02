module sipo_tb;
reg clk;
reg rst;
reg si;
wire [3:0] po;

sipo uut(
    .clk(clk),
    .rst(rst),
    .si(si),
    .po(po)
);

initial begin
    $dumpfile("wave.vcd");
    $dumpvars(0, sipo_tb);
end

initial begin
    $monitor("Time=%0t | rst=%b | si=%b | po=%b",
              $time, rst, si, po);
end

initial begin
    clk=0;
    forever #5 clk= ~clk;
end


initial begin
    rst = 1;
    si = 0;

    repeat(2) @(negedge clk);
    rst = 0;

    si = 1; @(negedge clk);
    si = 1; @(negedge clk);
    si = 0; @(negedge clk);
    si = 1; @(negedge clk);

    if (po !== 4'b1101)
        $fatal(1, "FAIL: Expected 1101, Got %b", po);
    else
        $display("PASS: SIPO output = %b", po);

    #1;
    $finish;
end

endmodule