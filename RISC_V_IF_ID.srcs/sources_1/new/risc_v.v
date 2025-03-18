module RISC_V(
              input clk,
              input reset,
              
              output [31:0] PC_EX,
              output [31:0] ALU_OUT_EX,
              output [31:0] PC_MEM,
              output PCSrc,
              output [31:0] DATA_MEMORY_MEM,
              output [31:0] ALU_DATA_WB,
              output [1:0] forwardA, forwardB,
              output pipeline_stall,
              
              
              output PCwr,
              output [31:0] PCIF,
              output [31:0] PCID,
              output [3:0] ALU_CONTROL,
              output [31:0] OPA,
              output [31:0] OPB,
              output [1:0] ALUOP,
              output [31:0] ALU_OUT_MEM,
              output [31:0] IMM,
              output ALUSRC,
              output [31:0] INSTRUCT_ID
            );

// if if part

  // Initialization of wires

// PC-related wires
wire PCsrc;
wire PCwrite;
wire IF_ID_write;
wire pipeline_st;
wire [31:0] PC_IF;                 // Current PC
wire [31:0] INSTRUCTION_IF;
wire [31:0] INSTRUCTION_ID;

// Control signals for ID stage
wire RegWrite_ID;
wire MemtoReg_ID;
wire MemRead_ID;
wire MemWrite_ID;
wire [1:0] ALUop_ID;
wire ALUSrc_ID;
wire ALUSrc_ID_OUT;
wire Branch_ID;  // Already assigned

// IDEX stage wires
wire [6:0] OPCODE;
wire [2:0] FUNCT3_ID_IN_IDEX;
wire [6:0] FUNCT7_ID_IN_IDEX;
wire [31:0] REG_DATA1_ID_IN_IDEX;
wire [31:0] REG_DATA2_ID_IN_IDEX;
wire [4:0] RS1_ID_IN_IDEX;
wire [4:0] RS2_ID_IN_IDEX;
wire [31:0] IMM_ID_IN_IDEX;
wire [4:0] RD_ID_IN_IDEX;
wire RegWrite_EX;
wire MemtoReg_EX;
wire MemRead_EX;
wire MemWrite_EX;
wire [4:0] OUT_IDEX_RS1;
wire [4:0] OUT_IDEX_RS2;
wire [31:0] OUT_IDEX_PC;
wire [2:0] OUT_IDEX_FUNCT3_ID;
wire [6:0] OUT_IDEX_FUNCT7_ID;
wire [31:0] OUT_IDEX_ALU_A_OUT;
wire [31:0] OUT_IDEX_ALU_B_OUT;
wire [4:0] OUT_IDEX_RD_OUT;
wire [31:0] OUT_IDEX_IMM_OUT;
wire [1:0] ALUop_ID_OUT;
// EX stage wires
wire [31:0] PC_ID;
wire VDD = 1'b1;  // Constant supply
//wire [2:0] FUNCT3_ID_IN_EX;
//wire [6:0] FUNCT7_ID_IN_EX;
//wire [31:0] REG_DATA1_ID_IN_EX;
//wire [31:0] REG_DATA2_ID_IN_EX;
//wire [4:0] RS1_ID_IN_EX;
//wire [4:0] RS2_ID_IN_EX;
//wire [31:0] IMM_ID_IN_EX;
//wire [4:0] RD_ID_IN_EX;
wire [1:0] ForwardA;
wire [1:0] ForwardB;
wire [31:0] ALU_DATA_wb;
//wire [31:0] ALU_OUT_MEM;
wire ZERO_EX;
wire [31:0] ALU_out_EX;
wire [31:0] PC_Branch_EX;
wire [31:0] REG_DATA2_EX_FINAL;
wire Branch_EX = 1'b0;

// EXMEM stage wires
wire [31:0] EXMEM_PC_OUT;
wire [2:0] EXMEM_F3;
wire [6:0] EXMEM_F7;
wire EXMEM_ZERO_OUT;
wire [31:0] EXMEM_ALU_OUT;
wire [31:0] EXMEM_REG2_DATA_OUT;
wire [4:0] EXMEM_RD_OUT;
wire RegWrite_MEM;
wire MemtoReg_MEM;
wire MemRead_MEM;
wire MemWrite_MEM;
wire Branch_MEM = 1'b0;

// Data memory
wire [31:0] DATA_MEMORY_mem;

// MEMWB stage wires
wire [31:0] DATA_MEMORY_WB;
wire [31:0] ALU_OUT_WB;
wire [4:0] RD_OUT_WB;
wire RegWrite_WB;
wire MemtoReg_WB;
wire MemRead_WB;
wire MemWrite_WB;


wire [3:0] ALU_CTRL_EX;
wire [31:0] SRC1 , SRC2;

 /////////////////////////////////////IF Module/////////////////////////////////////
 IF instruction_fetch(clk, reset, 
                      PCsrc, PCwrite,
                      EXMEM_PC_OUT,
                      PC_IF,INSTRUCTION_IF);
  
  
 //////////////////////////////////////pipeline registers////////////////////////////////////////////////////
 IF_ID_reg IF_ID_REGISTER(clk,reset,
                          IF_ID_write,
                          PC_IF,INSTRUCTION_IF,
                          PC_ID,INSTRUCTION_ID);
  
  
 ////////////////////////////////////////ID Module//////////////////////////////////
 ID instruction_decode(clk,
                       PC_ID,INSTRUCTION_ID,
                       RegWrite_WB, 
                       ALU_DATA_wb,//
                       RD_OUT_WB,
                       IMM_ID_IN_IDEX,
                       REG_DATA1_ID_IN_IDEX,REG_DATA2_ID_IN_IDEX,
                       RegWrite_ID,MemtoReg_ID,MemRead_ID,MemWrite_ID,
                       ALUop_ID,
                       ALUSrc_ID,
                       Branch_ID,
                       FUNCT3_ID_IN_IDEX,FUNCT7_ID_IN_IDEX,
                       OPCODE,
                       RD_ID_IN_IDEX,RS1_ID_IN_IDEX,RS2_ID_IN_IDEX);


ID_EX IDEX(VDD,clk,reset,
         PC_ID,FUNCT3_ID_IN_IDEX,FUNCT7_ID_IN_IDEX,
         REG_DATA1_ID_IN_IDEX,REG_DATA2_ID_IN_IDEX,
         RS1_ID_IN_IDEX,RS2_ID_IN_IDEX,
         RD_ID_IN_IDEX,
         IMM_ID_IN_IDEX,
         RegWrite_ID,MemtoReg_ID,MemRead_ID,MemWrite_ID,
         ALUop_ID,ALUSrc_ID,ALUSrc_ID_OUT,ALUop_ID_OUT,
         RegWrite_EX,MemtoReg_EX,MemRead_EX,MemWrite_EX,
         OUT_IDEX_PC,
         OUT_IDEX_FUNCT3_ID, OUT_IDEX_FUNCT7_ID,
         OUT_IDEX_ALU_A_OUT,OUT_IDEX_ALU_B_OUT,
         OUT_IDEX_RS1,OUT_IDEX_RS2,OUT_IDEX_RD_OUT,
         OUT_IDEX_IMM_OUT
     );
 
 EX EXMODULE(
         OUT_IDEX_IMM_OUT,
         OUT_IDEX_ALU_A_OUT,
         OUT_IDEX_ALU_B_OUT,
         OUT_IDEX_PC,
         
         OUT_IDEX_FUNCT3_ID,
         OUT_IDEX_FUNCT7_ID,
         OUT_IDEX_RD_OUT,
         OUT_IDEX_RS1,
         
         OUT_IDEX_RS2,
         
         RegWrite_EX,
         MemtoReg_EX,
         MemRead_EX,
         MemWrite_EX,
         
         ALUop_ID_OUT,ALUSrc_ID_OUT,
         Branch_EX,
         ForwardA,ForwardB, 
         
         ALU_DATA_wb, EXMEM_ALU_OUT,
         //
         ZERO_EX,ALU_out_EX,PC_Branch_EX, REG_DATA2_EX_FINAL,
         ALU_CTRL_EX,
         SRC1 , SRC2
    );
 EX_MEM EXMEM(VDD,clk,reset,
         PC_Branch_EX,
         OUT_IDEX_FUNCT3_ID,OUT_IDEX_FUNCT7_ID,
         ZERO_EX,ALU_out_EX,REG_DATA2_EX_FINAL,
         OUT_IDEX_RD_OUT,
         RegWrite_EX,MemtoReg_EX,MemRead_EX,MemWrite_EX,Branch_EX,
         RegWrite_MEM,MemtoReg_MEM,MemRead_MEM,MemWrite_MEM,Branch_MEM,
         EXMEM_PC_OUT,
         EXMEM_F3,
         EXMEM_F7,
         EXMEM_ZERO_OUT,
         EXMEM_ALU_OUT,
         EXMEM_REG2_DATA_OUT,
         EXMEM_RD_OUT
         ); 

data_memory DATA(
		clk,
		MemRead_MEM,
		MemWrite_MEM,
		EXMEM_ALU_OUT,
		EXMEM_REG2_DATA_OUT,
		DATA_MEMORY_mem

	);

MEM_WB MEMWB(
		clk,reset,
		DATA_MEMORY_MEM,
		EXMEM_ALU_OUT,
		EXMEM_RD_OUT,
		VDD,
		RegWrite_MEM,MemtoReg_MEM,MemRead_MEM,MemWrite_MEM,
		RegWrite_WB,MemtoReg_WB,MemRead_WB,MemWrite_WB,
		DATA_MEMORY_WB,
		ALU_OUT_WB,
		RD_OUT_WB
	);
mux2_1 MUX_ALU_DATA (
		ALU_OUT_WB,
		DATA_MEMORY_WB,
		MemtoReg_WB,
		ALU_DATA_wb //
	);

forwarding FORWARING_UNIT(
		OUT_IDEX_RS1,OUT_IDEX_RS2,
		EXMEM_RD_OUT,
		RD_OUT_WB,
		RegWrite_MEM,
		RegWrite_WB,
		ForwardA,ForwardB
	);
 branch_control BRANCH_CTRL(
		EXMEM_ZERO_OUT,
		EXMEM_ALU_OUT,
		Branch_MEM,
		EXMEM_F3,
		PCsrc
	);
 hazard_detection HAZARD(
		OUT_IDEX_RD_OUT,
		INSTRUCTION_ID[19:15],
		INSTRUCTION_ID[24:20],
		MemRead_EX,
		PCwrite,
		IF_ID_write,
		pipeline_st
	);


assign PC_EX = OUT_IDEX_PC;
assign ALU_OUT_EX = ALU_out_EX;
assign PC_MEM = EXMEM_PC_OUT;
assign PCSrc = PCsrc;
assign DATA_MEMORY_MEM = DATA_MEMORY_mem;
assign ALU_DATA_WB = ALU_DATA_wb;
assign forwardA = ForwardA;
assign forwardB = ForwardB;
assign pipeline_stall = pipeline_st;
assign PCwr = PCwrite;
assign PCIF = PC_IF;
assign PCID = PC_ID;
assign ALU_CONTROL = ALU_CTRL_EX;
assign OPA = SRC1;
assign OPB = SRC2; 
assign ALUOP = ALUop_ID;
assign ALU_OUT_MEM =  EXMEM_ALU_OUT;
assign IMM = OUT_IDEX_IMM_OUT;
assign ALUSRC = ALUSrc_ID_OUT;
assign INSTRUCT_ID = INSTRUCTION_ID;
endmodule