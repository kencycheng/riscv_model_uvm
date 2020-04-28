/*
 * Copyright 2018 Google LLC
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */


package riscv_instr_pkg;

  `include "dv_defines.svh"
  `include "riscv_defines.svh"
  `include "uvm_macros.svh"

  import uvm_pkg::*;

  `define include_file(f) `include `"f`"
// this parameter is copied from target/riscv_core_setting.sv
  parameter int XLEN = 32;

  `include "riscv_dv_type_defines.sv"



  // xSTATUS bit mask
  parameter bit [XLEN - 1 : 0] MPRV_BIT_MASK = 'h1 << 17;
  parameter bit [XLEN - 1 : 0] SUM_BIT_MASK  = 'h1 << 18;
  parameter bit [XLEN - 1 : 0] MPP_BIT_MASK  = 'h3 << 11;

  parameter int IMM25_WIDTH = 25;
  parameter int IMM12_WIDTH = 12;
  parameter int INSTR_WIDTH = 32;
  parameter int DATA_WIDTH  = 32;


  `include "riscv_dv_global_functions.sv"


  `include "riscv_instr.sv"
  `include "rv32i_instr.sv"
  `include "riscv_reg.sv"
  `include "riscv_privil_reg.sv"

endpackage
