`include "PC_Adder.v"
`include "Mux.v"
`include "Instruction_Memory.v"
 


module fetch_cycle(clk, rst, PCrcE, PCTargetE, InstrD, PCD, PCPlus4D);

//declaring input output
input clk, rst;
input PCrcE;
input [31:0] PCTargetE;
output [31:0] InstrD;
output [31:0] PCD, PCPlus4D;

//Declaring interim wires
wire [31:0] PC_F, PCF, PCPlus4F;
wire [31:0] InstrF;

 //Declaration of register
 reg[31:0] InstrF_reg;
 reg[31:0] PCF_reg, PCPlus4F_reg;


 //initiaton of modules
 //declare PC Mux
 Mux PC_MUX (.a(PCPlus4F),
             .b(PCTargetE),
             .s(PCrcE),
             .c(PC_F));

 // Declare PC Counter
PC_Module Program_Counter(
            .clk(clk),
            .rst(rst),
            .PC(PCF),
            .PC_Next(PC_F));            

//Declare Instruction memory
Instruction_Memory IMEM (
    .rst(rst),
    .A(PCF),
    .RD(InstrF)
);

//Declare PC adder
PC_Adder PC_adder(
    .a(PCF),
    .b(32'h00000004),
    .c(PCPlus4F)
);

//Fetch cycle register logic
always @(posedge clk or negedge rst) begin
    if (rst== 1'b0) begin
        InstrF_reg <= 32'h00000000;
        PCF_reg <= 32'h00000000;
        PCPlus4F_reg <= 32'h00000000;
    end
    else begin
        InstrF_reg <= InstrF;
        PCF_reg <= PCF;
        PCPlus4F_reg <= PCPlus4F;
    end
end

//Assigning Registers value to the output port
assign InstrD = (rst==1'b0) ? 32'h00000000 : InstrF_reg;
assign PCD = (rst==1'b0) ? 32'h00000000 : PCF_reg;
assign PCPlus4D = (rst==1'b0) ? 32'h00000000 : PCPlus4F_reg;

endmodule
