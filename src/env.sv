class pkt_env extends uvm_env;
  `uvm_component_utils(pkt_env)

  pkt_agent       agent;
  pkt_reg_block   regmodel;
  pkt_adapter     adapter;
  uvm_reg_predictor #(pkt_seq_item)   predictor;
  subscriber  sub;

  function new(string name, uvm_component parent);
    super.new(name,parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    agent= pkt_agent::type_id::create("agent",this);

    regmodel=pkt_reg_block::type_id::create("regmodel",this);
    regmodel.build();

    adapter=pkt_adapter::type_id::create("adapter");

    predictor=uvm_reg_predictor#(pkt_seq_item) ::type_id::create("predictor",this);
    sub=subscriber::type_id::create("sub",this);
  endfunction

  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);

    regmodel.apb_map.set_sequencer(agent.sequencer,adapter);
    regmodel.apb_map.set_auto_predict(0);

    predictor.map     = regmodel.apb_map;
    predictor.adapter = adapter;

    agent.monitor.ap.connect(predictor.bus_in);
    agent.monitor.ap.connect(sub.analysis_fifo);
  endfunction
endclass
