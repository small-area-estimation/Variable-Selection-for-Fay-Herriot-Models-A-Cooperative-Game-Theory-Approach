# Variable-Selection-for-Fay-Herriot-Models-A-Cooperative-Game-Theory-Approach

This repository provides a reproducible example of the methodology proposed in the paper 
> **Cabello, E., Gonçalves-Dosantos, J.C., Morales, D. et al. Variable selection for Fay–Herriot models: a cooperative game theory approach. *TEST (2025)*.
[https://doi.org/10.1007/s11749-025-00998-2](https://doi.org/10.1007/s11749-025-00998-2).**

It includes a script (use_example.R) that illustrates how to compute the Shapley-based influence measure and apply the variable selection algorithm to a synthetic dataset. The dataset used corresponds to the Examples 1,2, and 3 presented in the manuscript.

The file Example.csv contains the variables used in the analysis. The columns indicate: the domain, the value of the target variable in the d-th domain, the sampling error variance, and the explanatory variables.

The synthetic dataset is generated as follows:
- Number of areas/domains: $D=50$ 
- Target variables: $y_d = x_d\boldsymbol{\beta} + u_d + e_d$, $u_d \sim \mathcal{N}(0,\sigma_u^2)$ and $e_d \sim \mathcal{N}(0,\sigma_{ed}^2)$, independently.
- Random effects variance: $\sigma_u^2 = 1$
- Sampling error variances:  $\sigma^2_{ed} = \alpha_0 + \frac{(\alpha_1-\alpha_0)(d-1)}{D-1}$ with $\alpha_0=0.8$, $\alpha_1=1.2$, $d=1,\ldots,50$.
- Auxiliary variables: $x_{di} \sim \mathcal{U}(0,3)$, independently for $i=1,2,3$, and $\boldsymbol{\beta}=(1,1,0.25)^\top$.
