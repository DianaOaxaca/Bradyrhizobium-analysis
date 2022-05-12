#/bin/bash
#DianaOaxaca 190422
#This script take directory name to filename into directory 

INPUT=$(ls analysis/03.prokka)

DIR1="/data2/PEG/hoaxaca/bradys_analyze/analysis/03.prokka"

for DIR in $INPUT; do
        CD=$(cd $DIR1/$DIR && ls)
        for FILE in $CD; do
                MV=$(mv $DIR1/$DIR/$FILE $DIR1/$DIR/$DIR'_'$FILE)
                echo $MV
        done
done
