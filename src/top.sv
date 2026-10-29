`include "uvm_macros.svh"
`include "interface.sv"
`include "registers.sv"
`include "reg_block.sv"
`include "seq_item.sv"
`include "sequencer.sv"
`include "driver.sv"
`include "monitor.sv"
`include "agent.sv"
`include "adapter.sv"
`include "subscriber.sv"
`include "env.sv"
`include "sequence.sv"
`include "test.sv"
`include "design.sv"
module tb;

  import uvm_pkg::*;
  `include "uvm_macros.svh"

  bit pclk = 0;
  always #5 pclk = ~pclk;

  pkt_interface apb_if(pclk);

  apb_pkt_switch dut (
    .pclk    (pclk),
    .presetn (apb_if.presetn),
    .psel    (apb_if.psel),
    .penable (apb_if.penable),
    .pwrite  (apb_if.pwrite),
    .paddr   (apb_if.paddr),
    .pwdata  (apb_if.pwdata),
    .prdata  (apb_if.prdata),
    .pready  (apb_if.pready),
    .pslverr (apb_if.pslverr),
    .irq     (apb_if.irq)
  );

  initial begin
    apb_if.presetn = 1'b0;
    apb_if.psel    = 1'b0;
    apb_if.penable = 1'b0;
    apb_if.pwrite  = 1'b0;
    apb_if.paddr   = '0;
    apb_if.pwdata  = '0;

    repeat (2) @(posedge pclk);
    apb_if.presetn = 1'b1;
  end

  initial begin
    uvm_config_db#(virtual pkt_interface)::set(
      null,
      "uvm_test_top.env.agent.*",
      "vif",
      apb_if
    );

    run_test("gen_count_uvm_test");    
  end

endmodule
