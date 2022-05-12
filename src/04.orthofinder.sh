#!/usr/bin/bash
#DianaOaxaca 210422

mkdir -p analysis/04.Orthofinder/faa
cp analysis/03.prokka/*/*.faa analysis/04.Orthofinder/faa/
orthofinder -M msa -t 94  -f analysis/04.Orthofinder/faa/ -n OF_results
