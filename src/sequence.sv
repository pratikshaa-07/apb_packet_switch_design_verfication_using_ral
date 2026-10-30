class pkt_base_sequence extends uvm_sequence #(uvm_sequence_item);
  `uvm_object_utils(pkt_base_sequence)

  pkt_reg_block regmodel;
  uvm_status_e status;
  uvm_reg_data_t read_value;

  function new(string name = "pkt_base_sequence");
    super.new(name);
  endfunction

  task unlock_config();
    regmodel.lock.write(status, 32'hA5A5C3C3, UVM_FRONTDOOR);
    regmodel.lock.read(status, read_value, UVM_FRONTDOOR);
    if (read_value[0] != 1'b0)
      `uvm_fatal("BASE_SEQ", "Configuration did not unlock")
    `uvm_info("BASE_SEQ", "Configuration unlocked successfully", UVM_LOW)
  endtask

  task check_readback(
    uvm_reg rg,
    uvm_reg_data_t expected_value,
    uvm_reg_data_t mask,
    string name
  );
    rg.read(status, read_value, UVM_FRONTDOOR);
    if ((read_value & mask) == (expected_value & mask))
      `uvm_info("BASE_SEQ",$sformatf("PASS: %s expected=0x%08h read=0x%08h",name, expected_value, read_value), UVM_LOW)
    else
      `uvm_error("BASE_SEQ",$sformatf("FAIL: %s expected=0x%08h read=0x%08h mask=0x%08h",name, expected_value, read_value, mask))
  endtask

endclass
   
class device_id_ro_test extends pkt_base_sequence;
  `uvm_object_utils(device_id_ro_test)

  function new(string name = "device_id_ro_test");
    super.new(name);
  endfunction

  task body();
    uvm_reg_data_t original_value;
    uvm_reg_data_t after_write_value;
    uvm_reg_data_t write_value;

    if (regmodel == null) `uvm_fatal("DEVICE_ID_RO", "Register model is not assigned")

    regmodel.device_id.read(status, original_value, UVM_FRONTDOOR);
    if (status != UVM_IS_OK) `uvm_fatal("DEVICE_ID_RO", "Initial read failed")

    write_value = ~original_value;
    regmodel.device_id.write(status, write_value, UVM_FRONTDOOR);
    if (status != UVM_IS_OK) `uvm_fatal("DEVICE_ID_RO", "Write operation failed")

    regmodel.device_id.read(status, after_write_value, UVM_FRONTDOOR);
    if (status != UVM_IS_OK) `uvm_fatal("DEVICE_ID_RO", "Read after write failed")

    if (original_value == after_write_value) `uvm_info("DEVICE_ID_RO", "PASS: DEVICE_ID remained unchanged after write", UVM_LOW)
    else `uvm_error("DEVICE_ID_RO", $sformatf("FAIL: Before=0x%08h After=0x%08h", original_value, after_write_value))
  endtask
endclass
      
class version_ro_sequence extends pkt_base_sequence;
  `uvm_object_utils(version_ro_sequence)

  function new(string name = "version_ro_sequence");
    super.new(name);
  endfunction

  task body();
    uvm_reg_data_t original_value;
    uvm_reg_data_t after_write_value;
    uvm_reg_data_t write_value;

    if (regmodel == null) `uvm_fatal("VERSION_RO", "Register model is not assigned")

    regmodel.version.read(status, original_value, UVM_FRONTDOOR);
    if (status != UVM_IS_OK) `uvm_fatal("VERSION_RO", "Initial read failed")

    write_value = ~original_value;
    regmodel.version.write(status, write_value, UVM_FRONTDOOR);
    if (status != UVM_IS_OK) `uvm_fatal("VERSION_RO", "Write operation failed")

    regmodel.version.read(status, after_write_value, UVM_FRONTDOOR);
    if (status != UVM_IS_OK) `uvm_fatal("VERSION_RO", "Read after write failed")

    if (original_value == after_write_value) `uvm_info("VERSION_RO", "PASS: VERSION remained unchanged after write", UVM_LOW)
    else `uvm_error("VERSION_RO", $sformatf("FAIL: Original=0x%08h After=0x%08h", original_value, after_write_value))
  endtask
endclass
      
class switch_status_ro_sequence extends pkt_base_sequence;
  `uvm_object_utils(switch_status_ro_sequence)

  uvm_reg_data_t original_value;

  function new(string name = "switch_status_ro_sequence");
    super.new(name);
  endfunction

  task body();
    if (regmodel == null) `uvm_fatal("SWITCH_STATUS_RO", "Register model is not assigned")

    regmodel.switch_status.read(status, original_value, UVM_FRONTDOOR);
    if (status != UVM_IS_OK) `uvm_fatal("SWITCH_STATUS_RO", "Initial read failed")

    regmodel.switch_status.write(status, ~original_value, UVM_FRONTDOOR);
    if (status != UVM_IS_OK) `uvm_fatal("SWITCH_STATUS_RO", "Write access failed")

    regmodel.switch_status.read(status, read_value, UVM_FRONTDOOR);
    if (status != UVM_IS_OK) `uvm_fatal("SWITCH_STATUS_RO", "Readback failed")

    if (read_value == original_value)
      `uvm_info("SWITCH_STATUS_RO", $sformatf("PASS: SWITCH_STATUS is read-only, value=0x%08h", read_value), UVM_LOW)
    else
      `uvm_error("SWITCH_STATUS_RO", $sformatf("FAIL: SWITCH_STATUS changed, expected=0x%08h actual=0x%08h", original_value, read_value))
  endtask
endclass
      
class port_status_ro_sequence extends pkt_base_sequence;
  `uvm_object_utils(port_status_ro_sequence)

  uvm_reg_data_t original_value;

  function new(string name = "port_status_ro_sequence");
    super.new(name);
  endfunction

  task body();
    if (regmodel == null) `uvm_fatal("PORT_STATUS_RO", "Register model is not assigned")

    regmodel.port_status.read(status, original_value, UVM_FRONTDOOR);
    if (status != UVM_IS_OK) `uvm_fatal("PORT_STATUS_RO", "Initial read failed")

    regmodel.port_status.write(status, ~original_value, UVM_FRONTDOOR);
    if (status != UVM_IS_OK) `uvm_fatal("PORT_STATUS_RO", "Write access failed")

    regmodel.port_status.read(status, read_value, UVM_FRONTDOOR);
    if (status != UVM_IS_OK) `uvm_fatal("PORT_STATUS_RO", "Readback failed")

    if (read_value == original_value)
      `uvm_info("PORT_STATUS_RO", $sformatf("PASS: PORT_STATUS is read-only, value=0x%08h", read_value), UVM_LOW)
    else
      `uvm_error("PORT_STATUS_RO", $sformatf("FAIL: PORT_STATUS changed, expected=0x%08h actual=0x%08h", original_value, read_value))
  endtask
endclass
      
      
class gen_status_ro_sequence extends pkt_base_sequence;
  `uvm_object_utils(gen_status_ro_sequence)

  uvm_reg_data_t original_value;
  uvm_reg_data_t write_value;

  function new(string name = "gen_status_ro_sequence");
    super.new(name);
  endfunction

  task body();
    if (regmodel == null) `uvm_fatal("GEN_STATUS_RO", "Register model is not assigned")

    regmodel.gen_status.read(status, original_value, UVM_FRONTDOOR);
    if (status != UVM_IS_OK) `uvm_fatal("GEN_STATUS_RO", "Initial read failed")

    `uvm_info("GEN_STATUS_RO", $sformatf("Original GEN_STATUS = 0x%08h", original_value), UVM_LOW)

    write_value = ~original_value;
    regmodel.gen_status.write(status, write_value, UVM_FRONTDOOR);
    if (status != UVM_IS_OK) `uvm_fatal("GEN_STATUS_RO", "Write operation failed")

    regmodel.gen_status.read(status, read_value, UVM_FRONTDOOR);
    if (status != UVM_IS_OK) `uvm_fatal("GEN_STATUS_RO", "Read after write failed")

    if (original_value == read_value)
      `uvm_info("GEN_STATUS_RO", "PASS: GEN_STATUS remained unchanged after write", UVM_LOW)
    else
      `uvm_error("GEN_STATUS_RO", $sformatf("FAIL: Original=0x%08h, After write=0x%08h", original_value, read_value))
  endtask
endclass
      
 class stat_rx_ro_sequence extends pkt_base_sequence;
  `uvm_object_utils(stat_rx_ro_sequence)

  uvm_reg_data_t original_value;
  uvm_reg_data_t write_value;

  function new(string name = "stat_rx_ro_sequence");
    super.new(name);
  endfunction

  task body();
    if (regmodel == null) `uvm_fatal("STAT_RX_RO", "Register model is not assigned")

    regmodel.stat_rx.read(status, original_value, UVM_FRONTDOOR);
    if (status != UVM_IS_OK) `uvm_fatal("STAT_RX_RO", "Initial read failed")

    `uvm_info("STAT_RX_RO", $sformatf("Original STAT_RX = 0x%08h", original_value), UVM_LOW)

    write_value = ~original_value;
    regmodel.stat_rx.write(status, write_value, UVM_FRONTDOOR);
    if (status != UVM_IS_OK) `uvm_fatal("STAT_RX_RO", "Write operation failed")

    regmodel.stat_rx.read(status, read_value, UVM_FRONTDOOR);
    if (status != UVM_IS_OK) `uvm_fatal("STAT_RX_RO", "Read after write failed")

    if (original_value == read_value)
      `uvm_info("STAT_RX_RO", "PASS: STAT_RX remained unchanged after write", UVM_LOW)
    else
      `uvm_error("STAT_RX_RO", $sformatf("FAIL: Original=0x%08h, After write=0x%08h", original_value, read_value))
  endtask
endclass
      
      
class stat_tx_ro_sequence extends pkt_base_sequence;
  `uvm_object_utils(stat_tx_ro_sequence)

  uvm_reg_data_t original_value;
  uvm_reg_data_t write_value;

  function new(string name = "stat_tx_ro_sequence");
    super.new(name);
  endfunction

  task body();
    if (regmodel == null) `uvm_fatal("STAT_TX_RO", "Register model is not assigned")

    regmodel.stat_tx.read(status, original_value, UVM_FRONTDOOR);
    if (status != UVM_IS_OK) `uvm_fatal("STAT_TX_RO", "Initial read failed")

    `uvm_info("STAT_TX_RO", $sformatf("Original STAT_TX = 0x%08h", original_value), UVM_LOW)

    write_value = ~original_value;
    regmodel.stat_tx.write(status, write_value, UVM_FRONTDOOR);
    if (status != UVM_IS_OK) `uvm_fatal("STAT_TX_RO", "Write operation failed")

    regmodel.stat_tx.read(status, read_value, UVM_FRONTDOOR);
    if (status != UVM_IS_OK) `uvm_fatal("STAT_TX_RO", "Read after write failed")

    if (original_value == read_value)
      `uvm_info("STAT_TX_RO", "PASS: STAT_TX remained unchanged after write", UVM_LOW)
    else
      `uvm_error("STAT_TX_RO", $sformatf("FAIL: Original=0x%08h, After write=0x%08h", original_value, read_value))
  endtask
endclass
      
      
class stat_drop_ro_sequence extends pkt_base_sequence;
  `uvm_object_utils(stat_drop_ro_sequence)

  uvm_reg_data_t original_value;
  uvm_reg_data_t write_value;

  function new(string name = "stat_drop_ro_sequence");
    super.new(name);
  endfunction

  task body();
    if (regmodel == null) `uvm_fatal("STAT_DROP_RO", "Register model is not assigned")

    regmodel.stat_drop.read(status, original_value, UVM_FRONTDOOR);
    if (status != UVM_IS_OK) `uvm_fatal("STAT_DROP_RO", "Initial read failed")

    `uvm_info("STAT_DROP_RO", $sformatf("Original STAT_DROP = 0x%08h", original_value), UVM_LOW)

    write_value = ~original_value;
    regmodel.stat_drop.write(status, write_value, UVM_FRONTDOOR);
    if (status != UVM_IS_OK) `uvm_fatal("STAT_DROP_RO", "Write operation failed")

    regmodel.stat_drop.read(status, read_value, UVM_FRONTDOOR);
    if (status != UVM_IS_OK) `uvm_fatal("STAT_DROP_RO", "Read after write failed")

    if (original_value == read_value)
      `uvm_info("STAT_DROP_RO", "PASS: STAT_DROP remained unchanged after write", UVM_LOW)
    else
      `uvm_error("STAT_DROP_RO", $sformatf("FAIL: Original=0x%08h, After write=0x%08h", original_value, read_value))
  endtask
endclass
      
class irq_status_sequence extends pkt_base_sequence;
  `uvm_object_utils(irq_status_sequence)

  uvm_reg_data_t original_value;
  uvm_reg_data_t write_value;
  uvm_reg_data_t read_value;
  string bit_name[8] = '{"gen_done", "error", "overflow", "packet_drop", "packet_fwd", "queue_af", "start_ack", "sw_event"};

  function new(string name = "irq_status_sequence");
    super.new(name);
  endfunction

  task body();
    if (regmodel == null) `uvm_fatal("IRQ_STATUS", "Register model is not assigned")

    regmodel.irq_status.read(status, original_value, UVM_FRONTDOOR);
    if (status != UVM_IS_OK) `uvm_fatal("IRQ_STATUS", "Initial read failed")

    `uvm_info("IRQ_STATUS", $sformatf("Original IRQ_STATUS = 0x%08h", original_value), UVM_LOW)

    if (original_value == 32'h00000000)
      `uvm_info("IRQ_STATUS", "PASS: reset value is 0x00000000", UVM_LOW)
    else
      `uvm_error("IRQ_STATUS", $sformatf("FAIL: reset value expected 0x00000000, read 0x%08h", original_value))

    for (int i = 0; i < 8; i++) begin
      write_value = 32'h1 << i;
      regmodel.irq_force.write(status, write_value, UVM_FRONTDOOR);
      if (status != UVM_IS_OK) `uvm_fatal("IRQ_STATUS", $sformatf("IRQ_FORCE write failed for bit %0d", i))

      regmodel.irq_status.read(status, read_value, UVM_FRONTDOOR);
      if (status != UVM_IS_OK) `uvm_fatal("IRQ_STATUS", $sformatf("Read after force failed for bit %0d", i))

      `uvm_info("IRQ_STATUS", $sformatf("%s: IRQ_STATUS = 0x%08h", bit_name[i], read_value), UVM_LOW)

      if (read_value[i] == 1'b1)
        `uvm_info("IRQ_STATUS", $sformatf("PASS: %s bit set", bit_name[i]), UVM_LOW)
      else
        `uvm_error("IRQ_STATUS", $sformatf("FAIL: %s bit not set", bit_name[i]))

      regmodel.irq_status.write(status, write_value, UVM_FRONTDOOR);
      if (status != UVM_IS_OK) `uvm_fatal("IRQ_STATUS", $sformatf("IRQ_STATUS clear failed for bit %0d", i))

      regmodel.irq_status.read(status, read_value, UVM_FRONTDOOR);
      if (status != UVM_IS_OK) `uvm_fatal("IRQ_STATUS", $sformatf("Read after clear failed for bit %0d", i))

      if (read_value[i] == 1'b0)
        `uvm_info("IRQ_STATUS", $sformatf("PASS: %s bit cleared", bit_name[i]), UVM_LOW)
      else
        `uvm_error("IRQ_STATUS", $sformatf("FAIL: %s bit not cleared", bit_name[i]))
    end
  endtask
endclass
        
class err_status_sequence extends pkt_base_sequence;
  `uvm_object_utils(err_status_sequence)

  uvm_reg_data_t read_value;

  function new(string name = "err_status_sequence");
    super.new(name);
  endfunction

  task body();
    if (regmodel == null) `uvm_fatal("ERR_STATUS", "Register model is not assigned")

    regmodel.err_inject.write(status, 32'h0000007F, UVM_FRONTDOOR);
    if (status != UVM_IS_OK) `uvm_fatal("ERR_STATUS", "Error injection write failed")

    regmodel.err_status.read(status, read_value, UVM_FRONTDOOR);
    if (status != UVM_IS_OK) `uvm_fatal("ERR_STATUS", "Error status read failed")

    if (read_value[6:0] == 7'h7F)
      `uvm_info("ERR_STATUS", "PASS: Error bits [6:0] are set", UVM_LOW)
    else
      `uvm_error("ERR_STATUS", $sformatf("FAIL: Expected 0x7F, read 0x%08h", read_value))

    regmodel.err_status.write(status, 32'h0000007F, UVM_FRONTDOOR);
    if (status != UVM_IS_OK) `uvm_fatal("ERR_STATUS", "Error status clear failed")

    regmodel.err_status.read(status, read_value, UVM_FRONTDOOR);
    if (status != UVM_IS_OK) `uvm_fatal("ERR_STATUS", "Read after clear failed")

    if (read_value[6:0] == 7'h00)
      `uvm_info("ERR_STATUS", "PASS: Error bits [6:0] are cleared", UVM_LOW)
    else
      `uvm_error("ERR_STATUS", $sformatf("FAIL: Error bits [6:0] not cleared, read 0x%08h", read_value))

    regmodel.err_inject.write(status, 32'h00000080, UVM_FRONTDOOR);
    if (status != UVM_IS_OK) `uvm_fatal("ERR_STATUS", "Injected-bit write failed")

    regmodel.err_status.read(status, read_value, UVM_FRONTDOOR);
    if (status != UVM_IS_OK) `uvm_fatal("ERR_STATUS", "Injected-bit read failed")

    if (read_value[7] == 1'b1)
      `uvm_info("ERR_STATUS", "PASS: INJECTED bit is set", UVM_LOW)
    else
      `uvm_error("ERR_STATUS", "FAIL: INJECTED bit is not set")

    regmodel.err_status.write(status, 32'h00000080, UVM_FRONTDOOR);
    if (status != UVM_IS_OK) `uvm_fatal("ERR_STATUS", "Injected-bit clear failed")

    regmodel.err_status.read(status, read_value, UVM_FRONTDOOR);
    if (status != UVM_IS_OK) `uvm_fatal("ERR_STATUS", "Final read failed")

    if (read_value[7] == 1'b0)
      `uvm_info("ERR_STATUS", "PASS: INJECTED bit is cleared", UVM_LOW)
    else
      `uvm_error("ERR_STATUS", "FAIL: INJECTED bit is not cleared")

    if (read_value[31:8] == 24'h0)
      `uvm_info("ERR_STATUS", "PASS: Reserved bits are zero", UVM_LOW)
    else
      `uvm_error("ERR_STATUS", $sformatf("FAIL: Reserved bits are not zero, read 0x%08h", read_value))
  endtask
endclass
      
 class err_enable_sequence extends pkt_base_sequence;
  `uvm_object_utils(err_enable_sequence)

  uvm_reg_data_t lock_value;
  uvm_reg_data_t original_value;
  uvm_reg_data_t write_value;
  uvm_reg_data_t read_value;

  function new(string name = "err_enable_sequence");
    super.new(name);
  endfunction

  task body();
    if (regmodel == null) `uvm_fatal("ERR_ENABLE", "Register model is not assigned")

    regmodel.lock.write(status, 32'hA5A5C3C3, UVM_FRONTDOOR);
    if (status != UVM_IS_OK) `uvm_fatal("ERR_ENABLE", "Unlock write failed")

    regmodel.lock.read(status, lock_value, UVM_FRONTDOOR);
    if (status != UVM_IS_OK) `uvm_fatal("ERR_ENABLE", "LOCK read failed")
    `uvm_info("ERR_ENABLE", $sformatf("LOCK after unlock = 0x%08h", lock_value), UVM_LOW)

    regmodel.err_enable.read(status, original_value, UVM_FRONTDOOR);
    if (status != UVM_IS_OK) `uvm_fatal("ERR_ENABLE", "Initial read failed")
    `uvm_info("ERR_ENABLE", $sformatf("Original ERR_ENABLE = 0x%08h", original_value), UVM_LOW)

    write_value = 32'h000000FF;
    regmodel.err_enable.write(status, write_value, UVM_FRONTDOOR);
    if (status != UVM_IS_OK) `uvm_fatal("ERR_ENABLE", "Write 0xFF failed")

    regmodel.err_enable.read(status, read_value, UVM_FRONTDOOR);
    if (status != UVM_IS_OK) `uvm_fatal("ERR_ENABLE", "Read after write 0xFF failed")

    if (read_value == write_value)
      `uvm_info("ERR_ENABLE", "PASS: all 8 enable bits set", UVM_LOW)
    else
      `uvm_error("ERR_ENABLE", $sformatf("FAIL: Written=0x%08h Read=0x%08h", write_value, read_value))

    write_value = 32'h00000000;
    regmodel.err_enable.write(status, write_value, UVM_FRONTDOOR);
    if (status != UVM_IS_OK) `uvm_fatal("ERR_ENABLE", "Write 0x00 failed")

    regmodel.err_enable.read(status, read_value, UVM_FRONTDOOR);
    if (status != UVM_IS_OK) `uvm_fatal("ERR_ENABLE", "Read after write 0x00 failed")

    if (read_value == write_value)
      `uvm_info("ERR_ENABLE", "PASS: all 8 enable bits cleared", UVM_LOW)
    else
      `uvm_error("ERR_ENABLE", $sformatf("FAIL: Written=0x%08h Read=0x%08h", write_value, read_value))

    write_value = 32'hABCDEF55;
    regmodel.err_enable.write(status, write_value, UVM_FRONTDOOR);
    if (status != UVM_IS_OK) `uvm_fatal("ERR_ENABLE", "Reserved write failed")

    regmodel.err_enable.read(status, read_value, UVM_FRONTDOOR);
    if (status != UVM_IS_OK) `uvm_fatal("ERR_ENABLE", "Reserved read after write failed")

    if (read_value[31:8] == 24'h0)
      `uvm_info("ERR_ENABLE", "PASS: reserved bits remain zero", UVM_LOW)
    else
      `uvm_error("ERR_ENABLE", $sformatf("FAIL: reserved bits changed, read[31:8]=0x%06h", read_value[31:8]))

    if (read_value[7:0] == write_value[7:0])
      `uvm_info("ERR_ENABLE", "PASS: enable bits stored correctly", UVM_LOW)
    else
      `uvm_error("ERR_ENABLE", $sformatf("FAIL: expected 0x%02h, read 0x%02h", write_value[7:0], read_value[7:0]))

    regmodel.err_enable.write(status, 32'h00000000, UVM_FRONTDOOR);
    if (status != UVM_IS_OK) `uvm_fatal("ERR_ENABLE", "Restore write failed")
  endtask
endclass
      
      
 class err_inject_sequence extends pkt_base_sequence;
  `uvm_object_utils(err_inject_sequence)

  uvm_reg_data_t original_value;
  uvm_reg_data_t read_value;

  function new(string name = "err_inject_sequence");
    super.new(name);
  endfunction

  task body();
    if (regmodel == null) `uvm_fatal("ERR_INJECT", "Register model is not assigned")

    regmodel.err_inject.read(status, original_value, UVM_FRONTDOOR);
    if (status != UVM_IS_OK) `uvm_fatal("ERR_INJECT", "Initial read failed")

    `uvm_info("ERR_INJECT", $sformatf("Original ERR_INJECT = 0x%08h", original_value), UVM_LOW)

    if (original_value == 32'h00000000)
      `uvm_info("ERR_INJECT", "PASS: reset value is 0", UVM_LOW)
    else
      `uvm_error("ERR_INJECT", $sformatf("FAIL: expected 0, read 0x%08h", original_value))

    regmodel.err_inject.write(status, 32'h00000001, UVM_FRONTDOOR);
    if (status != UVM_IS_OK) `uvm_fatal("ERR_INJECT", "Write 0x1 failed")

    regmodel.err_inject.read(status, read_value, UVM_FRONTDOOR);
    if (status != UVM_IS_OK) `uvm_fatal("ERR_INJECT", "Read after write 0x1 failed")

    if (read_value == 32'h00000000)
      `uvm_info("ERR_INJECT", "PASS: reads zero after write of 0x1", UVM_LOW)
    else
      `uvm_error("ERR_INJECT", $sformatf("FAIL: expected zero, read 0x%08h", read_value))

    regmodel.err_inject.write(status, 32'h7FFFFF00, UVM_FRONTDOOR);
    if (status != UVM_IS_OK) `uvm_fatal("ERR_INJECT", "Write 0x7FFFFF00 failed")

    regmodel.err_inject.read(status, read_value, UVM_FRONTDOOR);
    if (status != UVM_IS_OK) `uvm_fatal("ERR_INJECT", "Read after write 0x7FFFFF00 failed")

    if (read_value == 32'h00000000)
      `uvm_info("ERR_INJECT", "PASS: reads zero after write of 0x7FFFFF00", UVM_LOW)
    else
      `uvm_error("ERR_INJECT", $sformatf("FAIL: expected zero, read 0x%08h", read_value))

    regmodel.err_inject.write(status, 32'hFFFFFFFF, UVM_FRONTDOOR);
    if (status != UVM_IS_OK) `uvm_fatal("ERR_INJECT", "Write 0xFFFFFFFF failed")

    regmodel.err_inject.read(status, read_value, UVM_FRONTDOOR);
    if (status != UVM_IS_OK) `uvm_fatal("ERR_INJECT", "Read after write 0xFFFFFFFF failed")

    if (read_value == 32'h00000000)
      `uvm_info("ERR_INJECT", "PASS: reads zero after write of 0xFFFFFFFF", UVM_LOW)
    else
      `uvm_error("ERR_INJECT", $sformatf("FAIL: expected zero, read 0x%08h", read_value))

    regmodel.err_inject.write(status, 32'h80000000, UVM_FRONTDOOR);
    if (status != UVM_IS_OK) `uvm_fatal("ERR_INJECT", "Clear-count write failed")

    regmodel.err_status.write(status, 32'h000000FF, UVM_FRONTDOOR);
    if (status != UVM_IS_OK) `uvm_fatal("ERR_INJECT", "ERR_STATUS clear failed")
  endtask
endclass
    

      
class port_enable_sequence extends pkt_base_sequence;

  `uvm_object_utils(port_enable_sequence)

  function new(string name = "port_enable_sequence");
    super.new(name);
  endfunction

  task body();
    uvm_reg_data_t original_value;
    uvm_reg_data_t write_value;
    uvm_reg_data_t after_write_value;

    unlock_config();

    regmodel.port_enable.read(status, original_value, UVM_FRONTDOOR);
    `uvm_info("PORT_ENABLE",$sformatf("Original PORT_ENABLE = 0x%08h", original_value),UVM_LOW)

    write_value = original_value ^ 32'h0000000F;

    `uvm_info("PORT_ENABLE",
      $sformatf("Writing PORT_ENABLE = 0x%08h", write_value),
      UVM_LOW)

    regmodel.port_enable.write(status, write_value, UVM_FRONTDOOR);
    regmodel.port_enable.read(status, after_write_value, UVM_FRONTDOOR);

    `uvm_info("PORT_ENABLE",$sformatf("PORT_ENABLE after write = 0x%08h", after_write_value),UVM_LOW)

    if (after_write_value == write_value)
      `uvm_info("PORT_ENABLE","PASS: read value matches written value", UVM_LOW)
    else
      `uvm_error("PORT_ENABLE",$sformatf("FAIL: Written=0x%08h Read=0x%08h", write_value, after_write_value))

  endtask

endclass
      
      
class switch_ctrl_sequence extends pkt_base_sequence;

  `uvm_object_utils(switch_ctrl_sequence)

  function new(string name = "switch_ctrl_sequence");
    super.new(name);
  endfunction

  task body();
    uvm_reg_data_t original_value;
    uvm_reg_data_t write_value;
    uvm_reg_data_t after_write_value;

    unlock_config();

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
      
      
class fwd_enable_sequence extends pkt_base_sequence;

  `uvm_object_utils(fwd_enable_sequence)

  function new(string name = "fwd_enable_sequence");
    super.new(name);
  endfunction

  task body();
    uvm_reg_data_t original_value;
    uvm_reg_data_t write_value;
    uvm_reg_data_t after_write_value;

    unlock_config();

    regmodel.fwd_enable.read(status, original_value, UVM_FRONTDOOR);

    `uvm_info("FWD_ENABLE",
      $sformatf("Original FWD_ENABLE = 0x%08h", original_value),
      UVM_LOW)

    write_value = original_value ^ 32'h0000000F;

    `uvm_info("FWD_ENABLE",
      $sformatf("Writing FWD_ENABLE = 0x%08h", write_value),
      UVM_LOW)

    regmodel.fwd_enable.write(status, write_value, UVM_FRONTDOOR);
    regmodel.fwd_enable.read(status, after_write_value, UVM_FRONTDOOR);

    `uvm_info("FWD_ENABLE",
      $sformatf("FWD_ENABLE after write = 0x%08h", after_write_value),
      UVM_LOW)

    if (after_write_value == write_value)
      `uvm_info("FWD_ENABLE",
        "PASS: read value matches written value", UVM_LOW)
    else
      `uvm_error("FWD_ENABLE",
        $sformatf("FAIL: Written=0x%08h Read=0x%08h",
                  write_value, after_write_value))

  endtask

endclass
      
class gen_ctrl_sequence extends pkt_base_sequence;

  `uvm_object_utils(gen_ctrl_sequence)

  function new(string name = "gen_ctrl_sequence");
    super.new(name);
  endfunction

  task body();

    unlock_config();

    `uvm_info("GEN_CTRL",
      "CHECK 1: RW fields (enable, continuous)", UVM_LOW)

    regmodel.gen_ctrl.write(status, 32'h00000009, UVM_FRONTDOOR);
    regmodel.gen_ctrl.read(status, read_value, UVM_FRONTDOOR);

    `uvm_info("GEN_CTRL",
      $sformatf("Wrote 0x00000009, read 0x%08h", read_value),
      UVM_LOW)

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

    `uvm_info("GEN_CTRL",
      $sformatf("Wrote 0x00000000, read 0x%08h", read_value),
      UVM_LOW)

    `uvm_info("GEN_CTRL",
      "CHECK 2: Reserved bits [31:4]", UVM_LOW)

    regmodel.gen_ctrl.write(status, 32'hFFFFFFF0, UVM_FRONTDOOR);
    regmodel.gen_ctrl.read(status, read_value, UVM_FRONTDOOR);

    `uvm_info("GEN_CTRL",
      $sformatf("Wrote 0xFFFFFFF0, read 0x%08h", read_value),
      UVM_LOW)

    if (read_value[31:4] == 28'h0)
      `uvm_info("GEN_CTRL",
        "PASS: reserved bits remain zero", UVM_LOW)
    else
      `uvm_error("GEN_CTRL",
        $sformatf("FAIL: reserved bits changed, read[31:4]=0x%07h",
                  read_value[31:4]))

    `uvm_info("GEN_CTRL",
      "CHECK 3: WO fields START and STOP read as zero", UVM_LOW)

    regmodel.gen_ctrl.write(status, 32'h00000002, UVM_FRONTDOOR);
    regmodel.gen_ctrl.read(status, read_value, UVM_FRONTDOOR);

    if (read_value[1] == 1'b0)
      `uvm_info("GEN_CTRL", "PASS: START reads as 0", UVM_LOW)
    else
      `uvm_error("GEN_CTRL", "FAIL: START did not read as 0")

    regmodel.gen_ctrl.write(status, 32'h00000004, UVM_FRONTDOOR);
    regmodel.gen_ctrl.read(status, read_value, UVM_FRONTDOOR);

    if (read_value[2] == 1'b0)
      `uvm_info("GEN_CTRL", "PASS: STOP reads as 0", UVM_LOW)
    else
      `uvm_error("GEN_CTRL", "FAIL: STOP did not read as 0")

    regmodel.gen_ctrl.write(status, 32'h00000000, UVM_FRONTDOOR);

  endtask

endclass
    
class gen_pkt_cfg_sequence extends pkt_base_sequence;

  `uvm_object_utils(gen_pkt_cfg_sequence)

  function new(string name = "gen_pkt_cfg_sequence");
    super.new(name);
  endfunction

  task body();

    uvm_reg_data_t original_value;
    uvm_reg_data_t write_value;
    uvm_reg_data_t read_value;

    unlock_config();

    regmodel.gen_pkt_cfg.read(status, original_value, UVM_FRONTDOOR);

    `uvm_info("GEN_PKT_CFG",
      $sformatf("Original GEN_PKT_CFG = 0x%08h", original_value),
      UVM_LOW)

    if (original_value == 32'h00000401)
      `uvm_info("GEN_PKT_CFG", "PASS: reset value is 0x00000401", UVM_LOW)
    else
      `uvm_error("GEN_PKT_CFG",
        $sformatf("Expected reset value 0x00000401, read 0x%08h",
                  original_value))

    write_value = 32'h00A50A0B;

    regmodel.gen_pkt_cfg.write(status, write_value, UVM_FRONTDOOR);
    regmodel.gen_pkt_cfg.read(status, read_value, UVM_FRONTDOOR);

    if (read_value[23:16] == write_value[23:16])
      `uvm_info("GEN_PKT_CFG", "PASS: seed matches", UVM_LOW)
    else
      `uvm_error("GEN_PKT_CFG", "FAIL: seed mismatch")

    if (read_value[15:8] == write_value[15:8])
      `uvm_info("GEN_PKT_CFG", "PASS: length matches", UVM_LOW)
    else
      `uvm_error("GEN_PKT_CFG", "FAIL: length mismatch")

    if (read_value[3:2] == write_value[3:2])
      `uvm_info("GEN_PKT_CFG", "PASS: src_port matches", UVM_LOW)
    else
      `uvm_error("GEN_PKT_CFG", "FAIL: src_port mismatch")

    if (read_value[1:0] == write_value[1:0])
      `uvm_info("GEN_PKT_CFG", "PASS: dst_port matches", UVM_LOW)
    else
      `uvm_error("GEN_PKT_CFG", "FAIL: dst_port mismatch")

    write_value = 32'h005A0504;

    regmodel.gen_pkt_cfg.write(status, write_value, UVM_FRONTDOOR);
    regmodel.gen_pkt_cfg.read(status, read_value, UVM_FRONTDOOR);

    if (read_value == write_value)
      `uvm_info("GEN_PKT_CFG", "PASS: pattern 2 matches", UVM_LOW)
    else
      `uvm_error("GEN_PKT_CFG",
        $sformatf("FAIL: Written=0x%08h Read=0x%08h",
                  write_value, read_value))

    write_value = 32'hFF0001F0;

    regmodel.gen_pkt_cfg.write(status, write_value, UVM_FRONTDOOR);
    regmodel.gen_pkt_cfg.read(status, read_value, UVM_FRONTDOOR);

    if (read_value[31:24] == 8'h00)
      `uvm_info("GEN_PKT_CFG", "PASS: reserved bits [31:24] are zero", UVM_LOW)
    else
      `uvm_error("GEN_PKT_CFG", "FAIL: reserved bits [31:24] changed")

    if (read_value[7:4] == 4'h0)
      `uvm_info("GEN_PKT_CFG", "PASS: reserved bits [7:4] are zero", UVM_LOW)
    else
      `uvm_error("GEN_PKT_CFG", "FAIL: reserved bits [7:4] changed")

    write_value = 32'h00000000;

    regmodel.gen_pkt_cfg.write(status, write_value, UVM_FRONTDOOR);
    regmodel.gen_pkt_cfg.read(status, read_value, UVM_FRONTDOOR);

    if (read_value[15:8] == 8'h01)
      `uvm_info("GEN_PKT_CFG", "PASS: length 0 is stored as 1", UVM_LOW)
    else
      `uvm_error("GEN_PKT_CFG",
        $sformatf("FAIL: expected length 1, read 0x%02h",
                  read_value[15:8]))

    write_value = 32'h00002000;

    regmodel.gen_pkt_cfg.write(status, write_value, UVM_FRONTDOOR);
    regmodel.gen_pkt_cfg.read(status, read_value, UVM_FRONTDOOR);

    if (read_value[15:8] == 8'h20)
      `uvm_info("GEN_PKT_CFG",
        "PASS: length 0x20 remains readable", UVM_LOW)
    else
      `uvm_error("GEN_PKT_CFG",
        $sformatf("FAIL: expected length 0x20, read 0x%02h",
                  read_value[15:8]))

    regmodel.gen_pkt_cfg.write(status, 32'h00000401, UVM_FRONTDOOR);

  endtask

endclass
    
    
class gen_interval_sequence extends pkt_base_sequence;

  `uvm_object_utils(gen_interval_sequence)

  function new(string name = "gen_interval_sequence");
    super.new(name);
  endfunction

  task body();

    uvm_reg_data_t original_value;
    uvm_reg_data_t write_value;
    uvm_reg_data_t read_value;

    unlock_config();

    regmodel.gen_interval.read(status, original_value, UVM_FRONTDOOR);

    `uvm_info("GEN_INTERVAL",
      $sformatf("Original GEN_INTERVAL = 0x%08h", original_value),
      UVM_LOW)

    `uvm_info("GEN_INTERVAL",
      "CHECK 1: RW field [15:0]", UVM_LOW)

    write_value = 32'h0000A5C3;

    regmodel.gen_interval.write(status, write_value, UVM_FRONTDOOR);
    regmodel.gen_interval.read(status, read_value, UVM_FRONTDOOR);

    if (read_value[15:0] == write_value[15:0])
      `uvm_info("GEN_INTERVAL", "PASS: interval stored correctly", UVM_LOW)
    else
      `uvm_error("GEN_INTERVAL",
        $sformatf("FAIL: Expected 0x%04h, read 0x%04h",
                  write_value[15:0], read_value[15:0]))

    `uvm_info("GEN_INTERVAL",
      "CHECK 2: Reserved bits [31:16]", UVM_LOW)

    write_value = 32'hABCD0005;

    regmodel.gen_interval.write(status, write_value, UVM_FRONTDOOR);
    regmodel.gen_interval.read(status, read_value, UVM_FRONTDOOR);

    if (read_value[31:16] == 16'h0000)
      `uvm_info("GEN_INTERVAL", "PASS: reserved bits remain zero", UVM_LOW)
    else
      `uvm_error("GEN_INTERVAL",
        $sformatf("FAIL: Reserved bits changed to 0x%04h",
                  read_value[31:16]))

    if (read_value[15:0] == write_value[15:0])
      `uvm_info("GEN_INTERVAL", "PASS: interval bits stored correctly", UVM_LOW)
    else
      `uvm_error("GEN_INTERVAL",
        $sformatf("FAIL: Expected 0x%04h, read 0x%04h",
                  write_value[15:0], read_value[15:0]))

    regmodel.gen_interval.write(status, 32'h00000002, UVM_FRONTDOOR);

  endtask

endclass
    
 class gen_count_sequence extends pkt_base_sequence;

  `uvm_object_utils(gen_count_sequence)

  function new(string name = "gen_count_sequence");
    super.new(name);
  endfunction

  task body();

    uvm_reg_data_t original_value;
    uvm_reg_data_t write_value;
    uvm_reg_data_t read_value;

    unlock_config();

    regmodel.gen_count.read(status, original_value, UVM_FRONTDOOR);

    `uvm_info("GEN_COUNT",
      $sformatf("Original GEN_COUNT = 0x%08h", original_value),
      UVM_LOW)

    `uvm_info("GEN_COUNT",
      "CHECK 1: RW field [15:0]", UVM_LOW)

    write_value = 32'h0000A5C3;

    regmodel.gen_count.write(status, write_value, UVM_FRONTDOOR);
    regmodel.gen_count.read(status, read_value, UVM_FRONTDOOR);

    if (read_value[15:0] == write_value[15:0])
      `uvm_info("GEN_COUNT", "PASS: packet_count stored correctly", UVM_LOW)
    else
      `uvm_error("GEN_COUNT",
        $sformatf("FAIL: Expected 0x%04h, read 0x%04h",
                  write_value[15:0], read_value[15:0]))

    `uvm_info("GEN_COUNT",
      "CHECK 2: Reserved bits [31:16]", UVM_LOW)

    write_value = 32'hABCD0005;

    regmodel.gen_count.write(status, write_value, UVM_FRONTDOOR);
    regmodel.gen_count.read(status, read_value, UVM_FRONTDOOR);

    if (read_value[31:16] == 16'h0000)
      `uvm_info("GEN_COUNT", "PASS: reserved bits remain zero", UVM_LOW)
    else
      `uvm_error("GEN_COUNT",
        $sformatf("FAIL: Reserved bits changed to 0x%04h",
                  read_value[31:16]))

    if (read_value[15:0] == write_value[15:0])
      `uvm_info("GEN_COUNT", "PASS: packet_count stored correctly", UVM_LOW)
    else
      `uvm_error("GEN_COUNT", $sformatf("FAIL: Expected 0x%04h, read 0x%04h",write_value[15:0], read_value[15:0]))

    regmodel.gen_count.write(status, 32'h00000001, UVM_FRONTDOOR);

  endtask

endclass

class err_count_sequence extends pkt_base_sequence;

  `uvm_object_utils(err_count_sequence)

  function new(string name = "err_count_sequence");
    super.new(name);
  endfunction

  task body();

    uvm_reg_data_t original_value;
    uvm_reg_data_t write_value;

    if (regmodel == null)
      `uvm_fatal("ERR_COUNT", "Register model is not assigned")

    regmodel.err_count.read(status, original_value, UVM_FRONTDOOR);

    `uvm_info("ERR_COUNT",
      $sformatf("Original ERR_COUNT = 0x%08h", original_value),
      UVM_LOW)

    write_value = ~original_value;

    regmodel.err_count.write(status, write_value, UVM_FRONTDOOR);
    regmodel.err_count.read(status, read_value, UVM_FRONTDOOR);

    if (read_value == original_value)
      `uvm_info("ERR_COUNT", "PASS: ERR_COUNT is read-only", UVM_LOW)
    else
      `uvm_error("ERR_COUNT",
        $sformatf("FAIL: Original=0x%08h, After write=0x%08h",
                  original_value, read_value))

  endtask

endclass
      
class err_info_sequence extends pkt_base_sequence;
  `uvm_object_utils(err_info_sequence)

  function new(string name = "err_info_sequence");
    super.new(name);
  endfunction

  task body();
    uvm_reg_data_t original_value;
    uvm_reg_data_t write_value;

    if (regmodel == null)
      `uvm_fatal("ERR_INFO", "Register model is not assigned")

    regmodel.err_info.read(status, original_value, UVM_FRONTDOOR);
    if (status != UVM_IS_OK)
      `uvm_fatal("ERR_INFO", "Initial read failed")

    `uvm_info("ERR_INFO", $sformatf("Original ERR_INFO = 0x%08h", original_value), UVM_LOW)

    if (original_value == 32'h00000000)
      `uvm_info("ERR_INFO", "PASS: reset value is 0x00000000", UVM_LOW)
    else
      `uvm_error("ERR_INFO", $sformatf("FAIL: expected reset value 0x00000000, read 0x%08h", original_value))

    write_value = 32'hFFFFFFFF;
    regmodel.err_info.write(status, write_value, UVM_FRONTDOOR);
    if (status != UVM_IS_OK)
      `uvm_fatal("ERR_INFO", "Write failed")

    regmodel.err_info.read(status, read_value, UVM_FRONTDOOR);
    if (status != UVM_IS_OK)
      `uvm_fatal("ERR_INFO", "Read after write failed")

    if (read_value == original_value)
      `uvm_info("ERR_INFO", "PASS: ERR_INFO unchanged after write of 0xFFFFFFFF", UVM_LOW)
    else
      `uvm_error("ERR_INFO", $sformatf("FAIL: Original=0x%08h After write=0x%08h", original_value, read_value))

    write_value = 32'hA5A5A5A5;
    regmodel.err_info.write(status, write_value, UVM_FRONTDOOR);
    if (status != UVM_IS_OK)
      `uvm_fatal("ERR_INFO", "Second write failed")

    regmodel.err_info.read(status, read_value, UVM_FRONTDOOR);
    if (status != UVM_IS_OK)
      `uvm_fatal("ERR_INFO", "Read after second write failed")

    if (read_value == original_value)
      `uvm_info("ERR_INFO", "PASS: ERR_INFO unchanged after second write", UVM_LOW)
    else
      `uvm_error("ERR_INFO", $sformatf("FAIL: Original=0x%08h After write=0x%08h", original_value, read_value))
  endtask
endclass
      
      
class lock_sequence extends pkt_base_sequence;
  `uvm_object_utils(lock_sequence)

  function new(string name = "lock_sequence");
    super.new(name);
  endfunction

  task body();
    uvm_reg_data_t original_value;
    uvm_reg_data_t write_value;

    regmodel.lock.read(status, original_value, UVM_FRONTDOOR);
    `uvm_info("LOCK", $sformatf("Original LOCK = 0x%08h", original_value), UVM_LOW)

//     if (original_value == 32'h00000001)
//       `uvm_info("LOCK", "PASS: reset value is 0x00000001 (locked)", UVM_LOW)
//     else
//       `uvm_error("LOCK", $sformatf("FAIL: expected reset value 0x00000001, read 0x%08h", original_value))

    write_value = 32'h12345678;
    regmodel.lock.write(status, write_value, UVM_FRONTDOOR);
    if (status != UVM_IS_OK) `uvm_fatal("LOCK", "Wrong key write failed")
    regmodel.lock.read(status, read_value, UVM_FRONTDOOR);
    if (status != UVM_IS_OK) `uvm_fatal("LOCK", "Read after wrong key failed")

    if (read_value == 32'h00000001)
      `uvm_info("LOCK", "PASS: still locked after wrong key", UVM_LOW)
    else
      `uvm_error("LOCK", $sformatf("FAIL: expected 0x00000001, read 0x%08h", read_value))

    write_value = 32'hA5A5C3C3;
    regmodel.lock.write(status, write_value, UVM_FRONTDOOR);
    if (status != UVM_IS_OK) `uvm_fatal("LOCK", "Correct key write failed")
    regmodel.lock.read(status, read_value, UVM_FRONTDOOR);
    if (status != UVM_IS_OK) `uvm_fatal("LOCK", "Read after correct key failed")

    if (read_value[0] == 1'b0)
      `uvm_info("LOCK", "PASS: correct key unlocked configuration", UVM_LOW)
    else
      `uvm_error("LOCK", $sformatf("FAIL: expected unlocked value, read 0x%08h", read_value))
  endtask
endclass
      
class generate_four_packets_sequence extends pkt_base_sequence;
  `uvm_object_utils(generate_four_packets_sequence)

  function new(string name = "generate_four_packets_sequence");
    super.new(name);
  endfunction

  task body();
    int i;

    unlock_config();

    regmodel.port_enable.write(status, 32'h0000000F, UVM_FRONTDOOR);
    regmodel.fwd_enable.write(status, 32'h0000000F, UVM_FRONTDOOR);
    regmodel.switch_ctrl.write(status, 32'h00000009, UVM_FRONTDOOR);
    regmodel.gen_pkt_cfg.write(status, 32'h00100401, UVM_FRONTDOOR);
    regmodel.gen_interval.write(status, 32'h00000002, UVM_FRONTDOOR);
    regmodel.gen_count.write(status, 32'h00000004, UVM_FRONTDOOR);
    regmodel.irq_enable.write(status, 32'h00000041, UVM_FRONTDOOR);
    regmodel.gen_ctrl.write(status, 32'h00000003, UVM_FRONTDOOR);

    i = 0;
    read_value = 0;
    do begin
      regmodel.gen_status.read(status, read_value, UVM_FRONTDOOR);
      if (status != UVM_IS_OK) `uvm_fatal("PKT_TEST", "GEN_STATUS read failed")
      i++;
    end while (read_value[1] != 1'b1 && i < 100);

    if (read_value[1] == 1'b1)
      `uvm_info("PKT_TEST", "PASS: Packet generation completed", UVM_LOW)
    else
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
      
class clear_sticky_status_sequence extends pkt_base_sequence;
  `uvm_object_utils(clear_sticky_status_sequence)

  function new(string name = "clear_sticky_status_sequence");
    super.new(name);
  endfunction

  task body();
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
      
class destination_drop_sequence extends pkt_base_sequence;
  `uvm_object_utils(destination_drop_sequence)

  function new(string name = "destination_drop_sequence");
    super.new(name);
  endfunction

  task body();
    int timeout_count = 0;
    unlock_config();

    regmodel.switch_ctrl.write(status, 32'h00000001, UVM_FRONTDOOR);
    regmodel.fwd_enable.write(status, 32'h00000001, UVM_FRONTDOOR);
    regmodel.gen_pkt_cfg.write(status, 32'h00000401, UVM_FRONTDOOR);
    regmodel.gen_interval.write(status, 32'h00000002, UVM_FRONTDOOR);
    regmodel.gen_count.write(status, 32'h00000001, UVM_FRONTDOOR);
    regmodel.gen_ctrl.write(status, 32'h00000003, UVM_FRONTDOOR);

    read_value = 0;
    while (read_value[1] != 1'b1 && timeout_count < 100) begin
      regmodel.gen_status.read(status, read_value, UVM_FRONTDOOR);
      timeout_count++;
    end

    if (read_value[1] != 1'b1) `uvm_error("DEST_DROP", "FAIL: Packet generation timed out")

    regmodel.err_status.read(status, read_value, UVM_FRONTDOOR);
    if (read_value[1] == 1'b1) `uvm_info("DEST_DROP", "PASS: ERR_STATUS.DEST_ERROR is set", UVM_LOW)
    else `uvm_error("DEST_DROP", "FAIL: DEST_ERROR is not set")

    regmodel.stat_drop.read(status, read_value, UVM_FRONTDOOR);
    if (read_value[15:0] == 1) 
      `uvm_info("DEST_DROP", "PASS: STAT_DROP = 1", UVM_LOW)
    else 
      `uvm_error("DEST_DROP", $sformatf("FAIL: STAT_DROP expected=1 actual=%0d", read_value[15:0]))

    regmodel.irq_status.read(status, read_value, UVM_FRONTDOOR);
    if (read_value[3] == 1'b1) 
      `uvm_info("DEST_DROP", "PASS: IRQ_STATUS.PACKET_DROPPED is set", UVM_LOW)
    else 
      `uvm_error("DEST_DROP", "FAIL: PACKET_DROPPED is not set")
  endtask
endclass
      
class soft_reset_sequence extends pkt_base_sequence;
  `uvm_object_utils(soft_reset_sequence)

  function new(string name = "soft_reset_sequence");
    super.new(name);
  endfunction

  task body();
    unlock_config();

    regmodel.port_enable.write(status, 32'h00000005, UVM_FRONTDOOR);

    regmodel.port_enable.read(status, read_value, UVM_FRONTDOOR);
    `uvm_info("SOFT_RESET", $sformatf("PORT_ENABLE before soft reset = 0x%08h", read_value), UVM_LOW)

    regmodel.soft_reset.write(status, 32'h00000001, UVM_FRONTDOOR);

    regmodel.port_enable.read(status, read_value, UVM_FRONTDOOR);
    if (read_value == 32'h0000000F) 
      `uvm_info("SOFT_RESET", "PASS: PORT_ENABLE restored to 0x0000000F", UVM_LOW)
    else 
      `uvm_error("SOFT_RESET", $sformatf("FAIL: PORT_ENABLE expected 0x0000000F, read 0x%08h", read_value))

    regmodel.lock.read(status, read_value, UVM_FRONTDOOR);
    if (read_value == 32'h00000001) 
      `uvm_info("SOFT_RESET", "PASS: LOCK restored to locked state", UVM_LOW)
    else 
      `uvm_error("SOFT_RESET", $sformatf("FAIL: LOCK expected 0x00000001, read 0x%08h", read_value))
  endtask
endclass
    
 class reset_values_sequence extends pkt_base_sequence;
  `uvm_object_utils(reset_values_sequence)

  function new(string name = "reset_values_sequence");
    super.new(name);
  endfunction

  task body();
    if (regmodel == null) `uvm_fatal("RESET_VAL", "Register model is not assigned")

    check_readback(regmodel.device_id, 32'h02A55357, 32'hFFFFFFFF, "DEVICE_ID");
    check_readback(regmodel.version, 32'h00010200, 32'hFFFFFFFF, "VERSION");
    check_readback(regmodel.switch_status, 32'h000000F9, 32'hFFFFFFFF, "SWITCH_STATUS");
    check_readback(regmodel.port_status, 32'h00000000, 32'hFFFFFFFF, "PORT_STATUS");
    check_readback(regmodel.gen_status, 32'h00000000, 32'hFFFFFFFF, "GEN_STATUS");
    check_readback(regmodel.stat_rx, 32'h00000000, 32'hFFFFFFFF, "STAT_RX");
    check_readback(regmodel.stat_tx, 32'h00000000, 32'hFFFFFFFF, "STAT_TX");
    check_readback(regmodel.stat_drop, 32'h00000000, 32'hFFFFFFFF, "STAT_DROP");
    check_readback(regmodel.irq_status, 32'h00000000, 32'hFFFFFFFF, "IRQ_STATUS");
    check_readback(regmodel.irq_enable, 32'h00000000, 32'hFFFFFFFF, "IRQ_ENABLE");
    check_readback(regmodel.irq_force, 32'h00000000, 32'hFFFFFFFF, "IRQ_FORCE");
    check_readback(regmodel.err_status, 32'h00000000, 32'hFFFFFFFF, "ERR_STATUS");
    check_readback(regmodel.err_enable, 32'h00000000, 32'hFFFFFFFF, "ERR_ENABLE");
    check_readback(regmodel.err_inject, 32'h00000000, 32'hFFFFFFFF, "ERR_INJECT");
    check_readback(regmodel.err_count, 32'h00000000, 32'hFFFFFFFF, "ERR_COUNT");
    check_readback(regmodel.err_info, 32'h00000000, 32'hFFFFFFFF, "ERR_INFO");
    check_readback(regmodel.lock, 32'h00000001, 32'hFFFFFFFF, "LOCK");
    check_readback(regmodel.soft_reset, 32'h00000000, 32'hFFFFFFFF, "SOFT_RESET");
  endtask
endclass
    
    

class irq_force_sequence extends pkt_base_sequence;
  `uvm_object_utils(irq_force_sequence)

  uvm_reg_data_t original_value;
  uvm_reg_data_t write_value;

  function new(string name = "irq_force_sequence");
    super.new(name);
  endfunction

  task body();
    if (regmodel == null) `uvm_fatal("IRQ_FORCE", "Register model is not assigned")

    regmodel.irq_status.read(status, original_value, UVM_FRONTDOOR);
    if (status != UVM_IS_OK) `uvm_fatal("IRQ_FORCE", "Initial IRQ_STATUS read failed")

    `uvm_info("IRQ_FORCE", $sformatf("Original IRQ_STATUS = 0x%08h", original_value), UVM_LOW)

    write_value = 32'h000000A5;
    regmodel.irq_force.write(status, write_value, UVM_FRONTDOOR);
    if (status != UVM_IS_OK) `uvm_fatal("IRQ_FORCE", "IRQ_FORCE write failed")

    regmodel.irq_force.read(status, read_value, UVM_FRONTDOOR);
    if (status != UVM_IS_OK) `uvm_fatal("IRQ_FORCE", "IRQ_FORCE read failed")

    if (read_value == 32'h00000000)
      `uvm_info("IRQ_FORCE", "PASS: IRQ_FORCE reads zero", UVM_LOW)
    else
      `uvm_error("IRQ_FORCE", $sformatf("FAIL: expected zero, read 0x%08h", read_value))

    regmodel.irq_status.read(status, read_value, UVM_FRONTDOOR);
    if (status != UVM_IS_OK) `uvm_fatal("IRQ_FORCE", "IRQ_STATUS read after force failed")

    if (read_value == write_value)
      `uvm_info("IRQ_FORCE", "PASS: forced bits set in IRQ_STATUS", UVM_LOW)
    else
      `uvm_error("IRQ_FORCE", $sformatf("FAIL: expected 0x%08h, read 0x%08h", write_value, read_value))

    regmodel.irq_force.write(status, 32'h00000000, UVM_FRONTDOOR);
    if (status != UVM_IS_OK) `uvm_fatal("IRQ_FORCE", "IRQ_FORCE write zero failed")

    regmodel.irq_status.read(status, read_value, UVM_FRONTDOOR);
    if (status != UVM_IS_OK) `uvm_fatal("IRQ_FORCE", "IRQ_STATUS read after force zero failed")

    if (read_value == 32'h000000A5)
      `uvm_info("IRQ_FORCE", "PASS: writing zero did not clear IRQ_STATUS", UVM_LOW)
    else
      `uvm_error("IRQ_FORCE", $sformatf("FAIL: expected 0x000000A5, read 0x%08h", read_value))

    regmodel.irq_status.write(status, 32'h000000FF, UVM_FRONTDOOR);
    if (status != UVM_IS_OK) `uvm_fatal("IRQ_FORCE", "IRQ_STATUS clear failed")

    regmodel.irq_status.read(status, read_value, UVM_FRONTDOOR);
    if (status != UVM_IS_OK) `uvm_fatal("IRQ_FORCE", "IRQ_STATUS read after clear failed")

    if (read_value == 32'h00000000)
      `uvm_info("IRQ_FORCE", "PASS: IRQ_STATUS cleared", UVM_LOW)
    else
      `uvm_error("IRQ_FORCE", $sformatf("FAIL: expected zero after clear, read 0x%08h", read_value))

    write_value = 32'hFFFFFF00;
    regmodel.irq_force.write(status, write_value, UVM_FRONTDOOR);
    if (status != UVM_IS_OK) `uvm_fatal("IRQ_FORCE", "Reserved bits write failed")

    regmodel.irq_status.read(status, read_value, UVM_FRONTDOOR);
    if (status != UVM_IS_OK) `uvm_fatal("IRQ_FORCE", "IRQ_STATUS read after reserved write failed")

    if (read_value == 32'h00000000)
      `uvm_info("IRQ_FORCE", "PASS: reserved bits ignored", UVM_LOW)
    else
      `uvm_error("IRQ_FORCE", $sformatf("FAIL: expected zero, read 0x%08h", read_value))
  endtask
endclass

    
      
 class unaligned_address_sequence extends uvm_sequence#(pkt_seq_item);
  `uvm_object_utils(unaligned_address_sequence)

  function new(string name = "unaligned_address_sequence");
    super.new(name);
  endfunction

  task body();
    `uvm_info("UNALIGNED", "Testing unaligned address 0x0002", UVM_LOW)
    `uvm_do_with(req,{req.addr==16'h02;});
  endtask
endclass


class invalid_address_sequence extends uvm_sequence#(pkt_seq_item);
  `uvm_object_utils(invalid_address_sequence)

  function new(string name = "invalid_address_sequence");
    super.new(name);
  endfunction

  task body();
    `uvm_info("INVALID_ADDR", "Testing invalid address 0x0064", UVM_LOW)
    `uvm_do_with(req,{req.addr==16'hFFFF;});
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

class err_info_covg_seq extends pkt_base_sequence;
  `uvm_object_utils(err_info_covg_seq)

  function new(string name = "err_info_covg_seq");
    super.new(name);
  endfunction

  task body();

    uvm_reg_data_t gen_status;
    uvm_reg_data_t err_info_value;
    int timeout_count;

    if (regmodel == null)
      `uvm_fatal("ERR_INFO_COVG", "Register model is not assigned")

    unlock_config();

    regmodel.port_enable.write(status, 32'h0000000F, UVM_FRONTDOOR);
    regmodel.fwd_enable.write(status, 32'h00000000, UVM_FRONTDOOR);
    regmodel.switch_ctrl.write(status, 32'h00000009, UVM_FRONTDOOR);
    regmodel.gen_interval.write(status, 32'h00000002, UVM_FRONTDOOR);

    for (int i = 0; i < 4; i++) begin

      regmodel.err_status.write(status, 32'h00000002, UVM_FRONTDOOR);

      regmodel.gen_pkt_cfg.write(status,
                                 32'h00100400 | i,
                                 UVM_FRONTDOOR);

      regmodel.gen_count.write(status, 32'h00000001, UVM_FRONTDOOR);

      regmodel.gen_ctrl.write(status, 32'h00000003, UVM_FRONTDOOR);

      timeout_count = 0;
      gen_status = 0;

      while (!gen_status[1] && timeout_count < 100) begin
        regmodel.gen_status.read(status, gen_status, UVM_FRONTDOOR);
        timeout_count++;
      end

      if (!gen_status[1])
        `uvm_error("ERR_INFO_COVG",
                   $sformatf("Generation timeout for destination %0d", i))

      regmodel.err_info.read(status, err_info_value, UVM_FRONTDOOR);

      `uvm_info("ERR_INFO_COVG",
                $sformatf("Destination = %0d, ERR_INFO = 0x%08h, Captured destination = %0d",
                          i, err_info_value, err_info_value[17:16]),
                UVM_LOW)

    end

  endtask
endclass

class switch_status_covg_seq extends pkt_base_sequence;
  `uvm_object_utils(switch_status_covg_seq)

  function new(string name = "switch_status_covg_seq");
    super.new(name);
  endfunction

  task body();

    uvm_reg_data_t sw_status;
    uvm_reg_data_t gen_status;
    int timeout_count;

    if (regmodel == null)
      `uvm_fatal("SW_COV", "Register model is not assigned")

    unlock_config();

    regmodel.switch_ctrl.write(status, 32'h00000009, UVM_FRONTDOOR);
    regmodel.port_enable.write(status, 32'h0000000F, UVM_FRONTDOOR);
    regmodel.fwd_enable.write(status, 32'h0000000F, UVM_FRONTDOOR);

    regmodel.gen_pkt_cfg.write(status, 32'h00001001, UVM_FRONTDOOR);
    regmodel.gen_interval.write(status, 32'h00000064, UVM_FRONTDOOR);
    regmodel.gen_count.write(status, 32'h00000004, UVM_FRONTDOOR);

    regmodel.gen_ctrl.write(status, 32'h00000003, UVM_FRONTDOOR);

    timeout_count = 0;

    while (timeout_count < 200) begin
      regmodel.switch_status.read(status, sw_status, UVM_FRONTDOOR);

      `uvm_info("SW_COV",
                $sformatf("SWITCH_STATUS = 0x%08h FSM = %0d RUNNING = %0b",
                          sw_status, sw_status[17:16], sw_status[8]),
                UVM_LOW)

      if (sw_status[17:16] == 2'b11)
        break;

      timeout_count++;
    end

    regmodel.gen_ctrl.write(status, 32'h00000005, UVM_FRONTDOOR);

    regmodel.switch_status.read(status, sw_status, UVM_FRONTDOOR);

    `uvm_info("SW_COV",
              $sformatf("Final SWITCH_STATUS = 0x%08h", sw_status),
              UVM_LOW)

  endtask
endclass
/*
class err_count_covg_seq extends pkt_base_sequence;
  `uvm_object_utils(err_count_covg_seq)

  function new(string name = "err_count_covg_seq");
    super.new(name);
  endfunction

  task body();

    if (regmodel == null)
      `uvm_fatal("ERR_COUNT_COV", "Register model is not assigned")

    // Clear error count and error information
    regmodel.err_inject.write(status, 32'h80000000, UVM_FRONTDOOR);

    // Hit zero
    regmodel.err_count.read(status, read_value, UVM_FRONTDOOR);
    `uvm_info("ERR_COUNT_COV",
              $sformatf("Zero count = %0d", read_value), UVM_LOW)

    // Hit one_error
    regmodel.err_inject.write(status, 32'h00000001, UVM_FRONTDOOR);
    regmodel.err_count.read(status, read_value, UVM_FRONTDOOR);
    `uvm_info("ERR_COUNT_COV",
              $sformatf("One error count = %0d", read_value), UVM_LOW)

    // Hit multiple
    regmodel.err_inject.write(status, 32'h00000007, UVM_FRONTDOOR);
    regmodel.err_count.read(status, read_value, UVM_FRONTDOOR);
    `uvm_info("ERR_COUNT_COV",
              $sformatf("Multiple error count = %0d", read_value), UVM_LOW)

    // Hit max_count
    regmodel.err_inject.write(status, 32'h80000000, UVM_FRONTDOOR);
    regmodel.err_inject.write(status, 32'h0000007F, UVM_FRONTDOOR);
    repeat (100) begin
      regmodel.err_inject.write(status, 32'h0000007F, UVM_FRONTDOOR);
    end

    regmodel.err_count.read(status, read_value, UVM_FRONTDOOR);
    `uvm_info("ERR_COUNT_COV",
              $sformatf("Maximum error count = %0d", read_value), UVM_LOW)

  endtask
endclass
*/
class pkt_regression_sequence extends pkt_base_sequence;
  `uvm_object_utils(pkt_regression_sequence)

  function new(string name = "pkt_regression_sequence");
    super.new(name);
  endfunction

  task body();
    reset_values_sequence reset_seq;
    device_id_ro_test device_seq;
    version_ro_sequence version_seq;
    switch_status_ro_sequence switch_status_seq;
    port_status_ro_sequence port_status_seq;
    gen_status_ro_sequence gen_status_seq;
    stat_rx_ro_sequence rx_seq;
    stat_tx_ro_sequence tx_seq;
    stat_drop_ro_sequence drop_seq;
    port_enable_sequence port_en_seq;
    switch_ctrl_sequence switch_ctrl_seq;
    fwd_enable_sequence fwd_seq;
    gen_ctrl_sequence gen_ctrl_seq;
    gen_pkt_cfg_sequence pkt_cfg_seq;
    gen_interval_sequence interval_seq;
    gen_count_sequence count_seq;
    irq_status_sequence irq_status_seq;
    irq_enable_sequence irq_en_seq;
    irq_force_sequence irq_force_seq;
    err_count_sequence err_count_seq;
    err_info_sequence err_info_seq;
    lock_sequence lock_seq;
    clear_sticky_status_sequence clear_seq;
    generate_four_packets_sequence packets_seq;
    destination_drop_sequence dest_drop_seq;
    soft_reset_sequence soft_reset_seq;
    unaligned_address_sequence unaligned_seq;
    invalid_address_sequence invalid_seq;
    err_info_covg_seq cov_seq1;
    switch_status_covg_seq cov_seq2;
    err_count_covg_seq cov_seq3;

    if (regmodel == null)
      `uvm_fatal("REGRESSION", "Register model is not assigned")

    reset_seq = reset_values_sequence::type_id::create("reset_seq");
    reset_seq.regmodel = regmodel;
    reset_seq.start(m_sequencer);

    device_seq = device_id_ro_test::type_id::create("device_seq");
    device_seq.regmodel = regmodel;
    device_seq.start(m_sequencer);

    version_seq = version_ro_sequence::type_id::create("version_seq");
    version_seq.regmodel = regmodel;
    version_seq.start(m_sequencer);

    switch_status_seq = switch_status_ro_sequence::type_id::create("switch_status_seq");
    switch_status_seq.regmodel = regmodel;
    switch_status_seq.start(m_sequencer);

    port_status_seq = port_status_ro_sequence::type_id::create("port_status_seq");
    port_status_seq.regmodel = regmodel;
    port_status_seq.start(m_sequencer);

    gen_status_seq = gen_status_ro_sequence::type_id::create("gen_status_seq");
    gen_status_seq.regmodel = regmodel;
    gen_status_seq.start(m_sequencer);

    rx_seq = stat_rx_ro_sequence::type_id::create("rx_seq");
    rx_seq.regmodel = regmodel;
    rx_seq.start(m_sequencer);

    tx_seq = stat_tx_ro_sequence::type_id::create("tx_seq");
    tx_seq.regmodel = regmodel;
    tx_seq.start(m_sequencer);

    drop_seq = stat_drop_ro_sequence::type_id::create("drop_seq");
    drop_seq.regmodel = regmodel;
    drop_seq.start(m_sequencer);

    port_en_seq = port_enable_sequence::type_id::create("port_en_seq");
    port_en_seq.regmodel = regmodel;
    port_en_seq.start(m_sequencer);

    switch_ctrl_seq = switch_ctrl_sequence::type_id::create("switch_ctrl_seq");
    switch_ctrl_seq.regmodel = regmodel;
    switch_ctrl_seq.start(m_sequencer);

    fwd_seq = fwd_enable_sequence::type_id::create("fwd_seq");
    fwd_seq.regmodel = regmodel;
    fwd_seq.start(m_sequencer);

    gen_ctrl_seq = gen_ctrl_sequence::type_id::create("gen_ctrl_seq");
    gen_ctrl_seq.regmodel = regmodel;
    gen_ctrl_seq.start(m_sequencer);

    pkt_cfg_seq = gen_pkt_cfg_sequence::type_id::create("pkt_cfg_seq");
    pkt_cfg_seq.regmodel = regmodel;
    pkt_cfg_seq.start(m_sequencer);

    interval_seq = gen_interval_sequence::type_id::create("interval_seq");
    interval_seq.regmodel = regmodel;
    interval_seq.start(m_sequencer);

    count_seq = gen_count_sequence::type_id::create("count_seq");
    count_seq.regmodel = regmodel;
    count_seq.start(m_sequencer);

    irq_status_seq = irq_status_sequence::type_id::create("irq_status_seq");
    irq_status_seq.regmodel = regmodel;
    irq_status_seq.start(m_sequencer);

    irq_en_seq = irq_enable_sequence::type_id::create("irq_en_seq");
    irq_en_seq.regmodel = regmodel;
    irq_en_seq.start(m_sequencer);

    irq_force_seq = irq_force_sequence::type_id::create("irq_force_seq");
    irq_force_seq.regmodel = regmodel;
    irq_force_seq.start(m_sequencer);

    err_count_seq = err_count_sequence::type_id::create("err_count_seq");
    err_count_seq.regmodel = regmodel;
    err_count_seq.start(m_sequencer);

    err_info_seq = err_info_sequence::type_id::create("err_info_seq");
    err_info_seq.regmodel = regmodel;
    err_info_seq.start(m_sequencer);

    lock_seq = lock_sequence::type_id::create("lock_seq");
    lock_seq.regmodel = regmodel;
    lock_seq.start(m_sequencer);

    clear_seq = clear_sticky_status_sequence::type_id::create("clear_seq");
    clear_seq.regmodel = regmodel;
    clear_seq.start(m_sequencer);

    packets_seq = generate_four_packets_sequence::type_id::create("packets_seq");
    packets_seq.regmodel = regmodel;
    packets_seq.start(m_sequencer);

    dest_drop_seq = destination_drop_sequence::type_id::create("dest_drop_seq");
    dest_drop_seq.regmodel = regmodel;
    dest_drop_seq.start(m_sequencer);

    soft_reset_seq = soft_reset_sequence::type_id::create("soft_reset_seq");
    soft_reset_seq.regmodel = regmodel;
    soft_reset_seq.start(m_sequencer);

    unaligned_seq = unaligned_address_sequence::type_id::create("unaligned_seq");
   // unaligned_seq.regmodel = regmodel;
    unaligned_seq.start(m_sequencer);

    invalid_seq = invalid_address_sequence::type_id::create("invalid_seq");
   // invalid_seq.regmodel = regmodel;
    invalid_seq.start(m_sequencer);

    cov_seq1 = err_info_covg_seq::type_id::create("err_info_covg_seq");
    cov_seq1.regmodel = regmodel;
    cov_seq1.start(m_sequencer);

    
    cov_seq2 = switch_status_covg_seq::type_id::create("switch_status_covg_seq");
    cov_seq2.regmodel = regmodel;
    cov_seq2.start(m_sequencer);

    cov_seq3 = err_count_covg_seq::type_id::create("switch_status_covg_seq");
    cov_seq3.regmodel = regmodel;
    cov_seq3.start(m_sequencer);
    `uvm_info("REGRESSION", "All regression sequences completed", UVM_LOW)
  endtask
endclass

/*class err_info_covg_seq extends pkt_base_sequence;
  `uvm_object_utils(err_info_coverage_sequence)
   pkt_reg_block regmodel;

  function new(string name = "err_info_coverage_sequence");
    super.new(name);
  endfunction

  task body();

    unlock_config();

    regmodel.port_enable.write(status, 32'h0000000F, UVM_FRONTDOOR);
    regmodel.fwd_enable.write(status, 32'h0000000F, UVM_FRONTDOOR);
    regmodel.switch_ctrl.write(status, 32'h00000009, UVM_FRONTDOOR);

    // Generate packets for destination ports 0, 1, 2 and 3
    // Update GEN_PKT_CFG destination field for each port.

    // Generate an invalid-destination packet
    // Configure GEN_PKT_CFG with an invalid destination.

  endtask
endclass*/
