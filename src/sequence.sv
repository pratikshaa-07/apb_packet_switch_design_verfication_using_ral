//1. device id ro test - read only register same value always
class device_id_ro_test extends uvm_sequence #(uvm_sequence_item);

  `uvm_object_utils(device_id_ro_test)

  pkt_reg_block regmodel;

  function new(string name = "device_id_ro_test");
    super.new(name);
  endfunction

  task body();
    uvm_status_e status;
    uvm_reg_data_t original_value;
    uvm_reg_data_t after_write_value;
    uvm_reg_data_t write_value;

    regmodel.device_id.read(status, original_value, UVM_FRONTDOOR);
    `uvm_info("DEVICE_ID_RO",$sformatf("Original DEVICE_ID = 0x%08h", original_value),UVM_LOW)
    
    write_value = ~original_value;
    regmodel.device_id.write(status, write_value, UVM_FRONTDOOR);
    regmodel.device_id.read(status, after_write_value, UVM_FRONTDOOR);
    `uvm_info("DEVICE_ID_RO", $sformatf("DEVICE_ID after write = 0x%08h",after_write_value),UVM_LOW)
 
    if (original_value == after_write_value) 
      `uvm_info("DEVICE_ID_RO","PASS: DEVICE_ID remained unchanged after write",UVM_LOW)
    else 
      `uvm_error("DEVICE_ID_RO",$sformatf("FAIL: Before=0x%08h After=0x%08h",original_value, after_write_value))

  endtask

endclass

////////////////////////////////////////////////////////////////////////

//2.version - read only same value always
class version_ro_sequence extends uvm_sequence #(uvm_sequence_item);

  `uvm_object_utils(version_ro_sequence)

  pkt_reg_block regmodel;

  function new(string name = "version_ro_sequence");
    super.new(name);
  endfunction

  task body();
    uvm_status_e status;
    uvm_reg_data_t original_value;
    uvm_reg_data_t after_write_value;
    uvm_reg_data_t write_value;

    regmodel.version.read(status, original_value, UVM_FRONTDOOR);
    `uvm_info("VERSION_RO",$sformatf("Original VERSION = 0x%08h", original_value),UVM_LOW)
    write_value = ~original_value;
    regmodel.version.write(status, write_value, UVM_FRONTDOOR);
    regmodel.version.read(status, after_write_value, UVM_FRONTDOOR);
    `uvm_info("VERSION_RO", $sformatf("VERSION after write = 0x%08h", after_write_value),UVM_LOW)

    if (original_value == after_write_value) 
      `uvm_info("VERSION_RO","PASS: VERSION register remained unchanged after write",UVM_LOW)
    else 
      `uvm_error("VERSION_RO", $sformatf("FAIL: Original=0x%08h, After write=0x%08h",original_value, after_write_value))

  endtask

endclass

////////////////////////////////////////////////////////////////////////

//3.switch status
      
class switch_status_ro_sequence extends uvm_sequence #(uvm_sequence_item);

  `uvm_object_utils(switch_status_ro_sequence)

  pkt_reg_block regmodel;

  function new(string name = "switch_status_ro_sequence");
    super.new(name);
  endfunction

  task body();
    uvm_status_e status;
    uvm_reg_data_t original_value;
    uvm_reg_data_t after_write_value;
    uvm_reg_data_t write_value;

    regmodel.switch_status.read(status, original_value, UVM_FRONTDOOR);
    `uvm_info("SWITCH_STATUS_RO", $sformatf("Original SWITCH_STATUS = 0x%08h", original_value), UVM_LOW)
    write_value = ~original_value;
    regmodel.switch_status.write(status, write_value, UVM_FRONTDOOR);
    regmodel.switch_status.read(status, after_write_value, UVM_FRONTDOOR);
    `uvm_info("SWITCH_STATUS_RO",$sformatf("SWITCH_STATUS after write = 0x%08h", after_write_value),UVM_LOW)
    if (original_value == after_write_value) 
      `uvm_info("SWITCH_STATUS_RO", "PASS: SWITCH_STATUS remained unchanged after write",UVM_LOW)
    else
      `uvm_error("SWITCH_STATUS_RO",$sformatf("FAIL: Original=0x%08h, After write=0x%08h",original_value, after_write_value))
  endtask

endclass

//////////////////////////////////////////////////////////////////////////

//4.port status
class port_status_ro_sequence extends uvm_sequence #(uvm_sequence_item);

  `uvm_object_utils(port_status_ro_sequence)

  pkt_reg_block regmodel;

  function new(string name = "port_status_ro_sequence");
    super.new(name);
  endfunction

  task body();
    uvm_status_e status;
    uvm_reg_data_t original_value;
    uvm_reg_data_t after_write_value;
    uvm_reg_data_t write_value;

    regmodel.port_status.read(status, original_value, UVM_FRONTDOOR);
    `uvm_info("PORT_STATUS_RO",$sformatf("Original PORT_STATUS = 0x%08h", original_value),UVM_LOW)

    write_value = ~original_value;

    regmodel.port_status.write(status, write_value, UVM_FRONTDOOR);
    regmodel.port_status.read(status, after_write_value, UVM_FRONTDOOR);
    `uvm_info("PORT_STATUS_RO", $sformatf("PORT_STATUS after write = 0x%08h",after_write_value),UVM_LOW)

    if (original_value == after_write_value) 
      `uvm_info("PORT_STATUS_RO","PASS: PORT_STATUS remained unchanged after write",UVM_LOW)
    else 
      `uvm_error("PORT_STATUS_RO", $sformatf("FAIL: Original=0x%08h, After write=0x%08h",original_value, after_write_value))
  endtask
endclass

//////////////////////////////////////////////////////////////////////
//5.gen status reg
class gen_status_ro_sequence extends uvm_sequence #(uvm_sequence_item);

  `uvm_object_utils(gen_status_ro_sequence)

  pkt_reg_block regmodel;

  function new(string name = "gen_status_ro_sequence");
    super.new(name);
  endfunction

  task body();
    uvm_status_e status;
    uvm_reg_data_t original_value;
    uvm_reg_data_t after_write_value;
    uvm_reg_data_t write_value;

    regmodel.gen_status.read(status, original_value, UVM_FRONTDOOR);

    `uvm_info("GEN_STATUS_RO",
      $sformatf("Original GEN_STATUS = 0x%08h", original_value),
      UVM_LOW)

    write_value = ~original_value;

    regmodel.gen_status.write(status, write_value, UVM_FRONTDOOR);

 
    regmodel.gen_status.read(status, after_write_value, UVM_FRONTDOOR);

    `uvm_info("GEN_STATUS_RO",
      $sformatf("GEN_STATUS after write = 0x%08h",
                after_write_value),
      UVM_LOW)

    if (original_value == after_write_value) begin
      `uvm_info("GEN_STATUS_RO",
        "PASS: GEN_STATUS remained unchanged after write",
        UVM_LOW)
    end
    else begin
      `uvm_error("GEN_STATUS_RO",
        $sformatf("FAIL: Original=0x%08h, After write=0x%08h",
                  original_value, after_write_value))
    end
  endtask

endclass


//////////////////////////////////////////////////////////////////////////
//6.stat rx reg
class stat_rx_ro_sequence extends uvm_sequence #(uvm_sequence_item);

  `uvm_object_utils(stat_rx_ro_sequence)

  pkt_reg_block regmodel;

  function new(string name = "stat_rx_ro_sequence");
    super.new(name);
  endfunction

  task body();
    uvm_status_e status;
    uvm_reg_data_t original_value;
    uvm_reg_data_t after_write_value;
    uvm_reg_data_t write_value;

    if (regmodel == null)
      `uvm_fatal("STAT_RX_RO", "Register model is not assigned")

    regmodel.stat_rx.read(status, original_value, UVM_FRONTDOOR);

    if (status != UVM_IS_OK)
      `uvm_fatal("STAT_RX_RO", "Initial read failed")

    `uvm_info("STAT_RX_RO",
      $sformatf("Original STAT_RX = 0x%08h", original_value),
      UVM_LOW)

    write_value = ~original_value;

    regmodel.stat_rx.write(status, write_value, UVM_FRONTDOOR);
    regmodel.stat_rx.read(status, after_write_value, UVM_FRONTDOOR);
    `uvm_info("STAT_RX_RO",
      $sformatf("STAT_RX after write = 0x%08h", after_write_value),
      UVM_LOW)

    if (original_value == after_write_value) begin
      `uvm_info("STAT_RX_RO",
        "PASS: STAT_RX remained unchanged after write",
        UVM_LOW)
    end
    else begin
      `uvm_error("STAT_RX_RO",
        $sformatf("FAIL: Original=0x%08h, After write=0x%08h",
                  original_value, after_write_value))
    end
  endtask

endclass

////////////////////////////////////////////////////////////////////////////
//7. stat tx reg
class stat_tx_ro_sequence extends uvm_sequence #(uvm_sequence_item);

  `uvm_object_utils(stat_tx_ro_sequence)

  pkt_reg_block regmodel;

  function new(string name = "stat_tx_ro_sequence");
    super.new(name);
  endfunction

  task body();
    uvm_status_e status;
    uvm_reg_data_t original_value;
    uvm_reg_data_t after_write_value;
    uvm_reg_data_t write_value;

    regmodel.stat_tx.read(status, original_value, UVM_FRONTDOOR);

    if (status != UVM_IS_OK)
      `uvm_fatal("STAT_TX_RO", "Initial read failed")

    `uvm_info("STAT_TX_RO",
      $sformatf("Original STAT_TX = 0x%08h", original_value),
      UVM_LOW)

    write_value = ~original_value;

    regmodel.stat_tx.write(status, write_value, UVM_FRONTDOOR);

    if (status != UVM_IS_OK)
      `uvm_fatal("STAT_TX_RO", "Write operation failed")

    regmodel.stat_tx.read(status, after_write_value, UVM_FRONTDOOR);

    if (status != UVM_IS_OK)
      `uvm_fatal("STAT_TX_RO", "Read after write failed")

    `uvm_info("STAT_TX_RO",
      $sformatf("STAT_TX after write = 0x%08h", after_write_value),
      UVM_LOW)

    if (original_value == after_write_value) begin
      `uvm_info("STAT_TX_RO",
        "PASS: STAT_TX remained unchanged after write",
        UVM_LOW)
    end
    else begin
      `uvm_error("STAT_TX_RO",
        $sformatf("FAIL: Original=0x%08h, After write=0x%08h",
                  original_value, after_write_value))
    end
  endtask

endclass

//////////////////////////////////////////////////////////////////////////////
//8. stat drop reg
class stat_drop_ro_sequence extends uvm_sequence #(uvm_sequence_item);

  `uvm_object_utils(stat_drop_ro_sequence)

  pkt_reg_block regmodel;

  function new(string name = "stat_drop_ro_sequence");
    super.new(name);
  endfunction

  task body();
    uvm_status_e status;
    uvm_reg_data_t original_value;
    uvm_reg_data_t after_write_value;
    uvm_reg_data_t write_value;

    if (regmodel == null)
      `uvm_fatal("STAT_DROP_RO", "Register model is not assigned")

    regmodel.stat_drop.read(status, original_value, UVM_FRONTDOOR);

    `uvm_info("STAT_DROP_RO",
      $sformatf("Original STAT_DROP = 0x%08h", original_value),
      UVM_LOW)

    write_value = ~original_value;

    regmodel.stat_drop.write(status, write_value, UVM_FRONTDOOR);
    regmodel.stat_drop.read(status, after_write_value, UVM_FRONTDOOR);

    if (status != UVM_IS_OK)
      `uvm_fatal("STAT_DROP_RO", "Read after write failed")

    `uvm_info("STAT_DROP_RO",
      $sformatf("STAT_DROP after write = 0x%08h", after_write_value),
      UVM_LOW)

    if (original_value == after_write_value) begin
      `uvm_info("STAT_DROP_RO",
        "PASS: STAT_DROP remained unchanged after write",
        UVM_LOW)
    end
    else begin
      `uvm_error("STAT_DROP_RO",
        $sformatf("FAIL: Original=0x%08h, After write=0x%08h",
                  original_value, after_write_value))
    end
  endtask

endclass
/////////////////////////////////////////////////////////////
//9. port enable reg
class port_enable_sequence extends uvm_sequence #(uvm_sequence_item);

  `uvm_object_utils(port_enable_sequence)

  pkt_reg_block regmodel;

  function new(string name = "port_enable_sequence");
    super.new(name);
  endfunction

  task body();
    uvm_status_e   status;
    uvm_reg_data_t lock_value;
    uvm_reg_data_t original_value;
    uvm_reg_data_t write_value;
    uvm_reg_data_t after_write_value;

    regmodel.lock.write(status, 32'hA5A5C3C3, UVM_FRONTDOOR);
    regmodel.lock.read(status, lock_value, UVM_FRONTDOOR);
    `uvm_info("PORT_ENABLE",
      $sformatf("LOCK after unlock = 0x%08h (bit0 must be 0)", lock_value),
      UVM_LOW)
    regmodel.port_enable.read(status, original_value, UVM_FRONTDOOR);
    `uvm_info("PORT_ENABLE",
      $sformatf("Original PORT_ENABLE = 0x%08h", original_value),
      UVM_LOW)

    write_value = original_value ^ 32'h0000000F;

    `uvm_info("PORT_ENABLE",
      $sformatf("Writing PORT_ENABLE = 0x%08h", write_value),
      UVM_LOW)

    regmodel.port_enable.write(status, write_value, UVM_FRONTDOOR);
    regmodel.port_enable.read(status, after_write_value, UVM_FRONTDOOR);

    `uvm_info("PORT_ENABLE",
      $sformatf("PORT_ENABLE after write = 0x%08h", after_write_value),
      UVM_LOW)

    if (after_write_value == write_value)
      `uvm_info("PORT_ENABLE",
        "PASS: read value matches written value", UVM_LOW)
    else
      `uvm_error("PORT_ENABLE",
        $sformatf("FAIL: Written=0x%08h Read=0x%08h",
                  write_value, after_write_value))

  endtask

endclass

////////////////////////////////////////////////////////
//10.switch ctrl reg
class switch_ctrl_sequence extends uvm_sequence #(uvm_sequence_item);

  `uvm_object_utils(switch_ctrl_sequence)

  pkt_reg_block regmodel;

  function new(string name = "switch_ctrl_sequence");
    super.new(name);
  endfunction

  task body();
    uvm_status_e   status;
    uvm_reg_data_t lock_value;
    uvm_reg_data_t original_value;
    uvm_reg_data_t write_value;
    uvm_reg_data_t after_write_value;

    regmodel.lock.write(status, 32'hA5A5C3C3, UVM_FRONTDOOR);
    regmodel.lock.read(status, lock_value, UVM_FRONTDOOR);
    `uvm_info("SWITCH_CTRL",
      $sformatf("LOCK after unlock = 0x%08h (bit0 must be 0)", lock_value),
      UVM_LOW)

    regmodel.switch_ctrl.read(status, original_value, UVM_FRONTDOOR);
    `uvm_info("SWITCH_CTRL",
      $sformatf("Original SWITCH_CTRL = 0x%08h", original_value),
      UVM_LOW)
    write_value = original_value ^ 32'h00000009;

    `uvm_info("SWITCH_CTRL",
      $sformatf("Writing SWITCH_CTRL = 0x%08h", write_value),
      UVM_LOW)

    regmodel.switch_ctrl.write(status, write_value, UVM_FRONTDOOR);
    regmodel.switch_ctrl.read(status, after_write_value, UVM_FRONTDOOR);
    `uvm_info("SWITCH_CTRL",
      $sformatf("SWITCH_CTRL after write = 0x%08h", after_write_value),
      UVM_LOW)

    if (after_write_value == write_value)
      `uvm_info("SWITCH_CTRL",
        "PASS: read value matches written value", UVM_LOW)
    else
      `uvm_error("SWITCH_CTRL",
        $sformatf("FAIL: Written=0x%08h Read=0x%08h",
                  write_value, after_write_value))

  endtask

endclass

//////////////////////////////////////////////////////////////////////////
//11.fwd enable reg
class fwd_enable_sequence extends uvm_sequence #(uvm_sequence_item);

  `uvm_object_utils(fwd_enable_sequence)

  pkt_reg_block regmodel;

  function new(string name = "fwd_enable_sequence");
    super.new(name);
  endfunction

  task body();
    uvm_status_e   status;
    uvm_reg_data_t lock_value;
    uvm_reg_data_t original_value;
    uvm_reg_data_t write_value;
    uvm_reg_data_t after_write_value;
    
    regmodel.lock.write(status, 32'hA5A5C3C3, UVM_FRONTDOOR);
    regmodel.lock.read(status, lock_value, UVM_FRONTDOOR);
    `uvm_info("FWD_ENABLE", $sformatf("LOCK after unlock = 0x%08h (bit0 must be 0)", lock_value),UVM_LOW)
    regmodel.fwd_enable.read(status, original_value, UVM_FRONTDOOR);
    `uvm_info("FWD_ENABLE",$sformatf("Original FWD_ENABLE = 0x%08h", original_value),UVM_LOW)
    write_value = 'h05;
    `uvm_info("FWD_ENABLE",$sformatf("Writing FWD_ENABLE = 0x%08h", write_value),UVM_LOW)
    regmodel.fwd_enable.write(status, write_value, UVM_FRONTDOOR);
    regmodel.fwd_enable.read(status, after_write_value, UVM_FRONTDOOR);
    `uvm_info("FWD_ENABLE",$sformatf("FWD_ENABLE after write = 0x%08h", after_write_value),UVM_LOW)
    if (after_write_value == write_value)
      `uvm_info("FWD_ENABLE","PASS: read value matches written value", UVM_LOW)
    else
      `uvm_error("FWD_ENABLE",$sformatf("FAIL: Written=0x%08h Read=0x%08h",write_value, after_write_value))

  endtask

endclass

//////////////////////////////////////////////////////////////////////////////
//  12. gen ctrl reg 
class gen_ctrl_sequence extends uvm_sequence #(uvm_sequence_item);

  `uvm_object_utils(gen_ctrl_sequence)

  pkt_reg_block regmodel;

  function new(string name = "gen_ctrl_sequence");
    super.new(name);
  endfunction

  task body();
    uvm_status_e   status;
    uvm_reg_data_t lock_value;
    uvm_reg_data_t original_value;
    uvm_reg_data_t read_value;
    regmodel.lock.write(status, 32'hA5A5C3C3, UVM_FRONTDOOR);
    regmodel.lock.read(status, lock_value, UVM_FRONTDOOR);
    `uvm_info("GEN_CTRL",$sformatf("LOCK after unlock = 0x%08h (bit0 must be 0)", lock_value),UVM_LOW)
    
    regmodel.gen_ctrl.read(status, original_value, UVM_FRONTDOOR);
    `uvm_info("GEN_CTRL",$sformatf("Original GEN_CTRL = 0x%08h", original_value), UVM_LOW)
    
    `uvm_info("GEN_CTRL", "---- CHECK 1: RW fields (enable, continuous) ----", UVM_LOW)
    regmodel.gen_ctrl.write(status, 32'h00000009, UVM_FRONTDOOR);
    regmodel.gen_ctrl.read(status, read_value, UVM_FRONTDOOR);
    `uvm_info("GEN_CTRL", $sformatf("Wrote 0x00000009, read 0x%08h", read_value),UVM_LOW)
    if (read_value[0] == 1'b1)
      `uvm_info("GEN_CTRL", "PASS: enable set to 1", UVM_LOW)
    else
      `uvm_error("GEN_CTRL", "FAIL: enable did not set to 1")
    if (read_value[3] == 1'b1)
      `uvm_info("GEN_CTRL", "PASS: continuous set to 1", UVM_LOW)
    else
      `uvm_error("GEN_CTRL", "FAIL: continuous did not set to 1")
      
    regmodel.gen_ctrl.write(status, 32'h00000000, UVM_FRONTDOOR);
    regmodel.gen_ctrl.read(status, read_value, UVM_FRONTDOOR);
    `uvm_info("GEN_CTRL",$sformatf("Wrote 0x00000000, read 0x%08h", read_value),UVM_LOW)
      
    `uvm_info("GEN_CTRL", "---- CHECK 2: RO field (reserved bits 31:4) ----", UVM_LOW)
    regmodel.gen_ctrl.write(status, 32'hFFFFFFF0, UVM_FRONTDOOR);
    regmodel.gen_ctrl.read(status, read_value, UVM_FRONTDOOR);
    `uvm_info("GEN_CTRL",$sformatf("Wrote 0xFFFFFFF0, read 0x%08h", read_value),UVM_LOW)
    if (read_value[31:4] == 28'h0)
      `uvm_info("GEN_CTRL", "PASS: reserved bits unchanged, still 0", UVM_LOW)
    else
      `uvm_error("GEN_CTRL",
        $sformatf("FAIL: reserved bits changed, read[31:4]=0x%07h", read_value[31:4]))

   
    `uvm_info("GEN_CTRL", "---- CHECK 3: WO fields (start, stop) read as 0 ----", UVM_LOW)

    regmodel.gen_ctrl.write(status, 32'h00000002, UVM_FRONTDOOR);
    regmodel.gen_ctrl.read(status, read_value, UVM_FRONTDOOR);
    `uvm_info("GEN_CTRL",$sformatf("Wrote 0x00000002 (start), read 0x%08h", read_value),UVM_LOW)
    if (read_value[1] == 1'b0)
      `uvm_info("GEN_CTRL", "PASS: start reads 0", UVM_LOW)
    else
      `uvm_error("GEN_CTRL", "FAIL: start did not read 0")

    regmodel.gen_ctrl.write(status, 32'h00000004, UVM_FRONTDOOR);
    regmodel.gen_ctrl.read(status, read_value, UVM_FRONTDOOR);
    `uvm_info("GEN_CTRL",$sformatf("Wrote 0x00000004 (stop), read 0x%08h", read_value),UVM_LOW)

    if (read_value[2] == 1'b0)
      `uvm_info("GEN_CTRL", "PASS: stop reads 0", UVM_LOW)
    else
      `uvm_error("GEN_CTRL", "FAIL: stop did not read 0")

    regmodel.gen_ctrl.write(status, 32'h00000000, UVM_FRONTDOOR);
  endtask

endclass
      
////////////////////////////////////////////////////////////////////// 
//13.gen pkt cfg 
class gen_pkt_cfg_sequence extends uvm_sequence #(uvm_sequence_item);

  `uvm_object_utils(gen_pkt_cfg_sequence)

  pkt_reg_block regmodel;

  function new(string name = "gen_pkt_cfg_sequence");
    super.new(name);
  endfunction

  task body();
    uvm_status_e   status;
    uvm_reg_data_t lock_value;
    uvm_reg_data_t original_value;
    uvm_reg_data_t write_value;
    uvm_reg_data_t read_value;

    regmodel.lock.write(status, 32'hA5A5C3C3, UVM_FRONTDOOR);
    regmodel.lock.read(status, lock_value, UVM_FRONTDOOR);
    `uvm_info("GEN_PKT_CFG", $sformatf("LOCK after unlock = 0x%08h (bit0 must be 0)", lock_value),UVM_LOW)

    regmodel.gen_pkt_cfg.read(status, original_value, UVM_FRONTDOOR);
    `uvm_info("GEN_PKT_CFG",$sformatf("Original GEN_PKT_CFG = 0x%08h", original_value), UVM_LOW)

    if (original_value == 32'h00000401)
      `uvm_info("GEN_PKT_CFG", "PASS: reset value is 0x00000401", UVM_LOW)
    else
      `uvm_error("GEN_PKT_CFG",
        $sformatf("FAIL: reset value expected 0x00000401, read 0x%08h", original_value))

    `uvm_info("GEN_PKT_CFG", "---- CHECK 1: RW fields (seed, length, src_port, dst_port) ----", UVM_LOW)

    write_value = 32'h00A50A0B;

    regmodel.gen_pkt_cfg.write(status, write_value, UVM_FRONTDOOR);
    regmodel.gen_pkt_cfg.read(status, read_value, UVM_FRONTDOOR);
    `uvm_info("GEN_PKT_CFG",$sformatf("Wrote 0x%08h, read 0x%08h", write_value, read_value),UVM_LOW)

    if (read_value[23:16] == write_value[23:16])
      `uvm_info("GEN_PKT_CFG", "PASS: seed matches", UVM_LOW)
    else
      `uvm_error("GEN_PKT_CFG",$sformatf("FAIL: seed expected 0x%02h, read 0x%02h",write_value[23:16], read_value[23:16]))

    if (read_value[15:8] == write_value[15:8])
      `uvm_info("GEN_PKT_CFG", "PASS: length matches", UVM_LOW)
    else
      `uvm_error("GEN_PKT_CFG",
        $sformatf("FAIL: length expected 0x%02h, read 0x%02h", write_value[15:8], read_value[15:8]))

    if (read_value[3:2] == write_value[3:2])
      `uvm_info("GEN_PKT_CFG", "PASS: src_port matches", UVM_LOW)
    else
      `uvm_error("GEN_PKT_CFG",
        $sformatf("FAIL: src_port expected 0x%h, read 0x%h", write_value[3:2], read_value[3:2]))

    if (read_value[1:0] == write_value[1:0])
      `uvm_info("GEN_PKT_CFG", "PASS: dst_port matches", UVM_LOW)
    else
      `uvm_error("GEN_PKT_CFG",$sformatf("FAIL: dst_port expected 0x%h, read 0x%h", write_value[1:0], read_value[1:0]))

    write_value = 32'h005A0504;

    regmodel.gen_pkt_cfg.write(status, write_value, UVM_FRONTDOOR);
    regmodel.gen_pkt_cfg.read(status, read_value, UVM_FRONTDOOR);
    `uvm_info("GEN_PKT_CFG", $sformatf("Wrote 0x%08h, read 0x%08h", write_value, read_value),UVM_LOW)

    if (read_value == write_value)
      `uvm_info("GEN_PKT_CFG", "PASS: pattern 2 read value matches written value", UVM_LOW)
    else
      `uvm_error("GEN_PKT_CFG",
        $sformatf("FAIL: Written=0x%08h Read=0x%08h", write_value, read_value))

    `uvm_info("GEN_PKT_CFG", "---- CHECK 2: RO fields (reserved_hi 31:24, reserved_mid 7:4) ----", UVM_LOW)

    write_value = 32'hFF0001F0;

    regmodel.gen_pkt_cfg.write(status, write_value, UVM_FRONTDOOR);
    if (status != UVM_IS_OK)
      `uvm_fatal("GEN_PKT_CFG", "RO write failed")

    regmodel.gen_pkt_cfg.read(status, read_value, UVM_FRONTDOOR);
    if (status != UVM_IS_OK)
      `uvm_fatal("GEN_PKT_CFG", "RO read after write failed")

    `uvm_info("GEN_PKT_CFG",
      $sformatf("Wrote 0x%08h, read 0x%08h", write_value, read_value),
      UVM_LOW)

    if (read_value[31:24] == 8'h00)
      `uvm_info("GEN_PKT_CFG", "PASS: reserved_hi unchanged, still 0", UVM_LOW)
    else
      `uvm_error("GEN_PKT_CFG",
        $sformatf("FAIL: reserved_hi changed, read 0x%02h", read_value[31:24]))

    if (read_value[7:4] == 4'h0)
      `uvm_info("GEN_PKT_CFG", "PASS: reserved_mid unchanged, still 0", UVM_LOW)
    else
      `uvm_error("GEN_PKT_CFG",
        $sformatf("FAIL: reserved_mid changed, read 0x%h", read_value[7:4]))

    `uvm_info("GEN_PKT_CFG", "---- CHECK 3: length = 0 is stored as 1 ----", UVM_LOW)

    write_value = 32'h00000000;

    regmodel.gen_pkt_cfg.write(status, write_value, UVM_FRONTDOOR);
    if (status != UVM_IS_OK)
      `uvm_fatal("GEN_PKT_CFG", "Length 0 write failed")

    regmodel.gen_pkt_cfg.read(status, read_value, UVM_FRONTDOOR);
    if (status != UVM_IS_OK)
      `uvm_fatal("GEN_PKT_CFG", "Length 0 read failed")

    `uvm_info("GEN_PKT_CFG",
      $sformatf("Wrote 0x%08h, read 0x%08h", write_value, read_value),
      UVM_LOW)

    if (read_value[15:8] == 8'h01)
      `uvm_info("GEN_PKT_CFG", "PASS: length 0 stored as 1", UVM_LOW)
    else
      `uvm_error("GEN_PKT_CFG",
        $sformatf("FAIL: length expected 0x01, read 0x%02h", read_value[15:8]))

    `uvm_info("GEN_PKT_CFG", "---- CHECK 4: length above 16 stays readable ----", UVM_LOW)

    write_value = 32'h00002000;

    regmodel.gen_pkt_cfg.write(status, write_value, UVM_FRONTDOOR);
    regmodel.gen_pkt_cfg.read(status, read_value, UVM_FRONTDOOR);
    `uvm_info("GEN_PKT_CFG",$sformatf("Wrote 0x%08h, read 0x%08h", write_value, read_value), UVM_LOW)
    if (read_value[15:8] == 8'h20)
      `uvm_info("GEN_PKT_CFG", "PASS: length 0x20 read back unchanged", UVM_LOW)
    else
      `uvm_error("GEN_PKT_CFG",
        $sformatf("FAIL: length expected 0x20, read 0x%02h", read_value[15:8]))
      
    regmodel.gen_pkt_cfg.write(status, 32'h00000401, UVM_FRONTDOOR);
  endtask

endclass


/////////////////////////////////////////////////////////////////////////////
//14.gen interval reg     
class gen_interval_sequence extends uvm_sequence #(uvm_sequence_item);

  `uvm_object_utils(gen_interval_sequence)

  pkt_reg_block regmodel;

  function new(string name = "gen_interval_sequence");
    super.new(name);
  endfunction

  task body();
    uvm_status_e   status;
    uvm_reg_data_t lock_value;
    uvm_reg_data_t original_value;
    uvm_reg_data_t write_value;
    uvm_reg_data_t read_value;
    
    regmodel.lock.write(status, 32'hA5A5C3C3, UVM_FRONTDOOR);
    regmodel.lock.read(status, lock_value, UVM_FRONTDOOR);
    `uvm_info("GEN_INTERVAL",$sformatf("LOCK after unlock = 0x%08h (bit0 must be 0)", lock_value),UVM_LOW)
    regmodel.gen_interval.read(status, original_value, UVM_FRONTDOOR);
    `uvm_info("GEN_INTERVAL",$sformatf("Original GEN_INTERVAL = 0x%08h", original_value),UVM_LOW)

    `uvm_info("GEN_INTERVAL", "---- CHECK 1: RW field (interval 15:0) ----", UVM_LOW)
    write_value = 32'h0000A5C3;
    `uvm_info("GEN_INTERVAL", $sformatf("Writing GEN_INTERVAL = 0x%08h", write_value),UVM_LOW)
    
    regmodel.gen_interval.write(status, write_value, UVM_FRONTDOOR);
    regmodel.gen_interval.read(status, read_value, UVM_FRONTDOOR);
    `uvm_info("GEN_INTERVAL",$sformatf("GEN_INTERVAL after write = 0x%08h", read_value),UVM_LOW)

    if (read_value == write_value)
      `uvm_info("GEN_INTERVAL", "PASS: read value matches written value", UVM_LOW)
    else
      `uvm_error("GEN_INTERVAL", $sformatf("FAIL: Written=0x%08h Read=0x%08h", write_value, read_value))

    `uvm_info("GEN_INTERVAL", "---- CHECK 2: Reserved bits [31:16] ----", UVM_LOW)

    write_value = 32'hABCD0005;
    `uvm_info("GEN_INTERVAL",$sformatf("Writing GEN_INTERVAL = 0x%08h", write_value), UVM_LOW)

    regmodel.gen_interval.write(status, write_value, UVM_FRONTDOOR);
    regmodel.gen_interval.read(status, read_value, UVM_FRONTDOOR);
    `uvm_info("GEN_INTERVAL",$sformatf("GEN_INTERVAL after write = 0x%08h", read_value),UVM_LOW)
    if (read_value[31:16] == 16'h0000)
      `uvm_info("GEN_INTERVAL", "PASS: reserved bits unchanged, still 0", UVM_LOW)
    else
      `uvm_error("GEN_INTERVAL", $sformatf("FAIL: reserved bits changed, read[31:16]=0x%04h", read_value[31:16]))

    if (read_value[15:0] == write_value[15:0])
      `uvm_info("GEN_INTERVAL", "PASS: interval bits stored correctly", UVM_LOW)
    else
      `uvm_error("GEN_INTERVAL", $sformatf("FAIL: interval expected 0x%04h, read 0x%04h", write_value[15:0], read_value[15:0]))

    regmodel.gen_interval.write(status, 32'h00000002, UVM_FRONTDOOR);
  endtask

endclass

/////////////////////////////////////////////////////////////////////////////
//15.gen count      
class gen_count_sequence extends uvm_sequence #(uvm_sequence_item);

  `uvm_object_utils(gen_count_sequence)

  pkt_reg_block regmodel;

  function new(string name = "gen_count_sequence");
    super.new(name);
  endfunction

  task body();
    uvm_status_e   status;
    uvm_reg_data_t lock_value;
    uvm_reg_data_t original_value;
    uvm_reg_data_t write_value;
    uvm_reg_data_t read_value;

    regmodel.lock.write(status, 32'hA5A5C3C3, UVM_FRONTDOOR);
    regmodel.lock.read(status, lock_value, UVM_FRONTDOOR);
    `uvm_info("GEN_COUNT",
      $sformatf("LOCK after unlock = 0x%08h (bit0 must be 0)", lock_value),
      UVM_LOW)

    regmodel.gen_count.read(status, original_value, UVM_FRONTDOOR);
    `uvm_info("GEN_COUNT",$sformatf("Original GEN_COUNT = 0x%08h", original_value), UVM_LOW)

    `uvm_info("GEN_COUNT", "---- CHECK 1: RW field (packet_count 15:0) ----", UVM_LOW)
    
    write_value = 32'h0000A5C3;
    `uvm_info("GEN_COUNT",$sformatf("Writing GEN_COUNT = 0x%08h", write_value),UVM_LOW)

    regmodel.gen_count.write(status, write_value, UVM_FRONTDOOR);
    regmodel.gen_count.read(status, read_value, UVM_FRONTDOOR);
    `uvm_info("GEN_COUNT",$sformatf("GEN_COUNT after write = 0x%08h", read_value),UVM_LOW)

    if (read_value == write_value)
      `uvm_info("GEN_COUNT", "PASS: read value matches written value", UVM_LOW)
    else
      `uvm_error("GEN_COUNT",$sformatf("FAIL: Written=0x%08h Read=0x%08h", write_value, read_value))

    `uvm_info("GEN_COUNT", "---- CHECK 2: Reserved bits [31:16] ----", UVM_LOW)
    write_value = 32'hABCD0005;

    `uvm_info("GEN_COUNT",$sformatf("Writing GEN_COUNT = 0x%08h", write_value),UVM_LOW)

    regmodel.gen_count.write(status, write_value, UVM_FRONTDOOR);
    regmodel.gen_count.read(status, read_value, UVM_FRONTDOOR);
    `uvm_info("GEN_COUNT", $sformatf("GEN_COUNT after write = 0x%08h", read_value), UVM_LOW)

    if (read_value[31:16] == 16'h0000)
      `uvm_info("GEN_COUNT", "PASS: reserved bits unchanged, still 0", UVM_LOW)
    else
      `uvm_error("GEN_COUNT",
        $sformatf("FAIL: reserved bits changed, read[31:16]=0x%04h", read_value[31:16]))

    if (read_value[15:0] == write_value[15:0])
      `uvm_info("GEN_COUNT", "PASS: packet_count bits stored correctly", UVM_LOW)
    else
      `uvm_error("GEN_COUNT",$sformatf("FAIL: packet_count expected 0x%04h, read 0x%04h", write_value[15:0], read_value[15:0]))

    regmodel.gen_count.write(status, 32'h00000004, UVM_FRONTDOOR);
  endtask

endclass


////////////////////////////////////////////////////////////////////////////
      
      class irq_status_sequence extends uvm_sequence #(uvm_sequence_item);

  `uvm_object_utils(irq_status_sequence)

  pkt_reg_block regmodel;

  function new(string name = "irq_status_sequence");
    super.new(name);
  endfunction

  task body();
    uvm_status_e   status;
    uvm_reg_data_t original_value;
    uvm_reg_data_t write_value;
    uvm_reg_data_t read_value;
    string         bit_name [8] = '{"gen_done", "error", "overflow", "packet_drop",
                                    "packet_fwd", "queue_af", "start_ack", "sw_event"};

    if (regmodel == null)
      `uvm_fatal("IRQ_STATUS", "Register model is not assigned")

    regmodel.irq_status.read(status, original_value, UVM_FRONTDOOR);
    if (status != UVM_IS_OK)
      `uvm_fatal("IRQ_STATUS", "Initial read failed")

    `uvm_info("IRQ_STATUS",
      $sformatf("Original IRQ_STATUS = 0x%08h", original_value),
      UVM_LOW)

    if (original_value == 32'h00000000)
      `uvm_info("IRQ_STATUS", "PASS: reset value is 0x00000000", UVM_LOW)
    else
      `uvm_error("IRQ_STATUS",
        $sformatf("FAIL: reset value expected 0x00000000, read 0x%08h", original_value))

    `uvm_info("IRQ_STATUS", "---- CHECK 1: each W1C field, set by IRQ_FORCE then cleared ----", UVM_LOW)

    for (int i = 0; i < 8; i++) begin
      write_value = 32'h1 << i;

      regmodel.irq_force.write(status, write_value, UVM_FRONTDOOR);
      if (status != UVM_IS_OK)
        `uvm_fatal("IRQ_STATUS", $sformatf("IRQ_FORCE write failed for bit %0d", i))

      regmodel.irq_status.read(status, read_value, UVM_FRONTDOOR);
      if (status != UVM_IS_OK)
        `uvm_fatal("IRQ_STATUS", $sformatf("Read after force failed for bit %0d", i))

      `uvm_info("IRQ_STATUS",
        $sformatf("%s (bit %0d): forced 0x%08h, read 0x%08h", bit_name[i], i, write_value, read_value),
        UVM_LOW)

      if (read_value == write_value)
        `uvm_info("IRQ_STATUS", $sformatf("PASS: %s set by IRQ_FORCE", bit_name[i]), UVM_LOW)
      else
        `uvm_error("IRQ_STATUS",
          $sformatf("FAIL: %s expected 0x%08h after force, read 0x%08h",
                    bit_name[i], write_value, read_value))

      regmodel.irq_status.write(status, 32'h00000000, UVM_FRONTDOOR);
      if (status != UVM_IS_OK)
        `uvm_fatal("IRQ_STATUS", $sformatf("Write 0 failed for bit %0d", i))

      regmodel.irq_status.read(status, read_value, UVM_FRONTDOOR);
      if (status != UVM_IS_OK)
        `uvm_fatal("IRQ_STATUS", $sformatf("Read after write 0 failed for bit %0d", i))

      if (read_value == write_value)
        `uvm_info("IRQ_STATUS", $sformatf("PASS: %s unchanged by write of 0", bit_name[i]), UVM_LOW)
      else
        `uvm_error("IRQ_STATUS",
          $sformatf("FAIL: %s changed by write of 0, read 0x%08h", bit_name[i], read_value))

      regmodel.irq_status.write(status, write_value, UVM_FRONTDOOR);
      if (status != UVM_IS_OK)
        `uvm_fatal("IRQ_STATUS", $sformatf("Write 1 to clear failed for bit %0d", i))

      regmodel.irq_status.read(status, read_value, UVM_FRONTDOOR);
      if (status != UVM_IS_OK)
        `uvm_fatal("IRQ_STATUS", $sformatf("Read after clear failed for bit %0d", i))

      if (read_value == 32'h00000000)
        `uvm_info("IRQ_STATUS", $sformatf("PASS: %s cleared by write of 1", bit_name[i]), UVM_LOW)
      else
        `uvm_error("IRQ_STATUS",
          $sformatf("FAIL: %s not cleared by write of 1, read 0x%08h", bit_name[i], read_value))
    end

    `uvm_info("IRQ_STATUS", "---- CHECK 2: clearing one bit must not affect other bits ----", UVM_LOW)

    regmodel.irq_force.write(status, 32'h000000FF, UVM_FRONTDOOR);
    if (status != UVM_IS_OK)
      `uvm_fatal("IRQ_STATUS", "IRQ_FORCE write 0xFF failed")

    regmodel.irq_status.read(status, read_value, UVM_FRONTDOOR);
    if (status != UVM_IS_OK)
      `uvm_fatal("IRQ_STATUS", "Read after force 0xFF failed")

    `uvm_info("IRQ_STATUS",
      $sformatf("Forced 0x000000FF, read 0x%08h", read_value),
      UVM_LOW)

    if (read_value == 32'h000000FF)
      `uvm_info("IRQ_STATUS", "PASS: all 8 bits set", UVM_LOW)
    else
      `uvm_error("IRQ_STATUS",
        $sformatf("FAIL: expected 0x000000FF, read 0x%08h", read_value))

    regmodel.irq_status.write(status, 32'h00000041, UVM_FRONTDOOR);
    if (status != UVM_IS_OK)
      `uvm_fatal("IRQ_STATUS", "Write 0x41 failed")

    regmodel.irq_status.read(status, read_value, UVM_FRONTDOOR);
    if (status != UVM_IS_OK)
      `uvm_fatal("IRQ_STATUS", "Read after write 0x41 failed")

    `uvm_info("IRQ_STATUS",
      $sformatf("Wrote 0x00000041 (gen_done, start_ack), read 0x%08h", read_value),
      UVM_LOW)

    if (read_value == 32'h000000BE)
      `uvm_info("IRQ_STATUS", "PASS: only gen_done and start_ack cleared", UVM_LOW)
    else
      `uvm_error("IRQ_STATUS",
        $sformatf("FAIL: expected 0x000000BE, read 0x%08h", read_value))

    `uvm_info("IRQ_STATUS", "---- CHECK 3: reserved bits [31:8] ----", UVM_LOW)

    regmodel.irq_status.write(status, 32'hFFFFFF00, UVM_FRONTDOOR);
    if (status != UVM_IS_OK)
      `uvm_fatal("IRQ_STATUS", "Reserved write failed")

    regmodel.irq_status.read(status, read_value, UVM_FRONTDOOR);
    if (status != UVM_IS_OK)
      `uvm_fatal("IRQ_STATUS", "Reserved read after write failed")

    `uvm_info("IRQ_STATUS",
      $sformatf("Wrote 0xFFFFFF00, read 0x%08h", read_value),
      UVM_LOW)

    if (read_value[31:8] == 24'h0)
      `uvm_info("IRQ_STATUS", "PASS: reserved bits read 0", UVM_LOW)
    else
      `uvm_error("IRQ_STATUS",
        $sformatf("FAIL: reserved bits changed, read[31:8]=0x%06h", read_value[31:8]))

    if (read_value[7:0] == 8'hBE)
      `uvm_info("IRQ_STATUS", "PASS: bits [7:0] unchanged by write of 0", UVM_LOW)
    else
      `uvm_error("IRQ_STATUS",
        $sformatf("FAIL: bits [7:0] expected 0xBE, read 0x%02h", read_value[7:0]))

    regmodel.irq_status.write(status, 32'h000000FF, UVM_FRONTDOOR);
    if (status != UVM_IS_OK)
      `uvm_fatal("IRQ_STATUS", "Final clear failed")

    regmodel.irq_status.read(status, read_value, UVM_FRONTDOOR);
    if (status != UVM_IS_OK)
      `uvm_fatal("IRQ_STATUS", "Final read failed")

    if (read_value == 32'h00000000)
      `uvm_info("IRQ_STATUS", "PASS: all bits cleared at end of test", UVM_LOW)
    else
      `uvm_error("IRQ_STATUS",
        $sformatf("FAIL: expected 0x00000000 at end, read 0x%08h", read_value))

  endtask

endclass


      /////////////////////////////////////////////////////////////////////
      
      class irq_enable_sequence extends uvm_sequence #(uvm_sequence_item);

  `uvm_object_utils(irq_enable_sequence)

  pkt_reg_block regmodel;

  function new(string name = "irq_enable_sequence");
    super.new(name);
  endfunction

  task body();
    uvm_status_e   status;
    uvm_reg_data_t lock_value;
    uvm_reg_data_t original_value;
    uvm_reg_data_t write_value;
    uvm_reg_data_t read_value;

    if (regmodel == null)
      `uvm_fatal("IRQ_ENABLE", "Register model is not assigned")

    regmodel.lock.write(status, 32'hA5A5C3C3, UVM_FRONTDOOR);
    if (status != UVM_IS_OK)
      `uvm_fatal("IRQ_ENABLE", "Unlock write failed")

    regmodel.lock.read(status, lock_value, UVM_FRONTDOOR);
    `uvm_info("IRQ_ENABLE",
      $sformatf("LOCK after unlock = 0x%08h (bit0 must be 0)", lock_value),
      UVM_LOW)

    regmodel.irq_enable.read(status, original_value, UVM_FRONTDOOR);
    if (status != UVM_IS_OK)
      `uvm_fatal("IRQ_ENABLE", "Initial read failed")

    `uvm_info("IRQ_ENABLE",
      $sformatf("Original IRQ_ENABLE = 0x%08h", original_value),
      UVM_LOW)

    `uvm_info("IRQ_ENABLE", "---- CHECK 1: RW bits [7:0], all set then all clear ----", UVM_LOW)

    write_value = 32'h000000FF;

    `uvm_info("IRQ_ENABLE",
      $sformatf("Writing IRQ_ENABLE = 0x%08h", write_value),
      UVM_LOW)

    regmodel.irq_enable.write(status, write_value, UVM_FRONTDOOR);
    if (status != UVM_IS_OK)
      `uvm_fatal("IRQ_ENABLE", "Write 0xFF failed")

    regmodel.irq_enable.read(status, read_value, UVM_FRONTDOOR);
    if (status != UVM_IS_OK)
      `uvm_fatal("IRQ_ENABLE", "Read after write 0xFF failed")

    `uvm_info("IRQ_ENABLE",
      $sformatf("IRQ_ENABLE after write = 0x%08h", read_value),
      UVM_LOW)

    if (read_value == write_value)
      `uvm_info("IRQ_ENABLE", "PASS: all 8 enable bits set", UVM_LOW)
    else
      `uvm_error("IRQ_ENABLE",
        $sformatf("FAIL: Written=0x%08h Read=0x%08h", write_value, read_value))

    write_value = 32'h00000000;

    `uvm_info("IRQ_ENABLE",
      $sformatf("Writing IRQ_ENABLE = 0x%08h", write_value),
      UVM_LOW)

    regmodel.irq_enable.write(status, write_value, UVM_FRONTDOOR);
    if (status != UVM_IS_OK)
      `uvm_fatal("IRQ_ENABLE", "Write 0x00 failed")

    regmodel.irq_enable.read(status, read_value, UVM_FRONTDOOR);
    if (status != UVM_IS_OK)
      `uvm_fatal("IRQ_ENABLE", "Read after write 0x00 failed")

    `uvm_info("IRQ_ENABLE",
      $sformatf("IRQ_ENABLE after write = 0x%08h", read_value),
      UVM_LOW)

    if (read_value == write_value)
      `uvm_info("IRQ_ENABLE", "PASS: all 8 enable bits cleared", UVM_LOW)
    else
      `uvm_error("IRQ_ENABLE",
        $sformatf("FAIL: Written=0x%08h Read=0x%08h", write_value, read_value))

    `uvm_info("IRQ_ENABLE", "---- CHECK 2: Reserved bits [31:8] ----", UVM_LOW)

    write_value = 32'hABCDEF55;

    `uvm_info("IRQ_ENABLE",
      $sformatf("Writing IRQ_ENABLE = 0x%08h", write_value),
      UVM_LOW)

    regmodel.irq_enable.write(status, write_value, UVM_FRONTDOOR);
    if (status != UVM_IS_OK)
      `uvm_fatal("IRQ_ENABLE", "Reserved write failed")

    regmodel.irq_enable.read(status, read_value, UVM_FRONTDOOR);
    if (status != UVM_IS_OK)
      `uvm_fatal("IRQ_ENABLE", "Reserved read after write failed")

    `uvm_info("IRQ_ENABLE",
      $sformatf("IRQ_ENABLE after write = 0x%08h", read_value),
      UVM_LOW)

    if (read_value[31:8] == 24'h0)
      `uvm_info("IRQ_ENABLE", "PASS: reserved bits unchanged, still 0", UVM_LOW)
    else
      `uvm_error("IRQ_ENABLE",
        $sformatf("FAIL: reserved bits changed, read[31:8]=0x%06h", read_value[31:8]))

  endtask

endclass


/////////////////////////////////////////////////////////////////////////////
      
      class irq_force_sequence extends uvm_sequence #(uvm_sequence_item);

  `uvm_object_utils(irq_force_sequence)

  pkt_reg_block regmodel;

  function new(string name = "irq_force_sequence");
    super.new(name);
  endfunction

  task body();
    uvm_status_e   status;
    uvm_reg_data_t original_value;
    uvm_reg_data_t write_value;
    uvm_reg_data_t read_value;

    if (regmodel == null)
      `uvm_fatal("IRQ_FORCE", "Register model is not assigned")

    regmodel.irq_status.read(status, original_value, UVM_FRONTDOOR);
    if (status != UVM_IS_OK)
      `uvm_fatal("IRQ_FORCE", "Initial IRQ_STATUS read failed")

    `uvm_info("IRQ_FORCE",
      $sformatf("Original IRQ_STATUS = 0x%08h", original_value),
      UVM_LOW)

    `uvm_info("IRQ_FORCE", "---- CHECK 1: WO register reads as 0 ----", UVM_LOW)

    write_value = 32'h000000A5;

    `uvm_info("IRQ_FORCE",
      $sformatf("Writing IRQ_FORCE = 0x%08h", write_value),
      UVM_LOW)

    regmodel.irq_force.write(status, write_value, UVM_FRONTDOOR);
    if (status != UVM_IS_OK)
      `uvm_fatal("IRQ_FORCE", "IRQ_FORCE write failed")

    regmodel.irq_force.read(status, read_value, UVM_FRONTDOOR);
    if (status != UVM_IS_OK)
      `uvm_fatal("IRQ_FORCE", "IRQ_FORCE read failed")

    `uvm_info("IRQ_FORCE",
      $sformatf("IRQ_FORCE read = 0x%08h", read_value),
      UVM_LOW)

    if (read_value == 32'h00000000)
      `uvm_info("IRQ_FORCE", "PASS: IRQ_FORCE reads 0", UVM_LOW)
    else
      `uvm_error("IRQ_FORCE",
        $sformatf("FAIL: IRQ_FORCE expected 0x00000000, read 0x%08h", read_value))

    `uvm_info("IRQ_FORCE", "---- CHECK 2: written 1s set IRQ_STATUS, written 0s do nothing ----", UVM_LOW)

    regmodel.irq_status.read(status, read_value, UVM_FRONTDOOR);
    if (status != UVM_IS_OK)
      `uvm_fatal("IRQ_FORCE", "IRQ_STATUS read after force failed")

    `uvm_info("IRQ_FORCE",
      $sformatf("Forced 0x%08h, IRQ_STATUS = 0x%08h", write_value, read_value),
      UVM_LOW)

    if (read_value == write_value)
      `uvm_info("IRQ_FORCE", "PASS: forced bits set in IRQ_STATUS", UVM_LOW)
    else
      `uvm_error("IRQ_FORCE",
        $sformatf("FAIL: IRQ_STATUS expected 0x%08h, read 0x%08h", write_value, read_value))

    regmodel.irq_force.write(status, 32'h00000000, UVM_FRONTDOOR);
    if (status != UVM_IS_OK)
      `uvm_fatal("IRQ_FORCE", "IRQ_FORCE write 0 failed")

    regmodel.irq_status.read(status, read_value, UVM_FRONTDOOR);
    if (status != UVM_IS_OK)
      `uvm_fatal("IRQ_FORCE", "IRQ_STATUS read after force 0 failed")

    `uvm_info("IRQ_FORCE",
      $sformatf("Forced 0x00000000, IRQ_STATUS = 0x%08h", read_value),
      UVM_LOW)

    if (read_value == 32'h000000A5)
      `uvm_info("IRQ_FORCE", "PASS: writing 0 did not clear IRQ_STATUS", UVM_LOW)
    else
      `uvm_error("IRQ_FORCE",
        $sformatf("FAIL: IRQ_STATUS expected 0x000000A5, read 0x%08h", read_value))

    regmodel.irq_status.write(status, 32'h000000FF, UVM_FRONTDOOR);
    if (status != UVM_IS_OK)
      `uvm_fatal("IRQ_FORCE", "IRQ_STATUS clear failed")

    regmodel.irq_status.read(status, read_value, UVM_FRONTDOOR);
    if (status != UVM_IS_OK)
      `uvm_fatal("IRQ_FORCE", "IRQ_STATUS read after clear failed")

    if (read_value == 32'h00000000)
      `uvm_info("IRQ_FORCE", "PASS: IRQ_STATUS cleared", UVM_LOW)
    else
      `uvm_error("IRQ_FORCE",
        $sformatf("FAIL: IRQ_STATUS expected 0x00000000 after clear, read 0x%08h", read_value))

    `uvm_info("IRQ_FORCE", "---- CHECK 3: Reserved bits [31:8] are ignored ----", UVM_LOW)

    write_value = 32'hFFFFFF00;

    `uvm_info("IRQ_FORCE",
      $sformatf("Writing IRQ_FORCE = 0x%08h", write_value),
      UVM_LOW)

    regmodel.irq_force.write(status, write_value, UVM_FRONTDOOR);
    if (status != UVM_IS_OK)
      `uvm_fatal("IRQ_FORCE", "Reserved write failed")

    regmodel.irq_status.read(status, read_value, UVM_FRONTDOOR);
    if (status != UVM_IS_OK)
      `uvm_fatal("IRQ_FORCE", "IRQ_STATUS read after reserved write failed")

    `uvm_info("IRQ_FORCE",
      $sformatf("IRQ_STATUS after reserved write = 0x%08h", read_value),
      UVM_LOW)

    if (read_value == 32'h00000000)
      `uvm_info("IRQ_FORCE", "PASS: reserved bits ignored, no status bit set", UVM_LOW)
    else
      `uvm_error("IRQ_FORCE",
        $sformatf("FAIL: IRQ_STATUS expected 0x00000000, read 0x%08h", read_value))

  endtask

endclass


/////////////////////////////////////////////////////////////////////////////
     
   class err_status_sequence extends uvm_sequence #(uvm_sequence_item);

  `uvm_object_utils(err_status_sequence)

  pkt_reg_block regmodel;

  function new(string name = "err_status_sequence");
    super.new(name);
  endfunction

  task body();
    uvm_status_e status;
    uvm_reg_data_t read_value;

    regmodel.err_inject.write(status, 32'h0000007F, UVM_FRONTDOOR);

    regmodel.err_status.read(status, read_value, UVM_FRONTDOOR);

    if (read_value[6:0] == 7'h7F)
      `uvm_info("ERR_STATUS", "PASS: Error bits [6:0] are set", UVM_LOW)
    else
      `uvm_error("ERR_STATUS", "FAIL: Error bits [6:0] are not set")

    regmodel.err_status.write(status, 32'h0000007F, UVM_FRONTDOOR);

    regmodel.err_status.read(status, read_value, UVM_FRONTDOOR);

    if (read_value[6:0] == 7'h00)
      `uvm_info("ERR_STATUS", "PASS: Error bits [6:0] are cleared", UVM_LOW)
    else
      `uvm_error("ERR_STATUS", "FAIL: Error bits [6:0] are not cleared")

    regmodel.err_inject.write(status, 32'h00000080, UVM_FRONTDOOR);

    regmodel.err_status.read(status, read_value, UVM_FRONTDOOR);

    if (read_value[7] == 1'b1)
      `uvm_info("ERR_STATUS", "PASS: INJECTED bit is set", UVM_LOW)
    else
      `uvm_error("ERR_STATUS", "FAIL: INJECTED bit is not set")

    regmodel.err_status.write(status, 32'h00000080, UVM_FRONTDOOR);

    regmodel.err_status.read(status, read_value, UVM_FRONTDOOR);

    if (read_value[7] == 1'b0)
      `uvm_info("ERR_STATUS", "PASS: INJECTED bit is cleared", UVM_LOW)
    else
      `uvm_error("ERR_STATUS", "FAIL: INJECTED bit is not cleared")

    if (read_value[31:8] == 24'h0)
      `uvm_info("ERR_STATUS", "PASS: Reserved bits are zero", UVM_LOW)
    else
      `uvm_error("ERR_STATUS", "FAIL: Reserved bits are not zero")

  endtask

endclass

/////////////////////////////////////////////////////////////////////////////////////////////////
      
      class err_enable_sequence extends uvm_sequence #(uvm_sequence_item);

  `uvm_object_utils(err_enable_sequence)

  pkt_reg_block regmodel;

  function new(string name = "err_enable_sequence");
    super.new(name);
  endfunction

  task body();
    uvm_status_e   status;
    uvm_reg_data_t lock_value;
    uvm_reg_data_t original_value;
    uvm_reg_data_t write_value;
    uvm_reg_data_t read_value;

    if (regmodel == null)
      `uvm_fatal("ERR_ENABLE", "Register model is not assigned")

    regmodel.lock.write(status, 32'hA5A5C3C3, UVM_FRONTDOOR);
    if (status != UVM_IS_OK)
      `uvm_fatal("ERR_ENABLE", "Unlock write failed")

    regmodel.lock.read(status, lock_value, UVM_FRONTDOOR);
    `uvm_info("ERR_ENABLE",
      $sformatf("LOCK after unlock = 0x%08h (bit0 must be 0)", lock_value),
      UVM_LOW)

    regmodel.err_enable.read(status, original_value, UVM_FRONTDOOR);
    if (status != UVM_IS_OK)
      `uvm_fatal("ERR_ENABLE", "Initial read failed")

    `uvm_info("ERR_ENABLE",
      $sformatf("Original ERR_ENABLE = 0x%08h", original_value),
      UVM_LOW)

    `uvm_info("ERR_ENABLE", "---- CHECK 1: RW bits [7:0], all set then all clear ----", UVM_LOW)

    write_value = 32'h000000FF;

    `uvm_info("ERR_ENABLE",
      $sformatf("Writing ERR_ENABLE = 0x%08h", write_value),
      UVM_LOW)

    regmodel.err_enable.write(status, write_value, UVM_FRONTDOOR);
    if (status != UVM_IS_OK)
      `uvm_fatal("ERR_ENABLE", "Write 0xFF failed")

    regmodel.err_enable.read(status, read_value, UVM_FRONTDOOR);
    if (status != UVM_IS_OK)
      `uvm_fatal("ERR_ENABLE", "Read after write 0xFF failed")

    `uvm_info("ERR_ENABLE",
      $sformatf("ERR_ENABLE after write = 0x%08h", read_value),
      UVM_LOW)

    if (read_value == write_value)
      `uvm_info("ERR_ENABLE", "PASS: all 8 enable bits set", UVM_LOW)
    else
      `uvm_error("ERR_ENABLE",
        $sformatf("FAIL: Written=0x%08h Read=0x%08h", write_value, read_value))

    write_value = 32'h00000000;

    `uvm_info("ERR_ENABLE",
      $sformatf("Writing ERR_ENABLE = 0x%08h", write_value),
      UVM_LOW)

    regmodel.err_enable.write(status, write_value, UVM_FRONTDOOR);
    if (status != UVM_IS_OK)
      `uvm_fatal("ERR_ENABLE", "Write 0x00 failed")

    regmodel.err_enable.read(status, read_value, UVM_FRONTDOOR);
    if (status != UVM_IS_OK)
      `uvm_fatal("ERR_ENABLE", "Read after write 0x00 failed")

    `uvm_info("ERR_ENABLE",
      $sformatf("ERR_ENABLE after write = 0x%08h", read_value),
      UVM_LOW)

    if (read_value == write_value)
      `uvm_info("ERR_ENABLE", "PASS: all 8 enable bits cleared", UVM_LOW)
    else
      `uvm_error("ERR_ENABLE",
        $sformatf("FAIL: Written=0x%08h Read=0x%08h", write_value, read_value))

    `uvm_info("ERR_ENABLE", "---- CHECK 2: Reserved bits [31:8] ----", UVM_LOW)

    write_value = 32'hABCDEF55;

    `uvm_info("ERR_ENABLE",
      $sformatf("Writing ERR_ENABLE = 0x%08h", write_value),
      UVM_LOW)

    regmodel.err_enable.write(status, write_value, UVM_FRONTDOOR);
    if (status != UVM_IS_OK)
      `uvm_fatal("ERR_ENABLE", "Reserved write failed")

    regmodel.err_enable.read(status, read_value, UVM_FRONTDOOR);
    if (status != UVM_IS_OK)
      `uvm_fatal("ERR_ENABLE", "Reserved read after write failed")

    `uvm_info("ERR_ENABLE",
      $sformatf("ERR_ENABLE after write = 0x%08h", read_value),
      UVM_LOW)

    if (read_value[31:8] == 24'h0)
      `uvm_info("ERR_ENABLE", "PASS: reserved bits unchanged, still 0", UVM_LOW)
    else
      `uvm_error("ERR_ENABLE",
        $sformatf("FAIL: reserved bits changed, read[31:8]=0x%06h", read_value[31:8]))

    if (read_value[7:0] == write_value[7:0])
      `uvm_info("ERR_ENABLE", "PASS: enable bits stored correctly", UVM_LOW)
    else
      `uvm_error("ERR_ENABLE",
        $sformatf("FAIL: enable bits expected 0x%02h, read 0x%02h",
                  write_value[7:0], read_value[7:0]))

    regmodel.err_enable.write(status, 32'h00000000, UVM_FRONTDOOR);
    if (status != UVM_IS_OK)
      `uvm_fatal("ERR_ENABLE", "Restore write failed")

  endtask

endclass


//////////////////////////////////////////////////////////////////////////////////////////////
      
      
      class err_inject_sequence extends uvm_sequence #(uvm_sequence_item);

  `uvm_object_utils(err_inject_sequence)

  pkt_reg_block regmodel;

  function new(string name = "err_inject_sequence");
    super.new(name);
  endfunction

  task body();
    uvm_status_e   status;
    uvm_reg_data_t original_value;
    uvm_reg_data_t read_value;

    if (regmodel == null)
      `uvm_fatal("ERR_INJECT", "Register model is not assigned")

    regmodel.err_inject.read(status, original_value, UVM_FRONTDOOR);
    if (status != UVM_IS_OK)
      `uvm_fatal("ERR_INJECT", "Initial read failed")

    `uvm_info("ERR_INJECT",
      $sformatf("Original ERR_INJECT = 0x%08h", original_value),
      UVM_LOW)

    if (original_value == 32'h00000000)
      `uvm_info("ERR_INJECT", "PASS: reset value is 0x00000000", UVM_LOW)
    else
      `uvm_error("ERR_INJECT",
        $sformatf("FAIL: reset value expected 0x00000000, read 0x%08h", original_value))

    `uvm_info("ERR_INJECT", "Writing ERR_INJECT = 0x00000001", UVM_LOW)

    regmodel.err_inject.write(status, 32'h00000001, UVM_FRONTDOOR);
    if (status != UVM_IS_OK)
      `uvm_fatal("ERR_INJECT", "Write 0x1 failed")

    regmodel.err_inject.read(status, read_value, UVM_FRONTDOOR);
    if (status != UVM_IS_OK)
      `uvm_fatal("ERR_INJECT", "Read after write 0x1 failed")

    `uvm_info("ERR_INJECT",
      $sformatf("ERR_INJECT after write = 0x%08h", read_value),
      UVM_LOW)

    if (read_value == 32'h00000000)
      `uvm_info("ERR_INJECT", "PASS: reads 0 after write of 0x00000001", UVM_LOW)
    else
      `uvm_error("ERR_INJECT",
        $sformatf("FAIL: expected 0x00000000, read 0x%08h", read_value))

    `uvm_info("ERR_INJECT", "Writing ERR_INJECT = 0x7FFFFF00", UVM_LOW)

    regmodel.err_inject.write(status, 32'h7FFFFF00, UVM_FRONTDOOR);
    if (status != UVM_IS_OK)
      `uvm_fatal("ERR_INJECT", "Write 0x7FFFFF00 failed")

    regmodel.err_inject.read(status, read_value, UVM_FRONTDOOR);
    if (status != UVM_IS_OK)
      `uvm_fatal("ERR_INJECT", "Read after write 0x7FFFFF00 failed")

    `uvm_info("ERR_INJECT",
      $sformatf("ERR_INJECT after write = 0x%08h", read_value),
      UVM_LOW)

    if (read_value == 32'h00000000)
      `uvm_info("ERR_INJECT", "PASS: reads 0 after write of 0x7FFFFF00", UVM_LOW)
    else
      `uvm_error("ERR_INJECT",
        $sformatf("FAIL: expected 0x00000000, read 0x%08h", read_value))

    `uvm_info("ERR_INJECT", "Writing ERR_INJECT = 0xFFFFFFFF", UVM_LOW)

    regmodel.err_inject.write(status, 32'hFFFFFFFF, UVM_FRONTDOOR);
    if (status != UVM_IS_OK)
      `uvm_fatal("ERR_INJECT", "Write 0xFFFFFFFF failed")

    regmodel.err_inject.read(status, read_value, UVM_FRONTDOOR);
    if (status != UVM_IS_OK)
      `uvm_fatal("ERR_INJECT", "Read after write 0xFFFFFFFF failed")

    `uvm_info("ERR_INJECT",
      $sformatf("ERR_INJECT after write = 0x%08h", read_value),
      UVM_LOW)

    if (read_value == 32'h00000000)
      `uvm_info("ERR_INJECT", "PASS: reads 0 after write of 0xFFFFFFFF", UVM_LOW)
    else
      `uvm_error("ERR_INJECT",
        $sformatf("FAIL: expected 0x00000000, read 0x%08h", read_value))

    regmodel.err_inject.write(status, 32'h80000000, UVM_FRONTDOOR);
    regmodel.err_status.write(status, 32'h000000FF, UVM_FRONTDOOR);

  endtask

endclass



/////////////////////////////////////////////////////////////////////////////////////////////////
      
      
      
      class err_count_sequence extends uvm_sequence #(uvm_sequence_item);

  `uvm_object_utils(err_count_sequence)

  pkt_reg_block regmodel;

  function new(string name = "err_count_sequence");
    super.new(name);
  endfunction

  task body();
    uvm_status_e   status;
    uvm_reg_data_t original_value;
    uvm_reg_data_t write_value;
    uvm_reg_data_t read_value;

    if (regmodel == null)
      `uvm_fatal("ERR_COUNT", "Register model is not assigned")

    regmodel.err_count.read(status, original_value, UVM_FRONTDOOR);
    if (status != UVM_IS_OK)
      `uvm_fatal("ERR_COUNT", "Initial read failed")

    `uvm_info("ERR_COUNT",
      $sformatf("Original ERR_COUNT = 0x%08h", original_value),
      UVM_LOW)

    if (original_value == 32'h00000000)
      `uvm_info("ERR_COUNT", "PASS: reset value is 0x00000000", UVM_LOW)
    else
      `uvm_error("ERR_COUNT",
        $sformatf("FAIL: reset value expected 0x00000000, read 0x%08h", original_value))

    `uvm_info("ERR_COUNT", "---- CHECK 1: write to RO register is ignored (count = 0) ----", UVM_LOW)

    write_value = 32'hFFFFFFFF;

    `uvm_info("ERR_COUNT",
      $sformatf("Writing ERR_COUNT = 0x%08h", write_value),
      UVM_LOW)

    regmodel.err_count.write(status, write_value, UVM_FRONTDOOR);
    if (status != UVM_IS_OK)
      `uvm_fatal("ERR_COUNT", "Write to RO register failed")

    regmodel.err_count.read(status, read_value, UVM_FRONTDOOR);
    if (status != UVM_IS_OK)
      `uvm_fatal("ERR_COUNT", "Read after write failed")

    `uvm_info("ERR_COUNT",
      $sformatf("ERR_COUNT after write = 0x%08h", read_value),
      UVM_LOW)

    if (read_value == original_value)
      `uvm_info("ERR_COUNT", "PASS: ERR_COUNT unchanged after write", UVM_LOW)
    else
      `uvm_error("ERR_COUNT",
        $sformatf("FAIL: Original=0x%08h After write=0x%08h", original_value, read_value))

    `uvm_info("ERR_COUNT", "---- CHECK 2: counter follows hardware, write is still ignored ----", UVM_LOW)

    regmodel.err_inject.write(status, 32'h00000007, UVM_FRONTDOOR);
    if (status != UVM_IS_OK)
      `uvm_fatal("ERR_COUNT", "ERR_INJECT write failed")

    regmodel.err_count.read(status, read_value, UVM_FRONTDOOR);
    if (status != UVM_IS_OK)
      `uvm_fatal("ERR_COUNT", "Read after inject failed")

    `uvm_info("ERR_COUNT",
      $sformatf("After injecting 3 bits, ERR_COUNT = 0x%08h", read_value),
      UVM_LOW)

    if (read_value == 32'h00000003)
      `uvm_info("ERR_COUNT", "PASS: ERR_COUNT is 3", UVM_LOW)
    else
      `uvm_error("ERR_COUNT",
        $sformatf("FAIL: ERR_COUNT expected 0x00000003, read 0x%08h", read_value))

    regmodel.err_count.write(status, 32'hFFFFFFFF, UVM_FRONTDOOR);
    if (status != UVM_IS_OK)
      `uvm_fatal("ERR_COUNT", "Write to RO register with non-zero count failed")

    regmodel.err_count.read(status, read_value, UVM_FRONTDOOR);
    if (status != UVM_IS_OK)
      `uvm_fatal("ERR_COUNT", "Read after second write failed")

    `uvm_info("ERR_COUNT",
      $sformatf("ERR_COUNT after write of 0xFFFFFFFF = 0x%08h", read_value),
      UVM_LOW)

    if (read_value == 32'h00000003)
      `uvm_info("ERR_COUNT", "PASS: ERR_COUNT unchanged, still 3", UVM_LOW)
    else
      `uvm_error("ERR_COUNT",
        $sformatf("FAIL: ERR_COUNT expected 0x00000003, read 0x%08h", read_value))

    `uvm_info("ERR_COUNT", "---- CHECK 3: Reserved bits [31:16] ----", UVM_LOW)

    if (read_value[31:16] == 16'h0000)
      `uvm_info("ERR_COUNT", "PASS: reserved bits read 0", UVM_LOW)
    else
      `uvm_error("ERR_COUNT",
        $sformatf("FAIL: reserved bits changed, read[31:16]=0x%04h", read_value[31:16]))

    regmodel.err_inject.write(status, 32'h80000000, UVM_FRONTDOOR);
    if (status != UVM_IS_OK)
      `uvm_fatal("ERR_COUNT", "clear_count write failed")

    regmodel.err_status.write(status, 32'h000000FF, UVM_FRONTDOOR);
    if (status != UVM_IS_OK)
      `uvm_fatal("ERR_COUNT", "ERR_STATUS clear failed")

    regmodel.err_count.read(status, read_value, UVM_FRONTDOOR);
    if (status != UVM_IS_OK)
      `uvm_fatal("ERR_COUNT", "Final read failed")

    if (read_value == 32'h00000000)
      `uvm_info("ERR_COUNT", "PASS: ERR_COUNT cleared at end of test", UVM_LOW)
    else
      `uvm_error("ERR_COUNT",
        $sformatf("FAIL: expected 0x00000000 at end, read 0x%08h", read_value))

  endtask

endclass

////////////////////////////////////////////////////////////////////////////////////////////////
      
class err_info_sequence extends uvm_sequence #(uvm_sequence_item);

  `uvm_object_utils(err_info_sequence)

  pkt_reg_block regmodel;

  function new(string name = "err_info_sequence");
    super.new(name);
  endfunction

  task body();
    uvm_status_e   status;
    uvm_reg_data_t original_value;
    uvm_reg_data_t write_value;
    uvm_reg_data_t read_value;

    if (regmodel == null)
      `uvm_fatal("ERR_INFO", "Register model is not assigned")

    regmodel.err_info.read(status, original_value, UVM_FRONTDOOR);
    if (status != UVM_IS_OK)
      `uvm_fatal("ERR_INFO", "Initial read failed")

    `uvm_info("ERR_INFO",
      $sformatf("Original ERR_INFO = 0x%08h", original_value),
      UVM_LOW)

    if (original_value == 32'h00000000)
      `uvm_info("ERR_INFO", "PASS: reset value is 0x00000000", UVM_LOW)
    else
      `uvm_error("ERR_INFO",
        $sformatf("FAIL: reset value expected 0x00000000, read 0x%08h", original_value))

    write_value = 32'hFFFFFFFF;

    `uvm_info("ERR_INFO",
      $sformatf("Writing ERR_INFO = 0x%08h", write_value),
      UVM_LOW)

    regmodel.err_info.write(status, write_value, UVM_FRONTDOOR);
    if (status != UVM_IS_OK)
      `uvm_fatal("ERR_INFO", "Write failed")

    regmodel.err_info.read(status, read_value, UVM_FRONTDOOR);
    if (status != UVM_IS_OK)
      `uvm_fatal("ERR_INFO", "Read after write failed")

    `uvm_info("ERR_INFO",
      $sformatf("ERR_INFO after write = 0x%08h", read_value),
      UVM_LOW)

    if (read_value == original_value)
      `uvm_info("ERR_INFO", "PASS: ERR_INFO unchanged after write of 0xFFFFFFFF", UVM_LOW)
    else
      `uvm_error("ERR_INFO",
        $sformatf("FAIL: Original=0x%08h After write=0x%08h", original_value, read_value))

    write_value = 32'hA5A5A5A5;

    `uvm_info("ERR_INFO",
      $sformatf("Writing ERR_INFO = 0x%08h", write_value),
      UVM_LOW)

    regmodel.err_info.write(status, write_value, UVM_FRONTDOOR);
    if (status != UVM_IS_OK)
      `uvm_fatal("ERR_INFO", "Second write failed")

    regmodel.err_info.read(status, read_value, UVM_FRONTDOOR);
    if (status != UVM_IS_OK)
      `uvm_fatal("ERR_INFO", "Read after second write failed")

    `uvm_info("ERR_INFO",
      $sformatf("ERR_INFO after write = 0x%08h", read_value),
      UVM_LOW)

    if (read_value == original_value)
      `uvm_info("ERR_INFO", "PASS: ERR_INFO unchanged after write of 0xA5A5A5A5", UVM_LOW)
    else
      `uvm_error("ERR_INFO",
        $sformatf("FAIL: Original=0x%08h After write=0x%08h", original_value, read_value))

    if (read_value[19:18] == 2'b00)
      `uvm_info("ERR_INFO", "PASS: reserved bits [19:18] read 0", UVM_LOW)
    else
      `uvm_error("ERR_INFO",
        $sformatf("FAIL: reserved bits changed, read[19:18]=0x%h", read_value[19:18]))

  endtask

endclass

//////////////////////////////////////////////////////////////////////////////////////////////
      
      
      class lock_sequence extends uvm_sequence #(uvm_sequence_item);

  `uvm_object_utils(lock_sequence)

  pkt_reg_block regmodel;

  function new(string name = "lock_sequence");
    super.new(name);
  endfunction

  task body();
    uvm_status_e   status;
    uvm_reg_data_t original_value;
    uvm_reg_data_t write_value;
    uvm_reg_data_t read_value;

    if (regmodel == null)
      `uvm_fatal("LOCK", "Register model is not assigned")

    regmodel.lock.read(status, original_value, UVM_FRONTDOOR);
    if (status != UVM_IS_OK)
      `uvm_fatal("LOCK", "Initial read failed")

    `uvm_info("LOCK",
      $sformatf("Original LOCK = 0x%08h", original_value),
      UVM_LOW)

    if (original_value == 32'h00000001)
      `uvm_info("LOCK", "PASS: reset value is 0x00000001 (locked)", UVM_LOW)
    else
      `uvm_error("LOCK",
        $sformatf("FAIL: reset value expected 0x00000001, read 0x%08h", original_value))

    `uvm_info("LOCK", "---- CHECK 1: wrong key keeps the block locked ----", UVM_LOW)

    write_value = 32'h12345678;

    `uvm_info("LOCK",
      $sformatf("Writing LOCK = 0x%08h", write_value),
      UVM_LOW)

    regmodel.lock.write(status, write_value, UVM_FRONTDOOR);
    if (status != UVM_IS_OK)
      `uvm_fatal("LOCK", "Wrong key write failed")

    regmodel.lock.read(status, read_value, UVM_FRONTDOOR);
    if (status != UVM_IS_OK)
      `uvm_fatal("LOCK", "Read after wrong key failed")

    `uvm_info("LOCK",
      $sformatf("LOCK after wrong key = 0x%08h", read_value),
      UVM_LOW)

    if (read_value == 32'h00000001)
      `uvm_info("LOCK", "PASS: still locked after wrong key", UVM_LOW)
    else
      `uvm_error("LOCK",
        $sformatf("FAIL: expected 0x00000001, read 0x%08h", read_value))

    `uvm_info("LOCK", "---- CHECK 2: correct key unlocks, key is never read back ----", UVM_LOW)

    write_value = 32'hA5A5C3C3;

    `uvm_info("LOCK",
      $sformatf("Writing LOCK = 0x%08h", write_value),
      UVM_LOW)

    regmodel.lock.write(status, write_value, UVM_FRONTDOOR);
    if (status != UVM_IS_OK)
      `uvm_fatal("LOCK", "Key write failed")

    regmodel.lock.read(status, read_value, UVM_FRONTDOOR);
    if (status != UVM_IS_OK)
      `uvm_fatal("LOCK", "Read after key write failed")

    `uvm_info("LOCK",
      $sformatf("LOCK after correct key = 0x%08h", read_value),
      UVM_LOW)

    if (read_value[0] == 1'b0)
      `uvm_info("LOCK", "PASS: unlocked (LOCKED = 0)", UVM_LOW)
    else
      `uvm_error("LOCK", "FAIL: LOCKED did not clear after correct key")

    if (read_value[31:1] == 31'h0)
      `uvm_info("LOCK", "PASS: key bits [31:1] read 0", UVM_LOW)
    else
      `uvm_error("LOCK",
        $sformatf("FAIL: key bits returned, read[31:1]=0x%08h", read_value[31:1]))

    `uvm_info("LOCK", "---- CHECK 3: key must match all 32 bits, a near miss locks again ----", UVM_LOW)

    write_value = 32'hA5A5C3C2;

    `uvm_info("LOCK",
      $sformatf("Writing LOCK = 0x%08h", write_value),
      UVM_LOW)

    regmodel.lock.write(status, write_value, UVM_FRONTDOOR);
    if (status != UVM_IS_OK)
      `uvm_fatal("LOCK", "Near miss write failed")

    regmodel.lock.read(status, read_value, UVM_FRONTDOOR);
    if (status != UVM_IS_OK)
      `uvm_fatal("LOCK", "Read after near miss failed")

    `uvm_info("LOCK",
      $sformatf("LOCK after near-miss key = 0x%08h", read_value),
      UVM_LOW)

    if (read_value == 32'h00000001)
      `uvm_info("LOCK", "PASS: locked again after near-miss key", UVM_LOW)
    else
      `uvm_error("LOCK",
        $sformatf("FAIL: expected 0x00000001, read 0x%08h", read_value))

    `uvm_info("LOCK", "---- CHECK 4: any non-key write locks an unlocked block ----", UVM_LOW)

    regmodel.lock.write(status, 32'hA5A5C3C3, UVM_FRONTDOOR);
    if (status != UVM_IS_OK)
      `uvm_fatal("LOCK", "Unlock write failed")

    regmodel.lock.write(status, 32'h00000000, UVM_FRONTDOOR);
    if (status != UVM_IS_OK)
      `uvm_fatal("LOCK", "Write 0 failed")

    regmodel.lock.read(status, read_value, UVM_FRONTDOOR);
    if (status != UVM_IS_OK)
      `uvm_fatal("LOCK", "Read after write 0 failed")

    `uvm_info("LOCK",
      $sformatf("LOCK after unlock then write of 0 = 0x%08h", read_value),
      UVM_LOW)

    if (read_value == 32'h00000001)
      `uvm_info("LOCK", "PASS: write of 0 locked the block", UVM_LOW)
    else
      `uvm_error("LOCK",
        $sformatf("FAIL: expected 0x00000001, read 0x%08h", read_value))

  endtask

endclass


//////////////////////////////////////////////////////////////////////////////////////////////
      
    class soft_reset_sequence extends uvm_sequence #(uvm_sequence_item);

  `uvm_object_utils(soft_reset_sequence)

  pkt_reg_block regmodel;

  function new(string name = "soft_reset_sequence");
    super.new(name);
  endfunction

  task body();
    uvm_status_e   status;
    uvm_reg_data_t value;

    if (regmodel == null)
      `uvm_fatal("SOFT_RESET", "Register model is not assigned")

    regmodel.lock.write(status, 32'hA5A5C3C3, UVM_FRONTDOOR);
    regmodel.port_enable.write(status, 32'h00000005, UVM_FRONTDOOR);
    regmodel.port_enable.read(status, value, UVM_FRONTDOOR);

    `uvm_info("SOFT_RESET",
      $sformatf("PORT_ENABLE before soft reset = 0x%08h", value),
      UVM_LOW)

    regmodel.soft_reset.write(status, 32'h00000001, UVM_FRONTDOOR);

    regmodel.port_enable.read(status, value, UVM_FRONTDOOR);
    if (value == 32'h0000000F)
      `uvm_info("SOFT_RESET", "PASS: PORT_ENABLE back to reset value 0x0000000F", UVM_LOW)
    else
      `uvm_error("SOFT_RESET",
        $sformatf("FAIL: PORT_ENABLE expected 0x0000000F, read 0x%08h", value))

    regmodel.lock.read(status, value, UVM_FRONTDOOR);
    if (value == 32'h00000001)
      `uvm_info("SOFT_RESET", "PASS: LOCK back to 1 (locked)", UVM_LOW)
    else
      `uvm_error("SOFT_RESET",
        $sformatf("FAIL: LOCK expected 0x00000001, read 0x%08h", value))

  endtask

endclass

/////////////////////////////////////////////////////////////////////////////////////////////////
      
      
      class reset_values_sequence extends uvm_sequence #(uvm_sequence_item);

  `uvm_object_utils(reset_values_sequence)

  pkt_reg_block regmodel;

  function new(string name = "reset_values_sequence");
    super.new(name);
  endfunction

  task body();
    uvm_status_e   status;
    uvm_reg_data_t value;

    if (regmodel == null)
      `uvm_fatal("RESET_VAL", "Register model is not assigned")

    regmodel.device_id.read(status, value, UVM_FRONTDOOR);
    if (value == 32'h02A55357)
      `uvm_info("RESET_VAL", $sformatf("PASS: DEVICE_ID = 0x%08h", value), UVM_LOW)
    else
      `uvm_error("RESET_VAL", $sformatf("FAIL: DEVICE_ID expected 0x02A55357, read 0x%08h", value))

    regmodel.version.read(status, value, UVM_FRONTDOOR);
    if (value == 32'h00010200)
      `uvm_info("RESET_VAL", $sformatf("PASS: VERSION = 0x%08h", value), UVM_LOW)
    else
      `uvm_error("RESET_VAL", $sformatf("FAIL: VERSION expected 0x00010200, read 0x%08h", value))

    regmodel.switch_status.read(status, value, UVM_FRONTDOOR);
    if (value == 32'h000000F9)
      `uvm_info("RESET_VAL", $sformatf("PASS: SWITCH_STATUS = 0x%08h", value), UVM_LOW)
    else
      `uvm_error("RESET_VAL", $sformatf("FAIL: SWITCH_STATUS expected 0x000000F9, read 0x%08h", value))

    regmodel.port_status.read(status, value, UVM_FRONTDOOR);
    if (value == 32'h00000000)
      `uvm_info("RESET_VAL", $sformatf("PASS: PORT_STATUS = 0x%08h", value), UVM_LOW)
    else
      `uvm_error("RESET_VAL", $sformatf("FAIL: PORT_STATUS expected 0x00000000, read 0x%08h", value))

    regmodel.gen_status.read(status, value, UVM_FRONTDOOR);
    if (value == 32'h00000000)
      `uvm_info("RESET_VAL", $sformatf("PASS: GEN_STATUS = 0x%08h", value), UVM_LOW)
    else
      `uvm_error("RESET_VAL", $sformatf("FAIL: GEN_STATUS expected 0x00000000, read 0x%08h", value))

    regmodel.stat_rx.read(status, value, UVM_FRONTDOOR);
    if (value == 32'h00000000)
      `uvm_info("RESET_VAL", $sformatf("PASS: STAT_RX = 0x%08h", value), UVM_LOW)
    else
      `uvm_error("RESET_VAL", $sformatf("FAIL: STAT_RX expected 0x00000000, read 0x%08h", value))

    regmodel.stat_tx.read(status, value, UVM_FRONTDOOR);
    if (value == 32'h00000000)
      `uvm_info("RESET_VAL", $sformatf("PASS: STAT_TX = 0x%08h", value), UVM_LOW)
    else
      `uvm_error("RESET_VAL", $sformatf("FAIL: STAT_TX expected 0x00000000, read 0x%08h", value))

    regmodel.stat_drop.read(status, value, UVM_FRONTDOOR);
    if (value == 32'h00000000)
      `uvm_info("RESET_VAL", $sformatf("PASS: STAT_DROP = 0x%08h", value), UVM_LOW)
    else
      `uvm_error("RESET_VAL", $sformatf("FAIL: STAT_DROP expected 0x00000000, read 0x%08h", value))

    regmodel.switch_ctrl.read(status, value, UVM_FRONTDOOR);
    if (value == 32'h00000000)
      `uvm_info("RESET_VAL", $sformatf("PASS: SWITCH_CTRL = 0x%08h", value), UVM_LOW)
    else
      `uvm_error("RESET_VAL", $sformatf("FAIL: SWITCH_CTRL expected 0x00000000, read 0x%08h", value))

    regmodel.port_enable.read(status, value, UVM_FRONTDOOR);
    if (value == 32'h0000000F)
      `uvm_info("RESET_VAL", $sformatf("PASS: PORT_ENABLE = 0x%08h", value), UVM_LOW)
    else
      `uvm_error("RESET_VAL", $sformatf("FAIL: PORT_ENABLE expected 0x0000000F, read 0x%08h", value))

    regmodel.fwd_enable.read(status, value, UVM_FRONTDOOR);
    if (value == 32'h0000000F)
      `uvm_info("RESET_VAL", $sformatf("PASS: FWD_ENABLE = 0x%08h", value), UVM_LOW)
    else
      `uvm_error("RESET_VAL", $sformatf("FAIL: FWD_ENABLE expected 0x0000000F, read 0x%08h", value))

    regmodel.gen_ctrl.read(status, value, UVM_FRONTDOOR);
    if (value == 32'h00000000)
      `uvm_info("RESET_VAL", $sformatf("PASS: GEN_CTRL = 0x%08h", value), UVM_LOW)
    else
      `uvm_error("RESET_VAL", $sformatf("FAIL: GEN_CTRL expected 0x00000000, read 0x%08h", value))

    regmodel.gen_pkt_cfg.read(status, value, UVM_FRONTDOOR);
    if (value == 32'h00000401)
      `uvm_info("RESET_VAL", $sformatf("PASS: GEN_PKT_CFG = 0x%08h", value), UVM_LOW)
    else
      `uvm_error("RESET_VAL", $sformatf("FAIL: GEN_PKT_CFG expected 0x00000401, read 0x%08h", value))

    regmodel.gen_interval.read(status, value, UVM_FRONTDOOR);
    if (value == 32'h00000002)
      `uvm_info("RESET_VAL", $sformatf("PASS: GEN_INTERVAL = 0x%08h", value), UVM_LOW)
    else
      `uvm_error("RESET_VAL", $sformatf("FAIL: GEN_INTERVAL expected 0x00000002, read 0x%08h", value))

    regmodel.gen_count.read(status, value, UVM_FRONTDOOR);
    if (value == 32'h00000004)
      `uvm_info("RESET_VAL", $sformatf("PASS: GEN_COUNT = 0x%08h", value), UVM_LOW)
    else
      `uvm_error("RESET_VAL", $sformatf("FAIL: GEN_COUNT expected 0x00000004, read 0x%08h", value))

    regmodel.irq_status.read(status, value, UVM_FRONTDOOR);
    if (value == 32'h00000000)
      `uvm_info("RESET_VAL", $sformatf("PASS: IRQ_STATUS = 0x%08h", value), UVM_LOW)
    else
      `uvm_error("RESET_VAL", $sformatf("FAIL: IRQ_STATUS expected 0x00000000, read 0x%08h", value))

    regmodel.irq_enable.read(status, value, UVM_FRONTDOOR);
    if (value == 32'h00000000)
      `uvm_info("RESET_VAL", $sformatf("PASS: IRQ_ENABLE = 0x%08h", value), UVM_LOW)
    else
      `uvm_error("RESET_VAL", $sformatf("FAIL: IRQ_ENABLE expected 0x00000000, read 0x%08h", value))

    regmodel.irq_force.read(status, value, UVM_FRONTDOOR);
    if (value == 32'h00000000)
      `uvm_info("RESET_VAL", $sformatf("PASS: IRQ_FORCE = 0x%08h", value), UVM_LOW)
    else
      `uvm_error("RESET_VAL", $sformatf("FAIL: IRQ_FORCE expected 0x00000000, read 0x%08h", value))

    regmodel.err_status.read(status, value, UVM_FRONTDOOR);
    if (value == 32'h00000000)
      `uvm_info("RESET_VAL", $sformatf("PASS: ERR_STATUS = 0x%08h", value), UVM_LOW)
    else
      `uvm_error("RESET_VAL", $sformatf("FAIL: ERR_STATUS expected 0x00000000, read 0x%08h", value))

    regmodel.err_enable.read(status, value, UVM_FRONTDOOR);
    if (value == 32'h00000000)
      `uvm_info("RESET_VAL", $sformatf("PASS: ERR_ENABLE = 0x%08h", value), UVM_LOW)
    else
      `uvm_error("RESET_VAL", $sformatf("FAIL: ERR_ENABLE expected 0x00000000, read 0x%08h", value))

    regmodel.err_inject.read(status, value, UVM_FRONTDOOR);
    if (value == 32'h00000000)
      `uvm_info("RESET_VAL", $sformatf("PASS: ERR_INJECT = 0x%08h", value), UVM_LOW)
    else
      `uvm_error("RESET_VAL", $sformatf("FAIL: ERR_INJECT expected 0x00000000, read 0x%08h", value))

    regmodel.err_count.read(status, value, UVM_FRONTDOOR);
    if (value == 32'h00000000)
      `uvm_info("RESET_VAL", $sformatf("PASS: ERR_COUNT = 0x%08h", value), UVM_LOW)
    else
      `uvm_error("RESET_VAL", $sformatf("FAIL: ERR_COUNT expected 0x00000000, read 0x%08h", value))

    regmodel.err_info.read(status, value, UVM_FRONTDOOR);
    if (value == 32'h00000000)
      `uvm_info("RESET_VAL", $sformatf("PASS: ERR_INFO = 0x%08h", value), UVM_LOW)
    else
      `uvm_error("RESET_VAL", $sformatf("FAIL: ERR_INFO expected 0x00000000, read 0x%08h", value))

    regmodel.lock.read(status, value, UVM_FRONTDOOR);
    if (value == 32'h00000001)
      `uvm_info("RESET_VAL", $sformatf("PASS: LOCK = 0x%08h", value), UVM_LOW)
    else
      `uvm_error("RESET_VAL", $sformatf("FAIL: LOCK expected 0x00000001, read 0x%08h", value))

    regmodel.soft_reset.read(status, value, UVM_FRONTDOOR);
    if (value == 32'h00000000)
      `uvm_info("RESET_VAL", $sformatf("PASS: SOFT_RESET = 0x%08h", value), UVM_LOW)
    else
      `uvm_error("RESET_VAL", $sformatf("FAIL: SOFT_RESET expected 0x00000000, read 0x%08h", value))

  endtask

endclass

///////////////////////////////////////////////////////////////////////////////////////////////////////
      
      
class generate_four_packets_sequence extends uvm_sequence #(uvm_sequence_item);

  `uvm_object_utils(generate_four_packets_sequence)

  pkt_reg_block regmodel;

  function new(string name = "generate_four_packets_sequence");
    super.new(name);
  endfunction

  task body();
    uvm_status_e status;
    uvm_reg_data_t read_value;
    int i;

    regmodel.lock.write(status, 32'hA5A5C3C3, UVM_FRONTDOOR);

    regmodel.port_enable.write(status, 32'h0000000F, UVM_FRONTDOOR);
    regmodel.fwd_enable.write(status, 32'h0000000F, UVM_FRONTDOOR);
    regmodel.switch_ctrl.write(status, 32'h00000009, UVM_FRONTDOOR);
    regmodel.gen_pkt_cfg.write(status, 32'h00100401, UVM_FRONTDOOR);
    regmodel.gen_interval.write(status, 32'h00000002, UVM_FRONTDOOR);
    regmodel.gen_count.write(status, 32'h00000004, UVM_FRONTDOOR);
    regmodel.irq_enable.write(status, 32'h00000041, UVM_FRONTDOOR);

    regmodel.gen_ctrl.write(status, 32'h00000003, UVM_FRONTDOOR);

//     i = 0;
//     do begin
//       regmodel.gen_status.read(status, read_value, UVM_FRONTDOOR);
//       i++;
//     end while (read_value[1] != 1'b1 && i < 100);

    if (read_value[1] != 1'b1)
      `uvm_error("PKT_TEST", "Packet generation timeout")

    regmodel.stat_rx.read(status, read_value, UVM_FRONTDOOR);
    if (read_value[15:0] == 4)
      `uvm_info("PKT_TEST", "PASS: STAT_RX = 4", UVM_LOW)
    else
      `uvm_error("PKT_TEST", "FAIL: STAT_RX is not 4")

    regmodel.stat_tx.read(status, read_value, UVM_FRONTDOOR);
    if (read_value[15:0] == 4)
      `uvm_info("PKT_TEST", "PASS: STAT_TX = 4", UVM_LOW)
    else
      `uvm_error("PKT_TEST", "FAIL: STAT_TX is not 4")

    regmodel.stat_drop.read(status, read_value, UVM_FRONTDOOR);
    if (read_value[15:0] == 0)
      `uvm_info("PKT_TEST", "PASS: STAT_DROP = 0", UVM_LOW)
    else
      `uvm_error("PKT_TEST", "FAIL: STAT_DROP is not 0")

    regmodel.gen_status.read(status, read_value, UVM_FRONTDOOR);
    if (read_value[1] == 1'b1)
      `uvm_info("PKT_TEST", "PASS: GEN_STATUS.DONE = 1", UVM_LOW)
    else
      `uvm_error("PKT_TEST", "FAIL: GEN_STATUS.DONE is not 1")

    regmodel.irq_status.read(status, read_value, UVM_FRONTDOOR);
    if (read_value[0] == 1'b1)
      `uvm_info("PKT_TEST", "PASS: IRQ_STATUS.GEN_DONE = 1", UVM_LOW)
    else
      `uvm_error("PKT_TEST", "FAIL: IRQ_STATUS.GEN_DONE is not 1")

  endtask

endclass

      ////////////////////////////////////////////////////////////////////////////////////////////////
      
      class clear_sticky_status_sequence extends uvm_sequence #(uvm_sequence_item);

  `uvm_object_utils(clear_sticky_status_sequence)

  pkt_reg_block regmodel;

  function new(string name = "clear_sticky_status_sequence");
    super.new(name);
  endfunction

  task body();
    uvm_status_e status;
    uvm_reg_data_t read_value;

    regmodel.irq_status.write(status, 32'h00000041, UVM_FRONTDOOR);

    regmodel.irq_status.read(status, read_value, UVM_FRONTDOOR);

    if ((read_value & 32'h00000041) == 0)
      `uvm_info("IRQ_CLEAR", "PASS: GEN_DONE and START_ACK cleared", UVM_LOW)
    else
      `uvm_error("IRQ_CLEAR", "FAIL: IRQ status bits not cleared")

    regmodel.irq_status.write(status, 32'h000000FF, UVM_FRONTDOOR);

    regmodel.irq_status.read(status, read_value, UVM_FRONTDOOR);

    if ((read_value & 32'h000000FF) == 0)
      `uvm_info("IRQ_CLEAR", "PASS: All implemented IRQ bits cleared", UVM_LOW)
    else
      `uvm_error("IRQ_CLEAR", "FAIL: IRQ bits not cleared")

    regmodel.err_status.write(status, 32'h00000002, UVM_FRONTDOOR);

    regmodel.err_status.read(status, read_value, UVM_FRONTDOOR);

    if ((read_value & 32'h00000002) == 0)
      `uvm_info("IRQ_CLEAR", "PASS: DEST_ERROR cleared", UVM_LOW)
    else
      `uvm_error("IRQ_CLEAR", "FAIL: DEST_ERROR not cleared")

  endtask

endclass
      
      ////////////////////////////////////////////////////////////////////////////////////////
      
class destination_drop_sequence extends uvm_sequence #(uvm_sequence_item);

  `uvm_object_utils(destination_drop_sequence)

  pkt_reg_block regmodel;

  function new(string name = "destination_drop_sequence");
    super.new(name);
  endfunction

  task body();
    uvm_status_e status;
    uvm_reg_data_t read_value;

    regmodel.lock.write(status, 32'hA5A5C3C3, UVM_FRONTDOOR);

    regmodel.switch_ctrl.write(status, 32'h00000001, UVM_FRONTDOOR);
    regmodel.fwd_enable.write(status, 32'h00000001, UVM_FRONTDOOR);
    regmodel.gen_pkt_cfg.write(status, 32'h00000401, UVM_FRONTDOOR);
    regmodel.gen_interval.write(status, 32'h00000002, UVM_FRONTDOOR);
    regmodel.gen_count.write(status, 32'h00000001, UVM_FRONTDOOR);

    regmodel.gen_ctrl.write(status, 32'h00000003, UVM_FRONTDOOR);

//     read_value = 0;
//     do begin
//       regmodel.gen_status.read(status, read_value, UVM_FRONTDOOR);
//     end while (read_value[1] != 1'b1);

    regmodel.err_status.read(status, read_value, UVM_FRONTDOOR);

    if (read_value[1] == 1'b1)
      `uvm_info("DEST_DROP", "PASS: ERR_STATUS.DEST_ERROR is set", UVM_LOW)
    else
      `uvm_error("DEST_DROP", "FAIL: DEST_ERROR is not set")

    regmodel.stat_drop.read(status, read_value, UVM_FRONTDOOR);

    if (read_value[15:0] == 1)
      `uvm_info("DEST_DROP", "PASS: STAT_DROP = 1", UVM_LOW)
    else
      `uvm_error("DEST_DROP", "FAIL: STAT_DROP is not 1")

    regmodel.irq_status.read(status, read_value, UVM_FRONTDOOR);

    if (read_value[3] == 1'b1)
      `uvm_info("DEST_DROP", "PASS: IRQ_STATUS.PACKET_DROPPED is set", UVM_LOW)
    else
      `uvm_error("DEST_DROP", "FAIL: PACKET_DROPPED is not set")

  endtask

endclass

      
      ///////////////////////////////////////////////////////////////////////////////////////////////////
