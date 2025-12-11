CS 3710 Final Project – Scary Maze Game
README
Overview
This archive contains the full hardware and software implementation of our final project for CS/ECE 3710 – Computer Design Lab at the University of Utah. The project includes a custom-designed CPU written in Verilog, a custom assembler, and a complete application: a three-level “Scary Maze” game that runs entirely on our CPU. The game uses an SNES controller for input and a VGA monitor for output.
Authors: Elden Harrison, Luke Jones, and David Brown  
GitHub: https://github.com/eharrison39/CS3710.git

Directory Structure

Verilog Code/  
Contains all FPGA hardware files: CPU modules, datapath, control FSM, VGA controller, bit generator, SNES interface, dual-port RAM, initialization files, top-level integration, and Quartus constraint files.

Test Benches/  
Contains all simulation testbenches for individual modules and the fully integrated system. These were used with QuestaSim to validate CPU operation, memory behavior, VGA timing, and SNES input decoding.

Assembler/  
Contains the custom assembler and all software game code written in our assembly language. Includes the assembled machine-code hex files used to initialize memory.

Documents/  
Contains the final project report, diagrams, and this README.

How to Recompile and Run on the DE10-Lite
1.	Open Quartus Prime Lite and load the project located in the Verilog Code directory.
2.	Confirm pin assignments from the .qsf file (VGA, SNES, clock, LEDs, etc.).
3.	Compile the project.
4.	Program the DE10-Lite using the USB-Blaster.
5.	Ensure the memory initialization hex file path is correct for the dual-port RAM.
6.	Connect a VGA monitor and SNES controller.
7.	After programming, the maze game will run automatically.

Simulation Instructions
1.	Open QuestaSim.
2.	Compile all files from Verilog Code and Test Benches.
3.	Run the top-level testbench to verify instruction sequencing, VGA timing, SNES decoding, and memory read/write operation.

Additional Notes
⦁	The design expects a 50 MHz clock input.
⦁	VGA graphics (maze backgrounds and the final scare image) are hardcoded directly into the bit generator.