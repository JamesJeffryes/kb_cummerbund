#!/usr/bin/env RScript


suppressMessages(require("getopt"))

options(showWarnCalls=FALSE)
options(showErrorCalls=FALSE)

spec = matrix(c(
  'cuffdiff_dir', 'c', 1, "character",
  'outpng'      , 'p', 1, "character",
  'outjson'     , 'j', 1, "character",
  'help'        , 'h', 0, "logical"
), byrow=TRUE, ncol=4);
opt = getopt(spec);

if ( !is.null(opt$help) ) {
  cat(getopt(spec, usage=TRUE));
  q(status=1);
}

suppressMessages(require (cummeRbund))
suppressMessages(require (rjson))

cuff<-readCufflinks(opt$cuffdiff_dir)
PCA <- PCAplot(genes(cuff),"PC1","PC2")
png (file=opt$outpng,width=1080)
PCA
.invisible <- dev.off()
#write(toJSON(PCA$data), file=opt$outjson)

q(save="no")
