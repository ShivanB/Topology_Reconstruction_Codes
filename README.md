
# Topology_Reconstruction_Codes
Topology Reconstruction of a Resistor Network with Limited Boundary Measurements: An Optimization Approach <br>
RUN FILE ***topology_reconstruct.m*** to get a reconstructed network. 
# Reconstruction
Run file [topology_reconstruct.m]() to get a reconstructed network, using the resistance distance measurements and the Kirchhoff index.
# Code Flow
For computing the estimates of resistance distances, i.e., $\hat{r}^d_{i,j}\,\forall i,j \in \mathcal{V_B}$, run code named [compute_initial_estimates_rho.m](https://github.com/ShivanB/Topology_Reconstruction_Codes/blob/main/Resistance_Distance_Estimates/compute_intial_estimates_rho.m). This code solves problem $\mathcal{I}$.
