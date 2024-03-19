
# Topology_Reconstruction_Codes
Topology Reconstruction of a Resistor Network with Limited Boundary Measurements: An Optimization Approach <br>
# Reconstruction
Run file [topology_reconstruct.m]() to get a reconstructed network.
# Code Flow
1. For computing the estimates of resistance distances, i.e., $\hat{r}^d_{i,j}\,\forall i,j \in \mathcal{U_B}$, run code named [compute_initial_estimates_rho.m](https://github.com/ShivanB/Topology_Reconstruction_Codes/blob/main/0_Resistance_Distance_Estimates/compute_intial_estimates_rho.m). This code solves problem $\mathcal{I}$.

2. Now use the resistance distance estimates $\hat{r}^d_{i,j}\,\forall i,j \in \mathcal{U_B}$ and the known resistance distance measurements $r^d_{i,j}\,\forall i,j \in \mathcal{A}$ to compute the intial switch positions to be fed into problem $\mathbf{\Pi_1}$. To execute this run code [MAIN_Initial_switch_position.m](https://github.com/ShivanB/Topology_Reconstruction_Codes/blob/main/A_INITIAL_GUESS_COMPUTE_FOR_GAMMA_AUX/MAIN_Initial_switch_position.m).

3. Use the resistance distance estimates $\hat{r}^d_{i,j}\,\forall i,j \in \mathcal{U_B}$, the known resistance distance measurements $r^d_{i,j}\,\forall i,j \in \mathcal{A}$ and intial switch positions guess to solve problem $\mathbf{\Pi_1}$. Run code [Construt_GAMMA_AUX.m](https://github.com/ShivanB/Topology_Reconstruction_Codes/blob/main/B_CONSTRUCTING_GAMMA_AUX/REFORMULATED_CODE_FINAL_best/Construt_GAMMA_AUX.m)

3. Apply heuristic method to detect the appropriate position of interior nodes. To execute the heuristic method run code [CONSTRUCT_GAMMA_BAR_AUX.m](https://github.com/ShivanB/Topology_Reconstruction_Codes/blob/main/C_INTERIOR_NODES_HEURISTICS/CONSTRUCT_GAMMA_BAR_AUX.m)

4. Place interior nodes appropriately and construct corresponding planar networks from a non-planar network. To implement this run code [code_to_be_uploaded]().

5. For rewiring and adjusting the edge weights of the constructed planar network run code [REWIRING_PLANAR_NETWORK.m](https://github.com/ShivanB/Topology_Reconstruction_Codes/blob/main/E_REWIRING_AFTER_PLANAR_NETWORK_CONSTRUCTION/REWIRING_PLANAR_NETWORK.m).

# FILE ARRANGEMENT
```mermaid
graph TD;
    A[0: Codes for Computing
    the estimates of
    resistance distance
    measurements]-->B[A: Codes for 
Computing initial 
guess to be fed into Pi1]-->C[B: Codes for 
                               constructing
                                Gamma_aux]-->D[C; Codes for 
                                              Interior node placement]
-->E[D: Codes for generating 
planar network from a 
non planar network]-->
F[E: Codes for rewiring and 
adjusting edge resistances of 
planar network generated from D];

