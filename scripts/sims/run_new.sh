#!/bin/bash

cd ~/reads/human/sims/
for i in {1..10} ; do
	~/thing/bin/thing -g ~/human/Homo_sapiens.GRCh38.92.chr.gtf -S ${i}.HISAT2.bam -p 20 -t ~/human/transcriptome_from_gtf.fa -e ~/human/kallisto.idx.ec
	/home/lynnyi/kallisto_del/kallisto/build/src/kallisto pseudoquant -i ~/human/human_gtf.idx -o . -d . -t 20 -l 187 -s 70
	mv matrix.tsv ${i}.HISAT2.tsv
	mv matrix.ec ${i}.HISAT2.ec
	mv matrix.cells ${i}.HISAT2.cells
	~/thing/bin/thing -g ~/human/Homo_sapiens.GRCh38.92.chr.gtf -S ${i}.STAR.bam -p 20 -t ~/human/transcriptome_from_gtf.fa -e ~/human/kallisto.idx.ec
	/home/lynnyi/kallisto_del/kallisto/build/src/kallisto pseudoquant -i ~/human/human_gtf.idx -o . -d . -t 20 -l 187 -s 70
	mv matrix.tsv ${i}.STAR.tsv
	mv matrix.ec ${i}.STAR.ec
	mv matrix.cells ${i}.STAR.cells
done
