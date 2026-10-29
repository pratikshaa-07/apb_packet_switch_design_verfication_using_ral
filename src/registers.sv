import uvm_pkg::*;
`include "uvm_macros.svh"
//==============================================================
// DEVICE_ID: 0x00
//==============================================================
class device_id_reg extends uvm_reg;
  `uvm_object_utils(device_id_reg)

  rand uvm_reg_field revision, vendor_id, product_id;

  covergroup device_id_cov;
    option.per_instance = 1;

    coverpoint revision.value {
      bins expected = {8'h02};
    }

    coverpoint vendor_id.value {
      bins expected = {8'hA5};
    }

    coverpoint product_id.value {
      bins expected = {16'h5357};
    }
  endgroup

  function new(string name="device_id_reg");
    super.new(name, 32, UVM_CVR_FIELD_VALS);
    if (has_coverage(UVM_CVR_FIELD_VALS))
      device_id_cov = new();
  endfunction

  virtual function void build();
    revision   = uvm_reg_field::type_id::create("revision");
    vendor_id  = uvm_reg_field::type_id::create("vendor_id");
    product_id = uvm_reg_field::type_id::create("product_id");

    revision.configure(this, 8, 24, "RO", 0, 8'h02, 1, 0, 0);
    vendor_id.configure(this, 8, 16, "RO", 0, 8'hA5, 1, 0, 0);
    product_id.configure(this, 16, 0, "RO", 0, 16'h5357, 1, 0, 0);
  endfunction

  virtual function void sample_values();
    super.sample_values();
    device_id_cov.sample();
  endfunction
endclass


//==============================================================
// VERSION: 0x04
//==============================================================
class version_reg extends uvm_reg;
  `uvm_object_utils(version_reg)

  rand uvm_reg_field reserved, major, minor, patch;

  covergroup version_cov;
    option.per_instance = 1;

    coverpoint major.value {
      bins expected = {8'h01};
    }

    coverpoint minor.value {
      bins expected = {8'h02};
    }

    coverpoint patch.value {
      bins expected = {8'h00};
    }
  endgroup

  function new(string name="version_reg");
    super.new(name, 32, UVM_CVR_FIELD_VALS);
    if (has_coverage(UVM_CVR_FIELD_VALS))
      version_cov = new();
  endfunction

  virtual function void build();
    reserved = uvm_reg_field::type_id::create("reserved");
    major    = uvm_reg_field::type_id::create("major");
    minor    = uvm_reg_field::type_id::create("minor");
    patch    = uvm_reg_field::type_id::create("patch");

    reserved.configure(this, 8, 24, "RO", 0, 8'h00, 1, 0, 0);
    major.configure(this, 8, 16, "RO", 0, 8'h01, 1, 0, 0);
    minor.configure(this, 8, 8, "RO", 0, 8'h02, 1, 0, 0);
    patch.configure(this, 8, 0, "RO", 0, 8'h00, 1, 0, 0);
  endfunction

  virtual function void sample_values();
    super.sample_values();
    version_cov.sample();
  endfunction
endclass

//==============================================================
// SWITCH_STATUS: 0x08
//==============================================================
class switch_status_reg extends uvm_reg;
  `uvm_object_utils(switch_status_reg)

  rand uvm_reg_field reserved_hi, gen_fsm, reserved_mid;
  rand uvm_reg_field err_pending, gen_running, port_enabled;
  rand uvm_reg_field locked, switch_enabled, busy, ready;

  covergroup switch_status_cov;
    option.per_instance = 1;

    coverpoint gen_fsm.value {
      bins idle = {0};
      bins send = {1};
      bins gap  = {2};
      bins done = {3};
    }

    coverpoint locked.value {
      bins locked   = {1};
      bins unlocked = {0};
    }

    coverpoint switch_enabled.value {
      bins disabled = {0};
      bins enabled  = {1};
    }

    coverpoint gen_running.value {
      bins stopped = {0};
      bins running = {1};
    }
  endgroup

  function new(string name="switch_status_reg");
    super.new(name, 32, UVM_CVR_FIELD_VALS);
    if (has_coverage(UVM_CVR_FIELD_VALS))
      switch_status_cov = new();
  endfunction

  virtual function void build();
    reserved_hi = uvm_reg_field::type_id::create("reserved_hi");
    gen_fsm = uvm_reg_field::type_id::create("gen_fsm");
    reserved_mid = uvm_reg_field::type_id::create("reserved_mid");
    err_pending = uvm_reg_field::type_id::create("err_pending");
    gen_running = uvm_reg_field::type_id::create("gen_running");
    port_enabled = uvm_reg_field::type_id::create("port_enabled");
    locked = uvm_reg_field::type_id::create("locked");
    switch_enabled = uvm_reg_field::type_id::create("switch_enabled");
    busy = uvm_reg_field::type_id::create("busy");
    ready = uvm_reg_field::type_id::create("ready");

    reserved_hi.configure(this,14,18,"RO",0,14'h0,1,0,0);
    gen_fsm.configure(this,2,16,"RO",1,2'h0,1,0,0);
    reserved_mid.configure(this,6,10,"RO",0,6'h0,1,0,0);
    err_pending.configure(this,1,9,"RO",1,1'b0,1,0,0);
    gen_running.configure(this,1,8,"RO",1,1'b0,1,0,0);
    port_enabled.configure(this,4,4,"RO",1,4'hF,1,0,0);
    locked.configure(this,1,3,"RO",1,1'b1,1,0,0);
    switch_enabled.configure(this,1,2,"RO",1,1'b0,1,0,0);
    busy.configure(this,1,1,"RO",1,1'b0,1,0,0);
    ready.configure(this,1,0,"RO",1,1'b1,1,0,0);
  endfunction

  virtual function void sample_values();
    super.sample_values();
    switch_status_cov.sample();
  endfunction
endclass


//==============================================================
// PORT_STATUS: 0x0C
//==============================================================
class port_status_reg extends uvm_reg;
  `uvm_object_utils(port_status_reg)

  rand uvm_reg_field port3_level, port2_level;
  rand uvm_reg_field port1_level, port0_level;

  covergroup port_status_cov;
    option.per_instance = 1;

    coverpoint port0_level.value {
      bins empty = {0};
      bins occupied = {[1:15]};
      bins full = {16};
    }

    coverpoint port1_level.value {
      bins empty = {0};
      bins occupied = {[1:15]};
      bins full = {16};
    }

    coverpoint port2_level.value {
      bins empty = {0};
      bins occupied = {[1:15]};
      bins full = {16};
    }

    coverpoint port3_level.value {
      bins empty = {0};
      bins occupied = {[1:15]};
      bins full = {16};
    }
  endgroup

  function new(string name="port_status_reg");
    super.new(name, 32, UVM_CVR_FIELD_VALS);
    if (has_coverage(UVM_CVR_FIELD_VALS))
      port_status_cov = new();
  endfunction

  virtual function void build();
    port3_level = uvm_reg_field::type_id::create("port3_level");
    port2_level = uvm_reg_field::type_id::create("port2_level");
    port1_level = uvm_reg_field::type_id::create("port1_level");
    port0_level = uvm_reg_field::type_id::create("port0_level");

    port3_level.configure(this,8,24,"RO",1,8'h0,1,0,0);
    port2_level.configure(this,8,16,"RO",1,8'h0,1,0,0);
    port1_level.configure(this,8,8,"RO",1,8'h0,1,0,0);
    port0_level.configure(this,8,0,"RO",1,8'h0,1,0,0);
  endfunction

  virtual function void sample_values();
    super.sample_values();
    port_status_cov.sample();
  endfunction
endclass

//==============================================================
// GEN_STATUS: 0x10
//==============================================================
class gen_status_reg extends uvm_reg;
  `uvm_object_utils(gen_status_reg)

  rand uvm_reg_field reserved_hi, remaining, reserved_mid;
  rand uvm_reg_field fsm, done, running;

  covergroup gen_status_cov;
    option.per_instance = 1;

    coverpoint fsm.value {
      bins idle = {0};
      bins send = {1};
      bins gap  = {2};
      bins done = {3};
    }

    coverpoint running.value {
      bins stopped = {0};
      bins running = {1};
    }

    coverpoint done.value {
      bins not_done = {0};
      bins completed = {1};
    }

    coverpoint remaining.value {
      bins zero = {0};
      bins some_remaining = {[1:65535]};
    }
  endgroup

  function new(string name="gen_status_reg");
    super.new(name,32,UVM_CVR_FIELD_VALS);
    if (has_coverage(UVM_CVR_FIELD_VALS))
      gen_status_cov = new();
  endfunction

  virtual function void build();
    reserved_hi=uvm_reg_field::type_id::create("reserved_hi");
    remaining=uvm_reg_field::type_id::create("remaining");
    reserved_mid=uvm_reg_field::type_id::create("reserved_mid");
    fsm=uvm_reg_field::type_id::create("fsm");
    done=uvm_reg_field::type_id::create("done");
    running=uvm_reg_field::type_id::create("running");

    reserved_hi.configure(this,8,24,"RO",0,8'h0,1,0,0);
    remaining.configure(this,16,8,"RO",1,16'h0,1,0,0);
    reserved_mid.configure(this,4,4,"RO",0,4'h0,1,0,0);
    fsm.configure(this,2,2,"RO",1,2'h0,1,0,0);
    done.configure(this,1,1,"RO",1,1'b0,1,0,0);
    running.configure(this,1,0,"RO",1,1'b0,1,0,0);
  endfunction

  virtual function void sample_values();
    super.sample_values();
    gen_status_cov.sample();
  endfunction
endclass


//==============================================================
// STAT_RX: 0x14
//==============================================================
class stat_rx_reg extends uvm_reg;
  `uvm_object_utils(stat_rx_reg)

  rand uvm_reg_field reserved, rx_packets;

  covergroup stat_rx_cov;
    option.per_instance = 1;

    coverpoint rx_packets.value {
      bins zero = {0};
      bins one_packet = {1};
      bins multiple_packets = {[2:65534]};
      bins max_count = {65535};
    }
  endgroup

  function new(string name="stat_rx_reg");
    super.new(name,32,UVM_CVR_FIELD_VALS);
    if (has_coverage(UVM_CVR_FIELD_VALS))
      stat_rx_cov = new();
  endfunction

  virtual function void build();
    reserved=uvm_reg_field::type_id::create("reserved");
    rx_packets=uvm_reg_field::type_id::create("rx_packets");

    reserved.configure(this,16,16,"RO",0,16'h0,1,0,0);
    rx_packets.configure(this,16,0,"RO",1,16'h0,1,0,0);
  endfunction

  virtual function void sample_values();
    super.sample_values();
    stat_rx_cov.sample();
  endfunction
endclass

//==============================================================
// STAT_TX: 0x18
//==============================================================
class stat_tx_reg extends uvm_reg;
  `uvm_object_utils(stat_tx_reg)

  rand uvm_reg_field reserved, tx_packets;

  covergroup stat_tx_cov;
    option.per_instance = 1;

    coverpoint tx_packets.value {
      bins zero = {0};
      bins one_packet = {1};
      bins multiple_packets = {[2:65534]};
      bins max_count = {65535};
    }
  endgroup

  function new(string name="stat_tx_reg");
    super.new(name,32,UVM_CVR_FIELD_VALS);
    if (has_coverage(UVM_CVR_FIELD_VALS))
      stat_tx_cov = new();
  endfunction

  virtual function void build();
    reserved=uvm_reg_field::type_id::create("reserved");
    tx_packets=uvm_reg_field::type_id::create("tx_packets");

    reserved.configure(this,16,16,"RO",0,16'h0,1,0,0);
    tx_packets.configure(this,16,0,"RO",1,16'h0,1,0,0);
  endfunction

  virtual function void sample_values();
    super.sample_values();
    stat_tx_cov.sample();
  endfunction
endclass


//==============================================================
// STAT_DROP: 0x1C
//==============================================================
class stat_drop_reg extends uvm_reg;
  `uvm_object_utils(stat_drop_reg)

  rand uvm_reg_field reserved, dropped_packets;

  covergroup stat_drop_cov;
    option.per_instance = 1;

    coverpoint dropped_packets.value {
      bins zero = {0};
      bins one_packet = {1};
      bins multiple_packets = {[2:65534]};
      bins max_count = {65535};
    }
  endgroup

  function new(string name="stat_drop_reg");
    super.new(name,32,UVM_CVR_FIELD_VALS);
    if (has_coverage(UVM_CVR_FIELD_VALS))
      stat_drop_cov = new();
  endfunction

  virtual function void build();
    reserved=uvm_reg_field::type_id::create("reserved");
    dropped_packets=uvm_reg_field::type_id::create("dropped_packets");

    reserved.configure(this,16,16,"RO",0,16'h0,1,0,0);
    dropped_packets.configure(this,16,0,"RO",1,16'h0,1,0,0);
  endfunction

  virtual function void sample_values();
    super.sample_values();
    stat_drop_cov.sample();
  endfunction
endclass

//==============================================================
// SWITCH_CTRL: 0x20 -- mixed RW / WO
//==============================================================
class switch_ctrl_reg extends uvm_reg;
  `uvm_object_utils(switch_ctrl_reg)

  rand uvm_reg_field reserved_hi, irq_global_en;
  rand uvm_reg_field reserved_bit2, stat_clear, enable;

  covergroup switch_ctrl_cov;
    option.per_instance = 1;

    coverpoint irq_global_en.value {
      bins disabled = {0};
      bins enabled  = {1};
    }

    coverpoint enable.value {
      bins disabled = {0};
      bins enabled  = {1};
    }
  endgroup

  function new(string name="switch_ctrl_reg");
    super.new(name,32,UVM_CVR_FIELD_VALS);

    if(has_coverage(UVM_CVR_FIELD_VALS))
      switch_ctrl_cov = new();
  endfunction

  virtual function void build();
    reserved_hi=uvm_reg_field::type_id::create("reserved_hi");
    irq_global_en=uvm_reg_field::type_id::create("irq_global_en");
    reserved_bit2=uvm_reg_field::type_id::create("reserved_bit2");
    stat_clear=uvm_reg_field::type_id::create("stat_clear");
    enable=uvm_reg_field::type_id::create("enable");

    reserved_hi.configure(this,28,4,"RO",0,28'h0,1,0,0);
    irq_global_en.configure(this,1,3,"RW",0,1'b0,1,1,1);
    reserved_bit2.configure(this,1,2,"RO",0,1'b0,1,0,0);
    stat_clear.configure(this,1,1,"WO",0,1'b0,1,0,0);
    enable.configure(this,1,0,"RW",0,1'b0,1,1,1);
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if(has_coverage(UVM_CVR_FIELD_VALS))
      switch_ctrl_cov.sample();
  endfunction
endclass

//==============================================================
// PORT_ENABLE: 0x24
//==============================================================
class port_enable_reg extends uvm_reg;
  `uvm_object_utils(port_enable_reg)

  rand uvm_reg_field reserved, port3_en, port2_en, port1_en, port0_en;

  covergroup port_enable_cov;
    option.per_instance = 1;

    coverpoint port0_en.value {
      bins disabled = {0};
      bins enabled  = {1};
    }

    coverpoint port1_en.value {
      bins disabled = {0};
      bins enabled  = {1};
    }

    coverpoint port2_en.value {
      bins disabled = {0};
      bins enabled  = {1};
    }

    coverpoint port3_en.value {
      bins disabled = {0};
      bins enabled  = {1};
    }
  endgroup

  function new(string name="port_enable_reg");
    super.new(name,32,UVM_CVR_FIELD_VALS);

    if(has_coverage(UVM_CVR_FIELD_VALS))
      port_enable_cov = new();
  endfunction

  virtual function void build();
    reserved=uvm_reg_field::type_id::create("reserved");
    port3_en=uvm_reg_field::type_id::create("port3_en");
    port2_en=uvm_reg_field::type_id::create("port2_en");
    port1_en=uvm_reg_field::type_id::create("port1_en");
    port0_en=uvm_reg_field::type_id::create("port0_en");

    reserved.configure(this,28,4,"RO",0,28'h0,1,0,0);
    port3_en.configure(this,1,3,"RW",0,1'b1,1,1,1);
    port2_en.configure(this,1,2,"RW",0,1'b1,1,1,1);
    port1_en.configure(this,1,1,"RW",0,1'b1,1,1,1);
    port0_en.configure(this,1,0,"RW",0,1'b1,1,1,1);
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if(has_coverage(UVM_CVR_FIELD_VALS))
      port_enable_cov.sample();
  endfunction
endclass

//==============================================================
// FWD_ENABLE: 0x28
//==============================================================
class fwd_enable_reg extends uvm_reg;
  `uvm_object_utils(fwd_enable_reg)

  rand uvm_reg_field reserved, fwd3_en, fwd2_en, fwd1_en, fwd0_en;

  covergroup fwd_enable_cov;
    option.per_instance = 1;

    coverpoint fwd0_en.value {
      bins disabled = {0};
      bins enabled  = {1};
    }

    coverpoint fwd1_en.value {
      bins disabled = {0};
      bins enabled  = {1};
    }

    coverpoint fwd2_en.value {
      bins disabled = {0};
      bins enabled  = {1};
    }

    coverpoint fwd3_en.value {
      bins disabled = {0};
      bins enabled  = {1};
    }
  endgroup

  function new(string name="fwd_enable_reg");
    super.new(name,32,UVM_CVR_FIELD_VALS);

    if(has_coverage(UVM_CVR_FIELD_VALS))
      fwd_enable_cov = new();
  endfunction

  virtual function void build();
    reserved=uvm_reg_field::type_id::create("reserved");
    fwd3_en=uvm_reg_field::type_id::create("fwd3_en");
    fwd2_en=uvm_reg_field::type_id::create("fwd2_en");
    fwd1_en=uvm_reg_field::type_id::create("fwd1_en");
    fwd0_en=uvm_reg_field::type_id::create("fwd0_en");

    reserved.configure(this,28,4,"RO",0,28'h0,1,0,0);
    fwd3_en.configure(this,1,3,"RW",0,1'b1,1,1,1);
    fwd2_en.configure(this,1,2,"RW",0,1'b1,1,1,1);
    fwd1_en.configure(this,1,1,"RW",0,1'b1,1,1,1);
    fwd0_en.configure(this,1,0,"RW",0,1'b1,1,1,1);
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if(has_coverage(UVM_CVR_FIELD_VALS))
      fwd_enable_cov.sample();
  endfunction
endclass

//==============================================================
// GEN_CTRL: 0x2C -- ENABLE/CONTINUOUS RW, START/STOP WO
//==============================================================
class gen_ctrl_reg extends uvm_reg;
  `uvm_object_utils(gen_ctrl_reg)

  rand uvm_reg_field reserved, continuous, stop, start, enable;

  covergroup gen_ctrl_cov;
    option.per_instance = 1;

    coverpoint continuous.value {
      bins disabled = {0};
      bins enabled  = {1};
    }

    coverpoint enable.value {
      bins disabled = {0};
      bins enabled  = {1};
    }
  endgroup

  function new(string name="gen_ctrl_reg");
    super.new(name,32,UVM_CVR_FIELD_VALS);

    if(has_coverage(UVM_CVR_FIELD_VALS))
      gen_ctrl_cov = new();
  endfunction

  virtual function void build();
    reserved=uvm_reg_field::type_id::create("reserved");
    continuous=uvm_reg_field::type_id::create("continuous");
    stop=uvm_reg_field::type_id::create("stop");
    start=uvm_reg_field::type_id::create("start");
    enable=uvm_reg_field::type_id::create("enable");

    reserved.configure(this,28,4,"RO",0,28'h0,1,0,0);
    continuous.configure(this,1,3,"RW",0,1'b0,1,1,1);
    stop.configure(this,1,2,"WO",0,1'b0,1,0,0);
    start.configure(this,1,1,"WO",0,1'b0,1,0,0);
    enable.configure(this,1,0,"RW",0,1'b0,1,1,1);
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if(has_coverage(UVM_CVR_FIELD_VALS))
      gen_ctrl_cov.sample();
  endfunction
endclass

//==============================================================
// GEN_PKT_CFG: 0x30
//==============================================================
class gen_pkt_cfg_reg extends uvm_reg;
  `uvm_object_utils(gen_pkt_cfg_reg)

  rand uvm_reg_field reserved_hi, seed, length;
  rand uvm_reg_field reserved_mid, src_port, dst_port;

  covergroup gen_pkt_cfg_cov;
    option.per_instance = 1;

    coverpoint length.value {
      bins zero       = {0};
      bins valid      = {[1:16]};
      bins above_max  = {[17:255]};
    }

    coverpoint src_port.value {
      bins port0 = {0};
      bins port1 = {1};
      bins port2 = {2};
      bins port3 = {3};
    }

    coverpoint dst_port.value {
      bins port0 = {0};
      bins port1 = {1};
      bins port2 = {2};
      bins port3 = {3};
    }
  endgroup

  function new(string name="gen_pkt_cfg_reg");
    super.new(name,32,UVM_CVR_FIELD_VALS);

    if(has_coverage(UVM_CVR_FIELD_VALS))
      gen_pkt_cfg_cov = new();
  endfunction

  virtual function void build();
    reserved_hi=uvm_reg_field::type_id::create("reserved_hi");
    seed=uvm_reg_field::type_id::create("seed");
    length=uvm_reg_field::type_id::create("length");
    reserved_mid=uvm_reg_field::type_id::create("reserved_mid");
    src_port=uvm_reg_field::type_id::create("src_port");
    dst_port=uvm_reg_field::type_id::create("dst_port");

    reserved_hi.configure(this,8,24,"RO",0,8'h0,1,0,0);
    seed.configure(this,8,16,"RW",0,8'h00,1,1,1);
    length.configure(this,8,8,"RW",0,8'h04,1,1,1);
    reserved_mid.configure(this,4,4,"RO",0,4'h0,1,0,0);
    src_port.configure(this,2,2,"RW",0,2'h0,1,1,1);
    dst_port.configure(this,2,0,"RW",0,2'h1,1,1,1);
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if(has_coverage(UVM_CVR_FIELD_VALS))
      gen_pkt_cfg_cov.sample();
  endfunction
endclass

//==============================================================
// GEN_INTERVAL: 0x34
//==============================================================
class gen_interval_reg extends uvm_reg;
  `uvm_object_utils(gen_interval_reg)

  rand uvm_reg_field interval;

  covergroup gen_interval_cov;
    option.per_instance = 1;

    coverpoint interval.value {
      bins zero          = {0};
      bins single_cycle  = {1};
      bins multiple      = {[2:32'hFFFFFFFE]};
      bins max_value     = {32'hFFFFFFFF};
    }
  endgroup

  function new(string name="gen_interval_reg");
    super.new(name,32,UVM_CVR_FIELD_VALS);

    if(has_coverage(UVM_CVR_FIELD_VALS))
      gen_interval_cov = new();
  endfunction

  virtual function void build();
    interval=uvm_reg_field::type_id::create("interval");
    interval.configure(this,32,0,"RW",0,32'h2,1,1,1);
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if(has_coverage(UVM_CVR_FIELD_VALS))
      gen_interval_cov.sample();
  endfunction
endclass

//==============================================================
// GEN_COUNT: 0x38
//==============================================================
class gen_count_reg extends uvm_reg;
  `uvm_object_utils(gen_count_reg)

  rand uvm_reg_field count;

  covergroup gen_count_cov;
    option.per_instance = 1;

    coverpoint count.value {
      bins zero          = {0};
      bins single_packet = {1};
      bins multiple      = {[2:32'hFFFFFFFE]};
      bins max_value     = {32'hFFFFFFFF};
    }
  endgroup

  function new(string name="gen_count_reg");
    super.new(name,32,UVM_CVR_FIELD_VALS);

    if(has_coverage(UVM_CVR_FIELD_VALS))
      gen_count_cov = new();
  endfunction

  virtual function void build();
    count=uvm_reg_field::type_id::create("count");
    count.configure(this,32,0,"RW",0,32'h4,1,1,1);
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if(has_coverage(UVM_CVR_FIELD_VALS))
      gen_count_cov.sample();
  endfunction
endclass

//==============================================================
// IRQ_STATUS: 0x3C -- W1C
//==============================================================
class irq_status_reg extends uvm_reg;
  `uvm_object_utils(irq_status_reg)

  rand uvm_reg_field sw_event, start_ack, queue_af, packet_fwd;
  rand uvm_reg_field packet_drop, overflow, error, gen_done;
  rand uvm_reg_field reserved;

  covergroup irq_status_cov;
    option.per_instance = 1;

    coverpoint sw_event.value {
      bins inactive = {0};
      bins active   = {1};
    }

    coverpoint start_ack.value {
      bins inactive = {0};
      bins active   = {1};
    }

    coverpoint packet_drop.value {
      bins inactive = {0};
      bins active   = {1};
    }

    coverpoint error.value {
      bins inactive = {0};
      bins active   = {1};
    }

    coverpoint gen_done.value {
      bins inactive = {0};
      bins active   = {1};
    }
  endgroup

  function new(string name="irq_status_reg");
    super.new(name,32,UVM_CVR_FIELD_VALS);

    if(has_coverage(UVM_CVR_FIELD_VALS))
      irq_status_cov = new();
  endfunction

  virtual function void build();
    sw_event=uvm_reg_field::type_id::create("sw_event");
    start_ack=uvm_reg_field::type_id::create("start_ack");
    queue_af=uvm_reg_field::type_id::create("queue_af");
    packet_fwd=uvm_reg_field::type_id::create("packet_fwd");
    packet_drop=uvm_reg_field::type_id::create("packet_drop");
    overflow=uvm_reg_field::type_id::create("overflow");
    error=uvm_reg_field::type_id::create("error");
    gen_done=uvm_reg_field::type_id::create("gen_done");
    reserved=uvm_reg_field::type_id::create("reserved");

    reserved.configure(this,24,8,"RO",0,24'h0,1,0,0);
    sw_event.configure(this,1,7,"W1C",0,1'b0,1,0,0);
    start_ack.configure(this,1,6,"W1C",0,1'b0,1,0,0);
    queue_af.configure(this,1,5,"W1C",0,1'b0,1,0,0);
    packet_fwd.configure(this,1,4,"W1C",0,1'b0,1,0,0);
    packet_drop.configure(this,1,3,"W1C",0,1'b0,1,0,0);
    overflow.configure(this,1,2,"W1C",0,1'b0,1,0,0);
    error.configure(this,1,1,"W1C",0,1'b0,1,0,0);
    gen_done.configure(this,1,0,"W1C",0,1'b0,1,0,0);
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if(has_coverage(UVM_CVR_FIELD_VALS))
      irq_status_cov.sample();
  endfunction
endclass

//==============================================================
// IRQ_ENABLE: 0x40
//==============================================================
class irq_enable_reg extends uvm_reg;
  `uvm_object_utils(irq_enable_reg)

  rand uvm_reg_field reserved, sw_event_en, start_ack_en, queue_af_en;
  rand uvm_reg_field packet_fwd_en, packet_drop_en, overflow_en;
  rand uvm_reg_field error_en, gen_done_en;

  covergroup irq_enable_cov;
    option.per_instance = 1;

    coverpoint sw_event_en.value {
      bins disabled = {0};
      bins enabled  = {1};
    }

    coverpoint packet_drop_en.value {
      bins disabled = {0};
      bins enabled  = {1};
    }

    coverpoint error_en.value {
      bins disabled = {0};
      bins enabled  = {1};
    }

    coverpoint gen_done_en.value {
      bins disabled = {0};
      bins enabled  = {1};
    }
  endgroup

  function new(string name="irq_enable_reg");
    super.new(name,32,UVM_CVR_FIELD_VALS);

    if(has_coverage(UVM_CVR_FIELD_VALS))
      irq_enable_cov = new();
  endfunction

  virtual function void build();
    reserved=uvm_reg_field::type_id::create("reserved");
    sw_event_en=uvm_reg_field::type_id::create("sw_event_en");
    start_ack_en=uvm_reg_field::type_id::create("start_ack_en");
    queue_af_en=uvm_reg_field::type_id::create("queue_af_en");
    packet_fwd_en=uvm_reg_field::type_id::create("packet_fwd_en");
    packet_drop_en=uvm_reg_field::type_id::create("packet_drop_en");
    overflow_en=uvm_reg_field::type_id::create("overflow_en");
    error_en=uvm_reg_field::type_id::create("error_en");
    gen_done_en=uvm_reg_field::type_id::create("gen_done_en");

    reserved.configure(this,24,8,"RO",0,24'h0,1,0,0);
    sw_event_en.configure(this,1,7,"RW",0,1'b0,1,1,1);
    start_ack_en.configure(this,1,6,"RW",0,1'b0,1,1,1);
    queue_af_en.configure(this,1,5,"RW",0,1'b0,1,1,1);
    packet_fwd_en.configure(this,1,4,"RW",0,1'b0,1,1,1);
    packet_drop_en.configure(this,1,3,"RW",0,1'b0,1,1,1);
    overflow_en.configure(this,1,2,"RW",0,1'b0,1,1,1);
    error_en.configure(this,1,1,"RW",0,1'b0,1,1,1);
    gen_done_en.configure(this,1,0,"RW",0,1'b0,1,1,1);
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if(has_coverage(UVM_CVR_FIELD_VALS))
      irq_enable_cov.sample();
  endfunction
endclass

//==============================================================
// IRQ_FORCE: 0x44 -- write-only force bits
//==============================================================
class irq_force_reg extends uvm_reg;
  `uvm_object_utils(irq_force_reg)

  rand uvm_reg_field reserved, force_bits;

  covergroup irq_force_cov;
    option.per_instance = 1;

    coverpoint force_bits.value {
      bins no_force       = {8'h00};
      bins single_bit     = {[8'h01:8'h80]};
      bins multiple_bits  = {[8'h81:8'hFF]};
    }
  endgroup

  function new(string name="irq_force_reg");
    super.new(name,32,UVM_CVR_FIELD_VALS);

    if(has_coverage(UVM_CVR_FIELD_VALS))
      irq_force_cov = new();
  endfunction

  virtual function void build();
    reserved=uvm_reg_field::type_id::create("reserved");
    force_bits=uvm_reg_field::type_id::create("force_bits");

    reserved.configure(this,24,8,"WO",0,24'h0,1,0,0);
    force_bits.configure(this,8,0,"WO",0,8'h0,1,0,0);
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if(has_coverage(UVM_CVR_FIELD_VALS))
      irq_force_cov.sample();
  endfunction
endclass

//==============================================================
// ERR_STATUS: 0x48 -- W1C
//==============================================================
class err_status_reg extends uvm_reg;
  `uvm_object_utils(err_status_reg)

  rand uvm_reg_field reserved, injected, length_error, crc_error;
  rand uvm_reg_field protocol_error, undersize, queue_overflow;
  rand uvm_reg_field dest_error, bus_error;

  covergroup err_status_cov;
    option.per_instance = 1;

    coverpoint injected.value {
      bins inactive = {0};
      bins active   = {1};
    }

    coverpoint length_error.value {
      bins inactive = {0};
      bins active   = {1};
    }

    coverpoint queue_overflow.value {
      bins inactive = {0};
      bins active   = {1};
    }

    coverpoint dest_error.value {
      bins inactive = {0};
      bins active   = {1};
    }

    coverpoint bus_error.value {
      bins inactive = {0};
      bins active   = {1};
    }
  endgroup

  function new(string name="err_status_reg");
    super.new(name,32,UVM_CVR_FIELD_VALS);

    if(has_coverage(UVM_CVR_FIELD_VALS))
      err_status_cov = new();
  endfunction

  virtual function void build();
    reserved=uvm_reg_field::type_id::create("reserved");
    injected=uvm_reg_field::type_id::create("injected");
    length_error=uvm_reg_field::type_id::create("length_error");
    crc_error=uvm_reg_field::type_id::create("crc_error");
    protocol_error=uvm_reg_field::type_id::create("protocol_error");
    undersize=uvm_reg_field::type_id::create("undersize");
    queue_overflow=uvm_reg_field::type_id::create("queue_overflow");
    dest_error=uvm_reg_field::type_id::create("dest_error");
    bus_error=uvm_reg_field::type_id::create("bus_error");

    reserved.configure(this,24,8,"RO",0,24'h0,1,0,0);
    injected.configure(this,1,7,"W1C",0,1'b0,1,0,0);
    length_error.configure(this,1,6,"W1C",0,1'b0,1,0,0);
    crc_error.configure(this,1,5,"W1C",0,1'b0,1,0,0);
    protocol_error.configure(this,1,4,"W1C",0,1'b0,1,0,0);
    undersize.configure(this,1,3,"W1C",0,1'b0,1,0,0);
    queue_overflow.configure(this,1,2,"W1C",0,1'b0,1,0,0);
    dest_error.configure(this,1,1,"W1C",0,1'b0,1,0,0);
    bus_error.configure(this,1,0,"W1C",0,1'b0,1,0,0);
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if(has_coverage(UVM_CVR_FIELD_VALS))
      err_status_cov.sample();
  endfunction
endclass

//==============================================================
// ERR_ENABLE: 0x4C
//==============================================================
class err_enable_reg extends uvm_reg;
  `uvm_object_utils(err_enable_reg)

  rand uvm_reg_field reserved, injected_en, length_en, crc_en;
  rand uvm_reg_field protocol_en, undersize_en, overflow_en;
  rand uvm_reg_field dest_en, bus_en;

  covergroup err_enable_cov;
    option.per_instance = 1;

    coverpoint injected_en.value {
      bins disabled = {0};
      bins enabled  = {1};
    }

    coverpoint length_en.value {
      bins disabled = {0};
      bins enabled  = {1};
    }

    coverpoint overflow_en.value {
      bins disabled = {0};
      bins enabled  = {1};
    }

    coverpoint dest_en.value {
      bins disabled = {0};
      bins enabled  = {1};
    }

    coverpoint bus_en.value {
      bins disabled = {0};
      bins enabled  = {1};
    }
  endgroup

  function new(string name="err_enable_reg");
    super.new(name,32,UVM_CVR_FIELD_VALS);

    if(has_coverage(UVM_CVR_FIELD_VALS))
      err_enable_cov = new();
  endfunction

  virtual function void build();
    reserved=uvm_reg_field::type_id::create("reserved");
    injected_en=uvm_reg_field::type_id::create("injected_en");
    length_en=uvm_reg_field::type_id::create("length_en");
    crc_en=uvm_reg_field::type_id::create("crc_en");
    protocol_en=uvm_reg_field::type_id::create("protocol_en");
    undersize_en=uvm_reg_field::type_id::create("undersize_en");
    overflow_en=uvm_reg_field::type_id::create("overflow_en");
    dest_en=uvm_reg_field::type_id::create("dest_en");
    bus_en=uvm_reg_field::type_id::create("bus_en");

    reserved.configure(this,24,8,"RO",0,24'h0,1,0,0);
    injected_en.configure(this,1,7,"RW",0,1'b0,1,1,1);
    length_en.configure(this,1,6,"RW",0,1'b0,1,1,1);
    crc_en.configure(this,1,5,"RW",0,1'b0,1,1,1);
    protocol_en.configure(this,1,4,"RW",0,1'b0,1,1,1);
    undersize_en.configure(this,1,3,"RW",0,1'b0,1,1,1);
    overflow_en.configure(this,1,2,"RW",0,1'b0,1,1,1);
    dest_en.configure(this,1,1,"RW",0,1'b0,1,1,1);
    bus_en.configure(this,1,0,"RW",0,1'b0,1,1,1);
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if(has_coverage(UVM_CVR_FIELD_VALS))
      err_enable_cov.sample();
  endfunction
endclass

//==============================================================
// ERR_INJECT: 0x50 -- WO diagnostic event register
//==============================================================
class err_inject_reg extends uvm_reg;
  `uvm_object_utils(err_inject_reg)

  rand uvm_reg_field clear_count, reserved, injected, length;
  rand uvm_reg_field crc, protocol, undersize, overflow, dest, bus;

  covergroup err_inject_cov;
    option.per_instance = 1;

    coverpoint clear_count.value {
      bins no_clear = {0};
      bins clear    = {1};
    }

    coverpoint {injected.value, length.value, crc.value,
                protocol.value, undersize.value, overflow.value,
                dest.value, bus.value} {
      bins no_injection = {8'b0};
      bins injection    = {[8'b1:8'hFF]};
    }
  endgroup

  function new(string name="err_inject_reg");
    super.new(name,32,UVM_CVR_FIELD_VALS);

    if(has_coverage(UVM_CVR_FIELD_VALS))
      err_inject_cov = new();
  endfunction

  virtual function void build();
    clear_count=uvm_reg_field::type_id::create("clear_count");
    reserved=uvm_reg_field::type_id::create("reserved");
    injected=uvm_reg_field::type_id::create("injected");
    length=uvm_reg_field::type_id::create("length");
    crc=uvm_reg_field::type_id::create("crc");
    protocol=uvm_reg_field::type_id::create("protocol");
    undersize=uvm_reg_field::type_id::create("undersize");
    overflow=uvm_reg_field::type_id::create("overflow");
    dest=uvm_reg_field::type_id::create("dest");
    bus=uvm_reg_field::type_id::create("bus");

    clear_count.configure(this,1,31,"WO",0,1'b0,1,0,0);
    reserved.configure(this,23,8,"WO",0,23'h0,1,0,0);
    injected.configure(this,1,7,"WO",0,1'b0,1,0,0);
    length.configure(this,1,6,"WO",0,1'b0,1,0,0);
    crc.configure(this,1,5,"WO",0,1'b0,1,0,0);
    protocol.configure(this,1,4,"WO",0,1'b0,1,0,0);
    undersize.configure(this,1,3,"WO",0,1'b0,1,0,0);
    overflow.configure(this,1,2,"WO",0,1'b0,1,0,0);
    dest.configure(this,1,1,"WO",0,1'b0,1,0,0);
    bus.configure(this,1,0,"WO",0,1'b0,1,0,0);
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if(has_coverage(UVM_CVR_FIELD_VALS))
      err_inject_cov.sample();
  endfunction
endclass

//==============================================================
// ERR_COUNT: 0x54
//==============================================================
class err_count_reg extends uvm_reg;
  `uvm_object_utils(err_count_reg)

  rand uvm_reg_field reserved, error_count;

  covergroup err_count_cov;
    option.per_instance = 1;

    coverpoint error_count.value {
      bins zero         = {0};
      bins one_error    = {1};
      bins multiple     = {[2:65534]};
      bins max_count    = {65535};
    }
  endgroup

  function new(string name="err_count_reg");
    super.new(name,32,UVM_CVR_FIELD_VALS);

    if(has_coverage(UVM_CVR_FIELD_VALS))
      err_count_cov = new();
  endfunction

  virtual function void build();
    reserved=uvm_reg_field::type_id::create("reserved");
    error_count=uvm_reg_field::type_id::create("error_count");

    reserved.configure(this,16,16,"RO",0,16'h0,1,0,0);
    error_count.configure(this,16,0,"RO",1,16'h0,1,0,0);
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if(has_coverage(UVM_CVR_FIELD_VALS))
      err_count_cov.sample();
  endfunction
endclass

//==============================================================
// ERR_INFO: 0x58
//==============================================================
class err_info_reg extends uvm_reg;
  `uvm_object_utils(err_info_reg)

  rand uvm_reg_field tx_snapshot, reserved, dest_port;
  rand uvm_reg_field source, last_code;

  covergroup err_info_cov;
    option.per_instance = 1;

    coverpoint dest_port.value {
      bins port0 = {0};
      bins port1 = {1};
      bins port2 = {2};
      bins port3 = {3};
    }

    coverpoint last_code.value {
      bins no_error = {0};
      bins error    = {[1:255]};
    }
  endgroup

  function new(string name="err_info_reg");
    super.new(name,32,UVM_CVR_FIELD_VALS);

    if(has_coverage(UVM_CVR_FIELD_VALS))
      err_info_cov = new();
  endfunction

  virtual function void build();
    tx_snapshot=uvm_reg_field::type_id::create("tx_snapshot");
    reserved=uvm_reg_field::type_id::create("reserved");
    dest_port=uvm_reg_field::type_id::create("dest_port");
    source=uvm_reg_field::type_id::create("source");
    last_code=uvm_reg_field::type_id::create("last_code");

    tx_snapshot.configure(this,12,20,"RO",1,12'h0,1,0,0);
    reserved.configure(this,2,18,"RO",0,2'h0,1,0,0);
    dest_port.configure(this,2,16,"RO",1,2'h0,1,0,0);
    source.configure(this,8,8,"RO",1,8'h0,1,0,0);
    last_code.configure(this,8,0,"RO",1,8'h0,1,0,0);
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if(has_coverage(UVM_CVR_FIELD_VALS))
      err_info_cov.sample();
  endfunction
endclass

//==============================================================
// LOCK: 0x5C
// Writes compare the complete key; read returns LOCKED at bit 0.
//==============================================================
class lock_reg extends uvm_reg;
  `uvm_object_utils(lock_reg)

  rand uvm_reg_field key_reserved, locked;

  covergroup lock_cov;
    option.per_instance = 1;

    coverpoint locked.value {
      bins unlocked = {0};
      bins locked   = {1};
    }
  endgroup

  function new(string name="lock_reg");
    super.new(name,32,UVM_CVR_FIELD_VALS);

    if(has_coverage(UVM_CVR_FIELD_VALS))
      lock_cov = new();
  endfunction

  virtual function void build();
    key_reserved=uvm_reg_field::type_id::create("key_reserved");
    locked=uvm_reg_field::type_id::create("locked");

    key_reserved.configure(this,31,1,"WO",0,31'h0,1,0,0);
    locked.configure(this,1,0,"RO",1,1'b1,1,0,0);
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if(has_coverage(UVM_CVR_FIELD_VALS))
      lock_cov.sample();
  endfunction
endclass

//==============================================================
// SOFT_RESET: 0x60
//==============================================================
class soft_reset_reg extends uvm_reg;
  `uvm_object_utils(soft_reset_reg)

  rand uvm_reg_field reserved, pulse;

  covergroup soft_reset_cov;
    option.per_instance = 1;

    coverpoint pulse.value {
      bins inactive = {0};
      bins asserted = {1};
    }
  endgroup

  function new(string name="soft_reset_reg");
    super.new(name,32,UVM_CVR_FIELD_VALS);

    if(has_coverage(UVM_CVR_FIELD_VALS))
      soft_reset_cov = new();
  endfunction

  virtual function void build();
    reserved=uvm_reg_field::type_id::create("reserved");
    pulse=uvm_reg_field::type_id::create("pulse");

    reserved.configure(this,31,1,"WO",0,31'h0,1,0,0);
    pulse.configure(this,1,0,"WO",0,1'b0,1,0,0);
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if(has_coverage(UVM_CVR_FIELD_VALS))
      soft_reset_cov.sample();
  endfunction
endclass
