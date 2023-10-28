; HEADER_BLOCK_START
; BambuStudio 01.07.03.50
; model printing time: 3h 31m 41s; total estimated time: 3h 37m 27s
; total layer number: 1001
; model label id: 88
; HEADER_BLOCK_END

; CONFIG_BLOCK_START
; accel_to_decel_enable = 0
; accel_to_decel_factor = 50%
; additional_cooling_fan_speed = 70,70,70,70
; auxiliary_fan = 1
; bed_custom_model = 
; bed_custom_texture = 
; bed_exclude_area = 0x0,18x0,18x28,0x28
; bed_temperature_difference = 10,10,10,10
; before_layer_change_gcode = 
; bottom_shell_layers = 3
; bottom_shell_thickness = 0
; bottom_surface_pattern = monotonic
; bridge_angle = 0
; bridge_flow = 1
; bridge_no_support = 0
; bridge_speed = 50
; brim_object_gap = 0.1
; brim_type = auto_brim
; brim_width = 5
; chamber_temperatures = 0,0,0,0
; change_filament_gcode = M620 S[next_extruder]A\nM204 S9000\n{if toolchange_count > 1 && (z_hop_types[current_extruder] == 0 || z_hop_types[current_extruder] == 3)}\nG17\nG2 Z{z_after_toolchange + 0.4} I0.86 J0.86 P1 F10000 ; spiral lift a little from second lift\n{endif}\nG1 Z{max_layer_z + 3.0} F1200\n\nG1 X70 F21000\nG1 Y245\nG1 Y265 F3000\nM400\nM106 P1 S0\nM106 P2 S0\n{if old_filament_temp > 142 && next_extruder < 255}\nM104 S[old_filament_temp]\n{endif}\nG1 X90 F3000\nG1 Y255 F4000\nG1 X100 F5000\nG1 X120 F15000\n\nG1 X20 Y50 F21000\nG1 Y-3\n{if toolchange_count == 2}\n; get travel path for change filament\nM620.1 X[travel_point_1_x] Y[travel_point_1_y] F21000 P0\nM620.1 X[travel_point_2_x] Y[travel_point_2_y] F21000 P1\nM620.1 X[travel_point_3_x] Y[travel_point_3_y] F21000 P2\n{endif}\nM620.1 E F[old_filament_e_feedrate] T{nozzle_temperature_range_high[previous_extruder]}\nT[next_extruder]\nM620.1 E F[new_filament_e_feedrate] T{nozzle_temperature_range_high[next_extruder]}\n\n{if next_extruder < 255}\nM400\n\nG92 E0\n{if flush_length_1 > 1}\n; FLUSH_START\n; always use highest temperature to flush\nM400\nM109 S[nozzle_temperature_range_high]\n{if flush_length_1 > 23.7}\nG1 E23.7 F{old_filament_e_feedrate} ; do not need pulsatile flushing for start part\nG1 E{(flush_length_1 - 23.7) * 0.02} F50\nG1 E{(flush_length_1 - 23.7) * 0.23} F{old_filament_e_feedrate}\nG1 E{(flush_length_1 - 23.7) * 0.02} F50\nG1 E{(flush_length_1 - 23.7) * 0.23} F{new_filament_e_feedrate}\nG1 E{(flush_length_1 - 23.7) * 0.02} F50\nG1 E{(flush_length_1 - 23.7) * 0.23} F{new_filament_e_feedrate}\nG1 E{(flush_length_1 - 23.7) * 0.02} F50\nG1 E{(flush_length_1 - 23.7) * 0.23} F{new_filament_e_feedrate}\n{else}\nG1 E{flush_length_1} F{old_filament_e_feedrate}\n{endif}\n; FLUSH_END\nG1 E-[old_retract_length_toolchange] F1800\nG1 E[old_retract_length_toolchange] F300\n{endif}\n\n{if flush_length_2 > 1}\n; FLUSH_START\nG1 E{flush_length_2 * 0.18} F{new_filament_e_feedrate}\nG1 E{flush_length_2 * 0.02} F50\nG1 E{flush_length_2 * 0.18} F{new_filament_e_feedrate}\nG1 E{flush_length_2 * 0.02} F50\nG1 E{flush_length_2 * 0.18} F{new_filament_e_feedrate}\nG1 E{flush_length_2 * 0.02} F50\nG1 E{flush_length_2 * 0.18} F{new_filament_e_feedrate}\nG1 E{flush_length_2 * 0.02} F50\nG1 E{flush_length_2 * 0.18} F{new_filament_e_feedrate}\nG1 E{flush_length_2 * 0.02} F50\n; FLUSH_END\nG1 E-[new_retract_length_toolchange] F1800\nG1 E[new_retract_length_toolchange] F300\n{endif}\n\n{if flush_length_3 > 1}\n; FLUSH_START\nG1 E{flush_length_3 * 0.18} F{new_filament_e_feedrate}\nG1 E{flush_length_3 * 0.02} F50\nG1 E{flush_length_3 * 0.18} F{new_filament_e_feedrate}\nG1 E{flush_length_3 * 0.02} F50\nG1 E{flush_length_3 * 0.18} F{new_filament_e_feedrate}\nG1 E{flush_length_3 * 0.02} F50\nG1 E{flush_length_3 * 0.18} F{new_filament_e_feedrate}\nG1 E{flush_length_3 * 0.02} F50\nG1 E{flush_length_3 * 0.18} F{new_filament_e_feedrate}\nG1 E{flush_length_3 * 0.02} F50\n; FLUSH_END\nG1 E-[new_retract_length_toolchange] F1800\nG1 E[new_retract_length_toolchange] F300\n{endif}\n\n{if flush_length_4 > 1}\n; FLUSH_START\nG1 E{flush_length_4 * 0.18} F{new_filament_e_feedrate}\nG1 E{flush_length_4 * 0.02} F50\nG1 E{flush_length_4 * 0.18} F{new_filament_e_feedrate}\nG1 E{flush_length_4 * 0.02} F50\nG1 E{flush_length_4 * 0.18} F{new_filament_e_feedrate}\nG1 E{flush_length_4 * 0.02} F50\nG1 E{flush_length_4 * 0.18} F{new_filament_e_feedrate}\nG1 E{flush_length_4 * 0.02} F50\nG1 E{flush_length_4 * 0.18} F{new_filament_e_feedrate}\nG1 E{flush_length_4 * 0.02} F50\n; FLUSH_END\n{endif}\n; FLUSH_START\nM400\nM109 S[new_filament_temp]\nG1 E2 F{new_filament_e_feedrate} ;Compensate for filament spillage during waiting temperature\n; FLUSH_END\nM400\nG92 E0\nG1 E-[new_retract_length_toolchange] F1800\nM106 P1 S255\nM400 S3\nG1 X80 F15000\nG1 X60 F15000\nG1 X80 F15000\nG1 X60 F15000; shake to put down garbage\n\nG1 X70 F5000\nG1 X90 F3000\nG1 Y255 F4000\nG1 X100 F5000\nG1 Y265 F5000\nG1 X70 F10000\nG1 X100 F5000\nG1 X70 F10000\nG1 X100 F5000\nG1 X165 F15000; wipe and shake\nG1 Y256 ; move Y to aside, prevent collision\nM400\nG1 Z{max_layer_z + 3.0} F3000\n{if layer_z <= (initial_layer_print_height + 0.001)}\nM204 S[initial_layer_acceleration]\n{else}\nM204 S[default_acceleration]\n{endif}\n{else}\nG1 X[x_after_toolchange] Y[y_after_toolchange] Z[z_after_toolchange] F12000\n{endif}\nM621 S[next_extruder]A
; close_fan_the_first_x_layers = 1,1,1,1
; cool_plate_temp = 35,35,35,35
; cool_plate_temp_initial_layer = 35,35,35,35
; curr_bed_type = Cool Plate
; default_acceleration = 10000
; default_filament_colour = ;;;
; default_filament_profile = "Bambu PLA Basic @BBL X1C"
; default_jerk = 0
; default_print_profile = 0.20mm Standard @BBL X1C
; deretraction_speed = 30
; detect_narrow_internal_solid_infill = 1
; detect_overhang_wall = 1
; detect_thin_wall = 0
; different_settings_to_system = enable_support;initial_layer_line_width;layer_height;sparse_infill_density;;;;;
; draft_shield = disabled
; elefant_foot_compensation = 0.15
; enable_arc_fitting = 1
; enable_overhang_bridge_fan = 1,1,1,1
; enable_overhang_speed = 1
; enable_pressure_advance = 0,0,0,0
; enable_prime_tower = 0
; enable_support = 1
; enforce_support_layers = 0
; eng_plate_temp = 0,0,0,0
; eng_plate_temp_initial_layer = 0,0,0,0
; ensure_vertical_shell_thickness = 1
; exclude_object = 1
; extruder_clearance_height_to_lid = 90
; extruder_clearance_height_to_rod = 36
; extruder_clearance_max_radius = 56
; extruder_clearance_radius = 57
; extruder_colour = #018001
; extruder_offset = 0x2
; extruder_type = DirectDrive
; fan_cooling_layer_time = 100,100,100,100
; fan_max_speed = 100,100,100,100
; fan_min_speed = 100,100,100,100
; filament_colour = #EDEDED;#2A2A2A;#FC3127;#FC7229
; filament_cost = 25.4,25.4,25.4,25.4
; filament_density = 1.31,1.31,1.31,1.31
; filament_diameter = 1.75,1.75,1.75,1.75
; filament_end_gcode = "; filament end gcode \nM106 P3 S0\n";"; filament end gcode \nM106 P3 S0\n";"; filament end gcode \nM106 P3 S0\n";"; filament end gcode \nM106 P3 S0\n"
; filament_flow_ratio = 0.98,0.98,0.98,0.98
; filament_ids = GFL01;GFL01;GFL01;GFL01
; filament_is_support = 0,0,0,0
; filament_max_volumetric_speed = 22,22,22,22
; filament_minimal_purge_on_wipe_tower = 15,15,15,15
; filament_settings_id = "PolyTerra PLA @BBL X1C";"PolyTerra PLA @BBL X1C";"PolyTerra PLA @BBL X1C";"PolyTerra PLA @BBL X1C"
; filament_soluble = 0,0,0,0
; filament_start_gcode = "; filament start gcode\n{if  (bed_temperature[current_extruder] >45)||(bed_temperature_initial_layer[current_extruder] >45)}M106 P3 S255\n{elsif(bed_temperature[current_extruder] >35)||(bed_temperature_initial_layer[current_extruder] >35)}M106 P3 S180\n{endif}";"; filament start gcode\n{if  (bed_temperature[current_extruder] >45)||(bed_temperature_initial_layer[current_extruder] >45)}M106 P3 S255\n{elsif(bed_temperature[current_extruder] >35)||(bed_temperature_initial_layer[current_extruder] >35)}M106 P3 S180\n{endif}";"; filament start gcode\n{if  (bed_temperature[current_extruder] >45)||(bed_temperature_initial_layer[current_extruder] >45)}M106 P3 S255\n{elsif(bed_temperature[current_extruder] >35)||(bed_temperature_initial_layer[current_extruder] >35)}M106 P3 S180\n{endif}";"; filament start gcode\n{if  (bed_temperature[current_extruder] >45)||(bed_temperature_initial_layer[current_extruder] >45)}M106 P3 S255\n{elsif(bed_temperature[current_extruder] >35)||(bed_temperature_initial_layer[current_extruder] >35)}M106 P3 S180\n{endif}"
; filament_type = PLA;PLA;PLA;PLA
; filament_vendor = Polymaker;Polymaker;Polymaker;Polymaker
; filename_format = {input_filename_base}_{filament_type[0]}_{print_time}.gcode
; filter_out_gap_fill = 0
; flush_into_infill = 0
; flush_into_objects = 0
; flush_into_support = 1
; flush_multiplier = 1
; flush_volumes_matrix = 0,280,280,280,280,0,280,280,280,280,0,280,280,280,280,0
; flush_volumes_vector = 140,140,140,140,140,140,140,140
; full_fan_speed_layer = 0,0,0,0
; fuzzy_skin = none
; fuzzy_skin_point_distance = 0.8
; fuzzy_skin_thickness = 0.3
; gap_infill_speed = 250
; gcode_add_line_number = 0
; gcode_flavor = marlin
; host_type = octoprint
; hot_plate_temp = 55,55,55,55
; hot_plate_temp_initial_layer = 55,55,55,55
; independent_support_layer_height = 1
; infill_combination = 0
; infill_direction = 45
; infill_jerk = 9
; infill_wall_overlap = 15%
; inherits_group = "0.20mm Standard @BBL X1C";;;;;
; initial_layer_acceleration = 500
; initial_layer_flow_ratio = 1
; initial_layer_infill_speed = 105
; initial_layer_jerk = 9
; initial_layer_line_width = 0.36
; initial_layer_print_height = 0.2
; initial_layer_speed = 50
; inner_wall_acceleration = 0
; inner_wall_jerk = 9
; inner_wall_line_width = 0.45
; inner_wall_speed = 300
; interface_shells = 0
; internal_bridge_support_thickness = 0.8
; internal_solid_infill_line_width = 0.42
; internal_solid_infill_pattern = zig-zag
; internal_solid_infill_speed = 250
; ironing_flow = 10%
; ironing_pattern = zig-zag
; ironing_spacing = 0.15
; ironing_speed = 30
; ironing_type = no ironing
; layer_change_gcode = ; layer num/total_layer_count: {layer_num+1}/[total_layer_count]\nM622.1 S1 ; for prev firware, default turned on\nM1002 judge_flag timelapse_record_flag\nM622 J1\n{if timelapse_type == 0} ; timelapse without wipe tower\nM971 S11 C10 O0\n{elsif timelapse_type == 1} ; timelapse with wipe tower\nG92 E0\nG1 E-[retraction_length] F1800\nG17\nG2 Z{layer_z + 0.4} I0.86 J0.86 P1 F20000 ; spiral lift a little\nG1 X65 Y245 F20000 ; move to safe pos\nG17\nG2 Z{layer_z} I0.86 J0.86 P1 F20000\nG1 Y265 F3000\nM400 P300\nM971 S11 C11 O0\nG92 E0\nG1 E[retraction_length] F300\nG1 X100 F5000\nG1 Y255 F20000\n{endif}\nM623\n; update layer progress\nM73 L{layer_num+1}\nM991 S0 P{layer_num} ;notify layer change
; layer_height = 0.1
; line_width = 0.42
; machine_end_gcode = ;===== date: 20230428 =====================\nM400 ; wait for buffer to clear\nG92 E0 ; zero the extruder\nG1 E-0.8 F1800 ; retract\nG1 Z{max_layer_z + 0.5} F900 ; lower z a little\nG1 X65 Y245 F12000 ; move to safe pos \nG1 Y265 F3000\n\nG1 X65 Y245 F12000\nG1 Y265 F3000\nM140 S0 ; turn off bed\nM106 S0 ; turn off fan\nM106 P2 S0 ; turn off remote part cooling fan\nM106 P3 S0 ; turn off chamber cooling fan\n\nG1 X100 F12000 ; wipe\n; pull back filament to AMS\nM620 S255\nG1 X20 Y50 F12000\nG1 Y-3\nT255\nG1 X65 F12000\nG1 Y265\nG1 X100 F12000 ; wipe\nM621 S255\nM104 S0 ; turn off hotend\n\nM622.1 S1 ; for prev firware, default turned on\nM1002 judge_flag timelapse_record_flag\nM622 J1\n    M400 ; wait all motion done\n    M991 S0 P-1 ;end smooth timelapse at safe pos\n    M400 S3 ;wait for last picture to be taken\nM623; end of "timelapse_record_flag"\n\nM400 ; wait all motion done\nM17 S\nM17 Z0.4 ; lower z motor current to reduce impact if there is something in the bottom\n{if (max_layer_z + 100.0) < 250}\n    G1 Z{max_layer_z + 100.0} F600\n    G1 Z{max_layer_z +98.0}\n{else}\n    G1 Z250 F600\n    G1 Z248\n{endif}\nM400 P100\nM17 R ; restore z current\n\nG90\nG1 X128 Y250 F3600\n\nM220 S100  ; Reset feedrate magnitude\nM201.2 K1.0 ; Reset acc magnitude\nM73.2   R1.0 ;Reset left time magnitude\nM1002 set_gcode_claim_speed_level : 0\n\nM17 X0.8 Y0.8 Z0.5 ; lower motor current to 45% power\n
; machine_load_filament_time = 29
; machine_max_acceleration_e = 5000,5000
; machine_max_acceleration_extruding = 20000,20000
; machine_max_acceleration_retracting = 5000,5000
; machine_max_acceleration_travel = 9000,9000
; machine_max_acceleration_x = 20000,20000
; machine_max_acceleration_y = 20000,20000
; machine_max_acceleration_z = 500,200
; machine_max_jerk_e = 2.5,2.5
; machine_max_jerk_x = 9,9
; machine_max_jerk_y = 9,9
; machine_max_jerk_z = 3,3
; machine_max_speed_e = 30,30
; machine_max_speed_x = 500,200
; machine_max_speed_y = 500,200
; machine_max_speed_z = 20,20
; machine_min_extruding_rate = 0,0
; machine_min_travel_rate = 0,0
; machine_pause_gcode = M400 U1
; machine_start_gcode = ;===== machine: P1S ========================\n;===== date: 20230707 =====================\n;===== turn on the HB fan =================\nM104 S75 ;set extruder temp to turn on the HB fan and prevent filament oozing from nozzle\n;===== reset machine status =================\nG91\nM17 Z0.4 ; lower the z-motor current\nG380 S2 Z30 F300 ; G380 is same as G38; lower the hotbed , to prevent the nozzle is below the hotbed\nG380 S2 Z-25 F300 ;\nG1 Z5 F300;\nG90\nM17 X1.2 Y1.2 Z0.75 ; reset motor current to default\nM960 S5 P1 ; turn on logo lamp\nG90\nM220 S100 ;Reset Feedrate\nM221 S100 ;Reset Flowrate\nM73.2   R1.0 ;Reset left time magnitude\nM1002 set_gcode_claim_speed_level : 5\nM221 X0 Y0 Z0 ; turn off soft endstop to prevent protential logic problem\nG29.1 Z{+0.0} ; clear z-trim value first\nM204 S10000 ; init ACC set to 10m/s^2\n\n;===== heatbed preheat ====================\nM1002 gcode_claim_action : 2\nM140 S[bed_temperature_initial_layer_single] ;set bed temp\nM190 S[bed_temperature_initial_layer_single] ;wait for bed temp\n\n\n\n;=============turn on fans to prevent PLA jamming=================\n{if filament_type[initial_extruder]=="PLA"}\n    {if (bed_temperature[initial_extruder] >45)||(bed_temperature_initial_layer[initial_extruder] >45)}\n    M106 P3 S180\n    {elsif (bed_temperature[initial_extruder] >50)||(bed_temperature_initial_layer[initial_extruder] >50)}\n    M106 P3 S255\n    {endif};Prevent PLA from jamming\n{endif}\nM106 P2 S100 ; turn on big fan ,to cool down toolhead\n\n;===== prepare print temperature and material ==========\nM104 S[nozzle_temperature_initial_layer] ;set extruder temp\nG91\nG0 Z10 F1200\nG90\nG28 X\nM975 S1 ; turn on\nG1 X60 F12000\nG1 Y245\nG1 Y265 F3000\nM620 M\nM620 S[initial_extruder]A   ; switch material if AMS exist\n    M109 S[nozzle_temperature_initial_layer]\n    G1 X120 F12000\n\n    G1 X20 Y50 F12000\n    G1 Y-3\n    T[initial_extruder]\n    G1 X54 F12000\n    G1 Y265\n    M400\nM621 S[initial_extruder]A\nM620.1 E F{filament_max_volumetric_speed[initial_extruder]/2.4053*60} T{nozzle_temperature_range_high[initial_extruder]}\n\n\nM412 S1 ; ===turn on filament runout detection===\n\nM109 S250 ;set nozzle to common flush temp\nM106 P1 S0\nG92 E0\nG1 E50 F200\nM400\nM104 S[nozzle_temperature_initial_layer]\nG92 E0\nG1 E50 F200\nM400\nM106 P1 S255\nG92 E0\nG1 E5 F300\nM109 S{nozzle_temperature_initial_layer[initial_extruder]-20} ; drop nozzle temp, make filament shink a bit\nG92 E0\nG1 E-0.5 F300\n\nG1 X70 F9000\nG1 X76 F15000\nG1 X65 F15000\nG1 X76 F15000\nG1 X65 F15000; shake to put down garbage\nG1 X80 F6000\nG1 X95 F15000\nG1 X80 F15000\nG1 X165 F15000; wipe and shake\nM400\nM106 P1 S0\n;===== prepare print temperature and material end =====\n\n\n;===== wipe nozzle ===============================\nM1002 gcode_claim_action : 14\nM975 S1\nM106 S255\nG1 X65 Y230 F18000\nG1 Y264 F6000\nM109 S{nozzle_temperature_initial_layer[initial_extruder]-20}\nG1 X100 F18000 ; first wipe mouth\n\nG0 X135 Y253 F20000  ; move to exposed steel surface edge\nG28 Z P0 T300; home z with low precision,permit 300deg temperature\nG29.2 S0 ; turn off ABL\nG0 Z5 F20000\n\nG1 X60 Y265\nG92 E0\nG1 E-0.5 F300 ; retrack more\nG1 X100 F5000; second wipe mouth\nG1 X70 F15000\nG1 X100 F5000\nG1 X70 F15000\nG1 X100 F5000\nG1 X70 F15000\nG1 X100 F5000\nG1 X70 F15000\nG1 X90 F5000\nG0 X128 Y261 Z-1.5 F20000  ; move to exposed steel surface and stop the nozzle\nM104 S140 ; set temp down to heatbed acceptable\nM106 S255 ; turn on fan (G28 has turn off fan)\n\nM221 S; push soft endstop status\nM221 Z0 ;turn off Z axis endstop\nG0 Z0.5 F20000\nG0 X125 Y259.5 Z-1.01\nG0 X131 F211\nG0 X124\nG0 Z0.5 F20000\nG0 X125 Y262.5\nG0 Z-1.01\nG0 X131 F211\nG0 X124\nG0 Z0.5 F20000\nG0 X125 Y260.0\nG0 Z-1.01\nG0 X131 F211\nG0 X124\nG0 Z0.5 F20000\nG0 X125 Y262.0\nG0 Z-1.01\nG0 X131 F211\nG0 X124\nG0 Z0.5 F20000\nG0 X125 Y260.5\nG0 Z-1.01\nG0 X131 F211\nG0 X124\nG0 Z0.5 F20000\nG0 X125 Y261.5\nG0 Z-1.01\nG0 X131 F211\nG0 X124\nG0 Z0.5 F20000\nG0 X125 Y261.0\nG0 Z-1.01\nG0 X131 F211\nG0 X124\nG0 X128\nG2 I0.5 J0 F300\nG2 I0.5 J0 F300\nG2 I0.5 J0 F300\nG2 I0.5 J0 F300\n\nM109 S140 ; wait nozzle temp down to heatbed acceptable\nG2 I0.5 J0 F3000\nG2 I0.5 J0 F3000\nG2 I0.5 J0 F3000\nG2 I0.5 J0 F3000\n\nM221 R; pop softend status\nG1 Z10 F1200\nM400\nG1 Z10\nG1 F30000\nG1 X230 Y15\nG29.2 S1 ; turn on ABL\n;G28 ; home again after hard wipe mouth\nM106 S0 ; turn off fan , too noisy\n;===== wipe nozzle end ================================\n\n\n;===== bed leveling ==================================\nM1002 judge_flag g29_before_print_flag\nM622 J1\n\n    M1002 gcode_claim_action : 1\n    G29 A X{first_layer_print_min[0]} Y{first_layer_print_min[1]} I{first_layer_print_size[0]} J{first_layer_print_size[1]}\n    M400\n    M500 ; save cali data\n\nM623\n;===== bed leveling end ================================\n\n;===== home after wipe mouth============================\nM1002 judge_flag g29_before_print_flag\nM622 J0\n\n    M1002 gcode_claim_action : 13\n    G28\n\nM623\n;===== home after wipe mouth end =======================\n\nM975 S1 ; turn on vibration supression\n\n\n;=============turn on fans to prevent PLA jamming=================\n{if filament_type[initial_extruder]=="PLA"}\n    {if (bed_temperature[initial_extruder] >45)||(bed_temperature_initial_layer[initial_extruder] >45)}\n    M106 P3 S180\n    {elsif (bed_temperature[initial_extruder] >50)||(bed_temperature_initial_layer[initial_extruder] >50)}\n    M106 P3 S255\n    {endif};Prevent PLA from jamming\n{endif}\nM106 P2 S100 ; turn on big fan ,to cool down toolhead\n\n\nM104 S{nozzle_temperature_initial_layer[initial_extruder]} ; set extrude temp earlier, to reduce wait time\n\n;===== mech mode fast check============================\nG1 X128 Y128 Z10 F20000\nM400 P200\nM970.3 Q1 A7 B30 C80  H15 K0\nM974 Q1 S2 P0\n\nG1 X128 Y128 Z10 F20000\nM400 P200\nM970.3 Q0 A7 B30 C90 Q0 H15 K0\nM974 Q0 S2 P0\n\nM975 S1\nG1 F30000\nG1 X230 Y15\nG28 X ; re-home XY\n;===== fmech mode fast check============================\n\n\n;===== noozle load line ===============================\nM975 S1\nG90\nM83\nT1000\nG1 X18.0 Y1.0 Z0.8 F18000;Move to start position\nM109 S{nozzle_temperature_initial_layer[initial_extruder]}\nG1 Z0.2\nG0 E2 F300\nG0 X240 E15 F{outer_wall_volumetric_speed/(0.3*0.5)     * 60}\nG0 Y11 E0.700 F{outer_wall_volumetric_speed/(0.3*0.5)/ 4 * 60}\nG0 X239.5\nG0 E0.2\nG0 Y1.5 E0.700\nG0 X18 E15 F{outer_wall_volumetric_speed/(0.3*0.5)     * 60}\nM400\n\n;===== for Textured PEI Plate , lower the nozzle as the nozzle was touching topmost of the texture when homing ==\n;curr_bed_type={curr_bed_type}\n{if curr_bed_type=="Textured PEI Plate"}\nG29.1 Z{-0.04} ; for Textured PEI Plate\n{endif}\n;========turn off light and wait extrude temperature =============\nM1002 gcode_claim_action : 0\nM106 S0 ; turn off fan\nM106 P2 S0 ; turn off big fan\nM106 P3 S0 ; turn off chamber fan\n\nM975 S1 ; turn on mech mode supression
; machine_unload_filament_time = 28
; max_bridge_length = 10
; max_layer_height = 0.28
; max_travel_detour_distance = 0
; min_bead_width = 85%
; min_feature_size = 25%
; min_layer_height = 0.08
; minimum_sparse_infill_area = 15
; nozzle_diameter = 0.4
; nozzle_temperature = 220,220,220,220
; nozzle_temperature_initial_layer = 220,220,220,220
; nozzle_temperature_range_high = 240,240,240,240
; nozzle_temperature_range_low = 190,190,190,190
; nozzle_type = stainless_steel
; nozzle_volume = 107
; only_one_wall_first_layer = 0
; ooze_prevention = 0
; outer_wall_acceleration = 5000
; outer_wall_jerk = 9
; outer_wall_line_width = 0.42
; outer_wall_speed = 200
; overhang_1_4_speed = 0
; overhang_2_4_speed = 50
; overhang_3_4_speed = 30
; overhang_4_4_speed = 10
; overhang_fan_speed = 100,100,100,100
; overhang_fan_threshold = 50%,50%,50%,50%
; post_process = 
; pressure_advance = 0.02,0.02,0.02,0.02
; prime_tower_brim_width = 3
; prime_tower_width = 35
; prime_volume = 45
; print_compatible_printers = "Bambu Lab X1 Carbon 0.4 nozzle";"Bambu Lab X1 0.4 nozzle";"Bambu Lab P1S 0.4 nozzle"
; print_flow_ratio = 1
; print_host = 
; print_host_webui = 
; print_sequence = by layer
; print_settings_id = 0.20mm Standard @BBL X1C - Copy
; printable_area = 0x0,256x0,256x256,0x256
; printable_height = 250
; printer_model = Bambu Lab P1S
; printer_settings_id = Bambu Lab P1S 0.4 nozzle
; printer_technology = FFF
; printer_variant = 0.4
; printhost_apikey = 
; printhost_authorization_type = key
; printhost_cafile = 
; printhost_password = 
; printhost_port = 
; printhost_ssl_ignore_revoke = 0
; printhost_user = 
; raft_contact_distance = 0.1
; raft_expansion = 1.5
; raft_first_layer_density = 90%
; raft_first_layer_expansion = 2
; raft_layers = 0
; reduce_crossing_wall = 0
; reduce_fan_stop_start_freq = 1,1,1,1
; reduce_infill_retraction = 1
; required_nozzle_HRC = 3,3,3,3
; resolution = 0.012
; retract_before_wipe = 0%
; retract_length_toolchange = 2
; retract_restart_extra = 0
; retract_restart_extra_toolchange = 0
; retract_when_changing_layer = 1
; retraction_length = 0.8
; retraction_minimum_travel = 1
; retraction_speed = 30
; scan_first_layer = 0
; seam_gap = 15%
; seam_position = aligned
; silent_mode = 0
; single_extruder_multi_material = 1
; skirt_distance = 2
; skirt_height = 1
; skirt_loops = 0
; slice_closing_radius = 0.049
; slicing_mode = regular
; slow_down_for_layer_cooling = 1,1,1,1
; slow_down_layer_time = 4,4,4,4
; slow_down_min_speed = 20,20,20,20
; solid_infill_filament = 1
; sparse_infill_acceleration = 100%
; sparse_infill_anchor = 400%
; sparse_infill_anchor_max = 20
; sparse_infill_density = 30%
; sparse_infill_filament = 1
; sparse_infill_line_width = 0.45
; sparse_infill_pattern = grid
; sparse_infill_speed = 270
; spiral_mode = 0
; standby_temperature_delta = -5
; start_end_points = 30x-3,54x245
; support_angle = 0
; support_base_pattern = default
; support_base_pattern_spacing = 2.5
; support_bottom_interface_spacing = 0.5
; support_bottom_z_distance = 0.2
; support_critical_regions_only = 0
; support_expansion = 0
; support_filament = 0
; support_interface_bottom_layers = 2
; support_interface_filament = 0
; support_interface_loop_pattern = 0
; support_interface_pattern = auto
; support_interface_spacing = 0.5
; support_interface_speed = 80
; support_interface_top_layers = 2
; support_line_width = 0.42
; support_object_xy_distance = 0.35
; support_on_build_plate_only = 0
; support_remove_small_overhang = 1
; support_speed = 150
; support_style = default
; support_threshold_angle = 30
; support_top_z_distance = 0.2
; support_type = normal(auto)
; temperature_vitrification = 55,55,55,55
; template_custom_gcode = 
; textured_plate_temp = 55,55,55,55
; textured_plate_temp_initial_layer = 55,55,55,55
; thick_bridges = 0
; timelapse_type = 0
; top_one_wall_type = all top
; top_shell_layers = 3
; top_shell_thickness = 0.6
; top_solid_infill_flow_ratio = 1
; top_surface_acceleration = 2000
; top_surface_jerk = 9
; top_surface_line_width = 0.42
; top_surface_pattern = monotonicline
; top_surface_speed = 200
; travel_jerk = 9
; travel_speed = 500
; travel_speed_z = 0
; tree_support_branch_angle = 45
; tree_support_branch_diameter = 2
; tree_support_branch_distance = 5
; tree_support_brim_width = 0
; tree_support_wall_count = 1
; upward_compatible_machine = "Bambu Lab P1P 0.4 nozzle";"Bambu Lab X1 0.4 nozzle";"Bambu Lab X1 Carbon 0.4 nozzle"
; use_relative_e_distances = 1
; wall_distribution_count = 1
; wall_filament = 1
; wall_generator = classic
; wall_infill_order = inner wall/outer wall/infill
; wall_loops = 2
; wall_transition_angle = 10
; wall_transition_filter_deviation = 25%
; wall_transition_length = 100%
; wipe = 1
; wipe_distance = 2
; wipe_speed = 80%
; wipe_tower_no_sparse_layers = 0
; wipe_tower_rotation_angle = 0
; wipe_tower_x = 155
; wipe_tower_y = 220
; xy_contour_compensation = 0
; xy_hole_compensation = 0
; z_hop = 0.4
; z_hop_types = Auto Lift
; CONFIG_BLOCK_END

; EXECUTABLE_BLOCK_START
M73 P0 R217
M201 X20000 Y20000 Z500 E5000
M203 X500 Y500 Z20 E30
M204 P20000 R5000 T20000
M205 X9.00 Y9.00 Z3.00 E2.50
M106 S0
M106 P2 S0
; FEATURE: Custom
;===== machine: P1S ========================
;===== date: 20230707 =====================
;===== turn on the HB fan =================
M104 S75 ;set extruder temp to turn on the HB fan and prevent filament oozing from nozzle
;===== reset machine status =================
G91
M17 Z0.4 ; lower the z-motor current
G380 S2 Z30 F300 ; G380 is same as G38; lower the hotbed , to prevent the nozzle is below the hotbed
G380 S2 Z-25 F300 ;
G1 Z5 F300;
G90
M17 X1.2 Y1.2 Z0.75 ; reset motor current to default
M960 S5 P1 ; turn on logo lamp
G90
M220 S100 ;Reset Feedrate
M221 S100 ;Reset Flowrate
M73.2   R1.0 ;Reset left time magnitude
M1002 set_gcode_claim_speed_level : 5
M221 X0 Y0 Z0 ; turn off soft endstop to prevent protential logic problem
G29.1 Z0 ; clear z-trim value first
M204 S10000 ; init ACC set to 10m/s^2

;===== heatbed preheat ====================
M1002 gcode_claim_action : 2
M140 S35 ;set bed temp
M190 S35 ;wait for bed temp



;=============turn on fans to prevent PLA jamming=================

    ;Prevent PLA from jamming

M106 P2 S100 ; turn on big fan ,to cool down toolhead

;===== prepare print temperature and material ==========
M104 S220 ;set extruder temp
G91
G0 Z10 F1200
G90
G28 X
M975 S1 ; turn on
M73 P2 R213
G1 X60 F12000
G1 Y245
G1 Y265 F3000
M620 M
M620 S0A   ; switch material if AMS exist
    M109 S220
    G1 X120 F12000

    G1 X20 Y50 F12000
    G1 Y-3
    T0
    G1 X54 F12000
    G1 Y265
    M400
M621 S0A
M620.1 E F548.788 T240


M412 S1 ; ===turn on filament runout detection===

M109 S250 ;set nozzle to common flush temp
M106 P1 S0
G92 E0
G1 E50 F200
M400
M104 S220
G92 E0
G1 E50 F200
M400
M106 P1 S255
G92 E0
G1 E5 F300
M109 S200 ; drop nozzle temp, make filament shink a bit
G92 E0
M73 P2 R212
G1 E-0.5 F300

G1 X70 F9000
G1 X76 F15000
G1 X65 F15000
G1 X76 F15000
G1 X65 F15000; shake to put down garbage
G1 X80 F6000
G1 X95 F15000
G1 X80 F15000
G1 X165 F15000; wipe and shake
M400
M106 P1 S0
;===== prepare print temperature and material end =====


;===== wipe nozzle ===============================
M1002 gcode_claim_action : 14
M975 S1
M106 S255
G1 X65 Y230 F18000
G1 Y264 F6000
M109 S200
G1 X100 F18000 ; first wipe mouth

G0 X135 Y253 F20000  ; move to exposed steel surface edge
G28 Z P0 T300; home z with low precision,permit 300deg temperature
G29.2 S0 ; turn off ABL
G0 Z5 F20000

G1 X60 Y265
G92 E0
G1 E-0.5 F300 ; retrack more
G1 X100 F5000; second wipe mouth
G1 X70 F15000
G1 X100 F5000
G1 X70 F15000
G1 X100 F5000
G1 X70 F15000
G1 X100 F5000
G1 X70 F15000
G1 X90 F5000
G0 X128 Y261 Z-1.5 F20000  ; move to exposed steel surface and stop the nozzle
M104 S140 ; set temp down to heatbed acceptable
M106 S255 ; turn on fan (G28 has turn off fan)

M221 S; push soft endstop status
M221 Z0 ;turn off Z axis endstop
G0 Z0.5 F20000
G0 X125 Y259.5 Z-1.01
G0 X131 F211
G0 X124
G0 Z0.5 F20000
G0 X125 Y262.5
G0 Z-1.01
G0 X131 F211
G0 X124
G0 Z0.5 F20000
G0 X125 Y260.0
G0 Z-1.01
G0 X131 F211
G0 X124
G0 Z0.5 F20000
G0 X125 Y262.0
G0 Z-1.01
G0 X131 F211
G0 X124
G0 Z0.5 F20000
G0 X125 Y260.5
G0 Z-1.01
G0 X131 F211
G0 X124
G0 Z0.5 F20000
G0 X125 Y261.5
G0 Z-1.01
G0 X131 F211
G0 X124
G0 Z0.5 F20000
G0 X125 Y261.0
G0 Z-1.01
G0 X131 F211
G0 X124
G0 X128
G2 I0.5 J0 F300
G2 I0.5 J0 F300
G2 I0.5 J0 F300
G2 I0.5 J0 F300

M109 S140 ; wait nozzle temp down to heatbed acceptable
G2 I0.5 J0 F3000
G2 I0.5 J0 F3000
G2 I0.5 J0 F3000
G2 I0.5 J0 F3000

M221 R; pop softend status
G1 Z10 F1200
M400
G1 Z10
G1 F30000
G1 X230 Y15
G29.2 S1 ; turn on ABL
;G28 ; home again after hard wipe mouth
M106 S0 ; turn off fan , too noisy
;===== wipe nozzle end ================================


;===== bed leveling ==================================
M1002 judge_flag g29_before_print_flag
M622 J1

    M1002 gcode_claim_action : 1
    G29 A X103.286 Y97.3575 I54.4586 J50.2795
    M400
    M500 ; save cali data

M623
;===== bed leveling end ================================

;===== home after wipe mouth============================
M1002 judge_flag g29_before_print_flag
M622 J0

    M1002 gcode_claim_action : 13
    G28

M623
;===== home after wipe mouth end =======================

M975 S1 ; turn on vibration supression


;=============turn on fans to prevent PLA jamming=================

    ;Prevent PLA from jamming

M106 P2 S100 ; turn on big fan ,to cool down toolhead


M104 S220 ; set extrude temp earlier, to reduce wait time

;===== mech mode fast check============================
G1 X128 Y128 Z10 F20000
M400 P200
M970.3 Q1 A7 B30 C80  H15 K0
M974 Q1 S2 P0

G1 X128 Y128 Z10 F20000
M400 P200
M970.3 Q0 A7 B30 C90 Q0 H15 K0
M974 Q0 S2 P0

M975 S1
G1 F30000
G1 X230 Y15
G28 X ; re-home XY
;===== fmech mode fast check============================


;===== noozle load line ===============================
M975 S1
G90
M83
T1000
G1 X18.0 Y1.0 Z0.8 F18000;Move to start position
M109 S220
G1 Z0.2
G0 E2 F300
G0 X240 E15 F6033.27
G0 Y11 E0.700 F1508.32
G0 X239.5
G0 E0.2
G0 Y1.5 E0.700
G0 X18 E15 F6033.27
M400

;===== for Textured PEI Plate , lower the nozzle as the nozzle was touching topmost of the texture when homing ==
;curr_bed_type=Cool Plate

;========turn off light and wait extrude temperature =============
M1002 gcode_claim_action : 0
M106 S0 ; turn off fan
M106 P2 S0 ; turn off big fan
M106 P3 S0 ; turn off chamber fan

M975 S1 ; turn on mech mode supression
G90
G21
M83 ; use relative distances for extrusion
; filament start gcode
M981 S1 P20000 ;open spaghetti detector
; CHANGE_LAYER
; Z_HEIGHT: 0.2
; LAYER_HEIGHT: 0.2
G1 E-.8 F1800
; layer num/total_layer_count: 1/1001
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0

M623
; update layer progress
M73 L1
M991 S0 P0 ;notify layer change
M106 S0
M106 P2 S0
M204 S500
M140 S50 
M190 S50 
M104 S200 
M109 S200 
M106 S255 
M83 ;relative extrusion mode 
G1 F25000 X110.0 Y100.0 Z0.1
G1 F15000 X100.0 Y110.0 Z0.1 E0.9407386813723233
G1 F15000 X90.0 Y100.0 Z0.1 E0.9407386813723233
G1 F15000 X100.0 Y90.0 Z0.1 E0.9407386813723233
G1 F15000 X110.0 Y100.0 Z0.1 E0.9407386813723233
G91
G0 F25000 X0.0 Y2.4492935982947065e-15 Z0.20000000000000004
G90 
M83 
G1 F15000 X100.0 Y110.0 Z0.30000000000000004 E0.9407386813723233
G1 F15000 X90.0 Y100.0 Z0.30000000000000004 E0.9407386813723233
G1 F15000 X100.0 Y90.0 Z0.30000000000000004 E0.9407386813723233
G1 F15000 X110.0 Y100.0 Z0.30000000000000004 E0.9407386813723233
G91
G0 F25000 X0.0 Y2.4492935982947065e-15 Z0.20000000000000007
G90 
M83 
G1 F15000 X100.0 Y110.0 Z0.5000000000000001 E0.9407386813723233
G1 F15000 X90.0 Y100.0 Z0.5000000000000001 E0.9407386813723233
G1 F15000 X100.0 Y90.0 Z0.5000000000000001 E0.9407386813723233
G1 F15000 X110.0 Y100.0 Z0.5000000000000001 E0.9407386813723233
G91
G0 F25000 X0.0 Y2.4492935982947065e-15 Z0.19999999999999996
G90 
M83 
G1 F15000 X100.0 Y110.0 Z0.7000000000000001 E0.9407386813723233
G1 F15000 X90.0 Y100.0 Z0.7000000000000001 E0.9407386813723233
G1 F15000 X100.0 Y90.0 Z0.7000000000000001 E0.9407386813723233
G1 F15000 X110.0 Y100.0 Z0.7000000000000001 E0.9407386813723233
G91
G0 F25000 X0.0 Y2.4492935982947065e-15 Z0.19999999999999996
G90 
M83 
G1 F15000 X100.0 Y110.0 Z0.9 E0.9407386813723233
G1 F15000 X90.0 Y100.0 Z0.9 E0.9407386813723233
G1 F15000 X100.0 Y90.0 Z0.9 E0.9407386813723233
G1 F15000 X110.0 Y100.0 Z0.9 E0.9407386813723233
G91
G0 F25000 X0.0 Y2.4492935982947065e-15 Z0.20000000000000007
G90 
M83 
G1 F15000 X100.0 Y110.0 Z1.1 E0.9407386813723233
G1 F15000 X90.0 Y100.0 Z1.1 E0.9407386813723233
G1 F15000 X100.0 Y90.0 Z1.1 E0.9407386813723233
G1 F15000 X110.0 Y100.0 Z1.1 E0.9407386813723233
G91
G0 F25000 X0.0 Y2.4492935982947065e-15 Z0.19999999999999996
G90 
M83 
G1 F15000 X100.0 Y110.0 Z1.3 E0.9407386813723233
G1 F15000 X90.0 Y100.0 Z1.3 E0.9407386813723233
G1 F15000 X100.0 Y90.0 Z1.3 E0.9407386813723233
G1 F15000 X110.0 Y100.0 Z1.3 E0.9407386813723233
G91
G0 F25000 X0.0 Y2.4492935982947065e-15 Z0.19999999999999996
G90 
M83 
G1 F15000 X100.0 Y110.0 Z1.5 E0.9407386813723233
G1 F15000 X90.0 Y100.0 Z1.5 E0.9407386813723233
G1 F15000 X100.0 Y90.0 Z1.5 E0.9407386813723233
G1 F15000 X110.0 Y100.0 Z1.5 E0.9407386813723233
G91
G0 F25000 X0.0 Y2.4492935982947065e-15 Z0.19999999999999996
G90 
M83 
G1 F15000 X100.0 Y110.0 Z1.7 E0.9407386813723233
G1 F15000 X90.0 Y100.0 Z1.7 E0.9407386813723233
G1 F15000 X100.0 Y90.0 Z1.7 E0.9407386813723233
G1 F15000 X110.0 Y100.0 Z1.7 E0.9407386813723233
G91
G0 F25000 X0.0 Y2.4492935982947065e-15 Z0.19999999999999996
G90 
M83 
G1 F15000 X100.0 Y110.0 Z1.9 E0.9407386813723233
G1 F15000 X90.0 Y100.0 Z1.9 E0.9407386813723233
G1 F15000 X100.0 Y90.0 Z1.9 E0.9407386813723233
G1 F15000 X110.0 Y100.0 Z1.9 E0.9407386813723233
G91
G0 F25000 X0.0 Y2.4492935982947065e-15 Z0.20000000000000018
G90 
M83 
G1 F15000 X100.0 Y110.0 Z2.1 E0.9407386813723233
G1 F15000 X90.0 Y100.0 Z2.1 E0.9407386813723233
G1 F15000 X100.0 Y90.0 Z2.1 E0.9407386813723233
G1 F15000 X110.0 Y100.0 Z2.1 E0.9407386813723233
G91
G0 F25000 X0.0 Y2.4492935982947065e-15 Z0.20000000000000018
G90 
M83 
G1 F15000 X100.0 Y110.0 Z2.3000000000000003 E0.9407386813723233
G1 F15000 X90.0 Y100.0 Z2.3000000000000003 E0.9407386813723233
G1 F15000 X100.0 Y90.0 Z2.3000000000000003 E0.9407386813723233
G1 F15000 X110.0 Y100.0 Z2.3000000000000003 E0.9407386813723233
G91
G0 F25000 X0.0 Y2.4492935982947065e-15 Z0.19999999999999973
G90 
M83 
G1 F15000 X100.0 Y110.0 Z2.5 E0.9407386813723233
G1 F15000 X90.0 Y100.0 Z2.5 E0.9407386813723233
G1 F15000 X100.0 Y90.0 Z2.5 E0.9407386813723233
G1 F15000 X110.0 Y100.0 Z2.5 E0.9407386813723233
G91
G0 F25000 X0.0 Y2.4492935982947065e-15 Z0.20000000000000018
G90 
M83 
G1 F15000 X100.0 Y110.0 Z2.7 E0.9407386813723233
G1 F15000 X90.0 Y100.0 Z2.7 E0.9407386813723233
G1 F15000 X100.0 Y90.0 Z2.7 E0.9407386813723233
G1 F15000 X110.0 Y100.0 Z2.7 E0.9407386813723233
G91
G0 F25000 X0.0 Y2.4492935982947065e-15 Z0.19999999999999973
G90 
M83 
G1 F15000 X100.0 Y110.0 Z2.9 E0.9407386813723233
G1 F15000 X90.0 Y100.0 Z2.9 E0.9407386813723233
G1 F15000 X100.0 Y90.0 Z2.9 E0.9407386813723233
G1 F15000 X110.0 Y100.0 Z2.9 E0.9407386813723233
G91
G0 F25000 X0.0 Y2.4492935982947065e-15 Z0.20000000000000018
G90 
M83 
G1 F15000 X100.0 Y110.0 Z3.1 E0.9407386813723233
G1 F15000 X90.0 Y100.0 Z3.1 E0.9407386813723233
G1 F15000 X100.0 Y90.0 Z3.1 E0.9407386813723233
G1 F15000 X110.0 Y100.0 Z3.1 E0.9407386813723233
G91
G0 F25000 X0.0 Y2.4492935982947065e-15 Z0.20000000000000018
G90 
M83 
G1 F15000 X100.0 Y110.0 Z3.3000000000000003 E0.9407386813723233
G1 F15000 X90.0 Y100.0 Z3.3000000000000003 E0.9407386813723233
G1 F15000 X100.0 Y90.0 Z3.3000000000000003 E0.9407386813723233
G1 F15000 X110.0 Y100.0 Z3.3000000000000003 E0.9407386813723233
G91
G0 F25000 X0.0 Y2.4492935982947065e-15 Z0.19999999999999973
G90 
M83 
G1 F15000 X100.0 Y110.0 Z3.5 E0.9407386813723233
G1 F15000 X90.0 Y100.0 Z3.5 E0.9407386813723233
G1 F15000 X100.0 Y90.0 Z3.5 E0.9407386813723233
G1 F15000 X110.0 Y100.0 Z3.5 E0.9407386813723233
G91
G0 F25000 X0.0 Y2.4492935982947065e-15 Z0.20000000000000018
G90 
M83 
G1 F15000 X100.0 Y110.0 Z3.7 E0.9407386813723233
G1 F15000 X90.0 Y100.0 Z3.7 E0.9407386813723233
G1 F15000 X100.0 Y90.0 Z3.7 E0.9407386813723233
G1 F15000 X110.0 Y100.0 Z3.7 E0.9407386813723233
G91
G0 F25000 X0.0 Y2.4492935982947065e-15 Z0.19999999999999973
G90 
M83 
G1 F15000 X100.0 Y110.0 Z3.9 E0.9407386813723233
G1 F15000 X90.0 Y100.0 Z3.9 E0.9407386813723233
G1 F15000 X100.0 Y90.0 Z3.9 E0.9407386813723233
G1 F15000 X110.0 Y100.0 Z3.9 E0.9407386813723233
G91
G0 F25000 X0.0 Y2.4492935982947065e-15 Z0.20000000000000062
G90 
M83 
G1 F15000 X100.0 Y110.0 Z4.1000000000000005 E0.9407386813723233
G1 F15000 X90.0 Y100.0 Z4.1000000000000005 E0.9407386813723233
G1 F15000 X100.0 Y90.0 Z4.1000000000000005 E0.9407386813723233
G1 F15000 X110.0 Y100.0 Z4.1000000000000005 E0.9407386813723233
G91
G0 F25000 X0.0 Y2.4492935982947065e-15 Z0.20000000000000018
G90 
M83 
G1 F15000 X100.0 Y110.0 Z4.300000000000001 E0.9407386813723233
G1 F15000 X90.0 Y100.0 Z4.300000000000001 E0.9407386813723233
G1 F15000 X100.0 Y90.0 Z4.300000000000001 E0.9407386813723233
G1 F15000 X110.0 Y100.0 Z4.300000000000001 E0.9407386813723233
G91
G0 F25000 X0.0 Y2.4492935982947065e-15 Z0.20000000000000018
G90 
M83 
G1 F15000 X100.0 Y110.0 Z4.500000000000001 E0.9407386813723233
G1 F15000 X90.0 Y100.0 Z4.500000000000001 E0.9407386813723233
G1 F15000 X100.0 Y90.0 Z4.500000000000001 E0.9407386813723233
G1 F15000 X110.0 Y100.0 Z4.500000000000001 E0.9407386813723233
G91
G0 F25000 X0.0 Y2.4492935982947065e-15 Z0.20000000000000018
G90 
M83 
G1 F15000 X100.0 Y110.0 Z4.700000000000001 E0.9407386813723233
G1 F15000 X90.0 Y100.0 Z4.700000000000001 E0.9407386813723233
G1 F15000 X100.0 Y90.0 Z4.700000000000001 E0.9407386813723233
G1 F15000 X110.0 Y100.0 Z4.700000000000001 E0.9407386813723233
G91
G0 F25000 X0.0 Y2.4492935982947065e-15 Z0.1999999999999993
G90 
M83 
G1 F15000 X100.0 Y110.0 Z4.9 E0.9407386813723233
G1 F15000 X90.0 Y100.0 Z4.9 E0.9407386813723233
G1 F15000 X100.0 Y90.0 Z4.9 E0.9407386813723233
G1 F15000 X110.0 Y100.0 Z4.9 E0.9407386813723233
G91
G0 F25000 X0.0 Y2.4492935982947065e-15 Z0.20000000000000018
G90 
M83 
G1 F15000 X100.0 Y110.0 Z5.1000000000000005 E0.9407386813723233
G1 F15000 X90.0 Y100.0 Z5.1000000000000005 E0.9407386813723233
G1 F15000 X100.0 Y90.0 Z5.1000000000000005 E0.9407386813723233
G1 F15000 X110.0 Y100.0 Z5.1000000000000005 E0.9407386813723233
G91
G0 F25000 X0.0 Y2.4492935982947065e-15 Z0.20000000000000018
G90 
M83 
G1 F15000 X100.0 Y110.0 Z5.300000000000001 E0.9407386813723233
G1 F15000 X90.0 Y100.0 Z5.300000000000001 E0.9407386813723233
G1 F15000 X100.0 Y90.0 Z5.300000000000001 E0.9407386813723233
G1 F15000 X110.0 Y100.0 Z5.300000000000001 E0.9407386813723233
G91
G0 F25000 X0.0 Y2.4492935982947065e-15 Z0.20000000000000018
G90 
M83 
G1 F15000 X100.0 Y110.0 Z5.500000000000001 E0.9407386813723233
G1 F15000 X90.0 Y100.0 Z5.500000000000001 E0.9407386813723233
G1 F15000 X100.0 Y90.0 Z5.500000000000001 E0.9407386813723233
G1 F15000 X110.0 Y100.0 Z5.500000000000001 E0.9407386813723233
G91
G0 F25000 X0.0 Y2.4492935982947065e-15 Z0.20000000000000018
G90 
M83 
G1 F15000 X100.0 Y110.0 Z5.700000000000001 E0.9407386813723233
G1 F15000 X90.0 Y100.0 Z5.700000000000001 E0.9407386813723233
G1 F15000 X100.0 Y90.0 Z5.700000000000001 E0.9407386813723233
G1 F15000 X110.0 Y100.0 Z5.700000000000001 E0.9407386813723233
G91
G0 F25000 X0.0 Y2.4492935982947065e-15 Z0.1999999999999993
G90 
M83 
G1 F15000 X100.0 Y110.0 Z5.9 E0.9407386813723233
G1 F15000 X90.0 Y100.0 Z5.9 E0.9407386813723233
G1 F15000 X100.0 Y90.0 Z5.9 E0.9407386813723233
G1 F15000 X110.0 Y100.0 Z5.9 E0.9407386813723233
G91
G0 F25000 X0.0 Y2.4492935982947065e-15 Z0.20000000000000018
G90 
M83 
G1 F15000 X100.0 Y110.0 Z6.1000000000000005 E0.9407386813723233
G1 F15000 X90.0 Y100.0 Z6.1000000000000005 E0.9407386813723233
G1 F15000 X100.0 Y90.0 Z6.1000000000000005 E0.9407386813723233
G1 F15000 X110.0 Y100.0 Z6.1000000000000005 E0.9407386813723233
G91
G0 F25000 X0.0 Y2.4492935982947065e-15 Z0.20000000000000018
G90 
M83 
G1 F15000 X100.0 Y110.0 Z6.300000000000001 E0.9407386813723233
G1 F15000 X90.0 Y100.0 Z6.300000000000001 E0.9407386813723233
G1 F15000 X100.0 Y90.0 Z6.300000000000001 E0.9407386813723233
G1 F15000 X110.0 Y100.0 Z6.300000000000001 E0.9407386813723233
G91
G0 F25000 X0.0 Y2.4492935982947065e-15 Z0.20000000000000018
G90 
M83 
G1 F15000 X100.0 Y110.0 Z6.500000000000001 E0.9407386813723233
G1 F15000 X90.0 Y100.0 Z6.500000000000001 E0.9407386813723233
G1 F15000 X100.0 Y90.0 Z6.500000000000001 E0.9407386813723233
G1 F15000 X110.0 Y100.0 Z6.500000000000001 E0.9407386813723233
G91
G0 F25000 X0.0 Y2.4492935982947065e-15 Z0.20000000000000018
G90 
M83 
G1 F15000 X100.0 Y110.0 Z6.700000000000001 E0.9407386813723233
G1 F15000 X90.0 Y100.0 Z6.700000000000001 E0.9407386813723233
G1 F15000 X100.0 Y90.0 Z6.700000000000001 E0.9407386813723233
G1 F15000 X110.0 Y100.0 Z6.700000000000001 E0.9407386813723233
G91
G0 F25000 X0.0 Y2.4492935982947065e-15 Z0.1999999999999993
G90 
M83 
G1 F15000 X100.0 Y110.0 Z6.9 E0.9407386813723233
G1 F15000 X90.0 Y100.0 Z6.9 E0.9407386813723233
G1 F15000 X100.0 Y90.0 Z6.9 E0.9407386813723233
G1 F15000 X110.0 Y100.0 Z6.9 E0.9407386813723233
G91
G0 F25000 X0.0 Y2.4492935982947065e-15 Z0.20000000000000018
G90 
M83 
G1 F15000 X100.0 Y110.0 Z7.1000000000000005 E0.9407386813723233
G1 F15000 X90.0 Y100.0 Z7.1000000000000005 E0.9407386813723233
G1 F15000 X100.0 Y90.0 Z7.1000000000000005 E0.9407386813723233
G1 F15000 X110.0 Y100.0 Z7.1000000000000005 E0.9407386813723233
G91
G0 F25000 X0.0 Y2.4492935982947065e-15 Z0.20000000000000018
G90 
M83 
G1 F15000 X100.0 Y110.0 Z7.300000000000001 E0.9407386813723233
G1 F15000 X90.0 Y100.0 Z7.300000000000001 E0.9407386813723233
G1 F15000 X100.0 Y90.0 Z7.300000000000001 E0.9407386813723233
G1 F15000 X110.0 Y100.0 Z7.300000000000001 E0.9407386813723233
G91
G0 F25000 X0.0 Y2.4492935982947065e-15 Z0.20000000000000018
G90 
M83 
G1 F15000 X100.0 Y110.0 Z7.500000000000001 E0.9407386813723233
G1 F15000 X90.0 Y100.0 Z7.500000000000001 E0.9407386813723233
G1 F15000 X100.0 Y90.0 Z7.500000000000001 E0.9407386813723233
G1 F15000 X110.0 Y100.0 Z7.500000000000001 E0.9407386813723233
G91
G0 F25000 X0.0 Y2.4492935982947065e-15 Z0.20000000000000018
G90 
M83 
G1 F15000 X100.0 Y110.0 Z7.700000000000001 E0.9407386813723233
G1 F15000 X90.0 Y100.0 Z7.700000000000001 E0.9407386813723233
G1 F15000 X100.0 Y90.0 Z7.700000000000001 E0.9407386813723233
G1 F15000 X110.0 Y100.0 Z7.700000000000001 E0.9407386813723233
G91
G0 F25000 X0.0 Y2.4492935982947065e-15 Z0.1999999999999993
G90 
M83 
G1 F15000 X100.0 Y110.0 Z7.9 E0.9407386813723233
G1 F15000 X90.0 Y100.0 Z7.9 E0.9407386813723233
G1 F15000 X100.0 Y90.0 Z7.9 E0.9407386813723233
G1 F15000 X110.0 Y100.0 Z7.9 E0.9407386813723233
G91
G0 F25000 X0.0 Y2.4492935982947065e-15 Z0.20000000000000107
G90 
M83 
G1 F15000 X100.0 Y110.0 Z8.100000000000001 E0.9407386813723233
G1 F15000 X90.0 Y100.0 Z8.100000000000001 E0.9407386813723233
G1 F15000 X100.0 Y90.0 Z8.100000000000001 E0.9407386813723233
G1 F15000 X110.0 Y100.0 Z8.100000000000001 E0.9407386813723233
G91
G0 F25000 X0.0 Y2.4492935982947065e-15 Z0.1999999999999993
G90 
M83 
G1 F15000 X100.0 Y110.0 Z8.3 E0.9407386813723233
G1 F15000 X90.0 Y100.0 Z8.3 E0.9407386813723233
G1 F15000 X100.0 Y90.0 Z8.3 E0.9407386813723233
G1 F15000 X110.0 Y100.0 Z8.3 E0.9407386813723233
G91
G0 F25000 X0.0 Y2.4492935982947065e-15 Z0.1999999999999993
G90 
M83 
G1 F15000 X100.0 Y110.0 Z8.5 E0.9407386813723233
G1 F15000 X90.0 Y100.0 Z8.5 E0.9407386813723233
G1 F15000 X100.0 Y90.0 Z8.5 E0.9407386813723233
G1 F15000 X110.0 Y100.0 Z8.5 E0.9407386813723233
G91
G0 F25000 X0.0 Y2.4492935982947065e-15 Z0.20000000000000107
G90 
M83 
G1 F15000 X100.0 Y110.0 Z8.700000000000001 E0.9407386813723233
G1 F15000 X90.0 Y100.0 Z8.700000000000001 E0.9407386813723233
G1 F15000 X100.0 Y90.0 Z8.700000000000001 E0.9407386813723233
G1 F15000 X110.0 Y100.0 Z8.700000000000001 E0.9407386813723233
G91
G0 F25000 X0.0 Y2.4492935982947065e-15 Z0.1999999999999993
G90 
M83 
G1 F15000 X100.0 Y110.0 Z8.9 E0.9407386813723233
G1 F15000 X90.0 Y100.0 Z8.9 E0.9407386813723233
G1 F15000 X100.0 Y90.0 Z8.9 E0.9407386813723233
G1 F15000 X110.0 Y100.0 Z8.9 E0.9407386813723233
G91
G0 F25000 X0.0 Y2.4492935982947065e-15 Z0.20000000000000107
G90 
M83 
G1 F15000 X100.0 Y110.0 Z9.100000000000001 E0.9407386813723233
G1 F15000 X90.0 Y100.0 Z9.100000000000001 E0.9407386813723233
G1 F15000 X100.0 Y90.0 Z9.100000000000001 E0.9407386813723233
G1 F15000 X110.0 Y100.0 Z9.100000000000001 E0.9407386813723233
G91
G0 F25000 X0.0 Y2.4492935982947065e-15 Z0.1999999999999993
G90 
M83 
G1 F15000 X100.0 Y110.0 Z9.3 E0.9407386813723233
G1 F15000 X90.0 Y100.0 Z9.3 E0.9407386813723233
G1 F15000 X100.0 Y90.0 Z9.3 E0.9407386813723233
G1 F15000 X110.0 Y100.0 Z9.3 E0.9407386813723233
G91
G0 F25000 X0.0 Y2.4492935982947065e-15 Z0.20000000000000107
G90 
M83 
G1 F15000 X100.0 Y110.0 Z9.500000000000002 E0.9407386813723233
G1 F15000 X90.0 Y100.0 Z9.500000000000002 E0.9407386813723233
G1 F15000 X100.0 Y90.0 Z9.500000000000002 E0.9407386813723233
G1 F15000 X110.0 Y100.0 Z9.500000000000002 E0.9407386813723233
G91
G0 F25000 X0.0 Y2.4492935982947065e-15 Z0.1999999999999993
G90 
M83 
G1 F15000 X100.0 Y110.0 Z9.700000000000001 E0.9407386813723233
G1 F15000 X90.0 Y100.0 Z9.700000000000001 E0.9407386813723233
G1 F15000 X100.0 Y90.0 Z9.700000000000001 E0.9407386813723233
G1 F15000 X110.0 Y100.0 Z9.700000000000001 E0.9407386813723233
G91
G0 F25000 X0.0 Y2.4492935982947065e-15 Z0.1999999999999993
G90 
M83 
G1 F15000 X100.0 Y110.0 Z9.9 E0.9407386813723233
G1 F15000 X90.0 Y100.0 Z9.9 E0.9407386813723233
G1 F15000 X100.0 Y90.0 Z9.9 E0.9407386813723233
G1 F15000 X110.0 Y100.0 Z9.9 E0.9407386813723233
G91
G0 F25000 X0.0 Y2.4492935982947065e-15 Z0.20000000000000107
G90 
M83 
G1 F15000 X100.0 Y110.0 Z10.100000000000001 E0.47036934068616165
G1 F15000 X90.0 Y100.0 Z10.100000000000001 E0.47036934068616165
G1 F15000 X100.0 Y90.0 Z10.100000000000001 E0.47036934068616165
G1 F15000 X110.0 Y100.0 Z10.100000000000001 E0.47036934068616165
G91
G0 F25000 X0.0 Y2.4492935982947065e-15 Z0.1999999999999993
G90 
M83 
G1 F15000 X100.0 Y110.0 Z10.3 E0.47036934068616165
G1 F15000 X90.0 Y100.0 Z10.3 E0.47036934068616165
G1 F15000 X100.0 Y90.0 Z10.3 E0.47036934068616165
G1 F15000 X110.0 Y100.0 Z10.3 E0.47036934068616165
G91
G0 F25000 X0.0 Y2.4492935982947065e-15 Z0.20000000000000107
G90 
M83 
G1 F15000 X100.0 Y110.0 Z10.500000000000002 E0.47036934068616165
G1 F15000 X90.0 Y100.0 Z10.500000000000002 E0.47036934068616165
G1 F15000 X100.0 Y90.0 Z10.500000000000002 E0.47036934068616165
G1 F15000 X110.0 Y100.0 Z10.500000000000002 E0.47036934068616165
G91
G0 F25000 X0.0 Y2.4492935982947065e-15 Z0.1999999999999993
G90 
M83 
G1 F15000 X100.0 Y110.0 Z10.700000000000001 E0.47036934068616165
G1 F15000 X90.0 Y100.0 Z10.700000000000001 E0.47036934068616165
G1 F15000 X100.0 Y90.0 Z10.700000000000001 E0.47036934068616165
G1 F15000 X110.0 Y100.0 Z10.700000000000001 E0.47036934068616165
G91
G0 F25000 X0.0 Y2.4492935982947065e-15 Z0.1999999999999993
G90 
M83 
G1 F15000 X100.0 Y110.0 Z10.9 E0.47036934068616165
G1 F15000 X90.0 Y100.0 Z10.9 E0.47036934068616165
G1 F15000 X100.0 Y90.0 Z10.9 E0.47036934068616165
G1 F15000 X110.0 Y100.0 Z10.9 E0.47036934068616165
G91
G0 F25000 X0.0 Y2.4492935982947065e-15 Z0.20000000000000107
G90 
M83 
G1 F15000 X100.0 Y110.0 Z11.100000000000001 E0.47036934068616165
G1 F15000 X90.0 Y100.0 Z11.100000000000001 E0.47036934068616165
G1 F15000 X100.0 Y90.0 Z11.100000000000001 E0.47036934068616165
G1 F15000 X110.0 Y100.0 Z11.100000000000001 E0.47036934068616165
G91
G0 F25000 X0.0 Y2.4492935982947065e-15 Z0.1999999999999993
G90 
M83 
G1 F15000 X100.0 Y110.0 Z11.3 E0.47036934068616165
G1 F15000 X90.0 Y100.0 Z11.3 E0.47036934068616165
G1 F15000 X100.0 Y90.0 Z11.3 E0.47036934068616165
G1 F15000 X110.0 Y100.0 Z11.3 E0.47036934068616165
G91
G0 F25000 X0.0 Y2.4492935982947065e-15 Z0.20000000000000107
G90 
M83 
G1 F15000 X100.0 Y110.0 Z11.500000000000002 E0.47036934068616165
G1 F15000 X90.0 Y100.0 Z11.500000000000002 E0.47036934068616165
G1 F15000 X100.0 Y90.0 Z11.500000000000002 E0.47036934068616165
G1 F15000 X110.0 Y100.0 Z11.500000000000002 E0.47036934068616165
G91
G0 F25000 X0.0 Y2.4492935982947065e-15 Z0.1999999999999993
G90 
M83 
G1 F15000 X100.0 Y110.0 Z11.700000000000001 E0.47036934068616165
G1 F15000 X90.0 Y100.0 Z11.700000000000001 E0.47036934068616165
G1 F15000 X100.0 Y90.0 Z11.700000000000001 E0.47036934068616165
G1 F15000 X110.0 Y100.0 Z11.700000000000001 E0.47036934068616165
G91
G0 F25000 X0.0 Y2.4492935982947065e-15 Z0.1999999999999993
G90 
M83 
G1 F15000 X100.0 Y110.0 Z11.9 E0.47036934068616165
G1 F15000 X90.0 Y100.0 Z11.9 E0.47036934068616165
G1 F15000 X100.0 Y90.0 Z11.9 E0.47036934068616165
G1 F15000 X110.0 Y100.0 Z11.9 E0.47036934068616165
G91
G0 F25000 X0.0 Y2.4492935982947065e-15 Z0.20000000000000107
G90 
M83 
G1 F15000 X100.0 Y110.0 Z12.100000000000001 E0.47036934068616165
G1 F15000 X90.0 Y100.0 Z12.100000000000001 E0.47036934068616165
G1 F15000 X100.0 Y90.0 Z12.100000000000001 E0.47036934068616165
G1 F15000 X110.0 Y100.0 Z12.100000000000001 E0.47036934068616165
G91
G0 F25000 X0.0 Y2.4492935982947065e-15 Z0.1999999999999993
G90 
M83 
G1 F15000 X100.0 Y110.0 Z12.3 E0.47036934068616165
G1 F15000 X90.0 Y100.0 Z12.3 E0.47036934068616165
G1 F15000 X100.0 Y90.0 Z12.3 E0.47036934068616165
G1 F15000 X110.0 Y100.0 Z12.3 E0.47036934068616165
G91
G0 F25000 X0.0 Y2.4492935982947065e-15 Z0.20000000000000107
G90 
M83 
G1 F15000 X100.0 Y110.0 Z12.500000000000002 E0.47036934068616165
G1 F15000 X90.0 Y100.0 Z12.500000000000002 E0.47036934068616165
G1 F15000 X100.0 Y90.0 Z12.500000000000002 E0.47036934068616165
G1 F15000 X110.0 Y100.0 Z12.500000000000002 E0.47036934068616165
G91
G0 F25000 X0.0 Y2.4492935982947065e-15 Z0.1999999999999993
G90 
M83 
G1 F15000 X100.0 Y110.0 Z12.700000000000001 E0.47036934068616165
G1 F15000 X90.0 Y100.0 Z12.700000000000001 E0.47036934068616165
G1 F15000 X100.0 Y90.0 Z12.700000000000001 E0.47036934068616165
G1 F15000 X110.0 Y100.0 Z12.700000000000001 E0.47036934068616165
G91
G0 F25000 X0.0 Y2.4492935982947065e-15 Z0.1999999999999993
G90 
M83 
G1 F15000 X100.0 Y110.0 Z12.9 E0.47036934068616165
G1 F15000 X90.0 Y100.0 Z12.9 E0.47036934068616165
G1 F15000 X100.0 Y90.0 Z12.9 E0.47036934068616165
G1 F15000 X110.0 Y100.0 Z12.9 E0.47036934068616165
G91
G0 F25000 X0.0 Y2.4492935982947065e-15 Z0.20000000000000107
G90 
M83 
G1 F15000 X100.0 Y110.0 Z13.100000000000001 E0.47036934068616165
G1 F15000 X90.0 Y100.0 Z13.100000000000001 E0.47036934068616165
G1 F15000 X100.0 Y90.0 Z13.100000000000001 E0.47036934068616165
G1 F15000 X110.0 Y100.0 Z13.100000000000001 E0.47036934068616165
G91
G0 F25000 X0.0 Y2.4492935982947065e-15 Z0.1999999999999993
G90 
M83 
G1 F15000 X100.0 Y110.0 Z13.3 E0.47036934068616165
G1 F15000 X90.0 Y100.0 Z13.3 E0.47036934068616165
G1 F15000 X100.0 Y90.0 Z13.3 E0.47036934068616165
G1 F15000 X110.0 Y100.0 Z13.3 E0.47036934068616165
G91
G0 F25000 X0.0 Y2.4492935982947065e-15 Z0.20000000000000107
G90 
M83 
G1 F15000 X100.0 Y110.0 Z13.500000000000002 E0.47036934068616165
G1 F15000 X90.0 Y100.0 Z13.500000000000002 E0.47036934068616165
G1 F15000 X100.0 Y90.0 Z13.500000000000002 E0.47036934068616165
G1 F15000 X110.0 Y100.0 Z13.500000000000002 E0.47036934068616165
G91
G0 F25000 X0.0 Y2.4492935982947065e-15 Z0.1999999999999993
G90 
M83 
G1 F15000 X100.0 Y110.0 Z13.700000000000001 E0.47036934068616165
G1 F15000 X90.0 Y100.0 Z13.700000000000001 E0.47036934068616165
G1 F15000 X100.0 Y90.0 Z13.700000000000001 E0.47036934068616165
G1 F15000 X110.0 Y100.0 Z13.700000000000001 E0.47036934068616165
G91
G0 F25000 X0.0 Y2.4492935982947065e-15 Z0.1999999999999993
G90 
M83 
G1 F15000 X100.0 Y110.0 Z13.9 E0.47036934068616165
G1 F15000 X90.0 Y100.0 Z13.9 E0.47036934068616165
G1 F15000 X100.0 Y90.0 Z13.9 E0.47036934068616165
G1 F15000 X110.0 Y100.0 Z13.9 E0.47036934068616165
G91
G0 F25000 X0.0 Y2.4492935982947065e-15 Z0.20000000000000107
G90 
M83 
G1 F15000 X100.0 Y110.0 Z14.100000000000001 E0.47036934068616165
G1 F15000 X90.0 Y100.0 Z14.100000000000001 E0.47036934068616165
G1 F15000 X100.0 Y90.0 Z14.100000000000001 E0.47036934068616165
G1 F15000 X110.0 Y100.0 Z14.100000000000001 E0.47036934068616165
G91
G0 F25000 X0.0 Y2.4492935982947065e-15 Z0.1999999999999993
G90 
M83 
G1 F15000 X100.0 Y110.0 Z14.3 E0.47036934068616165
G1 F15000 X90.0 Y100.0 Z14.3 E0.47036934068616165
G1 F15000 X100.0 Y90.0 Z14.3 E0.47036934068616165
G1 F15000 X110.0 Y100.0 Z14.3 E0.47036934068616165
G91
G0 F25000 X0.0 Y2.4492935982947065e-15 Z0.20000000000000107
G90 
M83 
G1 F15000 X100.0 Y110.0 Z14.500000000000002 E0.47036934068616165
G1 F15000 X90.0 Y100.0 Z14.500000000000002 E0.47036934068616165
G1 F15000 X100.0 Y90.0 Z14.500000000000002 E0.47036934068616165
G1 F15000 X110.0 Y100.0 Z14.500000000000002 E0.47036934068616165
G91
G0 F25000 X0.0 Y2.4492935982947065e-15 Z0.1999999999999993
G90 
M83 
G1 F15000 X100.0 Y110.0 Z14.700000000000001 E0.47036934068616165
G1 F15000 X90.0 Y100.0 Z14.700000000000001 E0.47036934068616165
G1 F15000 X100.0 Y90.0 Z14.700000000000001 E0.47036934068616165
G1 F15000 X110.0 Y100.0 Z14.700000000000001 E0.47036934068616165
G91
G0 F25000 X0.0 Y2.4492935982947065e-15 Z0.1999999999999993
G90 
M83 
G1 F15000 X100.0 Y110.0 Z14.9 E0.47036934068616165
G1 F15000 X90.0 Y100.0 Z14.9 E0.47036934068616165
G1 F15000 X100.0 Y90.0 Z14.9 E0.47036934068616165
G1 F15000 X110.0 Y100.0 Z14.9 E0.47036934068616165
G91
G0 F25000 X0.0 Y2.4492935982947065e-15 Z0.20000000000000107
G90 
M83 
G1 F15000 X100.0 Y110.0 Z15.100000000000001 E0.47036934068616165
G1 F15000 X90.0 Y100.0 Z15.100000000000001 E0.47036934068616165
G1 F15000 X100.0 Y90.0 Z15.100000000000001 E0.47036934068616165
G1 F15000 X110.0 Y100.0 Z15.100000000000001 E0.47036934068616165
G91
G0 F25000 X0.0 Y2.4492935982947065e-15 Z0.1999999999999993
G90 
M83 
G1 F15000 X100.0 Y110.0 Z15.3 E0.47036934068616165
G1 F15000 X90.0 Y100.0 Z15.3 E0.47036934068616165
G1 F15000 X100.0 Y90.0 Z15.3 E0.47036934068616165
G1 F15000 X110.0 Y100.0 Z15.3 E0.47036934068616165
G91
G0 F25000 X0.0 Y2.4492935982947065e-15 Z0.20000000000000107
G90 
M83 
G1 F15000 X100.0 Y110.0 Z15.500000000000002 E0.47036934068616165
G1 F15000 X90.0 Y100.0 Z15.500000000000002 E0.47036934068616165
G1 F15000 X100.0 Y90.0 Z15.500000000000002 E0.47036934068616165
G1 F15000 X110.0 Y100.0 Z15.500000000000002 E0.47036934068616165
G91
G0 F25000 X0.0 Y2.4492935982947065e-15 Z0.1999999999999993
G90 
M83 
G1 F15000 X100.0 Y110.0 Z15.700000000000001 E0.47036934068616165
G1 F15000 X90.0 Y100.0 Z15.700000000000001 E0.47036934068616165
G1 F15000 X100.0 Y90.0 Z15.700000000000001 E0.47036934068616165
G1 F15000 X110.0 Y100.0 Z15.700000000000001 E0.47036934068616165
G91
G0 F25000 X0.0 Y2.4492935982947065e-15 Z0.1999999999999993
G90 
M83 
G1 F15000 X100.0 Y110.0 Z15.9 E0.47036934068616165
G1 F15000 X90.0 Y100.0 Z15.9 E0.47036934068616165
G1 F15000 X100.0 Y90.0 Z15.9 E0.47036934068616165
G1 F15000 X110.0 Y100.0 Z15.9 E0.47036934068616165
G91
G0 F25000 X0.0 Y2.4492935982947065e-15 Z0.1999999999999975
G90 
M83 
G1 F15000 X100.0 Y110.0 Z16.099999999999998 E0.47036934068616165
G1 F15000 X90.0 Y100.0 Z16.099999999999998 E0.47036934068616165
G1 F15000 X100.0 Y90.0 Z16.099999999999998 E0.47036934068616165
G1 F15000 X110.0 Y100.0 Z16.099999999999998 E0.47036934068616165
G91
G0 F25000 X0.0 Y2.4492935982947065e-15 Z0.20000000000000284
G90 
M83 
G1 F15000 X100.0 Y110.0 Z16.3 E0.47036934068616165
G1 F15000 X90.0 Y100.0 Z16.3 E0.47036934068616165
G1 F15000 X100.0 Y90.0 Z16.3 E0.47036934068616165
G1 F15000 X110.0 Y100.0 Z16.3 E0.47036934068616165
G91
G0 F25000 X0.0 Y2.4492935982947065e-15 Z0.1999999999999993
G90 
M83 
G1 F15000 X100.0 Y110.0 Z16.5 E0.47036934068616165
G1 F15000 X90.0 Y100.0 Z16.5 E0.47036934068616165
G1 F15000 X100.0 Y90.0 Z16.5 E0.47036934068616165
G1 F15000 X110.0 Y100.0 Z16.5 E0.47036934068616165
G91
G0 F25000 X0.0 Y2.4492935982947065e-15 Z0.1999999999999993
G90 
M83 
G1 F15000 X100.0 Y110.0 Z16.7 E0.47036934068616165
G1 F15000 X90.0 Y100.0 Z16.7 E0.47036934068616165
G1 F15000 X100.0 Y90.0 Z16.7 E0.47036934068616165
G1 F15000 X110.0 Y100.0 Z16.7 E0.47036934068616165
G91
G0 F25000 X0.0 Y2.4492935982947065e-15 Z0.1999999999999993
G90 
M83 
G1 F15000 X100.0 Y110.0 Z16.9 E0.47036934068616165
G1 F15000 X90.0 Y100.0 Z16.9 E0.47036934068616165
G1 F15000 X100.0 Y90.0 Z16.9 E0.47036934068616165
G1 F15000 X110.0 Y100.0 Z16.9 E0.47036934068616165
G91
G0 F25000 X0.0 Y2.4492935982947065e-15 Z0.1999999999999993
G90 
M83 
G1 F15000 X100.0 Y110.0 Z17.099999999999998 E0.47036934068616165
G1 F15000 X90.0 Y100.0 Z17.099999999999998 E0.47036934068616165
G1 F15000 X100.0 Y90.0 Z17.099999999999998 E0.47036934068616165
G1 F15000 X110.0 Y100.0 Z17.099999999999998 E0.47036934068616165
G91
G0 F25000 X0.0 Y2.4492935982947065e-15 Z0.20000000000000284
G90 
M83 
G1 F15000 X100.0 Y110.0 Z17.3 E0.47036934068616165
G1 F15000 X90.0 Y100.0 Z17.3 E0.47036934068616165
G1 F15000 X100.0 Y90.0 Z17.3 E0.47036934068616165
G1 F15000 X110.0 Y100.0 Z17.3 E0.47036934068616165
G91
G0 F25000 X0.0 Y2.4492935982947065e-15 Z0.1999999999999993
G90 
M83 
G1 F15000 X100.0 Y110.0 Z17.5 E0.47036934068616165
G1 F15000 X90.0 Y100.0 Z17.5 E0.47036934068616165
G1 F15000 X100.0 Y90.0 Z17.5 E0.47036934068616165
G1 F15000 X110.0 Y100.0 Z17.5 E0.47036934068616165
G91
G0 F25000 X0.0 Y2.4492935982947065e-15 Z0.1999999999999993
G90 
M83 
G1 F15000 X100.0 Y110.0 Z17.7 E0.47036934068616165
G1 F15000 X90.0 Y100.0 Z17.7 E0.47036934068616165
G1 F15000 X100.0 Y90.0 Z17.7 E0.47036934068616165
G1 F15000 X110.0 Y100.0 Z17.7 E0.47036934068616165
G91
G0 F25000 X0.0 Y2.4492935982947065e-15 Z0.1999999999999993
G90 
M83 
G1 F15000 X100.0 Y110.0 Z17.9 E0.47036934068616165
G1 F15000 X90.0 Y100.0 Z17.9 E0.47036934068616165
G1 F15000 X100.0 Y90.0 Z17.9 E0.47036934068616165
G1 F15000 X110.0 Y100.0 Z17.9 E0.47036934068616165
G91
G0 F25000 X0.0 Y2.4492935982947065e-15 Z0.1999999999999993
G90 
M83 
G1 F15000 X100.0 Y110.0 Z18.099999999999998 E0.47036934068616165
G1 F15000 X90.0 Y100.0 Z18.099999999999998 E0.47036934068616165
G1 F15000 X100.0 Y90.0 Z18.099999999999998 E0.47036934068616165
G1 F15000 X110.0 Y100.0 Z18.099999999999998 E0.47036934068616165
G91
G0 F25000 X0.0 Y2.4492935982947065e-15 Z0.20000000000000284
G90 
M83 
G1 F15000 X100.0 Y110.0 Z18.3 E0.47036934068616165
G1 F15000 X90.0 Y100.0 Z18.3 E0.47036934068616165
G1 F15000 X100.0 Y90.0 Z18.3 E0.47036934068616165
G1 F15000 X110.0 Y100.0 Z18.3 E0.47036934068616165
G91
G0 F25000 X0.0 Y2.4492935982947065e-15 Z0.1999999999999993
G90 
M83 
G1 F15000 X100.0 Y110.0 Z18.5 E0.47036934068616165
G1 F15000 X90.0 Y100.0 Z18.5 E0.47036934068616165
G1 F15000 X100.0 Y90.0 Z18.5 E0.47036934068616165
G1 F15000 X110.0 Y100.0 Z18.5 E0.47036934068616165
G91
G0 F25000 X0.0 Y2.4492935982947065e-15 Z0.1999999999999993
G90 
M83 
G1 F15000 X100.0 Y110.0 Z18.7 E0.47036934068616165
G1 F15000 X90.0 Y100.0 Z18.7 E0.47036934068616165
G1 F15000 X100.0 Y90.0 Z18.7 E0.47036934068616165
G1 F15000 X110.0 Y100.0 Z18.7 E0.47036934068616165
G91
G0 F25000 X0.0 Y2.4492935982947065e-15 Z0.1999999999999993
G90 
M83 
G1 F15000 X100.0 Y110.0 Z18.9 E0.47036934068616165
G1 F15000 X90.0 Y100.0 Z18.9 E0.47036934068616165
G1 F15000 X100.0 Y90.0 Z18.9 E0.47036934068616165
G1 F15000 X110.0 Y100.0 Z18.9 E0.47036934068616165
G91
G0 F25000 X0.0 Y2.4492935982947065e-15 Z0.20000000000000284
G90 
M83 
G1 F15000 X100.0 Y110.0 Z19.1 E0.47036934068616165
G1 F15000 X90.0 Y100.0 Z19.1 E0.47036934068616165
G1 F15000 X100.0 Y90.0 Z19.1 E0.47036934068616165
G1 F15000 X110.0 Y100.0 Z19.1 E0.47036934068616165
G91
G0 F25000 X0.0 Y2.4492935982947065e-15 Z0.1999999999999993
G90 
M83 
G1 F15000 X100.0 Y110.0 Z19.3 E0.47036934068616165
G1 F15000 X90.0 Y100.0 Z19.3 E0.47036934068616165
G1 F15000 X100.0 Y90.0 Z19.3 E0.47036934068616165
G1 F15000 X110.0 Y100.0 Z19.3 E0.47036934068616165
G91
G0 F25000 X0.0 Y2.4492935982947065e-15 Z0.1999999999999993
G90 
M83 
G1 F15000 X100.0 Y110.0 Z19.5 E0.47036934068616165
G1 F15000 X90.0 Y100.0 Z19.5 E0.47036934068616165
G1 F15000 X100.0 Y90.0 Z19.5 E0.47036934068616165
G1 F15000 X110.0 Y100.0 Z19.5 E0.47036934068616165
G91
G0 F25000 X0.0 Y2.4492935982947065e-15 Z0.1999999999999993
G90 
M83 
G1 F15000 X100.0 Y110.0 Z19.7 E0.47036934068616165
G1 F15000 X90.0 Y100.0 Z19.7 E0.47036934068616165
G1 F15000 X100.0 Y90.0 Z19.7 E0.47036934068616165
G1 F15000 X110.0 Y100.0 Z19.7 E0.47036934068616165
G91
G0 F25000 X0.0 Y2.4492935982947065e-15 Z0.1999999999999993
G90 
M83 
G1 F15000 X100.0 Y110.0 Z19.9 E0.47036934068616165
G1 F15000 X90.0 Y100.0 Z19.9 E0.47036934068616165
G1 F15000 X100.0 Y90.0 Z19.9 E0.47036934068616165
G1 F15000 X110.0 Y100.0 Z19.9 E0.47036934068616165
; stop printing object, unique label id: 88
M625
M106 S0
M106 P2 S0
M981 S0 P20000 ; close spaghetti detector
; FEATURE: Custom
; filament end gcode 
M106 P3 S0
;===== date: 20230428 =====================
M400 ; wait for buffer to clear
G92 E0 ; zero the extruder
G1 E-0.8 F1800 ; retract
G1 Z100.7 F900 ; lower z a little
G1 X65 Y245 F12000 ; move to safe pos 
G1 Y265 F3000

G1 X65 Y245 F12000
G1 Y265 F3000
M140 S0 ; turn off bed
M106 S0 ; turn off fan
M106 P2 S0 ; turn off remote part cooling fan
M106 P3 S0 ; turn off chamber cooling fan

G1 X100 F12000 ; wipe
; pull back filament to AMS
M620 S255
G1 X20 Y50 F12000
G1 Y-3
T255
G1 X65 F12000
G1 Y265
G1 X100 F12000 ; wipe
M621 S255
M104 S0 ; turn off hotend

M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
    M400 ; wait all motion done
    M991 S0 P-1 ;end smooth timelapse at safe pos
    M400 S3 ;wait for last picture to be taken
M623; end of "timelapse_record_flag"

M400 ; wait all motion done
M17 S
M17 Z0.4 ; lower z motor current to reduce impact if there is something in the bottom

    G1 Z200.2 F600
    G1 Z198.2

M400 P100
M17 R ; restore z current

G90
G1 X128 Y250 F3600

M220 S100  ; Reset feedrate magnitude
M201.2 K1.0 ; Reset acc magnitude
M73.2   R1.0 ;Reset left time magnitude
M1002 set_gcode_claim_speed_level : 0

M17 X0.8 Y0.8 Z0.5 ; lower motor current to 45% power
M73 P100 R0
; EXECUTABLE_BLOCK_END

