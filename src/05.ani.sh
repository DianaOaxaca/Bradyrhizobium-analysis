#!/usr/bin/bash
#DianaOaxaca
#All diferent ANI analysis

#average_nucleotide_identity.py -i analysis/05.ANIm/genomes/ -m ANIm -g --labels analysis/05.ANIm/labels.tab -o analysis/05.ANIm/ANIm_out

#average_nucleotide_identity.py -i analysis/05.ANIm/ani_rep/fna_ani_rep/ -m ANIm -g --labels analysis/05.ANIm/ani_rep/labels.tab -o analysis/05.ANIm/ani_rep/ANIm_rep_out

#average_nucleotide_identity.py -i analysis/05.ANIm/ani_rep/fna_ani_rep_add/ -m ANIm -g --labels analysis/05.ANIm/ani_rep_add/labels.tab -o analysis/05.ANIm/ani_rep_add/ANIm_rep_out2

average_nucleotide_identity.py -i analysis/ANIgenes/fastas_final/ -m ANIm -g --labels analysis/ANIgenes/labels.tab -o analysis/ANIgenes/ani_genes
