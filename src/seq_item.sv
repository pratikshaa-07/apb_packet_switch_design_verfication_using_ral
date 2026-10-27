class pkt_seq_item extends uvm_sequence_item;
  `uvm_object_utils(pkt_seq_item)

  rand bit        write;
  rand bit [15:0] addr;
  rand bit [31:0] data;

       bit [31:0] rdata;
       bit        slverr;

  function new(string name="pkt_seq_item");
    super.new(name);
  endfunction

endclass
