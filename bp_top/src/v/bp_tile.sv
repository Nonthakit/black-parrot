/**
 *
 * bp_tile.v
 *
 */

`include "bp_common_defines.svh"
`include "bp_top_defines.svh"

module bp_tile
 import bp_common_pkg::*;
 import bp_be_pkg::*;
 import bsg_noc_pkg::*;
 import bsg_wormhole_router_pkg::*;
 import bp_me_pkg::*;
 #(parameter bp_params_e bp_params_p = e_bp_default_cfg
   `declare_bp_proc_params(bp_params_p)
   `declare_bp_bedrock_lce_if_widths(paddr_width_p, cce_block_width_p, lce_id_width_p, cce_id_width_p, lce_assoc_p, lce)
   `declare_bp_bedrock_mem_if_widths(paddr_width_p, cce_block_width_p, lce_id_width_p, lce_assoc_p, cce)
   `declare_bp_bedrock_mem_if_widths(paddr_width_p, dword_width_gp, lce_id_width_p, lce_assoc_p, xce)

    , localparam cfg_bus_width_lp        = `bp_cfg_bus_width(domain_width_p, core_id_width_p, cce_id_width_p, lce_id_width_p)
   // Wormhole parameters
   , localparam coh_noc_ral_link_width_lp = `bsg_ready_and_link_sif_width(coh_noc_flit_width_p)
   , localparam mem_noc_ral_link_width_lp = `bsg_ready_and_link_sif_width(mem_noc_flit_width_p)
   )
  (input                                                      clk_i
   , input                                                    reset_i

   // Memory side connection
   , input [io_noc_did_width_p-1:0]                           my_did_i
   , input [io_noc_did_width_p-1:0]                           host_did_i
   , input [coh_noc_cord_width_p-1:0]                         my_cord_i

   , input [coh_noc_ral_link_width_lp-1:0]                    lce_req_link_i
   , output [coh_noc_ral_link_width_lp-1:0]                   lce_req_link_o

   , input [coh_noc_ral_link_width_lp-1:0]                    lce_cmd_link_i
   , output [coh_noc_ral_link_width_lp-1:0]                   lce_cmd_link_o

   , input [coh_noc_ral_link_width_lp-1:0]                    lce_resp_link_i
   , output [coh_noc_ral_link_width_lp-1:0]                   lce_resp_link_o

   , output [mem_noc_ral_link_width_lp-1:0]                   mem_cmd_link_o
   , input [mem_noc_ral_link_width_lp-1:0]                    mem_resp_link_i
   );

  `declare_bp_cfg_bus_s(domain_width_p, core_id_width_p, cce_id_width_p, lce_id_width_p);
  `declare_bp_bedrock_lce_if(paddr_width_p, cce_block_width_p, lce_id_width_p, cce_id_width_p, lce_assoc_p, lce);
  `declare_bp_bedrock_mem_if(paddr_width_p, cce_block_width_p, lce_id_width_p, lce_assoc_p, cce);
  `declare_bp_bedrock_mem_if(paddr_width_p, dword_width_gp, lce_id_width_p, lce_assoc_p, xce);
  `declare_bp_memory_map(paddr_width_p, caddr_width_p);

  // Cast the routing links
  `declare_bsg_ready_and_link_sif_s(coh_noc_flit_width_p, bp_coh_ready_and_link_s);
  `declare_bsg_ready_and_link_sif_s(mem_noc_flit_width_p, bp_mem_ready_and_link_s);

  bp_coh_ready_and_link_s lce_req_link_cast_i, lce_req_link_cast_o;
  bp_coh_ready_and_link_s lce_resp_link_cast_i, lce_resp_link_cast_o;
  bp_coh_ready_and_link_s lce_cmd_link_cast_i, lce_cmd_link_cast_o;

  assign lce_req_link_cast_i  = lce_req_link_i;
  assign lce_cmd_link_cast_i  = lce_cmd_link_i;
  assign lce_resp_link_cast_i = lce_resp_link_i;

  assign lce_req_link_o  = lce_req_link_cast_o;
  assign lce_cmd_link_o  = lce_cmd_link_cast_o;
  assign lce_resp_link_o = lce_resp_link_cast_o;

  logic timer_irq_li, software_irq_li, external_irq_li;

  // Proc-side connections network connections
  bp_bedrock_lce_req_msg_s [1:0] lce_req_lo;
  logic [1:0] lce_req_v_lo, lce_req_ready_li;
  bp_bedrock_lce_resp_msg_s [1:0] lce_resp_lo;
  logic [1:0] lce_resp_v_lo, lce_resp_ready_li;
  bp_bedrock_lce_cmd_msg_s [1:0] lce_cmd_li;
  logic [1:0] lce_cmd_v_li, lce_cmd_yumi_lo;
  bp_bedrock_lce_cmd_msg_s [1:0] lce_cmd_lo;
  logic [1:0] lce_cmd_v_lo, lce_cmd_ready_li;

  // CCE connections
  bp_bedrock_lce_req_msg_s cce_lce_req_li;
  logic cce_lce_req_v_li, cce_lce_req_yumi_lo;
  bp_bedrock_lce_cmd_msg_s cce_lce_cmd_lo;
  logic cce_lce_cmd_v_lo, cce_lce_cmd_ready_li;
  bp_bedrock_lce_resp_msg_s cce_lce_resp_li;
  logic cce_lce_resp_v_li, cce_lce_resp_yumi_lo;

  // Mem connections
  bp_bedrock_cce_mem_msg_s cce_mem_cmd_lo;
  logic cce_mem_cmd_v_lo, cce_mem_cmd_ready_li;
  bp_bedrock_cce_mem_msg_s cce_mem_resp_li;
  logic cce_mem_resp_v_li, cce_mem_resp_yumi_lo;

  bp_bedrock_cce_mem_msg_s loopback_mem_cmd_li;
  bp_bedrock_xce_mem_msg_s loopback_mem_cmd;
  logic loopback_mem_cmd_v_li, loopback_mem_cmd_ready_lo;
  bp_bedrock_cce_mem_msg_s loopback_mem_resp_lo;
  bp_bedrock_xce_mem_msg_s loopback_mem_resp;
  logic loopback_mem_resp_v_lo, loopback_mem_resp_yumi_li;
  assign loopback_mem_cmd = '{header: loopback_mem_cmd_li.header
                             ,data: loopback_mem_cmd_li.data[0+:dword_width_gp]
                             };
  assign loopback_mem_resp_lo = '{header: loopback_mem_resp.header
                                 ,data: {cce_block_width_p/dword_width_gp{loopback_mem_resp.data}}
                                 };

  bp_bedrock_cce_mem_msg_s cache_mem_cmd_li;
  logic cache_mem_cmd_v_li, cache_mem_cmd_ready_lo;
  bp_bedrock_cce_mem_msg_s cache_mem_resp_lo;
  logic cache_mem_resp_v_lo, cache_mem_resp_yumi_li;

  bp_bedrock_cce_mem_msg_s cfg_mem_cmd_li;
  bp_bedrock_xce_mem_msg_s cfg_mem_cmd;
  logic cfg_mem_cmd_v_li, cfg_mem_cmd_ready_lo;
  bp_bedrock_cce_mem_msg_s cfg_mem_resp_lo;
  bp_bedrock_xce_mem_msg_s cfg_mem_resp;
  logic cfg_mem_resp_v_lo, cfg_mem_resp_yumi_li;
  assign cfg_mem_cmd = '{header: cfg_mem_cmd_li.header
                        ,data: cfg_mem_cmd_li.data[0+:dword_width_gp]
                        };
  assign cfg_mem_resp_lo = '{header: cfg_mem_resp.header
                            ,data: {cce_block_width_p/dword_width_gp{cfg_mem_resp.data}}
                            };

  bp_bedrock_cce_mem_msg_s clint_mem_cmd_li;
  bp_bedrock_xce_mem_msg_s clint_mem_cmd;
  logic clint_mem_cmd_v_li, clint_mem_cmd_ready_lo;
  bp_bedrock_cce_mem_msg_s clint_mem_resp_lo;
  bp_bedrock_xce_mem_msg_s clint_mem_resp;
  logic clint_mem_resp_v_lo, clint_mem_resp_yumi_li;
  assign clint_mem_cmd = '{header: clint_mem_cmd_li.header
                          ,data: clint_mem_cmd_li.data[0+:dword_width_gp]
                          };
  assign clint_mem_resp_lo = '{header: clint_mem_resp.header
                              ,data: {cce_block_width_p/dword_width_gp{clint_mem_resp.data}}
                              };

  logic reset_r;
  always_ff @(posedge clk_i)
    reset_r <= reset_i;

  bp_cfg_bus_s cfg_bus_lo;
  logic cce_ucode_v_lo;
  logic cce_ucode_w_lo;
  logic [cce_pc_width_p-1:0] cce_ucode_addr_lo;
  logic [cce_instr_width_gp-1:0] cce_ucode_data_lo, cce_ucode_data_li;
  bp_cfg
   #(.bp_params_p(bp_params_p))
   cfg
    (.clk_i(clk_i)
     ,.reset_i(reset_r)

     ,.mem_cmd_i(cfg_mem_cmd)
     ,.mem_cmd_v_i(cfg_mem_cmd_v_li)
     ,.mem_cmd_ready_o(cfg_mem_cmd_ready_lo)

     ,.mem_resp_o(cfg_mem_resp)
     ,.mem_resp_v_o(cfg_mem_resp_v_lo)
     ,.mem_resp_yumi_i(cfg_mem_resp_yumi_li)

     ,.cfg_bus_o(cfg_bus_lo)
     ,.did_i(my_did_i)
     ,.host_did_i(host_did_i)
     ,.cord_i(my_cord_i)

     ,.cce_ucode_v_o(cce_ucode_v_lo)
     ,.cce_ucode_w_o(cce_ucode_w_lo)
     ,.cce_ucode_addr_o(cce_ucode_addr_lo)
     ,.cce_ucode_data_o(cce_ucode_data_lo)
     ,.cce_ucode_data_i(cce_ucode_data_li)
     );

  bp_clint_slice
   #(.bp_params_p(bp_params_p))
   clint
    (.clk_i(clk_i)
     ,.reset_i(reset_r)

     ,.mem_cmd_i(clint_mem_cmd)
     ,.mem_cmd_v_i(clint_mem_cmd_v_li)
     ,.mem_cmd_ready_o(clint_mem_cmd_ready_lo)

     ,.mem_resp_o(clint_mem_resp)
     ,.mem_resp_v_o(clint_mem_resp_v_lo)
     ,.mem_resp_yumi_i(clint_mem_resp_yumi_li)

     ,.timer_irq_o(timer_irq_li)
     ,.software_irq_o(software_irq_li)
     ,.external_irq_o(external_irq_li)
     );

  // Module instantiations
  bp_core
   #(.bp_params_p(bp_params_p))
   core
    (.clk_i(clk_i)
     ,.reset_i(reset_r)

     ,.cfg_bus_i(cfg_bus_lo)

     ,.lce_req_o(lce_req_lo)
     ,.lce_req_v_o(lce_req_v_lo)
     ,.lce_req_ready_i(lce_req_ready_li)

     ,.lce_cmd_i(lce_cmd_li)
     ,.lce_cmd_v_i(lce_cmd_v_li)
     ,.lce_cmd_yumi_o(lce_cmd_yumi_lo)

     ,.lce_cmd_o(lce_cmd_lo)
     ,.lce_cmd_v_o(lce_cmd_v_lo)
     ,.lce_cmd_ready_i(lce_cmd_ready_li)

     ,.lce_resp_o(lce_resp_lo)
     ,.lce_resp_v_o(lce_resp_v_lo)
     ,.lce_resp_ready_i(lce_resp_ready_li)

     ,.timer_irq_i(timer_irq_li)
     ,.software_irq_i(software_irq_li)
     ,.external_irq_i(external_irq_li)
     );

  bp_cce_wrapper
   #(.bp_params_p(bp_params_p))
   cce
    (.clk_i(clk_i)
     ,.reset_i(reset_r)

     ,.cfg_bus_i(cfg_bus_lo)

     ,.ucode_v_i(cce_ucode_v_lo)
     ,.ucode_w_i(cce_ucode_w_lo)
     ,.ucode_addr_i(cce_ucode_addr_lo)
     ,.ucode_data_i(cce_ucode_data_lo)
     ,.ucode_data_o(cce_ucode_data_li)

     ,.lce_req_i(cce_lce_req_li)
     ,.lce_req_v_i(cce_lce_req_v_li)
     ,.lce_req_yumi_o(cce_lce_req_yumi_lo)

     ,.lce_cmd_o(cce_lce_cmd_lo)
     ,.lce_cmd_v_o(cce_lce_cmd_v_lo)
     ,.lce_cmd_ready_i(cce_lce_cmd_ready_li)

     ,.lce_resp_i(cce_lce_resp_li)
     ,.lce_resp_v_i(cce_lce_resp_v_li)
     ,.lce_resp_yumi_o(cce_lce_resp_yumi_lo)

     ,.mem_cmd_o(cce_mem_cmd_lo)
     ,.mem_cmd_v_o(cce_mem_cmd_v_lo)
     ,.mem_cmd_ready_i(cce_mem_cmd_ready_li)

     ,.mem_resp_i(cce_mem_resp_li)
     ,.mem_resp_v_i(cce_mem_resp_v_li)
     ,.mem_resp_yumi_o(cce_mem_resp_yumi_lo)
     );

  `declare_bp_lce_req_wormhole_packet_s(coh_noc_flit_width_p, coh_noc_cord_width_p, coh_noc_len_width_p, coh_noc_cid_width_p, bp_bedrock_lce_req_msg_header_s, cce_block_width_p);
  localparam lce_req_wh_payload_width_lp = `bp_coh_wormhole_payload_width(coh_noc_flit_width_p, coh_noc_cord_width_p, coh_noc_len_width_p, coh_noc_cid_width_p, $bits(bp_bedrock_lce_req_msg_header_s), cce_block_width_p);
  bp_lce_req_wormhole_packet_s [1:0] lce_req_packet_lo;
  bp_lce_req_wormhole_header_s [1:0] lce_req_header_lo;

  `declare_bp_lce_cmd_wormhole_packet_s(coh_noc_flit_width_p, coh_noc_cord_width_p, coh_noc_len_width_p, coh_noc_cid_width_p, bp_bedrock_lce_cmd_msg_header_s, cce_block_width_p);
  localparam lce_cmd_wh_payload_width_lp = `bp_coh_wormhole_payload_width(coh_noc_flit_width_p, coh_noc_cord_width_p, coh_noc_len_width_p, coh_noc_cid_width_p, $bits(bp_bedrock_lce_cmd_msg_header_s), cce_block_width_p);
  bp_lce_cmd_wormhole_packet_s [1:0] lce_cmd_packet_lo, lce_cmd_packet_li;
  bp_lce_cmd_wormhole_header_s [1:0] lce_cmd_header_lo, lce_cmd_header_li;

  `declare_bp_lce_resp_wormhole_packet_s(coh_noc_flit_width_p, coh_noc_cord_width_p, coh_noc_len_width_p, coh_noc_cid_width_p, bp_bedrock_lce_resp_msg_header_s, cce_block_width_p);
  localparam lce_resp_wh_payload_width_lp = `bp_coh_wormhole_payload_width(coh_noc_flit_width_p, coh_noc_cord_width_p, coh_noc_len_width_p, coh_noc_cid_width_p, $bits(bp_bedrock_lce_resp_msg_header_s), cce_block_width_p);
  bp_lce_resp_wormhole_packet_s [1:0] lce_resp_packet_lo;
  bp_lce_resp_wormhole_header_s [1:0] lce_resp_header_lo;

  bp_coh_ready_and_link_s [1:0] lce_req_link_li, lce_req_link_lo;
  bp_coh_ready_and_link_s [1:0] lce_cmd_link_li, lce_cmd_link_lo;
  bp_coh_ready_and_link_s [1:0] lce_resp_link_li, lce_resp_link_lo;

  bp_coh_ready_and_link_s cce_lce_req_link_li, cce_lce_req_link_lo;
  bp_coh_ready_and_link_s cce_lce_cmd_link_li, cce_lce_cmd_link_lo;
  bp_coh_ready_and_link_s cce_lce_resp_link_li, cce_lce_resp_link_lo;

  for (genvar i = 0; i < 2; i++)
    begin : lce
      bp_me_wormhole_packet_encode_lce_req
       #(.bp_params_p(bp_params_p)
         )
       req_encode
        (.lce_req_header_i(lce_req_lo[i].header)
         ,.wh_header_o(lce_req_header_lo[i])
         );
      assign lce_req_packet_lo[i] = '{header: lce_req_header_lo[i], data: lce_req_lo[i].data};

      bsg_wormhole_router_adapter_in
       #(.max_payload_width_p(lce_req_wh_payload_width_lp)
         ,.len_width_p(coh_noc_len_width_p)
         ,.cord_width_p(coh_noc_cord_width_p)
         ,.flit_width_p(coh_noc_flit_width_p)
         )
       lce_req_adapter_in
        (.clk_i(clk_i)
         ,.reset_i(reset_r)

         ,.packet_i(lce_req_packet_lo[i])
         ,.v_i(lce_req_v_lo[i])
         ,.ready_o(lce_req_ready_li[i])

         ,.link_i(lce_req_link_li[i])
         ,.link_o(lce_req_link_lo[i])
         );

      bp_me_wormhole_packet_encode_lce_cmd
       #(.bp_params_p(bp_params_p))
       cmd_encode
        (.lce_cmd_header_i(lce_cmd_lo[i].header)
         ,.wh_header_o(lce_cmd_header_lo[i])
         );
      assign lce_cmd_packet_lo[i] = '{header: lce_cmd_header_lo[i], data: lce_cmd_lo[i].data};

      bsg_wormhole_router_adapter
       #(.max_payload_width_p(lce_cmd_wh_payload_width_lp)
         ,.len_width_p(coh_noc_len_width_p)
         ,.cord_width_p(coh_noc_cord_width_p)
         ,.flit_width_p(coh_noc_flit_width_p)
         )
       cmd_adapter
        (.clk_i(clk_i)
         ,.reset_i(reset_r)

         ,.packet_i(lce_cmd_packet_lo[i])
         ,.v_i(lce_cmd_v_lo[i])
         ,.ready_o(lce_cmd_ready_li[i])

         ,.link_i(lce_cmd_link_li[i])
         ,.link_o(lce_cmd_link_lo[i])

         ,.packet_o(lce_cmd_packet_li[i])
         ,.v_o(lce_cmd_v_li[i])
         ,.yumi_i(lce_cmd_yumi_lo[i])
         );
      assign lce_cmd_li[i] = '{header: lce_cmd_packet_li[i].header.msg_hdr, data: lce_cmd_packet_li[i].data};

      bp_me_wormhole_packet_encode_lce_resp
       #(.bp_params_p(bp_params_p))
       resp_encode
        (.lce_resp_header_i(lce_resp_lo[i].header)
         ,.wh_header_o(lce_resp_header_lo[i])
         );
      assign lce_resp_packet_lo[i] = '{header: lce_resp_header_lo[i], data: lce_resp_lo[i].data};

      bsg_wormhole_router_adapter_in
       #(.max_payload_width_p(lce_resp_wh_payload_width_lp)
         ,.len_width_p(coh_noc_len_width_p)
         ,.cord_width_p(coh_noc_cord_width_p)
         ,.flit_width_p(coh_noc_flit_width_p)
         )
       lce_resp_adapter_in
        (.clk_i(clk_i)
         ,.reset_i(reset_r)

         ,.packet_i(lce_resp_packet_lo[i])
         ,.v_i(lce_resp_v_lo[i])
         ,.ready_o(lce_resp_ready_li[i])

         ,.link_i(lce_resp_link_li[i])
         ,.link_o(lce_resp_link_lo[i])
         );
    end

  bp_lce_req_wormhole_packet_s cce_lce_req_packet_li;
  bsg_wormhole_router_adapter_out
   #(.max_payload_width_p(lce_req_wh_payload_width_lp)
     ,.len_width_p(coh_noc_len_width_p)
     ,.cord_width_p(coh_noc_cord_width_p)
     ,.flit_width_p(coh_noc_flit_width_p)
     )
   cce_req_adapter_out
   (.clk_i(clk_i)
    ,.reset_i(reset_r)

    ,.link_i(lce_req_link_cast_i)
    ,.link_o(cce_lce_req_link_lo)

    ,.packet_o(cce_lce_req_packet_li)
    ,.v_o(cce_lce_req_v_li)
    ,.yumi_i(cce_lce_req_yumi_lo)
    );
  assign cce_lce_req_li = '{header: cce_lce_req_packet_li.header.msg_hdr, data: cce_lce_req_packet_li.data};

  bp_lce_cmd_wormhole_packet_s cce_lce_cmd_packet_lo;
  bp_lce_cmd_wormhole_header_s cce_lce_cmd_header_lo;
  bp_me_wormhole_packet_encode_lce_cmd
   #(.bp_params_p(bp_params_p))
   cmd_encode
    (.lce_cmd_header_i(cce_lce_cmd_lo.header)
     ,.wh_header_o(cce_lce_cmd_header_lo)
     );
  assign cce_lce_cmd_packet_lo = '{header: cce_lce_cmd_header_lo, data: cce_lce_cmd_lo.data};

  bsg_wormhole_router_adapter_in
   #(.max_payload_width_p(lce_cmd_wh_payload_width_lp)
     ,.len_width_p(coh_noc_len_width_p)
     ,.cord_width_p(coh_noc_cord_width_p)
     ,.flit_width_p(coh_noc_flit_width_p)
     )
   cmd_adapter_in
    (.clk_i(clk_i)
     ,.reset_i(reset_r)

     ,.packet_i(cce_lce_cmd_packet_lo)
     ,.v_i(cce_lce_cmd_v_lo)
     ,.ready_o(cce_lce_cmd_ready_li)

     ,.link_i(cce_lce_cmd_link_li)
     ,.link_o(cce_lce_cmd_link_lo)
     );

  bp_lce_resp_wormhole_packet_s cce_lce_resp_packet_li;
  bsg_wormhole_router_adapter_out
   #(.max_payload_width_p(lce_resp_wh_payload_width_lp)
     ,.len_width_p(coh_noc_len_width_p)
     ,.cord_width_p(coh_noc_cord_width_p)
     ,.flit_width_p(coh_noc_flit_width_p)
     )
   cce_resp_adapter_out
   (.clk_i(clk_i)
    ,.reset_i(reset_r)

    ,.link_i(lce_resp_link_cast_i)
    ,.link_o(cce_lce_resp_link_lo)

    ,.packet_o(cce_lce_resp_packet_li)
    ,.v_o(cce_lce_resp_v_li)
    ,.yumi_i(cce_lce_resp_yumi_lo)
    );
  assign cce_lce_resp_li = '{header: cce_lce_resp_packet_li.header.msg_hdr, data: cce_lce_resp_packet_li.data};

  bp_coh_ready_and_link_s req_concentrated_link_li, req_concentrated_link_lo;
  bp_coh_ready_and_link_s cmd_concentrated_link_li, cmd_concentrated_link_lo;
  bp_coh_ready_and_link_s resp_concentrated_link_li, resp_concentrated_link_lo;

  assign req_concentrated_link_li = lce_req_link_cast_i;
  assign lce_req_link_cast_o = '{data          : req_concentrated_link_lo.data
                                 ,v            : req_concentrated_link_lo.v
                                 ,ready_and_rev: cce_lce_req_link_lo.ready_and_rev
                                 };
  bsg_wormhole_concentrator_in
   #(.flit_width_p(coh_noc_flit_width_p)
     ,.len_width_p(coh_noc_len_width_p)
     ,.cid_width_p(coh_noc_cid_width_p)
     ,.num_in_p(2)
     ,.cord_width_p(coh_noc_cord_width_p)
     )
   req_concentrator
    (.clk_i(clk_i)
     ,.reset_i(reset_r)

     ,.links_i(lce_req_link_lo)
     ,.links_o(lce_req_link_li)

     ,.concentrated_link_i(req_concentrated_link_li)
     ,.concentrated_link_o(req_concentrated_link_lo)
     );

  assign cmd_concentrated_link_li = lce_cmd_link_cast_i;
  assign lce_cmd_link_cast_o = cmd_concentrated_link_lo;
  bsg_wormhole_concentrator
   #(.flit_width_p(coh_noc_flit_width_p)
     ,.len_width_p(coh_noc_len_width_p)
     ,.cid_width_p(coh_noc_cid_width_p)
     ,.num_in_p(3)
     ,.cord_width_p(coh_noc_cord_width_p)
     )
   cmd_concentrator
    (.clk_i(clk_i)
     ,.reset_i(reset_r)

     ,.links_i({cce_lce_cmd_link_lo, lce_cmd_link_lo})
     ,.links_o({cce_lce_cmd_link_li, lce_cmd_link_li})

     ,.concentrated_link_i(cmd_concentrated_link_li)
     ,.concentrated_link_o(cmd_concentrated_link_lo)
     );

  assign resp_concentrated_link_li = lce_resp_link_cast_i;
  assign lce_resp_link_cast_o = '{data          : resp_concentrated_link_lo.data
                                  ,v            : resp_concentrated_link_lo.v
                                  ,ready_and_rev: cce_lce_resp_link_lo.ready_and_rev
                                  };
  bsg_wormhole_concentrator_in
   #(.flit_width_p(coh_noc_flit_width_p)
     ,.len_width_p(coh_noc_len_width_p)
     ,.cid_width_p(coh_noc_cid_width_p)
     ,.num_in_p(2)
     ,.cord_width_p(coh_noc_cord_width_p)
     )
   resp_concentrator
    (.clk_i(clk_i)
     ,.reset_i(reset_r)

     ,.links_i(lce_resp_link_lo)
     ,.links_o(lce_resp_link_li)

     ,.concentrated_link_i(resp_concentrated_link_li)
     ,.concentrated_link_o(resp_concentrated_link_lo)
     );

  bp_local_addr_s local_addr_cast;
  assign local_addr_cast = cce_mem_cmd_lo.header.addr;
  wire [dev_id_width_gp-1:0] device_cmd_li = local_addr_cast.dev;

  wire local_cmd_li        = (cce_mem_cmd_lo.header.addr < dram_base_addr_gp);
  wire is_cfg_cmd          = local_cmd_li & (device_cmd_li == cfg_dev_gp);
  wire is_clint_cmd        = local_cmd_li & (device_cmd_li == clint_dev_gp);
  wire is_cache_cmd        = ~local_cmd_li || (local_cmd_li & (device_cmd_li == cache_dev_gp));
  wire is_loopback_cmd     = local_cmd_li & ~is_cfg_cmd & ~is_clint_cmd & ~is_cache_cmd;

  assign cfg_mem_cmd_v_li      = is_cfg_cmd   & cce_mem_cmd_v_lo;
  assign clint_mem_cmd_v_li    = is_clint_cmd & cce_mem_cmd_v_lo;
  assign cache_mem_cmd_v_li    = is_cache_cmd & cce_mem_cmd_v_lo;
  assign loopback_mem_cmd_v_li = is_loopback_cmd & cce_mem_cmd_v_lo;

  assign cce_mem_cmd_ready_li = &{loopback_mem_cmd_ready_lo, cache_mem_cmd_ready_lo, cfg_mem_cmd_ready_lo, clint_mem_cmd_ready_lo};

  assign {loopback_mem_cmd_li, cache_mem_cmd_li, clint_mem_cmd_li, cfg_mem_cmd_li} = {4{cce_mem_cmd_lo}};

  logic loopback_mem_resp_grant_li, clint_mem_resp_grant_li, cfg_mem_resp_grant_li, cache_mem_resp_grant_li;
  bsg_arb_fixed
   #(.inputs_p(4), .lo_to_hi_p(1))
   resp_arb
    (.ready_i(1'b1)
     ,.reqs_i({loopback_mem_resp_v_lo, clint_mem_resp_v_lo, cfg_mem_resp_v_lo, cache_mem_resp_v_lo})
     ,.grants_o({loopback_mem_resp_grant_li, clint_mem_resp_grant_li, cfg_mem_resp_grant_li, cache_mem_resp_grant_li})
     );

  bsg_mux_one_hot
   #(.width_p($bits(bp_bedrock_cce_mem_msg_s)), .els_p(4))
   resp_select
    (.data_i({loopback_mem_resp_lo, clint_mem_resp_lo, cfg_mem_resp_lo, cache_mem_resp_lo})
     ,.sel_one_hot_i({loopback_mem_resp_grant_li, clint_mem_resp_grant_li, cfg_mem_resp_grant_li, cache_mem_resp_grant_li})
     ,.data_o(cce_mem_resp_li)
     );
  assign cce_mem_resp_v_li = |{loopback_mem_resp_v_lo, clint_mem_resp_v_lo, cfg_mem_resp_v_lo, cache_mem_resp_v_lo};
  assign cache_mem_resp_yumi_li    = cce_mem_resp_yumi_lo & cache_mem_resp_grant_li;
  assign cfg_mem_resp_yumi_li      = cce_mem_resp_yumi_lo & cfg_mem_resp_grant_li;
  assign clint_mem_resp_yumi_li    = cce_mem_resp_yumi_lo & clint_mem_resp_grant_li;
  assign loopback_mem_resp_yumi_li = cce_mem_resp_yumi_lo & loopback_mem_resp_grant_li;

  import bsg_cache_pkg::*;
  `declare_bsg_cache_pkt_s(caddr_width_p, l2_data_width_p);
  bsg_cache_pkt_s cache_pkt_li;
  logic cache_pkt_v_li, cache_pkt_ready_lo;
  logic [l2_data_width_p-1:0] cache_data_lo;
  logic cache_data_v_lo, cache_data_yumi_li;
  bp_me_cce_to_cache
   #(.bp_params_p(bp_params_p))
   cce_to_cache
    (.clk_i(clk_i)
     ,.reset_i(reset_r)

     ,.mem_cmd_i(cache_mem_cmd_li)
     ,.mem_cmd_v_i(cache_mem_cmd_v_li)
     ,.mem_cmd_ready_o(cache_mem_cmd_ready_lo)

     ,.mem_resp_o(cache_mem_resp_lo)
     ,.mem_resp_v_o(cache_mem_resp_v_lo)
     ,.mem_resp_yumi_i(cache_mem_resp_yumi_li)

     ,.cache_pkt_o(cache_pkt_li)
     ,.v_o(cache_pkt_v_li)
     ,.ready_i(cache_pkt_ready_lo)

     ,.data_i(cache_data_lo)
     ,.v_i(cache_data_v_lo)
     ,.yumi_o(cache_data_yumi_li)
     );

  `declare_bsg_cache_dma_pkt_s(caddr_width_p);
  bsg_cache_dma_pkt_s dma_pkt_lo;
  logic dma_pkt_v_lo, dma_pkt_yumi_li;
  logic [l2_fill_width_p-1:0] dma_data_li;
  logic dma_data_v_li, dma_data_ready_and_lo;
  logic [l2_fill_width_p-1:0] dma_data_lo;
  logic dma_data_v_lo, dma_data_yumi_li;
  bsg_cache
   #(.addr_width_p(caddr_width_p)
     ,.data_width_p(l2_data_width_p)
     ,.dma_data_width_p(l2_fill_width_p)
     ,.block_size_in_words_p(l2_block_size_in_words_p)
     ,.sets_p(l2_en_p ? l2_sets_p : 2)
     ,.ways_p(l2_en_p ? l2_assoc_p : 2)
     ,.amo_support_p(((amo_swap_p == e_l2) << e_cache_amo_swap)
                     | ((amo_fetch_logic_p == e_l2) << e_cache_amo_xor)
                     | ((amo_fetch_logic_p == e_l2) << e_cache_amo_and)
                     | ((amo_fetch_logic_p == e_l2) << e_cache_amo_or)
                     | ((amo_fetch_arithmetic_p == e_l2) << e_cache_amo_add)
                     | ((amo_fetch_arithmetic_p == e_l2) << e_cache_amo_min)
                     | ((amo_fetch_arithmetic_p == e_l2) << e_cache_amo_max)
                     | ((amo_fetch_arithmetic_p == e_l2) << e_cache_amo_minu)
                     | ((amo_fetch_arithmetic_p == e_l2) << e_cache_amo_maxu)
                     )
    )
   cache
    (.clk_i(clk_i)
     ,.reset_i(reset_r)

     ,.cache_pkt_i(cache_pkt_li)
     ,.v_i(cache_pkt_v_li)
     ,.ready_o(cache_pkt_ready_lo)

     ,.data_o(cache_data_lo)
     ,.v_o(cache_data_v_lo)
     ,.yumi_i(cache_data_yumi_li)

     ,.dma_pkt_o(dma_pkt_lo)
     ,.dma_pkt_v_o(dma_pkt_v_lo)
     ,.dma_pkt_yumi_i(dma_pkt_yumi_li)

     ,.dma_data_i(dma_data_li)
     ,.dma_data_v_i(dma_data_v_li)
     ,.dma_data_ready_o(dma_data_ready_and_lo)

     ,.dma_data_o(dma_data_lo)
     ,.dma_data_v_o(dma_data_v_lo)
     ,.dma_data_yumi_i(dma_data_yumi_li)

     ,.v_we_o()
     );

  bsg_cache_dma_to_wormhole
   #(.dma_addr_width_p(caddr_width_p)
     ,.dma_burst_len_p(l2_block_size_in_fill_p)

     ,.wh_flit_width_p(mem_noc_flit_width_p)
     ,.wh_cid_width_p(mem_noc_cid_width_p)
     ,.wh_len_width_p(mem_noc_len_width_p)
     ,.wh_cord_width_p(mem_noc_cord_width_p)
     )
   bsg_cache_dma_to_wormhole
    (.clk_i(clk_i)
     ,.reset_i(reset_r)

     ,.dma_pkt_i(dma_pkt_lo)
     ,.dma_pkt_v_i(dma_pkt_v_lo)
     ,.dma_pkt_yumi_o(dma_pkt_yumi_li)

     ,.dma_data_o(dma_data_li)
     ,.dma_data_v_o(dma_data_v_li)
     ,.dma_data_ready_and_i(dma_data_ready_and_lo)

     ,.dma_data_i(dma_data_lo)
     ,.dma_data_v_i(dma_data_v_lo)
     ,.dma_data_yumi_o(dma_data_yumi_li)

     ,.wh_link_sif_i(mem_resp_link_i)
     ,.wh_link_sif_o(mem_cmd_link_o)

     ,.my_wh_cord_i(my_cord_i[coh_noc_x_cord_width_p+:mem_noc_y_cord_width_p])
     ,.my_wh_cid_i('0)
     ,.dest_wh_cord_i('1)
     ,.dest_wh_cid_i('0)
     );

  bp_cce_loopback
   #(.bp_params_p(bp_params_p))
   loopback
    (.clk_i(clk_i)
     ,.reset_i(reset_r)

     ,.mem_cmd_i(loopback_mem_cmd)
     ,.mem_cmd_v_i(loopback_mem_cmd_v_li)
     ,.mem_cmd_ready_o(loopback_mem_cmd_ready_lo)

     ,.mem_resp_o(loopback_mem_resp)
     ,.mem_resp_v_o(loopback_mem_resp_v_lo)
     ,.mem_resp_yumi_i(loopback_mem_resp_yumi_li)
     );

endmodule

