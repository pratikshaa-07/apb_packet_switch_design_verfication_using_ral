// class pkt_subscriber extends uvm_subscriber #(pkt_seq_item);
//   `uvm_component_utils(pkt_subscriber)

//   int unsigned read_count, write_count, error_count;

//   covergroup apb_cg with function sample(
//     bit wr, bit [15:0] addr, bit err
//   );
//     option.per_instance = 1;

//     cp_direction: coverpoint wr {
//       bins reads  = {0};
//       bins writes = {1};
//     }

//     cp_address: coverpoint addr {
//       bins legal_registers[] = {
//         'h00,'h04,'h08,'h0C,'h10,'h14,'h18,'h1C,
//         'h20,'h24,'h28,'h2C,'h30,'h34,'h38,'h3C,
//         'h40,'h44,'h48,'h4C,'h50,'h54,'h58,'h5C,'h60
//       };
//       bins unaligned = {'h02,'h06,'h12};
//       bins out_of_range = {[16'h0064:16'hFFFF]};
//     }

//     cp_error: coverpoint err {
//       bins pass = {0};
//       bins fail = {1};
//     }

//     direction_error: cross cp_direction, cp_error;
//   endgroup

//   function new(string name, uvm_component parent);
//     super.new(name,parent);
//     apb_cg = new();
//   endfunction

//   function void write(pkt_seq_item t);
//     if (t.write) write_count++;
//     else          read_count++;

//     if (t.slverr) error_count++;

//     apb_cg.sample(t.write,t.addr,t.slverr);
//   endfunction

//   function void report_phase(uvm_phase phase);
//     `uvm_info("PKT_COV",
//       $sformatf("Reads=%0d Writes=%0d Errors=%0d Coverage=%0.2f%%",
//         read_count,write_count,error_count,apb_cg.get_coverage()),
//       UVM_LOW)
//   endfunction
// endclass

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
//     agent.monitor.ap.connect(sub.analysis_fifo);
    agent.monitor.ap.connect(sub.analysis_fifo.analysis_export);
  endfunction
endclass
