#!/bin/bash
cd ~/reads/human/sims
for dataset in {1..1} ; do
	kallisto quant -l 187 -s 70 -i ~/human/human_gtf.idx -o . -t 20 --genomebam --gtf ~/human/Homo_sapiens.GRCh38.92.chr.gtf /home/lynnyi/dirichlet/6.3_sims_exp/rsem_perturb/${dataset}.results_1.fq /home/lynnyi/dirichlet/6.3_sims_exp/rsem_perturb/${dataset}.results_2.fq
	mv abundance.tsv abundance_${dataset}.quant.original.tsv
	rm abundance.h5
	rm pseudoalignments.bam.bai
	mv pseudoalignments.bam ${dataset}.quant.bam
	~/bam2tcc/build/src/bam2tcc -g ~/human/Homo_sapiens.GRCh38.92.chr.gtf -S ${dataset}.quant.bam -p 20 -t ~/human/transcriptome_from_gtf.fa -e ~/human/kallisto.idx.ec -k
	/home/lynnyi/kallisto_del/kallisto/build/src/kallisto pseudoquant -i ~/human/human_gtf.idx -d . -o . ~/human/human_gtf.idx -t 20 -l 187 -s 70
	mv matrix.ec ${dataset}.quant.ec
	mv matrix.tsv ${dataset}.quant.tsv
	mv matrix.cells ${dataset}.quant.cells
done
