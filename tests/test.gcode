;This is default G code from txt

M201 X1250 Y1250 Z400 E5000 ; sets maximum accelerations, mm/sec^2
M203 X180 Y180 Z12 E80 ; sets maximum feedrates, mm/sec
M204 P1250 R1250 T1250 ; sets acceleration (P, T) and retract acceleration (R), mm/sec^2
M205 X8.00 Y8.00 Z2.00 E10.00 ; sets the jerk limits, mm/sec
M205 S0 T0 ; sets the minimum extruding and travel feed rate, mm/sec


G90 ; use absolute coordinates
M83 ; extruder relative mode
M104 S200 ; set extruder temp for bed leveling
M140 S60
M109 R200 ; wait for bed leveling temp
M190 S60
G28 ; home all without mesh bed level
G29 ; mesh bed leveling 
M104 S200
G92 E0.0
G1 Y-2.0 X179 F2400
G1 Z30 F720
M109 S200

; intro line
G1 X170 F1000
G1 Z0.2 F720
G1 X110.0 E8.0 F900
M73 P0 R91
G1 X40.0 E10.0 F700
G92 E0.0

M221 S100 ; set flow
G21 ; set units to millimeters
G90 ; use absolute coordinates
M83 ; use relative distances for extrusion
M900 K0 ; No linear advance


G92 E0.0

G1 Z0.200 F9000.000


G1 E-3.20000 F4200.00000
G1 Z0.400 F9000.000
G1 X20.0 Y10.0
G1 Z0.300
G1 E3.20000 F2400.00000


M106 S255 ; set fan speed

;END OF THE START GCODE
G0 F5000 X110.0 Y100.0 Z0.0
G1 F1000 X100.0 Y110.0 Z0.0 E0.47036934068616165
G1 F1000 X90.0 Y100.0 Z0.0 E0.47036934068616165
G1 F1000 X100.0 Y90.0 Z0.0 E0.47036934068616165
G1 F1000 X110.0 Y100.0 Z0.0 E0.47036934068616165
G0 F5000 X110.0 Y100.0 Z0.1
G1 F1000 X100.0 Y110.0 Z0.1 E0.47036934068616165
G1 F1000 X90.0 Y100.0 Z0.1 E0.47036934068616165
G1 F1000 X100.0 Y90.0 Z0.1 E0.47036934068616165
G1 F1000 X110.0 Y100.0 Z0.1 E0.47036934068616165
G0 F5000 X110.0 Y100.0 Z0.2
G1 F1000 X100.0 Y110.0 Z0.2 E0.47036934068616165
G1 F1000 X90.0 Y100.0 Z0.2 E0.47036934068616165
G1 F1000 X100.0 Y90.0 Z0.2 E0.47036934068616165
G1 F1000 X110.0 Y100.0 Z0.2 E0.47036934068616165
G0 F5000 X110.0 Y100.0 Z0.30000000000000004
G1 F1000 X100.0 Y110.0 Z0.30000000000000004 E0.47036934068616165
G1 F1000 X90.0 Y100.0 Z0.30000000000000004 E0.47036934068616165
G1 F1000 X100.0 Y90.0 Z0.30000000000000004 E0.47036934068616165
G1 F1000 X110.0 Y100.0 Z0.30000000000000004 E0.47036934068616165
G0 F5000 X110.0 Y100.0 Z0.4
G1 F1000 X100.0 Y110.0 Z0.4 E0.47036934068616165
G1 F1000 X90.0 Y100.0 Z0.4 E0.47036934068616165
G1 F1000 X100.0 Y90.0 Z0.4 E0.47036934068616165
G1 F1000 X110.0 Y100.0 Z0.4 E0.47036934068616165
G0 F5000 X110.0 Y100.0 Z0.5
G1 F1000 X100.0 Y110.0 Z0.5 E0.47036934068616165
G1 F1000 X90.0 Y100.0 Z0.5 E0.47036934068616165
G1 F1000 X100.0 Y90.0 Z0.5 E0.47036934068616165
G1 F1000 X110.0 Y100.0 Z0.5 E0.47036934068616165
G0 F5000 X110.0 Y100.0 Z0.6000000000000001
G1 F1000 X100.0 Y110.0 Z0.6000000000000001 E0.47036934068616165
G1 F1000 X90.0 Y100.0 Z0.6000000000000001 E0.47036934068616165
G1 F1000 X100.0 Y90.0 Z0.6000000000000001 E0.47036934068616165
G1 F1000 X110.0 Y100.0 Z0.6000000000000001 E0.47036934068616165
G0 F5000 X110.0 Y100.0 Z0.7000000000000001
G1 F1000 X100.0 Y110.0 Z0.7000000000000001 E0.47036934068616165
G1 F1000 X90.0 Y100.0 Z0.7000000000000001 E0.47036934068616165
G1 F1000 X100.0 Y90.0 Z0.7000000000000001 E0.47036934068616165
G1 F1000 X110.0 Y100.0 Z0.7000000000000001 E0.47036934068616165
G0 F5000 X110.0 Y100.0 Z0.8
G1 F1000 X100.0 Y110.0 Z0.8 E0.47036934068616165
G1 F1000 X90.0 Y100.0 Z0.8 E0.47036934068616165
G1 F1000 X100.0 Y90.0 Z0.8 E0.47036934068616165
G1 F1000 X110.0 Y100.0 Z0.8 E0.47036934068616165
G0 F5000 X110.0 Y100.0 Z0.9
G1 F1000 X100.0 Y110.0 Z0.9 E0.47036934068616165
G1 F1000 X90.0 Y100.0 Z0.9 E0.47036934068616165
G1 F1000 X100.0 Y90.0 Z0.9 E0.47036934068616165
G1 F1000 X110.0 Y100.0 Z0.9 E0.47036934068616165
G0 F5000 X110.0 Y100.0 Z1.0
G1 F1000 X100.0 Y110.0 Z1.0 E0.47036934068616165
G1 F1000 X90.0 Y100.0 Z1.0 E0.47036934068616165
G1 F1000 X100.0 Y90.0 Z1.0 E0.47036934068616165
G1 F1000 X110.0 Y100.0 Z1.0 E0.47036934068616165
G0 F5000 X110.0 Y100.0 Z1.1
G1 F1000 X100.0 Y110.0 Z1.1 E0.47036934068616165
G1 F1000 X90.0 Y100.0 Z1.1 E0.47036934068616165
G1 F1000 X100.0 Y90.0 Z1.1 E0.47036934068616165
G1 F1000 X110.0 Y100.0 Z1.1 E0.47036934068616165
G0 F5000 X110.0 Y100.0 Z1.2000000000000002
G1 F1000 X100.0 Y110.0 Z1.2000000000000002 E0.47036934068616165
G1 F1000 X90.0 Y100.0 Z1.2000000000000002 E0.47036934068616165
G1 F1000 X100.0 Y90.0 Z1.2000000000000002 E0.47036934068616165
G1 F1000 X110.0 Y100.0 Z1.2000000000000002 E0.47036934068616165
G0 F5000 X110.0 Y100.0 Z1.3
G1 F1000 X100.0 Y110.0 Z1.3 E0.47036934068616165
G1 F1000 X90.0 Y100.0 Z1.3 E0.47036934068616165
G1 F1000 X100.0 Y90.0 Z1.3 E0.47036934068616165
G1 F1000 X110.0 Y100.0 Z1.3 E0.47036934068616165
G0 F5000 X110.0 Y100.0 Z1.4000000000000001
G1 F1000 X100.0 Y110.0 Z1.4000000000000001 E0.47036934068616165
G1 F1000 X90.0 Y100.0 Z1.4000000000000001 E0.47036934068616165
G1 F1000 X100.0 Y90.0 Z1.4000000000000001 E0.47036934068616165
G1 F1000 X110.0 Y100.0 Z1.4000000000000001 E0.47036934068616165
G0 F5000 X110.0 Y100.0 Z1.5
G1 F1000 X100.0 Y110.0 Z1.5 E0.47036934068616165
G1 F1000 X90.0 Y100.0 Z1.5 E0.47036934068616165
G1 F1000 X100.0 Y90.0 Z1.5 E0.47036934068616165
G1 F1000 X110.0 Y100.0 Z1.5 E0.47036934068616165
G0 F5000 X110.0 Y100.0 Z1.6
G1 F1000 X100.0 Y110.0 Z1.6 E0.47036934068616165
G1 F1000 X90.0 Y100.0 Z1.6 E0.47036934068616165
G1 F1000 X100.0 Y90.0 Z1.6 E0.47036934068616165
G1 F1000 X110.0 Y100.0 Z1.6 E0.47036934068616165
G0 F5000 X110.0 Y100.0 Z1.7000000000000002
G1 F1000 X100.0 Y110.0 Z1.7000000000000002 E0.47036934068616165
G1 F1000 X90.0 Y100.0 Z1.7000000000000002 E0.47036934068616165
G1 F1000 X100.0 Y90.0 Z1.7000000000000002 E0.47036934068616165
G1 F1000 X110.0 Y100.0 Z1.7000000000000002 E0.47036934068616165
G0 F5000 X110.0 Y100.0 Z1.8
G1 F1000 X100.0 Y110.0 Z1.8 E0.47036934068616165
G1 F1000 X90.0 Y100.0 Z1.8 E0.47036934068616165
G1 F1000 X100.0 Y90.0 Z1.8 E0.47036934068616165
G1 F1000 X110.0 Y100.0 Z1.8 E0.47036934068616165
G0 F5000 X110.0 Y100.0 Z1.9000000000000001
G1 F1000 X100.0 Y110.0 Z1.9000000000000001 E0.47036934068616165
G1 F1000 X90.0 Y100.0 Z1.9000000000000001 E0.47036934068616165
G1 F1000 X100.0 Y90.0 Z1.9000000000000001 E0.47036934068616165
G1 F1000 X110.0 Y100.0 Z1.9000000000000001 E0.47036934068616165
G0 F5000 X110.0 Y100.0 Z2.0
G1 F1000 X100.0 Y110.0 Z2.0 E0.47036934068616165
G1 F1000 X90.0 Y100.0 Z2.0 E0.47036934068616165
G1 F1000 X100.0 Y90.0 Z2.0 E0.47036934068616165
G1 F1000 X110.0 Y100.0 Z2.0 E0.47036934068616165
G0 F5000 X110.0 Y100.0 Z2.1
G1 F1000 X100.0 Y110.0 Z2.1 E0.47036934068616165
G1 F1000 X90.0 Y100.0 Z2.1 E0.47036934068616165
G1 F1000 X100.0 Y90.0 Z2.1 E0.47036934068616165
G1 F1000 X110.0 Y100.0 Z2.1 E0.47036934068616165
G0 F5000 X110.0 Y100.0 Z2.2
G1 F1000 X100.0 Y110.0 Z2.2 E0.47036934068616165
G1 F1000 X90.0 Y100.0 Z2.2 E0.47036934068616165
G1 F1000 X100.0 Y90.0 Z2.2 E0.47036934068616165
G1 F1000 X110.0 Y100.0 Z2.2 E0.47036934068616165
G0 F5000 X110.0 Y100.0 Z2.3000000000000003
G1 F1000 X100.0 Y110.0 Z2.3000000000000003 E0.47036934068616165
G1 F1000 X90.0 Y100.0 Z2.3000000000000003 E0.47036934068616165
G1 F1000 X100.0 Y90.0 Z2.3000000000000003 E0.47036934068616165
G1 F1000 X110.0 Y100.0 Z2.3000000000000003 E0.47036934068616165
G0 F5000 X110.0 Y100.0 Z2.4000000000000004
G1 F1000 X100.0 Y110.0 Z2.4000000000000004 E0.47036934068616165
G1 F1000 X90.0 Y100.0 Z2.4000000000000004 E0.47036934068616165
G1 F1000 X100.0 Y90.0 Z2.4000000000000004 E0.47036934068616165
G1 F1000 X110.0 Y100.0 Z2.4000000000000004 E0.47036934068616165
G0 F5000 X110.0 Y100.0 Z2.5
G1 F1000 X100.0 Y110.0 Z2.5 E0.47036934068616165
G1 F1000 X90.0 Y100.0 Z2.5 E0.47036934068616165
G1 F1000 X100.0 Y90.0 Z2.5 E0.47036934068616165
G1 F1000 X110.0 Y100.0 Z2.5 E0.47036934068616165
G0 F5000 X110.0 Y100.0 Z2.6
G1 F1000 X100.0 Y110.0 Z2.6 E0.47036934068616165
G1 F1000 X90.0 Y100.0 Z2.6 E0.47036934068616165
G1 F1000 X100.0 Y90.0 Z2.6 E0.47036934068616165
G1 F1000 X110.0 Y100.0 Z2.6 E0.47036934068616165
G0 F5000 X110.0 Y100.0 Z2.7
G1 F1000 X100.0 Y110.0 Z2.7 E0.47036934068616165
G1 F1000 X90.0 Y100.0 Z2.7 E0.47036934068616165
G1 F1000 X100.0 Y90.0 Z2.7 E0.47036934068616165
G1 F1000 X110.0 Y100.0 Z2.7 E0.47036934068616165
G0 F5000 X110.0 Y100.0 Z2.8000000000000003
G1 F1000 X100.0 Y110.0 Z2.8000000000000003 E0.47036934068616165
G1 F1000 X90.0 Y100.0 Z2.8000000000000003 E0.47036934068616165
G1 F1000 X100.0 Y90.0 Z2.8000000000000003 E0.47036934068616165
G1 F1000 X110.0 Y100.0 Z2.8000000000000003 E0.47036934068616165
G0 F5000 X110.0 Y100.0 Z2.9000000000000004
G1 F1000 X100.0 Y110.0 Z2.9000000000000004 E0.47036934068616165
G1 F1000 X90.0 Y100.0 Z2.9000000000000004 E0.47036934068616165
G1 F1000 X100.0 Y90.0 Z2.9000000000000004 E0.47036934068616165
G1 F1000 X110.0 Y100.0 Z2.9000000000000004 E0.47036934068616165
G0 F5000 X110.0 Y100.0 Z3.0
G1 F1000 X100.0 Y110.0 Z3.0 E0.47036934068616165
G1 F1000 X90.0 Y100.0 Z3.0 E0.47036934068616165
G1 F1000 X100.0 Y90.0 Z3.0 E0.47036934068616165
G1 F1000 X110.0 Y100.0 Z3.0 E0.47036934068616165
G0 F5000 X110.0 Y100.0 Z3.1
G1 F1000 X100.0 Y110.0 Z3.1 E0.47036934068616165
G1 F1000 X90.0 Y100.0 Z3.1 E0.47036934068616165
G1 F1000 X100.0 Y90.0 Z3.1 E0.47036934068616165
G1 F1000 X110.0 Y100.0 Z3.1 E0.47036934068616165
G0 F5000 X110.0 Y100.0 Z3.2
G1 F1000 X100.0 Y110.0 Z3.2 E0.47036934068616165
G1 F1000 X90.0 Y100.0 Z3.2 E0.47036934068616165
G1 F1000 X100.0 Y90.0 Z3.2 E0.47036934068616165
G1 F1000 X110.0 Y100.0 Z3.2 E0.47036934068616165
G0 F5000 X110.0 Y100.0 Z3.3000000000000003
G1 F1000 X100.0 Y110.0 Z3.3000000000000003 E0.47036934068616165
G1 F1000 X90.0 Y100.0 Z3.3000000000000003 E0.47036934068616165
G1 F1000 X100.0 Y90.0 Z3.3000000000000003 E0.47036934068616165
G1 F1000 X110.0 Y100.0 Z3.3000000000000003 E0.47036934068616165
G0 F5000 X110.0 Y100.0 Z3.4000000000000004
G1 F1000 X100.0 Y110.0 Z3.4000000000000004 E0.47036934068616165
G1 F1000 X90.0 Y100.0 Z3.4000000000000004 E0.47036934068616165
G1 F1000 X100.0 Y90.0 Z3.4000000000000004 E0.47036934068616165
G1 F1000 X110.0 Y100.0 Z3.4000000000000004 E0.47036934068616165
G0 F5000 X110.0 Y100.0 Z3.5
G1 F1000 X100.0 Y110.0 Z3.5 E0.47036934068616165
G1 F1000 X90.0 Y100.0 Z3.5 E0.47036934068616165
G1 F1000 X100.0 Y90.0 Z3.5 E0.47036934068616165
G1 F1000 X110.0 Y100.0 Z3.5 E0.47036934068616165
G0 F5000 X110.0 Y100.0 Z3.6
G1 F1000 X100.0 Y110.0 Z3.6 E0.47036934068616165
G1 F1000 X90.0 Y100.0 Z3.6 E0.47036934068616165
G1 F1000 X100.0 Y90.0 Z3.6 E0.47036934068616165
G1 F1000 X110.0 Y100.0 Z3.6 E0.47036934068616165
G0 F5000 X110.0 Y100.0 Z3.7
G1 F1000 X100.0 Y110.0 Z3.7 E0.47036934068616165
G1 F1000 X90.0 Y100.0 Z3.7 E0.47036934068616165
G1 F1000 X100.0 Y90.0 Z3.7 E0.47036934068616165
G1 F1000 X110.0 Y100.0 Z3.7 E0.47036934068616165
G0 F5000 X110.0 Y100.0 Z3.8000000000000003
G1 F1000 X100.0 Y110.0 Z3.8000000000000003 E0.47036934068616165
G1 F1000 X90.0 Y100.0 Z3.8000000000000003 E0.47036934068616165
G1 F1000 X100.0 Y90.0 Z3.8000000000000003 E0.47036934068616165
G1 F1000 X110.0 Y100.0 Z3.8000000000000003 E0.47036934068616165
G0 F5000 X110.0 Y100.0 Z3.9000000000000004
G1 F1000 X100.0 Y110.0 Z3.9000000000000004 E0.47036934068616165
G1 F1000 X90.0 Y100.0 Z3.9000000000000004 E0.47036934068616165
G1 F1000 X100.0 Y90.0 Z3.9000000000000004 E0.47036934068616165
G1 F1000 X110.0 Y100.0 Z3.9000000000000004 E0.47036934068616165
G0 F5000 X110.0 Y100.0 Z4.0
G1 F1000 X100.0 Y110.0 Z4.0 E0.47036934068616165
G1 F1000 X90.0 Y100.0 Z4.0 E0.47036934068616165
G1 F1000 X100.0 Y90.0 Z4.0 E0.47036934068616165
G1 F1000 X110.0 Y100.0 Z4.0 E0.47036934068616165
G0 F5000 X110.0 Y100.0 Z4.1000000000000005
G1 F1000 X100.0 Y110.0 Z4.1000000000000005 E0.47036934068616165
G1 F1000 X90.0 Y100.0 Z4.1000000000000005 E0.47036934068616165
G1 F1000 X100.0 Y90.0 Z4.1000000000000005 E0.47036934068616165
G1 F1000 X110.0 Y100.0 Z4.1000000000000005 E0.47036934068616165
G0 F5000 X110.0 Y100.0 Z4.2
G1 F1000 X100.0 Y110.0 Z4.2 E0.47036934068616165
G1 F1000 X90.0 Y100.0 Z4.2 E0.47036934068616165
G1 F1000 X100.0 Y90.0 Z4.2 E0.47036934068616165
G1 F1000 X110.0 Y100.0 Z4.2 E0.47036934068616165
G0 F5000 X110.0 Y100.0 Z4.3
G1 F1000 X100.0 Y110.0 Z4.3 E0.47036934068616165
G1 F1000 X90.0 Y100.0 Z4.3 E0.47036934068616165
G1 F1000 X100.0 Y90.0 Z4.3 E0.47036934068616165
G1 F1000 X110.0 Y100.0 Z4.3 E0.47036934068616165
G0 F5000 X110.0 Y100.0 Z4.4
G1 F1000 X100.0 Y110.0 Z4.4 E0.47036934068616165
G1 F1000 X90.0 Y100.0 Z4.4 E0.47036934068616165
G1 F1000 X100.0 Y90.0 Z4.4 E0.47036934068616165
G1 F1000 X110.0 Y100.0 Z4.4 E0.47036934068616165
G0 F5000 X110.0 Y100.0 Z4.5
G1 F1000 X100.0 Y110.0 Z4.5 E0.47036934068616165
G1 F1000 X90.0 Y100.0 Z4.5 E0.47036934068616165
G1 F1000 X100.0 Y90.0 Z4.5 E0.47036934068616165
G1 F1000 X110.0 Y100.0 Z4.5 E0.47036934068616165
G0 F5000 X110.0 Y100.0 Z4.6000000000000005
G1 F1000 X100.0 Y110.0 Z4.6000000000000005 E0.47036934068616165
G1 F1000 X90.0 Y100.0 Z4.6000000000000005 E0.47036934068616165
G1 F1000 X100.0 Y90.0 Z4.6000000000000005 E0.47036934068616165
G1 F1000 X110.0 Y100.0 Z4.6000000000000005 E0.47036934068616165
G0 F5000 X110.0 Y100.0 Z4.7
G1 F1000 X100.0 Y110.0 Z4.7 E0.47036934068616165
G1 F1000 X90.0 Y100.0 Z4.7 E0.47036934068616165
G1 F1000 X100.0 Y90.0 Z4.7 E0.47036934068616165
G1 F1000 X110.0 Y100.0 Z4.7 E0.47036934068616165
G0 F5000 X110.0 Y100.0 Z4.800000000000001
G1 F1000 X100.0 Y110.0 Z4.800000000000001 E0.47036934068616165
G1 F1000 X90.0 Y100.0 Z4.800000000000001 E0.47036934068616165
G1 F1000 X100.0 Y90.0 Z4.800000000000001 E0.47036934068616165
G1 F1000 X110.0 Y100.0 Z4.800000000000001 E0.47036934068616165
G0 F5000 X110.0 Y100.0 Z4.9
G1 F1000 X100.0 Y110.0 Z4.9 E0.47036934068616165
G1 F1000 X90.0 Y100.0 Z4.9 E0.47036934068616165
G1 F1000 X100.0 Y90.0 Z4.9 E0.47036934068616165
G1 F1000 X110.0 Y100.0 Z4.9 E0.47036934068616165
G0 F5000 X110.0 Y100.0 Z5.0
G1 F1000 X100.0 Y110.0 Z5.0 E0.9407386813723233
G1 F1000 X90.0 Y100.0 Z5.0 E0.9407386813723233
G1 F1000 X100.0 Y90.0 Z5.0 E0.9407386813723233
G1 F1000 X110.0 Y100.0 Z5.0 E0.9407386813723233
G0 F5000 X110.0 Y100.0 Z5.1000000000000005
G1 F1000 X100.0 Y110.0 Z5.1000000000000005 E0.9407386813723233
G1 F1000 X90.0 Y100.0 Z5.1000000000000005 E0.9407386813723233
G1 F1000 X100.0 Y90.0 Z5.1000000000000005 E0.9407386813723233
G1 F1000 X110.0 Y100.0 Z5.1000000000000005 E0.9407386813723233
G0 F5000 X110.0 Y100.0 Z5.2
G1 F1000 X100.0 Y110.0 Z5.2 E0.9407386813723233
G1 F1000 X90.0 Y100.0 Z5.2 E0.9407386813723233
G1 F1000 X100.0 Y90.0 Z5.2 E0.9407386813723233
G1 F1000 X110.0 Y100.0 Z5.2 E0.9407386813723233
G0 F5000 X110.0 Y100.0 Z5.300000000000001
G1 F1000 X100.0 Y110.0 Z5.300000000000001 E0.9407386813723233
G1 F1000 X90.0 Y100.0 Z5.300000000000001 E0.9407386813723233
G1 F1000 X100.0 Y90.0 Z5.300000000000001 E0.9407386813723233
G1 F1000 X110.0 Y100.0 Z5.300000000000001 E0.9407386813723233
G0 F5000 X110.0 Y100.0 Z5.4
G1 F1000 X100.0 Y110.0 Z5.4 E0.9407386813723233
G1 F1000 X90.0 Y100.0 Z5.4 E0.9407386813723233
G1 F1000 X100.0 Y90.0 Z5.4 E0.9407386813723233
G1 F1000 X110.0 Y100.0 Z5.4 E0.9407386813723233
G0 F5000 X110.0 Y100.0 Z5.5
G1 F1000 X100.0 Y110.0 Z5.5 E0.9407386813723233
G1 F1000 X90.0 Y100.0 Z5.5 E0.9407386813723233
G1 F1000 X100.0 Y90.0 Z5.5 E0.9407386813723233
G1 F1000 X110.0 Y100.0 Z5.5 E0.9407386813723233
G0 F5000 X110.0 Y100.0 Z5.6000000000000005
G1 F1000 X100.0 Y110.0 Z5.6000000000000005 E0.9407386813723233
G1 F1000 X90.0 Y100.0 Z5.6000000000000005 E0.9407386813723233
G1 F1000 X100.0 Y90.0 Z5.6000000000000005 E0.9407386813723233
G1 F1000 X110.0 Y100.0 Z5.6000000000000005 E0.9407386813723233
G0 F5000 X110.0 Y100.0 Z5.7
G1 F1000 X100.0 Y110.0 Z5.7 E0.9407386813723233
G1 F1000 X90.0 Y100.0 Z5.7 E0.9407386813723233
G1 F1000 X100.0 Y90.0 Z5.7 E0.9407386813723233
G1 F1000 X110.0 Y100.0 Z5.7 E0.9407386813723233
G0 F5000 X110.0 Y100.0 Z5.800000000000001
G1 F1000 X100.0 Y110.0 Z5.800000000000001 E0.9407386813723233
G1 F1000 X90.0 Y100.0 Z5.800000000000001 E0.9407386813723233
G1 F1000 X100.0 Y90.0 Z5.800000000000001 E0.9407386813723233
G1 F1000 X110.0 Y100.0 Z5.800000000000001 E0.9407386813723233
G0 F5000 X110.0 Y100.0 Z5.9
G1 F1000 X100.0 Y110.0 Z5.9 E0.9407386813723233
G1 F1000 X90.0 Y100.0 Z5.9 E0.9407386813723233
G1 F1000 X100.0 Y90.0 Z5.9 E0.9407386813723233
G1 F1000 X110.0 Y100.0 Z5.9 E0.9407386813723233
G0 F5000 X110.0 Y100.0 Z6.0
G1 F1000 X100.0 Y110.0 Z6.0 E0.9407386813723233
G1 F1000 X90.0 Y100.0 Z6.0 E0.9407386813723233
G1 F1000 X100.0 Y90.0 Z6.0 E0.9407386813723233
G1 F1000 X110.0 Y100.0 Z6.0 E0.9407386813723233
G0 F5000 X110.0 Y100.0 Z6.1000000000000005
G1 F1000 X100.0 Y110.0 Z6.1000000000000005 E0.9407386813723233
G1 F1000 X90.0 Y100.0 Z6.1000000000000005 E0.9407386813723233
G1 F1000 X100.0 Y90.0 Z6.1000000000000005 E0.9407386813723233
G1 F1000 X110.0 Y100.0 Z6.1000000000000005 E0.9407386813723233
G0 F5000 X110.0 Y100.0 Z6.2
G1 F1000 X100.0 Y110.0 Z6.2 E0.9407386813723233
G1 F1000 X90.0 Y100.0 Z6.2 E0.9407386813723233
G1 F1000 X100.0 Y90.0 Z6.2 E0.9407386813723233
G1 F1000 X110.0 Y100.0 Z6.2 E0.9407386813723233
G0 F5000 X110.0 Y100.0 Z6.300000000000001
G1 F1000 X100.0 Y110.0 Z6.300000000000001 E0.9407386813723233
G1 F1000 X90.0 Y100.0 Z6.300000000000001 E0.9407386813723233
G1 F1000 X100.0 Y90.0 Z6.300000000000001 E0.9407386813723233
G1 F1000 X110.0 Y100.0 Z6.300000000000001 E0.9407386813723233
G0 F5000 X110.0 Y100.0 Z6.4
G1 F1000 X100.0 Y110.0 Z6.4 E0.9407386813723233
G1 F1000 X90.0 Y100.0 Z6.4 E0.9407386813723233
G1 F1000 X100.0 Y90.0 Z6.4 E0.9407386813723233
G1 F1000 X110.0 Y100.0 Z6.4 E0.9407386813723233
G0 F5000 X110.0 Y100.0 Z6.5
G1 F1000 X100.0 Y110.0 Z6.5 E0.9407386813723233
G1 F1000 X90.0 Y100.0 Z6.5 E0.9407386813723233
G1 F1000 X100.0 Y90.0 Z6.5 E0.9407386813723233
G1 F1000 X110.0 Y100.0 Z6.5 E0.9407386813723233
G0 F5000 X110.0 Y100.0 Z6.6000000000000005
G1 F1000 X100.0 Y110.0 Z6.6000000000000005 E0.9407386813723233
G1 F1000 X90.0 Y100.0 Z6.6000000000000005 E0.9407386813723233
G1 F1000 X100.0 Y90.0 Z6.6000000000000005 E0.9407386813723233
G1 F1000 X110.0 Y100.0 Z6.6000000000000005 E0.9407386813723233
G0 F5000 X110.0 Y100.0 Z6.7
G1 F1000 X100.0 Y110.0 Z6.7 E0.9407386813723233
G1 F1000 X90.0 Y100.0 Z6.7 E0.9407386813723233
G1 F1000 X100.0 Y90.0 Z6.7 E0.9407386813723233
G1 F1000 X110.0 Y100.0 Z6.7 E0.9407386813723233
G0 F5000 X110.0 Y100.0 Z6.800000000000001
G1 F1000 X100.0 Y110.0 Z6.800000000000001 E0.9407386813723233
G1 F1000 X90.0 Y100.0 Z6.800000000000001 E0.9407386813723233
G1 F1000 X100.0 Y90.0 Z6.800000000000001 E0.9407386813723233
G1 F1000 X110.0 Y100.0 Z6.800000000000001 E0.9407386813723233
G0 F5000 X110.0 Y100.0 Z6.9
G1 F1000 X100.0 Y110.0 Z6.9 E0.9407386813723233
G1 F1000 X90.0 Y100.0 Z6.9 E0.9407386813723233
G1 F1000 X100.0 Y90.0 Z6.9 E0.9407386813723233
G1 F1000 X110.0 Y100.0 Z6.9 E0.9407386813723233
G0 F5000 X110.0 Y100.0 Z7.0
G1 F1000 X100.0 Y110.0 Z7.0 E0.9407386813723233
G1 F1000 X90.0 Y100.0 Z7.0 E0.9407386813723233
G1 F1000 X100.0 Y90.0 Z7.0 E0.9407386813723233
G1 F1000 X110.0 Y100.0 Z7.0 E0.9407386813723233
G0 F5000 X110.0 Y100.0 Z7.1000000000000005
G1 F1000 X100.0 Y110.0 Z7.1000000000000005 E0.9407386813723233
G1 F1000 X90.0 Y100.0 Z7.1000000000000005 E0.9407386813723233
G1 F1000 X100.0 Y90.0 Z7.1000000000000005 E0.9407386813723233
G1 F1000 X110.0 Y100.0 Z7.1000000000000005 E0.9407386813723233
G0 F5000 X110.0 Y100.0 Z7.2
G1 F1000 X100.0 Y110.0 Z7.2 E0.9407386813723233
G1 F1000 X90.0 Y100.0 Z7.2 E0.9407386813723233
G1 F1000 X100.0 Y90.0 Z7.2 E0.9407386813723233
G1 F1000 X110.0 Y100.0 Z7.2 E0.9407386813723233
G0 F5000 X110.0 Y100.0 Z7.300000000000001
G1 F1000 X100.0 Y110.0 Z7.300000000000001 E0.9407386813723233
G1 F1000 X90.0 Y100.0 Z7.300000000000001 E0.9407386813723233
G1 F1000 X100.0 Y90.0 Z7.300000000000001 E0.9407386813723233
G1 F1000 X110.0 Y100.0 Z7.300000000000001 E0.9407386813723233
G0 F5000 X110.0 Y100.0 Z7.4
G1 F1000 X100.0 Y110.0 Z7.4 E0.9407386813723233
G1 F1000 X90.0 Y100.0 Z7.4 E0.9407386813723233
G1 F1000 X100.0 Y90.0 Z7.4 E0.9407386813723233
G1 F1000 X110.0 Y100.0 Z7.4 E0.9407386813723233
G0 F5000 X110.0 Y100.0 Z7.5
G1 F1000 X100.0 Y110.0 Z7.5 E0.9407386813723233
G1 F1000 X90.0 Y100.0 Z7.5 E0.9407386813723233
G1 F1000 X100.0 Y90.0 Z7.5 E0.9407386813723233
G1 F1000 X110.0 Y100.0 Z7.5 E0.9407386813723233
G0 F5000 X110.0 Y100.0 Z7.6000000000000005
G1 F1000 X100.0 Y110.0 Z7.6000000000000005 E0.9407386813723233
G1 F1000 X90.0 Y100.0 Z7.6000000000000005 E0.9407386813723233
G1 F1000 X100.0 Y90.0 Z7.6000000000000005 E0.9407386813723233
G1 F1000 X110.0 Y100.0 Z7.6000000000000005 E0.9407386813723233
G0 F5000 X110.0 Y100.0 Z7.7
G1 F1000 X100.0 Y110.0 Z7.7 E0.9407386813723233
G1 F1000 X90.0 Y100.0 Z7.7 E0.9407386813723233
G1 F1000 X100.0 Y90.0 Z7.7 E0.9407386813723233
G1 F1000 X110.0 Y100.0 Z7.7 E0.9407386813723233
G0 F5000 X110.0 Y100.0 Z7.800000000000001
G1 F1000 X100.0 Y110.0 Z7.800000000000001 E0.9407386813723233
G1 F1000 X90.0 Y100.0 Z7.800000000000001 E0.9407386813723233
G1 F1000 X100.0 Y90.0 Z7.800000000000001 E0.9407386813723233
G1 F1000 X110.0 Y100.0 Z7.800000000000001 E0.9407386813723233
G0 F5000 X110.0 Y100.0 Z7.9
G1 F1000 X100.0 Y110.0 Z7.9 E0.9407386813723233
G1 F1000 X90.0 Y100.0 Z7.9 E0.9407386813723233
G1 F1000 X100.0 Y90.0 Z7.9 E0.9407386813723233
G1 F1000 X110.0 Y100.0 Z7.9 E0.9407386813723233
G0 F5000 X110.0 Y100.0 Z8.0
G1 F1000 X100.0 Y110.0 Z8.0 E0.9407386813723233
G1 F1000 X90.0 Y100.0 Z8.0 E0.9407386813723233
G1 F1000 X100.0 Y90.0 Z8.0 E0.9407386813723233
G1 F1000 X110.0 Y100.0 Z8.0 E0.9407386813723233
G0 F5000 X110.0 Y100.0 Z8.1
G1 F1000 X100.0 Y110.0 Z8.1 E0.9407386813723233
G1 F1000 X90.0 Y100.0 Z8.1 E0.9407386813723233
G1 F1000 X100.0 Y90.0 Z8.1 E0.9407386813723233
G1 F1000 X110.0 Y100.0 Z8.1 E0.9407386813723233
G0 F5000 X110.0 Y100.0 Z8.200000000000001
G1 F1000 X100.0 Y110.0 Z8.200000000000001 E0.9407386813723233
G1 F1000 X90.0 Y100.0 Z8.200000000000001 E0.9407386813723233
G1 F1000 X100.0 Y90.0 Z8.200000000000001 E0.9407386813723233
G1 F1000 X110.0 Y100.0 Z8.200000000000001 E0.9407386813723233
G0 F5000 X110.0 Y100.0 Z8.3
G1 F1000 X100.0 Y110.0 Z8.3 E0.9407386813723233
G1 F1000 X90.0 Y100.0 Z8.3 E0.9407386813723233
G1 F1000 X100.0 Y90.0 Z8.3 E0.9407386813723233
G1 F1000 X110.0 Y100.0 Z8.3 E0.9407386813723233
G0 F5000 X110.0 Y100.0 Z8.4
G1 F1000 X100.0 Y110.0 Z8.4 E0.9407386813723233
G1 F1000 X90.0 Y100.0 Z8.4 E0.9407386813723233
G1 F1000 X100.0 Y90.0 Z8.4 E0.9407386813723233
G1 F1000 X110.0 Y100.0 Z8.4 E0.9407386813723233
G0 F5000 X110.0 Y100.0 Z8.5
G1 F1000 X100.0 Y110.0 Z8.5 E0.9407386813723233
G1 F1000 X90.0 Y100.0 Z8.5 E0.9407386813723233
G1 F1000 X100.0 Y90.0 Z8.5 E0.9407386813723233
G1 F1000 X110.0 Y100.0 Z8.5 E0.9407386813723233
G0 F5000 X110.0 Y100.0 Z8.6
G1 F1000 X100.0 Y110.0 Z8.6 E0.9407386813723233
G1 F1000 X90.0 Y100.0 Z8.6 E0.9407386813723233
G1 F1000 X100.0 Y90.0 Z8.6 E0.9407386813723233
G1 F1000 X110.0 Y100.0 Z8.6 E0.9407386813723233
G0 F5000 X110.0 Y100.0 Z8.700000000000001
G1 F1000 X100.0 Y110.0 Z8.700000000000001 E0.9407386813723233
G1 F1000 X90.0 Y100.0 Z8.700000000000001 E0.9407386813723233
G1 F1000 X100.0 Y90.0 Z8.700000000000001 E0.9407386813723233
G1 F1000 X110.0 Y100.0 Z8.700000000000001 E0.9407386813723233
G0 F5000 X110.0 Y100.0 Z8.8
G1 F1000 X100.0 Y110.0 Z8.8 E0.9407386813723233
G1 F1000 X90.0 Y100.0 Z8.8 E0.9407386813723233
G1 F1000 X100.0 Y90.0 Z8.8 E0.9407386813723233
G1 F1000 X110.0 Y100.0 Z8.8 E0.9407386813723233
G0 F5000 X110.0 Y100.0 Z8.9
G1 F1000 X100.0 Y110.0 Z8.9 E0.9407386813723233
G1 F1000 X90.0 Y100.0 Z8.9 E0.9407386813723233
G1 F1000 X100.0 Y90.0 Z8.9 E0.9407386813723233
G1 F1000 X110.0 Y100.0 Z8.9 E0.9407386813723233
G0 F5000 X110.0 Y100.0 Z9.0
G1 F1000 X100.0 Y110.0 Z9.0 E0.9407386813723233
G1 F1000 X90.0 Y100.0 Z9.0 E0.9407386813723233
G1 F1000 X100.0 Y90.0 Z9.0 E0.9407386813723233
G1 F1000 X110.0 Y100.0 Z9.0 E0.9407386813723233
G0 F5000 X110.0 Y100.0 Z9.1
G1 F1000 X100.0 Y110.0 Z9.1 E0.9407386813723233
G1 F1000 X90.0 Y100.0 Z9.1 E0.9407386813723233
G1 F1000 X100.0 Y90.0 Z9.1 E0.9407386813723233
G1 F1000 X110.0 Y100.0 Z9.1 E0.9407386813723233
G0 F5000 X110.0 Y100.0 Z9.200000000000001
G1 F1000 X100.0 Y110.0 Z9.200000000000001 E0.9407386813723233
G1 F1000 X90.0 Y100.0 Z9.200000000000001 E0.9407386813723233
G1 F1000 X100.0 Y90.0 Z9.200000000000001 E0.9407386813723233
G1 F1000 X110.0 Y100.0 Z9.200000000000001 E0.9407386813723233
G0 F5000 X110.0 Y100.0 Z9.3
G1 F1000 X100.0 Y110.0 Z9.3 E0.9407386813723233
G1 F1000 X90.0 Y100.0 Z9.3 E0.9407386813723233
G1 F1000 X100.0 Y90.0 Z9.3 E0.9407386813723233
G1 F1000 X110.0 Y100.0 Z9.3 E0.9407386813723233
G0 F5000 X110.0 Y100.0 Z9.4
G1 F1000 X100.0 Y110.0 Z9.4 E0.9407386813723233
G1 F1000 X90.0 Y100.0 Z9.4 E0.9407386813723233
G1 F1000 X100.0 Y90.0 Z9.4 E0.9407386813723233
G1 F1000 X110.0 Y100.0 Z9.4 E0.9407386813723233
G0 F5000 X110.0 Y100.0 Z9.5
G1 F1000 X100.0 Y110.0 Z9.5 E0.9407386813723233
G1 F1000 X90.0 Y100.0 Z9.5 E0.9407386813723233
G1 F1000 X100.0 Y90.0 Z9.5 E0.9407386813723233
G1 F1000 X110.0 Y100.0 Z9.5 E0.9407386813723233
G0 F5000 X110.0 Y100.0 Z9.600000000000001
G1 F1000 X100.0 Y110.0 Z9.600000000000001 E0.9407386813723233
G1 F1000 X90.0 Y100.0 Z9.600000000000001 E0.9407386813723233
G1 F1000 X100.0 Y90.0 Z9.600000000000001 E0.9407386813723233
G1 F1000 X110.0 Y100.0 Z9.600000000000001 E0.9407386813723233
G0 F5000 X110.0 Y100.0 Z9.700000000000001
G1 F1000 X100.0 Y110.0 Z9.700000000000001 E0.9407386813723233
G1 F1000 X90.0 Y100.0 Z9.700000000000001 E0.9407386813723233
G1 F1000 X100.0 Y90.0 Z9.700000000000001 E0.9407386813723233
G1 F1000 X110.0 Y100.0 Z9.700000000000001 E0.9407386813723233
G0 F5000 X110.0 Y100.0 Z9.8
G1 F1000 X100.0 Y110.0 Z9.8 E0.9407386813723233
G1 F1000 X90.0 Y100.0 Z9.8 E0.9407386813723233
G1 F1000 X100.0 Y90.0 Z9.8 E0.9407386813723233
G1 F1000 X110.0 Y100.0 Z9.8 E0.9407386813723233
G0 F5000 X110.0 Y100.0 Z9.9
G1 F1000 X100.0 Y110.0 Z9.9 E0.9407386813723233
G1 F1000 X90.0 Y100.0 Z9.9 E0.9407386813723233
G1 F1000 X100.0 Y90.0 Z9.9 E0.9407386813723233
G1 F1000 X110.0 Y100.0 Z9.9 E0.9407386813723233
;START OF THE END GCODE

G1 F2400 E-6
M140 S0
M204 S4000
M205 X20 Y20
M107
M104 S0 ; turn off extruder
M140 S0 ; turn off bed
M84 ; disable motors
M107
G91 ;relative positioning
G1 E-1 F300 ;retract the filament a bit before lifting the nozzle, to release some of the pressure
G1 Z+0.5 E-5 ;move Z up a bit and retract filament even more
G28 X0 ;Y0 ;move X/Y to min endstops, so the head is out of the way
G1 Y180 F2000
M84 ;steppers off
G90
M300 P300 S4000
M82 ;absolute extrusion mode
M104 S0
;End of Gcode
;SETTING_3 {"extruder_quality": ["[general]\\nversion = 4\\nname = Normal 1.0 no
;SETTING_3 zzle vase mode\\ndefinition = anycubic_i3_mega\\n\\n[metadata]\\ninte
;SETTING_3 nt_category = default\\nquality_type = normal\\nposition = 0\\nsettin
;SETTING_3 g_version = 14\\ntype = quality_changes\\n\\n[values]\\ninfill_sparse
;SETTING_3 _density = 5\\nline_width = 1.0\\nmaterial_print_temperature = 220\\n
;SETTING_3 skirt_brim_speed = 20\\nspeed_layer_0 = 10\\nspeed_print = 20\\nspeed
;SETTING_3 _topbottom = 60\\nspeed_wall_0 = 30\\nspeed_wall_x = 30\\ntop_bottom_
;SETTING_3 pattern = lines\\ntop_bottom_thickness = 0.8\\nwall_thickness = 0.8\\
;SETTING_3 n\\n"], "global_quality": "[general]\\nversion = 4\\nname = Normal 1.
;SETTING_3 0 nozzle vase mode\\ndefinition = anycubic_i3_mega\\n\\n[metadata]\\n
;SETTING_3 quality_type = normal\\nsetting_version = 14\\ntype = quality_changes
;SETTING_3 \\n\\n[values]\\nmagic_spiralize = True\\nmaterial_bed_temperature = 
;SETTING_3 65\\nsupport_enable = False\\n\\n"}