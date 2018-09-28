#!/bin/bash
cd ~/reads/human/sims
for dataset in {1..10} ; do
	echo "${dataset} running..."
	~/salmon-0.8.2_linux_x86_64/bin/salmon quant -i ~/human/salmon_0.8.2_idx.rel92.31 -l IU -1 /home/lynnyi/dirichlet/6.3_sims_exp/rsem_perturb/${dataset}.results_1.fq -2 /home/lynnyi/dirichlet/6.3_sims_exp/rsem_perturb/${dataset}.results_2.fq -o ${dataset}.Salmon_0.8.2 --dumpEq
	~/llconv/build/src/debug -t ${dataset}.Salmon_0.8.2/aux_info/eq_classes.txt matrix ~/human/transcriptome_from_gtf.fa ~/human/kallisto.idx.ec
	echo "${dataset}.Salmon_0.8.2" > matrix.cells
	/home/lynnyi/kallisto_del/kallisto/build/src/kallisto pseudoquant -d . -o . -i ~/human/human_gtf.idx -t 20 -l 187 -s 70
	mv matrix.ec ${dataset}.Salmon_0.8.2.ec
	mv matrix.tsv ${dataset}.Salmon_0.8.2.tsv
	mv matrix.cells ${dataset}.Salmon_0.8.2.cells
	mv ${dataset}.Salmon_0.8.2/quant.sf ${dataset}.Salmon_0.8.2.quant.sf
	mv ${dataset}.Salmon_0.8.2/aux_info/eq_classes.txt ${dataset}.Salmon_0.8.2.eq_classes.txt
	rm -r ${dataset}.Salmon_0.8.2
done
