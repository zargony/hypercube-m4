; CoreXY configuration for Zargony's HyperCube

M111 S0                             ; Debug off
M550 PHyperCube				        ; Machine name (can be anything you like)
M551 Preprap                        ; Machine password (used for FTP connections)
M540 P0x6E:0x83:0x64:0x58:0x6A:0xD2 ; MAC Address
M552 P0.0.0.0						; IP address (0 = use DHCP)
M554 P192.168.1.1                   ; Gateway
M553 P255.255.255.0                 ; Netmask
M555 P2                             ; Set output to look like Marlin
M575 P1 B57600 S1					; Comms parameters for PanelDue

; Machine configuration
M569 P0 S1							; Drive 0 goes forwards (change to S0 to reverse it)
M569 P1 S1							; Drive 1 goes forwards
M569 P2 S1							; Drive 2 goes forwards
M569 P3 S1							; Drive 3 goes forwards
M569 P4 S1							; Drive 4 goes forwards
; If you use an endstop switch for Z homing, change Z0 to Z1 in the following line, and see also M558 command later in this file
M574 X1 Y1 Z0 S0					; set endstop configuration (X and Y and endstops only, at low end, active low)
M667 S1								; set CoreXY mode
M92 X80 Y80 Z400					; Set axis steps/mm
M92 E96:96						; Set extruder steps/mm
M906 X1000 Y1000 Z1000 E1500        ; Set motor currents (mA)
M201 X1500 Y1500 Z100 E10000        ; Accelerations (mm/s^2)         // dc42:800/800/15/1000       Tech2C:3000/3000/100/10000
M203 X15000 Y15000 Z600 E3600       ; Maximum speeds (mm/min)        // dc42:15000/15000/100/3600  Tech2C:18000/18000/300/1500
M566 X600 Y600 Z30 E20              ; Maximum jerk speeds mm/minute  // dc42:600/600/30/20         Tech2C:1200/1200/240/300
M208 X300 Y190 Z180					; set axis maxima (adjust to suit your machine)
M208 X-8 Y-8 Z0 S1				; set axis minima (adjust to make X=0 and Y=0 the edges of the bed)
G21                                 ; Work in millimetres
G90                                 ; Send absolute coordinates...
M83                                 ; ...but relative extruder moves

; Z probe
M558 P1 X0 Y0 Z1 H3 F150 T5000      ; Analog Z probe, also used for homing the Z axis
G31 X20 Y16 Z0.905 P500             ; Set the probe height and threshold (put your own values here)
; The following M557 commands are not needed if you are using a bed.g file to perform bed compensation
;*** Adjust the XY coordinates in the following M557 commands to suit your build and the position of the Z probe
;M557 P0 X60 Y0                     ; Four...
;M557 P1 X60 Y165                   ; ...probe points...
;M557 P2 X222 Y165                  ; ...for bed...
;M557 P3 X222 Y0                    ; ...levelling
;M557 P4 X141 Y82.5                 ; 5th probe point for levelling
;M557 X30:270 Y30:170 S120:70       ; 300x200 bed, 3x3 points
M557 X30:270 Y20:180 S20            ; 300x200 bed, 13x9 points
M376 H4                             ; taper bed compensation to zero over first 4mm height

; Thermistors and heaters
M305 P0 R4700 T100000 B3950 H0 L0	; bed thermistor
M305 P1 R4700 T100000 B4725 C7.06e-8 H-100 L-100	; first nozzle thermistor
M307 H0 A165.0 C725.0 D3.1 S1.00 B0	; heating process parameters for bed
M307 H1 A754.8 C270.0 D4.3 S1.00 B0	; heating process parameters for extruder 0
M570 S120							; Increase to allow extra heating time if needed

; Tool definition
M563 P0 D0 H1                       ; Define tool 0
G10 P0 S0 R170                      ; Set tool 0 operating and standby temperatures
;*** If you have a dual-nozzle build, un-comment the following 3 lines
;M563 P1 D1 H2                      ; Define tool 1
;G10 P1 S0 R0                       ; Set tool 1 operating and standby temperatures

;*** If you are using axis compensation, put the figures in the following command
M556 S78 X0 Y0 Z0                   ; Axis compensation here
T0									; select first hot end
