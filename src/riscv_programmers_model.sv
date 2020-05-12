`ifndef RISCV_PROGRAMMERS_MODEL_SV
`define RISCV_PROGRAMMERS_MODEL_SV 
class riscv_programmers_model extends uvm_object;
// 16 extendsion has 16 registers
parameter int X_REGISTER_BANK_SIZE = 32;
parameter int F_REGISTER_BANK_SIZE = 32;
// architecture states
bit [XLEN-1:0] X[X_REGISTER_BANK_SIZE];
bit [XLEN-1:0] F[F_REGISTER_BANK_SIZE];
bit [XLEN-1:0] PC;
bit [XLEN-1:0] CSR[csrtype];
riscv_priv_reg PRIV;

// for pending exceptions including sync/async exceptions and interrupts
riscv_exception out_riscv_exception_q[$];
riscv_exception in_riscv_exception_q[$];
// run time states
bit is_C_ext = 0;
// use uvm macros to make life easier

`uvm_object_utils_begin(riscv_programmers_model)
`uvm_filed_sarray_int(X, UVM_ALL_ON);
`uvm_filed_sarray_int(F, UVM_ALL_ON);
`uvm_filed_array_int(CSR, UVM_ALL_ON);
`uvm_filed_int(PC, UVM_ALL_ON);
`uvm_filed_object(PRIV, UVM_ALL_ON);
`uvm_object_utils_end


  function new (string name=""); \
    super.new(name); \
  endfunction : new
// The outer model shell will call execute_inst, two implement proposals: 
// 1. programmer's model will be passed in instruction and update the corresponding architecture states. The handle of programmer's model will be passed into instruction lib. e.g. riscv_inst::execute(p_model); 
//    
// 2  use result lists reture form the function and let programmers model handle it. The inststion library will have no handle of programmer's model. All the action items will be returned in result_list  
// 3. some instruction will refer architecture state thus the handle of programmers model should be visible in inst.execute_inst();
  extern virtual function void execute_inst(riscv_instr inst,riscv_execute_result_items  result_list[$]);
// for load instuctions send a requenst to outer shall for requensting a bus read access
  extern virtual task dbus_trans get_dbus_data();
// for store instuctions send a requenst to outer shall for requensting a bus read access
  extern virtual task put_dbus_data(dbus_trans bus_tr);
// exception handling from outer shall for FIQ, IRQ....
  extern virtual function void inbond_exception_handling(riscv_exception exception_tr);
// exception handling form inner to outer gic, sync_excpetions, SWI....
  extern virtual function void outbond_exception_handling(riscv_exception exception_tr);
  extern virtual bit [XLEN-1:0] function get_gpr(gprtype xn);
  extern virtual bit [XLEN-1:0] function get_fpr(fprtype fn);
  extern virtual bit [XLEN-1:0] function get_csr(csrtype csr);
  extern virtual bit [XLEN-1:0] function get_pc();
  extern virtual bit [XLEN-1:0] function get_priv();
  extern virtual function void set_gpr(gprtype xn, bit[XLEN-1:0] val_gpr);
  extern virtual function void set_fpr(fprtype fn, bit[XLEN-1:0] val_fpr);
  extern virtual function void set_csr(type_of_csr csr, bit[XLEN-1:0] val_csr);
  extern virtual function void set_pc(bit[XLEN-1:0] val_pc);
  extern virtual function void set_priv(riscv_priv_reg val_priv);
endclass
function bit [XLEN-1:0] get_gpr(gprtype xn);
  return X[xn.value()];
endfunction 

function bit [XLEN-1:0] get_rpr(fprtype xn);
  return F[xn.value()];
endfunction 

function bit [XLEN-1:0] get_pc();
  return PC;
endfunction 

function riscv_priv_reg get_priv();
  return PRIV;
endfunction 

function voind set_gpr(gprtype gpr_index, bit [XLEN-1:0] val_gpr);
  CSR[gpr_index] = val_gpr;
endfunction 

function set_fpr(gprtype fn, bit [XLEN-1:0] val_fpr);
  F[fn.value()] = val_fpr;
endfunction 

function set_csr(type_of_csr csr, bit [XLEN-1:0] val_csr);
  CSR[csr.value()] = val_csr;
endfunction 

function void set_pc(bit [XLEN-1:0] val_pc);
  PC = val_pc;
endfunction

function void set_priv(riscv_priv_reg val_priv);
  PRIV = val_priv;
endfunction

function bit [XLEN-1:0] next_PC();
  PC = PC + is_C_ext ? 2: 4;
endfunction
`endif
