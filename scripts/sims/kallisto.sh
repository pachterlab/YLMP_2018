#!/bin/bash

cd ~/reads/human/sims
for i in {1..1} ; do
	echo "${i} running..."
	kallisto pseudo -i ~/human/human_gtf.idx -o . /home/lynnyi/dirichlet/6.3_sims_exp/rsem_perturb/${i}.results_1.fq /home/lynnyi/dirichlet/6.3_sims_exp/rsem_perturb/${i}.results_2.fq
	mv pseudoalignments.tsv ${i}.kallisto.full.tsv
	mv pseudoalignments.ec matrix.ec
	~/bam2tcc/build/src/debug -x ${i}.kallisto.full.tsv matrix.tsv
	echo "${i}.kallisto" > matrix.cells
	/home/lynnyi/kallisto_del/kallisto/build/src/kallisto pseudoquant -i ~/human/human_gtf.idx -o . -d . -l 187 -s 70
	mv matrix.ec ${i}.kallisto.ec
	mv matrix.tsv ${i}.kalisto.tsv
	mv matrix.cells ${i}.kallisto.cells
done
