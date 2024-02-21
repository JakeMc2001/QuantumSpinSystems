# QuantumSpinSystems

Ensure that MATLAB PATH includes the subfolders to run codes.

## ---- DESCRIPTION OF SUBFOLDERS ----


### - general
**1. interactions.m** - Defines the interactions class which stores the terms of the Hamiltonian, with properties: name, Nsites (number of sites term is applied to), sites (cell array of arrays of specific sites the term is applied to) and strength of the interaction.
**2. CharacterTable.m** - Calculates and returns the character table for a system of N spins.
**3. checkParent.m** - Checks if a given parent state is active for the given momentum. **MAY NOT BE NEEDED**
**4. checkstate.m** - Checks if a given state s is an active parent state for the given momentum. **MAY NOT BE NEEDED**
**5. cyclebits.m** - Performs n transformations of the bits of a given state integer and returns the resulting state integer.
**6. findActiveParents.m** - Uses the number of spins (N), magnetization (mz) and the momentum (k) to perform 3 checks over all possible states. First, check if the current state has the given mz value, then if the current state is a parent state (lowest integer of the orbit) and lastly determines if the parent state is active for the given momentum.
**7. findNextSpin.m** - Finds the position of the next spin to the right of the current index, taking into account the periodic boundary conditions.
**8. findParentStates.m** - Returns a list of parent states and their associated periodicities for a system of N spins, regardless of magnetization or momentum. **MAY NOT BE NEEDED**
**9. findParentStatesMag.m** - Returns a list of parent momentum states for a given magnetization. **MAY NOT BE NEEDED**
**10. findPeriod.m** - Takes an integer s in bit representation, cycles the bits of s until the resulting state equals s and this number of cycles is the periodicities. The parent and child states are added to an array of states to produce the orbit of the parent state. **MAY NOT BE NEEDED**
**11. findState.m** - Takes a target state and an array of states in which to search for the target state, returns the index of the target state within the array.
**12. flipSpins.m** - Takes the bit representation of a state integer and returns the bit representation of that state with the bits in indices i and j flipped.
**13. fullBinaryHamiltonian.m** - Generates the full Hamiltonian matrix using the bit representation of states, with no symmetries implemented.
**14. genBasisStates.m** - Returns the representative states for given magnetization and momentum values. **MAY NOT BE NEEDED**
**15. genHterms.m** - Generates the Hamiltonian terms in an 'interactions' object for a Heisenberg ring with N spins.
**16. getSz.m** - Returns the magnetization value of a given state integer.
**17. PlotEnergykValues.m** - Plots the energy level diagram of a system of N spins, with energy plotted against magnetization value and each data point colour represents a momentum value, as indicated by the legend of the plot.
**18. PlotEnergyLevelDiagram.m** - Plots the energy level diagram against the magnetization value of each energy value, no momentum symmetry implemented.

### - magnetisation

**1. genMagStates.m** - Returns the list of states with given magnetization mz.
**2. fixedMagHamiltonian.m** - Calculates the Hamiltonian for a fixed magnetization value mz.
**3. MagneticEnergyLevels.m** - Generates a list of energy eigenvalues for a system of N spins, split up by magnetization value, to be passed to PlotEnergyLevelDiagram.m to plot the energy level diagram.

### - momentum

**1. findLj.m** - Takes a state b and an array of parent states, and performs translations on b to find the parent state within the array of parents. The parent and the number of translations required to obtain the parent (lj) are returned.
**2. getOrbit.m** - Returns the orbit of a given parent state, which is organised as a 2D array with the state integers in the first row and the momentum values of each state in the second.
**3. kMagHBlock.m** - Returns the list of energy eigenvalues from the Hamiltonian block matrix for magnetization mz and momentum k.
**4. momentumEnergySpectrum.m** - Returns the list of energy eigenvalues from all Hamiltonian blocks for each value of mz and k.
**5. generateHamiltonian.m** - Returns the Hamiltonian block matrix for mz and k values, which also takes an 'interactions' object to represent the terms of the Hamiltonian.

### - Lanczos
**1. hoperation.m** - Takes state phi and the number of spins (N), magnetization (mz) and the momentum (k), and returns the state gamma which is the result of acting the Hamiltonian on state phi.
**2. normalize.m** - Takes state phi, computes the inner product and rescales phi so the inner product = 1.
**3. numberOfHelements.m** - Returns an array of the non-zero Hamiltonian elements and an array of the positions of those non-zero elements.

### - oldMomentum

Includes functions previously created and used which are not relevant for the working momentum code.

### - semiMomentum

Includes functions relevant for the semi-momentum states.