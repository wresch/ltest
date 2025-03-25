#! /bin/bash
# adapted from https://github.com/lammpstutorials/lammpstutorials-inputs


run="${1}"
mkdir -p "${run}" && cd "${run}" || exit 1

cat <<__EOF__ > input.lammps
# LAMMPS input script by Simon Gravelle
# This input is part of a tutorial from https://lammpstutorials.github.io
# Last tested using the 2Aug2023 stable LAMMPS version
# This file was released under the GNU general public license v3.0

# ⣿⣿⡆⠀⠀⠀⠀⠀⠀⣾⣿⣿⣆⠀⠀⠀⣿⣿⣿⣆⠀⠀⣰⣿⣿⣷⠀⢸⣿⣿⣷⡀⠀⢀⣾⣿⣿⠀⠀⣿⣿⣿⣿⣿⣷⣆⠀⢀⣶⣿⠿⠿⣿⡆⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣀⣠⣤⣶⣿⣿⣿⣦⡄⠀⠀⠀⠀⠀⠀⠀
# ⣿⣿⡇⠀⠀⠀⠀⠀⣼⣿⡏⣿⣿⡄⠀⠀⣿⣿⡿⣿⡆⢰⣿⢿⣿⣿⠀⢸⣿⣿⢿⣧⠀⣾⡿⣿⣿⠀⠀⣿⣿⡇⠀⢈⣿⣿⠀⢸⣿⣧⣄⣀⡀⠀⠀⠀⠀⠀⠀⠀⢀⣤⣾⣿⣿⠏⣿⣿⣿⣿⣿⣿⣿⡄⠀⠀⠀⠀⠀⠀
# ⣿⣿⡇⠀⠀⠀⠀⢰⣿⣿⣀⣸⣿⣷⡀⠀⣿⣿⡇⢻⣿⣿⡏⢸⣿⣿⠀⢸⣿⣿⠘⣿⣿⡿⠁⣿⣿⠀⠀⣿⣿⡿⠿⠿⠿⠋⠀⠀⠉⠛⠻⠿⣿⣷⠀⠀⠀⠀⠀⢠⣿⣿⣿⣿⣿⡄⠻⣿⣿⣿⣿⡿⠟⣃⠀⠀⠀⠀⠀⠀
# ⣿⣿⣧⣤⣤⣤⢠⣿⣿⠛⠛⠛⢻⣿⣧⠀⣿⣿⡇⠀⠛⠛⠀⢸⣿⣿⠀⢸⣿⣿⠀⠘⠛⠃⠀⣿⣿⠀⠀⣿⣿⡇⠀⠀⠀⠀⠀⢰⣶⣤⣤⣤⣿⡿⠀⠀⠀⠀⠀⣻⣿⣿⣿⣿⣿⣿⣄⡀⠉⠉⠁⠀⢠⣿⡄⠀⠀⠀⠀⠀
# ⠉⠉⠉⠉⠉⠉⠈⠉⠁⠀⠀⠀⠀⠉⠉⠀⠉⠉⠁⠀⠀⠀⠀⠈⠉⠉⠀⠈⠉⠉⠀⠀⠀⠀⠀⠉⠉⠀⠀⠉⠉⠁⠀⠀⠀⠀⠀⠀⠉⠉⠉⠉⠉⠀⠀⠀⠀⠀⠀⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣶⣶⣾⣿⣿⡇⠀⠀⠀⠀⠀
# ⢀⣤⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣤⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢰⣶⠀⠀⠀⠀⠀⠀⠀⠀⢰⡆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡃⠀⠀⠀⠀⠀
# ⣼⣿⣴⡦⠀⣴⠀⠀⠀⣴⡄⢤⣿⣧⣶⠄⢀⣤⡶⣶⣄⠀⠀⣴⣤⣴⣦⢠⣦⠀⠀⣤⠶⢶⣤⡀⠀⢸⡇⠀⢠⣴⠶⢦⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣼⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣶⣄⠀⠀⠀
# ⢸⣿⠀⠀⠀⣿⠀⠀⠀⣿⡇⠀⣿⡆⠀⠀⣿⠇⠀⠀⢻⡇⠀⣿⡇⠀⠀⢸⣿⠀⠀⣠⣤⣤⣽⡇⠀⢸⡇⠀⢻⣧⣄⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣀⣀⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣧⡀⠀
# ⠸⣿⠀⠀⠀⣿⡄⠀⢀⣿⡇⠀⣿⡇⠀⠀⢿⣇⠀⢀⣼⡇⠀⣿⡇⠀⠀⢸⣿⠀⢸⣏⠀⠀⣼⡇⠀⢸⡇⠀⡀⠀⠉⢹⣷⠀⠀⠀⠀⠀⠀⠀⣀⣴⣾⣿⣿⡟⢸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⠀
# ⠀⠙⠛⠛⠀⠈⠛⠛⠋⠛⠁⠀⠈⠛⠛⠃⠈⠛⠛⠛⠋⠀⠀⠛⠃⠀⠀⠘⠛⠀⠈⠛⠛⠛⠙⠃⠀⠘⠃⠀⠙⠛⠛⠛⠁⠀⠀⠀⠀⠀⢠⣾⣿⣿⣿⣿⣿⠀⣼⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇
# ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⣴⣿⣿⣿⣿⣿⣿⣿⡀⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
#⠀ ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢰⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇⢻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡏
# ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡘⣿⣿⣿⣿⣿⡏⣼⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠁
# ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠨⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⡈⠻⣿⣿⣿⣇⠸⣿⣿⣿⣿⣿⣿⡿⢻⣿⣿⠿⠋⠁⠀
# ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⡀⠈⠻⢿⣿⣦⣈⠙⠛⠛⠛⣁⣴⡿⠛⠁⠀⠀⠀⠀
# ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣦⡀⠀⠈⠉⠛⠛⠓⠚⠋⠉⠁⠀⠀⠀⠀⠀⠀⠀
# ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⠻⠿⣿⣿⣿⣿⡿⠟⠋⠀

# PART A - ENERGY MINIMIZATION

# 1) Initialization
units lj
dimension 3
atom_style atomic
pair_style lj/cut 2.5
boundary p p p

# 2) System definition
region simulation_box block -20 20 -20 20 -20 20
create_box 2 simulation_box
create_atoms 1 random 1500 921342 simulation_box
create_atoms 2 random 100 225469 simulation_box

# 3) Simulation settings
mass 1 1
mass 2 1
pair_coeff 1 1 1.0 1.0
pair_coeff 2 2 0.5 3.0

# 4) Visualization
thermo 10
thermo_style custom step etotal press

# 5) Run
minimize 1.0e-6 1.0e-6 1000 10000

# PART B - MOLECULAR DYNAMICS
# 4) Visualization
dump mydmp1 all atom 100 dump.lammpstrj
dump mydmp2 all image 100 dump.*.jpg type type shiny 0.1 box no 0.01 view 0 0 zoom 1.8
dump_modify mydmp2 acolor 1 darkturquoise acolor 2 darkblue adiam 1 1 adiam 2 3 backcolor white
thermo 50
thermo_style custom step temp etotal pe ke press

# 5) Run
fix mynve all nve
fix mylgv all langevin 1.0 1.0 0.1 1530917
timestep 0.005
run 10000
__EOF__

pwd
ls -lh

