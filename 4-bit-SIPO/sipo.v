module sipo(
    input wire clk,
    input wire rst,
    input wire si,
    output reg [3:0] po

);

always @(posedge clk) begin
    if(rst)
        po <=4'b0000;
    else
        po <={po[2:0],si};


end
endmodule