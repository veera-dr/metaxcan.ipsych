#!/bin/make


#write snps/allele list
# create a table of number of snps queried and number of snps extracted
# create a list of snps not extracted along with its transcript IDs

#remove snps with <90% missing rate
$(outname).snp95.bim:$(outname).sample95.bim
	$(plink) --bfile $(outname).sample95 \
--geno 0.1 \
--make-bed --out $(outname).snp95

# remove individuals with <90% missing rate
$(outname).sample95.bim: $(outname).mismatch.removed.bim
	$(plink) --bfile $(outname).mismatch.removed \
--mind 0.1 \
--make-bed --out $(outname).sample95

$(outname).snps.not.extracted:$(db) $(outname).mismatch.removed.bim
	Rscript $(sd)/write.snp.report.R $(db) $(outname).mismatch.removed.bim $(outname).snps.not.extracted


#check the allele match again
$(outname).rsids.mismatch.verify: $(outname).mismatch.removed.bim $(outname).snplist $(outname).rsids.mismatch
	Rscript $(sd)/allele.check.R $(outname).mismatch.removed.bim $(db) $(outname).rsids.mismatch.verify

#remove the allele mismatched snps from the plink file
$(outname).mismatch.removed.bim:$(outname).rsids.mismatch  $(outname).bim
	$(plink) --bfile $(outname) \
--exclude $(outname).rsids.mismatch \
--reference-allele $(outname).snplist \
--make-bed \
--out $(outname).mismatch.removed


# check if the alleles match between bim and list files
$(outname).rsids.mismatch:$(outname).bim $(outname).snplist
	Rscript $(sd)/allele.check.R $(outname).bim $(db) $(outname).rsids.mismatch

#extract the snps forcing the reference-allele to 
$(outname).bim:$(plinkfile).bim $(outname).snplist.c1 $(outname).snplist
	$(plink) --bfile $(plinkfile) \
--extract $(outname).snplist.c1 \
--reference-allele $(outname).snplist \
--make-bed \
--out $(outname)


#write snplist and snplist_c1
$(outname).snplist.c1:$(outname).snplist
	cut -f 1 $(outname).snplist > $(outname).snplist.c1

$(outname).snplist:$(db)
	Rscript $(sd)/write.snplist.R $(db) $(outname).snplist




