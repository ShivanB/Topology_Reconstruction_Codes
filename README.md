
# Topology_Reconstruction_Codes
Topology Reconstruction of a Resistor Network with Limited Boundary Measurements: An Optimization Approach <br>
# Reconstruction
Run file [topology_reconstruct.m]() to get a reconstructed network.
# Code Flow
1. For computing the estimates of resistance distances, i.e., $\hat{r}^d_{i,j}\,\forall i,j \in \mathcal{U_B}$, run code named [compute_initial_estimates_rho.m](https://github.com/ShivanB/Topology_Reconstruction_Codes/blob/main/Resistance_Distance_Estimates/compute_intial_estimates_rho.m). This code solves problem $\mathcal{I}$.

2. Now use the resistance distance estimates $\hat{r}^d_{i,j}\,\forall i,j \in \mathcal{U_B}$ and the known resistance distance measurements $r^d_{i,j}\,\forall i,j \in \mathcal{A}$ to compute the switch positions for constructing the intial network $\Gamma_{aux}$. To execute this run code [MAIN_Initial_switch_position.m](https://github.com/ShivanB/Topology_Reconstruction_Codes/tree/main/A_INITIAL_GUESS_COMPUTE_FOR_GAMMA_AUX). This code solves problem $\mathbf{\Pi_1}$.

3. Constructing $\bar{\Gamma}_{aux}$ 
