class pkt_base_test extends uvm_test;
  `uvm_component_utils(pkt_base_test)

  pkt_env env;

  function new(string name, uvm_component parent);
    super.new(name,parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    env=pkt_env::type_id::create("env",this);
  endfunction
endclass



class device_id_ro_uvm_test extends pkt_base_test;

  `uvm_component_utils(device_id_ro_uvm_test)

  function new(string name = "device_id_ro_uvm_test",
               uvm_component parent = null);
    super.new(name, parent);
  endfunction

  task run_phase(uvm_phase phase);
    device_id_ro_test seq;

    phase.raise_objection(this);

    seq = device_id_ro_test::type_id::create("seq");

  
    seq.regmodel = env.regmodel;


    seq.start(env.agent.sequencer);

    phase.drop_objection(this);
  endtask

endclass



class version_ro_uvm_test extends pkt_base_test;

  `uvm_component_utils(version_ro_uvm_test)

  function new(string name = "version_ro_uvm_test",
               uvm_component parent = null);
    super.new(name, parent);
  endfunction

  task run_phase(uvm_phase phase);
    version_ro_sequence seq;

    phase.raise_objection(this);

    seq = version_ro_sequence::type_id::create("seq");

    seq.regmodel = env.regmodel;

    seq.start(env.agent.sequencer);

    phase.drop_objection(this);
  endtask

endclass



class switch_status_ro_uvm_test extends pkt_base_test;

  `uvm_component_utils(switch_status_ro_uvm_test)

  function new(string name = "switch_status_ro_uvm_test",
               uvm_component parent = null);
    super.new(name, parent);
  endfunction

  task run_phase(uvm_phase phase);
    switch_status_ro_sequence seq;

    phase.raise_objection(this);

    seq = switch_status_ro_sequence::type_id::create("seq");
    seq.regmodel = env.regmodel;
    seq.start(env.agent.sequencer);

    phase.drop_objection(this);
  endtask

endclass



class port_status_ro_uvm_test extends pkt_base_test;

  `uvm_component_utils(port_status_ro_uvm_test)

  function new(string name = "port_status_ro_uvm_test",
               uvm_component parent = null);
    super.new(name, parent);
  endfunction

  task run_phase(uvm_phase phase);
    port_status_ro_sequence seq;

    phase.raise_objection(this);

    seq = port_status_ro_sequence::type_id::create("seq");
    seq.regmodel = env.regmodel;
    seq.start(env.agent.sequencer);

    phase.drop_objection(this);
  endtask

endclass



class gen_status_ro_uvm_test extends pkt_base_test;

  `uvm_component_utils(gen_status_ro_uvm_test)

  function new(string name = "gen_status_ro_uvm_test",
               uvm_component parent = null);
    super.new(name, parent);
  endfunction

  task run_phase(uvm_phase phase);
    gen_status_ro_sequence seq;

    phase.raise_objection(this);

    seq = gen_status_ro_sequence::type_id::create("seq");
    seq.regmodel = env.regmodel;
    seq.start(env.agent.sequencer);

    phase.drop_objection(this);
  endtask

endclass



class stat_rx_ro_uvm_test extends pkt_base_test;

  `uvm_component_utils(stat_rx_ro_uvm_test)

  function new(string name = "stat_rx_ro_uvm_test",
               uvm_component parent = null);
    super.new(name, parent);
  endfunction

  task run_phase(uvm_phase phase);
    stat_rx_ro_sequence seq;

    phase.raise_objection(this);

    seq = stat_rx_ro_sequence::type_id::create("seq");
    seq.regmodel = env.regmodel;
    seq.start(env.agent.sequencer);

    phase.drop_objection(this);
  endtask

endclass


class stat_tx_ro_uvm_test extends pkt_base_test;

  `uvm_component_utils(stat_tx_ro_uvm_test)

  function new(string name = "stat_tx_ro_uvm_test",
               uvm_component parent = null);
    super.new(name, parent);
  endfunction

  task run_phase(uvm_phase phase);
    stat_tx_ro_sequence seq;

    phase.raise_objection(this);

    seq = stat_tx_ro_sequence::type_id::create("seq");
    seq.regmodel = env.regmodel;
    seq.start(env.agent.sequencer);

    phase.drop_objection(this);
  endtask

endclass




class stat_drop_ro_uvm_test extends pkt_base_test;

  `uvm_component_utils(stat_drop_ro_uvm_test)

  function new(string name = "stat_drop_ro_uvm_test",
               uvm_component parent = null);
    super.new(name, parent);
  endfunction

  task run_phase(uvm_phase phase);
    stat_drop_ro_sequence seq;

    phase.raise_objection(this);

    seq = stat_drop_ro_sequence::type_id::create("seq");
    seq.regmodel = env.regmodel;
    seq.start(env.agent.sequencer);

    phase.drop_objection(this);
  endtask

endclass


class port_enable_uvm_test extends pkt_base_test;

  `uvm_component_utils(port_enable_uvm_test)

  function new(string name = "port_enable_uvm_test",
               uvm_component parent = null);
    super.new(name, parent);
  endfunction

  task run_phase(uvm_phase phase);
    port_enable_sequence seq;

    phase.raise_objection(this);

    seq = port_enable_sequence::type_id::create("seq");
    seq.regmodel = env.regmodel;
    seq.start(env.agent.sequencer);

    phase.drop_objection(this);
  endtask

endclass


class switch_ctrl_uvm_test extends pkt_base_test;

  `uvm_component_utils(switch_ctrl_uvm_test)

  function new(string name = "switch_ctrl_uvm_test",
               uvm_component parent = null);
    super.new(name, parent);
  endfunction

  task run_phase(uvm_phase phase);
    switch_ctrl_sequence seq;

    phase.raise_objection(this);

    seq = switch_ctrl_sequence::type_id::create("seq");
    seq.regmodel = env.regmodel;
    seq.start(env.agent.sequencer);

    phase.drop_objection(this);
  endtask

endclass



class fwd_enable_uvm_test extends pkt_base_test;

  `uvm_component_utils(fwd_enable_uvm_test)

  function new(string name = "fwd_enable_uvm_test",
               uvm_component parent = null);
    super.new(name, parent);
  endfunction

  task run_phase(uvm_phase phase);
    fwd_enable_sequence seq;

    phase.raise_objection(this);

    seq = fwd_enable_sequence::type_id::create("seq");
    seq.regmodel = env.regmodel;
    seq.start(env.agent.sequencer);

    phase.drop_objection(this);
  endtask

endclass


class gen_ctrl_uvm_test extends pkt_base_test;

  `uvm_component_utils(gen_ctrl_uvm_test)

  function new(string name = "gen_ctrl_uvm_test",
               uvm_component parent = null);
    super.new(name, parent);
  endfunction

  task run_phase(uvm_phase phase);
    gen_ctrl_sequence seq;

    phase.raise_objection(this);

    seq = gen_ctrl_sequence::type_id::create("seq");
    seq.regmodel = env.regmodel;
    seq.start(env.agent.sequencer);

    phase.drop_objection(this);
  endtask

endclass



class gen_pkt_cfg_uvm_test extends pkt_base_test;

  `uvm_component_utils(gen_pkt_cfg_uvm_test)

  function new(string name = "gen_pkt_cfg_uvm_test",
               uvm_component parent = null);
    super.new(name, parent);
  endfunction

  task run_phase(uvm_phase phase);
    gen_pkt_cfg_sequence seq;

    phase.raise_objection(this);

    seq = gen_pkt_cfg_sequence::type_id::create("seq");
    seq.regmodel = env.regmodel;
    seq.start(env.agent.sequencer);

    phase.drop_objection(this);
  endtask

endclass

class unaligned_address_test extends pkt_base_test;
  `uvm_component_utils(unaligned_address_test)


  function new(string name = "unaligned_address_test", uvm_component parent = null);
    super.new(name, parent);
  endfunction


  task run_phase(uvm_phase phase);
    unaligned_address_sequence seq;

    phase.raise_objection(this);
    seq = unaligned_address_sequence::type_id::create("seq");
  //  seq.regmodel = env.regmodel;
    seq.start(env.agent.sequencer);
    phase.drop_objection(this);
  endtask
endclass


class invalid_address_test extends pkt_base_test;
  `uvm_component_utils(invalid_address_test)

  function new(string name = "invalid_address_test", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  task run_phase(uvm_phase phase);
    invalid_address_sequence seq;

    phase.raise_objection(this);
    seq = invalid_address_sequence::type_id::create("seq");
//    seq.regmodel = env.regmodel;
    seq.start(env.agent.sequencer);
    phase.drop_objection(this);
  endtask
endclass



class gen_interval_uvm_test extends pkt_base_test;

  `uvm_component_utils(gen_interval_uvm_test)

  function new(string name = "gen_interval_uvm_test",
               uvm_component parent = null);
    super.new(name, parent);
  endfunction

  task run_phase(uvm_phase phase);
    gen_interval_sequence seq;

    phase.raise_objection(this);

    seq = gen_interval_sequence::type_id::create("seq");
    seq.regmodel = env.regmodel;
    seq.start(env.agent.sequencer);

    phase.drop_objection(this);
  endtask

endclass



class gen_count_uvm_test extends pkt_base_test;

  `uvm_component_utils(gen_count_uvm_test)

  function new(string name = "gen_count_uvm_test",
               uvm_component parent = null);
    super.new(name, parent);
  endfunction

  task run_phase(uvm_phase phase);
    gen_count_sequence seq;

    phase.raise_objection(this);

    seq = gen_count_sequence::type_id::create("seq");
    seq.regmodel = env.regmodel;
    seq.start(env.agent.sequencer);

    phase.drop_objection(this);
  endtask

endclass


class irq_status_uvm_test extends pkt_base_test;

  `uvm_component_utils(irq_status_uvm_test)

  function new(string name = "irq_status_uvm_test",
               uvm_component parent = null);
    super.new(name, parent);
  endfunction

  task run_phase(uvm_phase phase);
    irq_status_sequence seq;

    phase.raise_objection(this);

    seq = irq_status_sequence::type_id::create("seq");
    seq.regmodel = env.regmodel;
    seq.start(env.agent.sequencer);

    phase.drop_objection(this);
  endtask

endclass



class irq_enable_uvm_test extends pkt_base_test;

  `uvm_component_utils(irq_enable_uvm_test)

  function new(string name = "irq_enable_uvm_test",
               uvm_component parent = null);
    super.new(name, parent);
  endfunction

  task run_phase(uvm_phase phase);
    irq_enable_sequence seq;

    phase.raise_objection(this);

    seq = irq_enable_sequence::type_id::create("seq");
    seq.regmodel = env.regmodel;
    seq.start(env.agent.sequencer);

    phase.drop_objection(this);
  endtask

endclass


class irq_force_uvm_test extends pkt_base_test;

  `uvm_component_utils(irq_force_uvm_test)

  function new(string name = "irq_force_uvm_test",
               uvm_component parent = null);
    super.new(name, parent);
  endfunction

  task run_phase(uvm_phase phase);
    irq_force_sequence seq;

    phase.raise_objection(this);

    seq = irq_force_sequence::type_id::create("seq");
    seq.regmodel = env.regmodel;
    seq.start(env.agent.sequencer);

    phase.drop_objection(this);
  endtask

endclass



class err_status_uvm_test extends pkt_base_test;

  `uvm_component_utils(err_status_uvm_test)

  function new(string name = "err_status_uvm_test",
               uvm_component parent = null);
    super.new(name, parent);
  endfunction

  task run_phase(uvm_phase phase);
    err_status_sequence seq;

    phase.raise_objection(this);

    seq = err_status_sequence::type_id::create("seq");
    seq.regmodel = env.regmodel;
    seq.start(env.agent.sequencer);

    phase.drop_objection(this);
  endtask

endclass



class err_enable_uvm_test extends pkt_base_test;

  `uvm_component_utils(err_enable_uvm_test)

  function new(string name = "err_enable_uvm_test",
               uvm_component parent = null);
    super.new(name, parent);
  endfunction

  task run_phase(uvm_phase phase);
    err_enable_sequence seq;

    phase.raise_objection(this);

    seq = err_enable_sequence::type_id::create("seq");
    seq.regmodel = env.regmodel;
    seq.start(env.agent.sequencer);

    phase.drop_objection(this);
  endtask

endclass



class err_inject_uvm_test extends pkt_base_test;

  `uvm_component_utils(err_inject_uvm_test)

  function new(string name = "err_inject_uvm_test",
               uvm_component parent = null);
    super.new(name, parent);
  endfunction

  task run_phase(uvm_phase phase);
    err_inject_sequence seq;

    phase.raise_objection(this);

    seq = err_inject_sequence::type_id::create("seq");
    seq.regmodel = env.regmodel;
    seq.start(env.agent.sequencer);

    phase.drop_objection(this);
  endtask

endclass




class err_count_uvm_test extends pkt_base_test;

  `uvm_component_utils(err_count_uvm_test)

  function new(string name = "err_count_uvm_test",
               uvm_component parent = null);
    super.new(name, parent);
  endfunction

  task run_phase(uvm_phase phase);
    err_count_sequence seq;

    phase.raise_objection(this);

    seq = err_count_sequence::type_id::create("seq");
    seq.regmodel = env.regmodel;
    seq.start(env.agent.sequencer);

    phase.drop_objection(this);
  endtask

endclass


class err_info_uvm_test extends pkt_base_test;

  `uvm_component_utils(err_info_uvm_test)

  function new(string name = "err_info_uvm_test",
               uvm_component parent = null);
    super.new(name, parent);
  endfunction

  task run_phase(uvm_phase phase);
    err_info_sequence seq;

    phase.raise_objection(this);

    seq = err_info_sequence::type_id::create("seq");
    seq.regmodel = env.regmodel;
    seq.start(env.agent.sequencer);

    phase.drop_objection(this);
  endtask

endclass

class lock_uvm_test extends pkt_base_test;

  `uvm_component_utils(lock_uvm_test)

  function new(string name = "lock_uvm_test",
               uvm_component parent = null);
    super.new(name, parent);
  endfunction

  task run_phase(uvm_phase phase);
    lock_sequence seq;

    phase.raise_objection(this);

    seq = lock_sequence::type_id::create("seq");
    seq.regmodel = env.regmodel;
    seq.start(env.agent.sequencer);

    phase.drop_objection(this);
  endtask

endclass



class soft_reset_uvm_test extends pkt_base_test;

  `uvm_component_utils(soft_reset_uvm_test)

  function new(string name = "soft_reset_uvm_test",
               uvm_component parent = null);
    super.new(name, parent);
  endfunction

  task run_phase(uvm_phase phase);
    soft_reset_sequence seq;

    phase.raise_objection(this);

    seq = soft_reset_sequence::type_id::create("seq");
    seq.regmodel = env.regmodel;
    seq.start(env.agent.sequencer);

    phase.drop_objection(this);
  endtask

endclass



class reset_values_uvm_test extends pkt_base_test;
 
  `uvm_component_utils(reset_values_uvm_test)
 
  function new(string name = "reset_values_uvm_test",
               uvm_component parent = null);
    super.new(name, parent);
  endfunction
 
  task run_phase(uvm_phase phase);
    reset_values_sequence seq;
 
    phase.raise_objection(this);
 
    seq = reset_values_sequence::type_id::create("seq");
    seq.regmodel = env.regmodel;
    seq.start(env.agent.sequencer);
 
    phase.drop_objection(this);
  endtask
 
endclass



class generate_four_packets_test extends pkt_base_test;

  `uvm_component_utils(generate_four_packets_test)

  function new(string name = "generate_four_packets_test",
               uvm_component parent = null);
    super.new(name, parent);
  endfunction

  task run_phase(uvm_phase phase);
    generate_four_packets_sequence seq;

    phase.raise_objection(this);

    seq = generate_four_packets_sequence::type_id::create("seq");
    seq.regmodel = env.regmodel;
    seq.start(env.agent.sequencer);

    phase.drop_objection(this);
  endtask

endclass




class clear_sticky_status_test extends pkt_base_test;

  `uvm_component_utils(clear_sticky_status_test)

  function new(string name = "clear_sticky_status_test",
               uvm_component parent = null);
    super.new(name, parent);
  endfunction

  task run_phase(uvm_phase phase);
    clear_sticky_status_sequence seq;

    phase.raise_objection(this);

    seq = clear_sticky_status_sequence::type_id::create("seq");
    seq.regmodel = env.regmodel;
    seq.start(env.agent.sequencer);

    phase.drop_objection(this);
  endtask

endclass




class destination_drop_test extends pkt_base_test;

  `uvm_component_utils(destination_drop_test)

  function new(string name = "destination_drop_test",
               uvm_component parent = null);
    super.new(name, parent);
  endfunction

  task run_phase(uvm_phase phase);
    destination_drop_sequence seq;

    phase.raise_objection(this);

    seq = destination_drop_sequence::type_id::create("seq");
    seq.regmodel = env.regmodel;
    seq.start(env.agent.sequencer);

    phase.drop_objection(this);
  endtask

endclass

class pkt_regression_test extends pkt_base_test;
  `uvm_component_utils(pkt_regression_test)

  function new(string name = "pkt_regression_test", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  task run_phase(uvm_phase phase);
    pkt_regression_sequence seq;

    phase.raise_objection(this);

    seq = pkt_regression_sequence::type_id::create("seq");
    seq.regmodel = env.regmodel;
    seq.start(env.agent.sequencer);

    phase.drop_objection(this);
  endtask

endclass
