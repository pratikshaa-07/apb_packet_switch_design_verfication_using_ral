interface pkt_interface(input logic pclk);

  logic        presetn;
  logic        psel;
  logic        penable;
  logic        pwrite;
  logic [15:0] paddr;
  logic [31:0] pwdata;
  logic [31:0] prdata;
  logic        pready;
  logic        pslverr;
  logic        irq;

  clocking driver_cb @(posedge pclk);
    default input #1step output #0;
    output psel, penable, pwrite, paddr, pwdata;
    input presetn, prdata, pready, pslverr, irq;
  endclocking

  clocking monitor_cb @(posedge pclk);
    default input #1step output #0;
    input presetn, psel, penable, pwrite, paddr, pwdata;
    input prdata, pready, pslverr, irq;
  endclocking

endinterface
