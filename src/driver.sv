// class pkt_driver extends uvm_driver #(pkt_seq_item);
//   `uvm_component_utils(pkt_driver)

//   virtual pkt_interface vif;

//   function new(string name, uvm_component parent);
//     super.new(name,parent);
//   endfunction

//   function void build_phase(uvm_phase phase);
//     super.build_phase(phase);

//     if (!uvm_config_db#(virtual pkt_interface)::get(
//           this,"","vif",vif))
//       `uvm_fatal("NO_VIF","APB virtual interface not configured")
//   endfunction

//   task run_phase(uvm_phase phase);
//     pkt_seq_item req;

//     vif.driver_cb.psel    <= 0;
//     vif.driver_cb.penable <= 0;
//     vif.driver_cb.pwrite  <= 0;
//     vif.driver_cb.paddr   <= 0;
//     vif.driver_cb.pwdata  <= 0;

//     forever begin
//       seq_item_port.get_next_item(req);
//       drive_transfer(req);
//       seq_item_port.item_done();
//     end
//   endtask

//   task drive_transfer(pkt_seq_item tr);
//     @(vif.driver_cb);
//     wait(vif.presetn === 1'b1);

//     // apb setup
//     vif.driver_cb.psel    <= 1;
//     vif.driver_cb.penable <= 0;
//     vif.driver_cb.pwrite  <= tr.write;
//     vif.driver_cb.paddr   <= tr.addr;
//     vif.driver_cb.pwdata  <= tr.data;

//     // apb access
//     @(vif.driver_cb);
//     vif.driver_cb.penable <= 1;

//     do @(vif.driver_cb);
//     while (vif.driver_cb.pready !== 1'b1);

//     tr.rdata  = vif.driver_cb.prdata;
//     tr.slverr = vif.driver_cb.pslverr;

//     vif.driver_cb.psel    <= 0;
//     vif.driver_cb.penable <= 0;
//     vif.driver_cb.pwrite  <= 0;

//     @(vif.driver_cb);
//   endtask
// endclass

class pkt_driver extends uvm_driver #(pkt_seq_item);
  `uvm_component_utils(pkt_driver)

  virtual pkt_interface vif;

  function new(string name, uvm_component parent);
    super.new(name,parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    if (!uvm_config_db#(virtual pkt_interface)::get(
          this,"","vif",vif))
      `uvm_fatal("NO_VIF","APB virtual interface not configured")
  endfunction

  task run_phase(uvm_phase phase);
    pkt_seq_item req;

    vif.driver_cb.psel    <= 0;
    vif.driver_cb.penable <= 0;
    vif.driver_cb.pwrite  <= 0;
    vif.driver_cb.paddr   <= 0;
    vif.driver_cb.pwdata  <= 0;
    repeat(3)@(vif.driver_cb);
    forever begin
      seq_item_port.get_next_item(req);
      drive_transfer(req);
      seq_item_port.item_done();
    end
  endtask

  task drive_transfer(pkt_seq_item tr);
    // apb setup
    vif.driver_cb.psel    <= 1;
    vif.driver_cb.penable <= 0;
    vif.driver_cb.pwrite  <= tr.write;
    vif.driver_cb.paddr   <= tr.addr;
    vif.driver_cb.pwdata  <= tr.data;

    // apb access
    @(vif.driver_cb);
    vif.driver_cb.penable <= 1;
    wait(vif.driver_cb.pready);
    
    if(tr.write)
      tr.rdata=vif.driver_cb.prdata;
    
    @(vif.driver_cb);
    vif.driver_cb.psel    <= 0;
    vif.driver_cb.penable <= 0;
    vif.driver_cb.pwrite  <= 0;
    
    //tr.slverr = vif.driver_cb.pslverr;
    @(vif.driver_cb);
  endtask
endclass
