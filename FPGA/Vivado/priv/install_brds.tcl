

set D /opt/Xilinx/xhub

set_property XSTORES_PATH $D [current_vivado_preferences]
set_param ced.repoPaths $D/ced_store/Vivado_example_project
set_param board.repoPaths $D/board_store/xilinx_board_store
if { [info exists ::env(https_proxy)] } {
	set_param xhub.http_proxy $::env(https_proxy)
}
xhub::refresh_catalog [xhub::get_xstores xilinx_board_store]


xhub::install [xhub::get_xitems digilentinc.com:xilinx_board_store:zedboard:1.0]
xhub::install [xhub::get_xitems digilentinc.com:xilinx_board_store:zybo:1.0]
xhub::install [xhub::get_xitems trenz.biz:xilinx_board_store:te0820_4cg_1i:3.0]

exit