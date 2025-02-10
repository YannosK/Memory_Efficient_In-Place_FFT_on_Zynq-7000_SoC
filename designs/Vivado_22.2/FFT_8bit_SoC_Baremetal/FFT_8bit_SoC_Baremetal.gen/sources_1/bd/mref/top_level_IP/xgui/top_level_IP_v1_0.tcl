# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Page_0 [ipgui::add_page $IPINST -name "Page 0"]
  ipgui::add_param $IPINST -name "C_S_AXI_ADDR_WIDTH" -parent ${Page_0}
  ipgui::add_param $IPINST -name "C_S_AXI_DATA_WIDTH" -parent ${Page_0}
  ipgui::add_param $IPINST -name "ROM_file" -parent ${Page_0}
  ipgui::add_param $IPINST -name "maxcount" -parent ${Page_0}
  ipgui::add_param $IPINST -name "points" -parent ${Page_0}
  ipgui::add_param $IPINST -name "shiftbits" -parent ${Page_0}
  ipgui::add_param $IPINST -name "stagebits" -parent ${Page_0}
  ipgui::add_param $IPINST -name "stages" -parent ${Page_0}
  ipgui::add_param $IPINST -name "width" -parent ${Page_0}


}

proc update_PARAM_VALUE.C_S_AXI_ADDR_WIDTH { PARAM_VALUE.C_S_AXI_ADDR_WIDTH } {
	# Procedure called to update C_S_AXI_ADDR_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_S_AXI_ADDR_WIDTH { PARAM_VALUE.C_S_AXI_ADDR_WIDTH } {
	# Procedure called to validate C_S_AXI_ADDR_WIDTH
	return true
}

proc update_PARAM_VALUE.C_S_AXI_DATA_WIDTH { PARAM_VALUE.C_S_AXI_DATA_WIDTH } {
	# Procedure called to update C_S_AXI_DATA_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_S_AXI_DATA_WIDTH { PARAM_VALUE.C_S_AXI_DATA_WIDTH } {
	# Procedure called to validate C_S_AXI_DATA_WIDTH
	return true
}

proc update_PARAM_VALUE.ROM_file { PARAM_VALUE.ROM_file } {
	# Procedure called to update ROM_file when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.ROM_file { PARAM_VALUE.ROM_file } {
	# Procedure called to validate ROM_file
	return true
}

proc update_PARAM_VALUE.maxcount { PARAM_VALUE.maxcount } {
	# Procedure called to update maxcount when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.maxcount { PARAM_VALUE.maxcount } {
	# Procedure called to validate maxcount
	return true
}

proc update_PARAM_VALUE.points { PARAM_VALUE.points } {
	# Procedure called to update points when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.points { PARAM_VALUE.points } {
	# Procedure called to validate points
	return true
}

proc update_PARAM_VALUE.shiftbits { PARAM_VALUE.shiftbits } {
	# Procedure called to update shiftbits when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.shiftbits { PARAM_VALUE.shiftbits } {
	# Procedure called to validate shiftbits
	return true
}

proc update_PARAM_VALUE.stagebits { PARAM_VALUE.stagebits } {
	# Procedure called to update stagebits when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.stagebits { PARAM_VALUE.stagebits } {
	# Procedure called to validate stagebits
	return true
}

proc update_PARAM_VALUE.stages { PARAM_VALUE.stages } {
	# Procedure called to update stages when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.stages { PARAM_VALUE.stages } {
	# Procedure called to validate stages
	return true
}

proc update_PARAM_VALUE.width { PARAM_VALUE.width } {
	# Procedure called to update width when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.width { PARAM_VALUE.width } {
	# Procedure called to validate width
	return true
}


proc update_MODELPARAM_VALUE.C_S_AXI_DATA_WIDTH { MODELPARAM_VALUE.C_S_AXI_DATA_WIDTH PARAM_VALUE.C_S_AXI_DATA_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_S_AXI_DATA_WIDTH}] ${MODELPARAM_VALUE.C_S_AXI_DATA_WIDTH}
}

proc update_MODELPARAM_VALUE.C_S_AXI_ADDR_WIDTH { MODELPARAM_VALUE.C_S_AXI_ADDR_WIDTH PARAM_VALUE.C_S_AXI_ADDR_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_S_AXI_ADDR_WIDTH}] ${MODELPARAM_VALUE.C_S_AXI_ADDR_WIDTH}
}

proc update_MODELPARAM_VALUE.points { MODELPARAM_VALUE.points PARAM_VALUE.points } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.points}] ${MODELPARAM_VALUE.points}
}

proc update_MODELPARAM_VALUE.stages { MODELPARAM_VALUE.stages PARAM_VALUE.stages } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.stages}] ${MODELPARAM_VALUE.stages}
}

proc update_MODELPARAM_VALUE.stagebits { MODELPARAM_VALUE.stagebits PARAM_VALUE.stagebits } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.stagebits}] ${MODELPARAM_VALUE.stagebits}
}

proc update_MODELPARAM_VALUE.shiftbits { MODELPARAM_VALUE.shiftbits PARAM_VALUE.shiftbits } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.shiftbits}] ${MODELPARAM_VALUE.shiftbits}
}

proc update_MODELPARAM_VALUE.maxcount { MODELPARAM_VALUE.maxcount PARAM_VALUE.maxcount } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.maxcount}] ${MODELPARAM_VALUE.maxcount}
}

proc update_MODELPARAM_VALUE.width { MODELPARAM_VALUE.width PARAM_VALUE.width } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.width}] ${MODELPARAM_VALUE.width}
}

proc update_MODELPARAM_VALUE.ROM_file { MODELPARAM_VALUE.ROM_file PARAM_VALUE.ROM_file } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.ROM_file}] ${MODELPARAM_VALUE.ROM_file}
}

