; CoreXY configuration for Zargony's HyperCube

M111 S0                             ; Debug off
M550 PHyperCube				        ; Machine name (can be anything you like)
M551 Preprap                        ; Machine password (used for FTP connections)
M552 S1                             ; Enable network as Wifi client
M555 P1                             ; Set output to look like RepRapFirmare
M575 P1 B57600 S1					; Comms parameters for PanelDue

; Machine configuration
M569 P0 S1							; Drive 0 goes forwards (change to S0 to reverse it)
M569 P1 S1							; Drive 1 goes forwards
M569 P2 S1							; Drive 2 goes forwards
M569 P3 S1							; Drive 3 goes forwards
M569 P4 S1							; Drive 4 goes forwards
; If you use an endstop switch for Z homing, change Z0 to Z1 in the following line, and see also M558 command later in this file
M574 X1 Y1 S0						; set endstop configuration (X and Y and endstops only, at low end, active low)
M667 S1								; set CoreXY mode
M350 X16 Y16 Z16 E16:16 I1			; set 1/16 microstepping mode with interpolation to 1/256
M92 X160 Y160 Z400					; Set axis steps/mm
M92 E94:94						; Set extruder steps/mm
M906 X800 Y800 Z800 E1200           ; Set motor currents (mA)
M201 X1500 Y1500 Z100 E10000        ; Accelerations (mm/s^2)         // dc42:800/800/15/1000       Tech2C:3000/3000/100/10000
M203 X15000 Y15000 Z1200 E3600      ; Maximum speeds (mm/min)        // dc42:15000/15000/100/3600  Tech2C:18000/18000/300/1500
M566 X600 Y600 Z240 E1200           ; Maximum jerk speeds mm/minute  // dc42:600/600/30/20         Tech2C:1200/1200/240/300
M208 X300 Y190 Z180					; set axis maxima (adjust to suit your machine)
M208 X-6 Y-8 Z0 S1					; set axis minima (adjust to make X=0 and Y=0 the edges of the bed)
G21                                 ; Work in millimetres
G90                                 ; Send absolute coordinates...
M83                                 ; ...but relative extruder moves

; Reduce motor power to 50% after being idle for 60s
M906 I50
M84 S60

; Z probe
M558 P1 H3 F150 T5000               ; Analog Z probe
M574 Z1 S2                          ; Set endstops controlled by probe
G31 X20 Y16 Z0.875 P500             ; Set the probe height and threshold (put your own values here)
; The following M557 commands are not needed if you are using a bed.g file to perform bed compensation
;*** Adjust the XY coordinates in the following M557 commands to suit your build and the position of the Z probe
;M557 P0 X60 Y0                     ; Four...
;M557 P1 X60 Y165                   ; ...probe points...
;M557 P2 X222 Y165                  ; ...for bed...
;M557 P3 X222 Y0                    ; ...levelling
;M557 P4 X141 Y82.5                 ; 5th probe point for levelling
;M557 X20:280 Y25:165 S120:70       ; 300x190 bed, 3x3 points
M557 X20:280 Y25:165 S20            ; 300x190 bed, 14x8 points

M375                                ; load heightmap.csv for mesh grid compensation
M376 H4                             ; taper bed compensation to zero over first 4mm height

; Thermistors and heaters
;M912 P0 S-21.9						; CPU temperature offset
M305 P0 R4700 T100000 B3950 H0 L0	; bed thermistor
M305 P1 R4700 T100000 B4725 C7.06e-8 H-100 L-100	; first nozzle thermistor
; Heater 0 model: gain 138.8, time constant 685.9, dead time 3.3, max PWM 1.00, calibration voltage 23.8, mode PID, inverted no, frequency default
; Computed PID parameters for setpoint change: P268.2, I5.646, D617.6
; Computed PID parameters for load change: P2
M307 H0 A138.8 C685.9 D3.3 B0 S1.00 V23.8
M143 H0 S120						; Set safety limit to 120°C
; Heater 1 model: gain 746.6, time constant 277.1, dead time 4.3, max PWM 1.00, calibration voltage 24.0, mode PID, inverted no, frequency default
; Computed PID parameters for setpoint change: P15.5, I0.452, D46.4
; Computed PID parameters for load change: P15.
M307 H1 A746.6 C277.1 D4.3 B0 S1.00 V24.0
M143 H1 S280						; Set safety limit to 280°C

; Fans
M106 P0 S0 L0.1 H-1 C"Part Fan"		; Fan 0 (part fan) PWM settings
M106 P1 S1 H1 T50 C"Hotend Fan"		; Fan 1 (hotend fan) thermostatic control settings
M106 P2 S0.25 L0.1 H-1 C"Light"		; Fan 2 (Light) PWM settings

; Tool definition
M563 P0 D0 H1 F0                    ; Define tool 0
G10 P0 S0 R170                      ; Set tool 0 operating and standby temperatures
;*** If you have a dual-nozzle build, un-comment the following 3 lines
;M563 P1 D1 H2                      ; Define tool 1
;G10 P1 S0 R0                       ; Set tool 1 operating and standby temperatures

;*** If you are using axis compensation, put the figures in the following command
M556 S78 X0 Y0 Z0                   ; Axis compensation here

M207 S2.0 F3000 Z0.0				; Set firmware retraction details
M572 D0 S0.2						; set pressure advance

T0									; select first tool
