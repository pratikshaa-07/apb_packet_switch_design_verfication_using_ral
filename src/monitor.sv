class pkt_monitor extends uvm_component;
  `uvm_component_utils(pkt_monitor)

  virtual pkt_interface vif;
  uvm_analysis_port #(pkt_seq_item) ap;

  function new(string name, uvm_component parent);
    super.new(name,parent);
    ap = new("ap",this);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    if (!uvm_config_db#(virtual pkt_interface)::get(
          this,"","vif",vif))
      `uvm_fatal("NO_VIF","APB virtual interface not configured")
  endfunction

  task run_phase(uvm_phase phase);
    pkt_seq_item tr;
    repeat(4)@(vif.monitor_cb);
    forever 
      begin
        wait(vif.monitor_cb.psel &&vif.monitor_cb.penable &&vif.monitor_cb.pready)
        tr = pkt_seq_item::type_id::create("tr");
        tr.write  = vif.monitor_cb.pwrite;
        tr.addr   = vif.monitor_cb.paddr;
        tr.data   = vif.monitor_cb.pwdata;
        tr.rdata  = vif.monitor_cb.prdata;
        tr.slverr = vif.monitor_cb.pslverr;
        ap.write(tr);
        @(vif.monitor_cb);
    end
  endtask
endclass
