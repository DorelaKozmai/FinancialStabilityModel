# MATLAB Fall 2014 – Research Plan (Template)
(text between brackets to be removed)

> * Group Name: SHOCKSTERS
> * Group participants names:  A. Bargerbos, D. Kozmai, E. Elsner
> * Project Title: Contagion Risk in Interconnected Banking Ecosystems 


## General Introduction

The global financial crisis of 2007-2008 has exposed major weaknesses in a financial supervision approach that is predominantely confined to microprudential regulation, which focuses mainly on the capital adequacy of individual insitutions while missing a large part of the picture by ignoring the interconnectedness of institutions in the financial system. The consensus among policymakers and regulators, most notably expressed at the Seoul meeting of the G20 in November 2010, has therefore been that further work on the improvement of macroprudential supervision frameworks is required. 
In reaction to the G20’s call for better techniques to identify and model systemic risk, team SHOCKERS aims to (i) model a highly interconnected banking system with heterogenous agents and (ii) shocking individual agent’s assets and (iii) defining and observing different resilience parameters in the simulation results.

## The Model

Building on the work of Nier et al. (2007), we represent a highly interconnected banking ecosystem using a simple random graph network model, namely the Erdös-Renyi model. The banking ecosystem consists of numerous banks, represented by a set of nodes N = {1, ...,n} and an n*n adjacency matrix g=[gij]i,j ∈ N ang gij∈{0,1} whereby the availability of an edge from node i to node j represents an interbank loan relationship. Each interbank loan is formed with probability p ∈ (0,1). 
Further to the interbank lending dimension, each bank’s balance sheet is described by its external assets, its depositors and its equity funding.
We aim to study the effects of financial shocks entering the financial system through the bank’s external assets and spreading through the banking network via the interbank loan edges.  
As an extension of Nier et al. we aim to introduce different non-bank agents, namely (i) fully equity financed money market funds, i.e. not receiving any bank loans, but still lending to other banks, represented by nodes m=[mij] with mi ∈ {0,1} and mj ∈ {0} and (ii) direct lenders, lending directly to exogenous creditors (e.g. through peer-to-peer lending platforms), which are represented by nodes p=[pij] with pij ∈ {0}.    


## Fundamental Questions

*	Our principal aim is to replicate the simulation results of Nier et al. (2007), in particular modelling the default/equity, default/interconnectivity, deposit loss/equity etc. relationships.
*	These relationships shall be compared to the results when different non-bank, risk absorbing agents are introduced, namely money market funds and direct lenders.

## Expected Results
*	We aim to draw policy implications from the macroprudential simulation results obtained from the above. In particular, we expect to find that the introduction of money market funds and direct lenders significantly increase financial stability in shock scenarios. As a result, financial regulation fostering disintermediation by introducing direct lending relationships and reducing the number of interbank loan edges should be further promoted.  


## References 

Gai, P. & Kapadia, S. (2010) Contagion in financial networks. Proceedings of the Royal Society A, 466(2120)

Haldane, A. & May, R. (2011) Systemic risk in banking ecosystems Nature, 469(7330)

May, R. M. & Nimalan, A. (2010) Systemic Risk: The Dynamics of Model Banking Systems. Journal of The Royal Society Interface, 7(46)

Nier, E. & Yang, J. & Yorulmazer, T. & Alentorn, A. (2007) Network models and financial stability. Journal of Economic Dynamics and Control, Elsevier, 31(6)


## Research Methods

As mentioned above, we are using the Erdös-Renyi random graph network model with the principal paraments used by Nier et al. (2007).
We are building our MATLAB code on the previous work of Kalinowski P., Park S. and Walser D., who have implemented the Nier et al. (2007) network model in the previous semester’s course. Given that their code has extensive runtime (upward of 7 hours) due to nested loops, we intend to simplify some of the routines. Further we intend to extend the code to replicate the surface charts of Nier et al. (2007) and to model the risk absorbing agents described above (money market funds, direct lenders).


## Other

Our work will be purely simulation based, we do not use or require external empirical data.
