library(stringi)
library(dplyr)
library(stringdist)

## Load ASR dataset
asr = read.csv("data/strutture_anagrafe_ras.csv")
dim(asr) # 7924    4
## replacing 'undefined' values with ''
idRas_cleaned = sapply(asr$idRas, function(x) gsub("undefined", "", x))
asr$idRas = idRas_cleaned

### asr structure without and with an idRas
asr_noId = asr %>% filter(idRas == '') # 615   4
dim(asr_noId)
asr_id = asr %>% filter(idRas != '') # 7309    4
dim(asr_id)

## Load SiRed dataset
sired = read.csv("data/strutture_sired.csv", header = T, quote = "")
sired_cleaned = data.frame(sapply(sired, function(x) stri_trim_both(x)))
dim(sired) # 6263    4

### sired structures with and without and idRas
sired_noId = sired_cleaned %>% filter(idRas == '') # 867   4
sired_id = sired_cleaned %>% filter(idRas != '') # 5396    4
#sired_id$idRas = as.character(sired_id$idRas)
dim(sired_noId)
dim(sired_id)

## Exploring datasets

x = intersect(sired_id$idRas, asr_id$idRas) # common idRas
ax = asr_id %>% filter(idRas %in% x)
sx = sired_id %>% filter(idRas %in% x)

dim(ax)
dim(sx)

head(ax)
head(sx)

## Joining datasets
asr_sired <- cbind(ax, sx[,2:4])



###

