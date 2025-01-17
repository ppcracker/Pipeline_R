module tb ();

//Declare I/O
reg clk = 0, rst, PCrcE;
reg[31:0] PCTargetE;
wire[31:0] InstrD, PCD, PCPlus4D;

//Declare the design under test
fetch_cycle dut(
    .clk(clk),
    . rst(rst),
    . PCrcE(PCrcE),
    . PCTargetE(PCTargetE),
    .InstrD(InstrD),
    . PCD(PCD), 
    .PCPlus4D(PCPlus4D)
    );

//Generation of clock
always begin
    clk = ~clk;
    #50;
end

//Provide the Stimulus
initial begin
  rst <= 1'b0;
  #200;
  rst <= 1'b1;
  PCrcE <= 1'b0;
  PCTargetE <= 32'h00000000;
  #500;
  $finish;

end
//Generation of VCD File
initial begin
    $dumpfile("dump.vcd");
    $dumpfile(0);
end
    
endmodule
