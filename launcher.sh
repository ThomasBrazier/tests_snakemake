#!/bin/bash
#SBATCH --mail-user=thomas.brazier@univ-rennes.fr
#SBATCH --mail-type=all
#SBATCH --cpus-per-task=1
#SBATCH --mem=10GB
#SBATCH --time=20-60:00:00
#SBATCH --job-name=test_snakemake
#SBATCH --partition=ecobio,genouest
#SBATCH --output=log/slurm-%A.out

. /local/env/envconda.sh
conda activate snakemake
# . /local/env/envsnakemake-8.0.1.sh

snakemake -s workflow/Snakefile --configfile config/config.yaml \
--use-conda --conda-frontend conda --profile ./profiles/slurm --cores 1 --rerun-incomplete