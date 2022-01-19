# These scripts are used to sample a path for metadynamics simulations from EDS sampling done using GROMACS. Scripts are to be executed in the following order

prerequities: An EDS trajectory (.xtc) generated from gromacs and structures of the initial and target systems (.pdb)

Step 1: compute full RMSD matrix using all the "n" frames from EDS by running the script "compute-full-rmsd-matrix.sh"
Step 2: now extract EDS times for collecting snapshots using "snap-times.sh"
Step 3: Genearte the path to be used in metadynamics by running "path-for-mtd.sh"
Step 4: Now, calculate RMSD between successive frames in the genertaed path by running "rmsd_matrix-mtd.sh"
Step 5: Finally, calculate lamda using RMSD values between successive frames by executing "lambda.sh" 

