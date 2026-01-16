#!/bin/bash

# This script should be run once the completeness pipeline has been completed and we have
# the completeness cuts to apply to the BGS_BRIGHT clustering catalogs.

# filepath: /global/homes/m/mcdemart/satfrac/catalog_prep/create_cut_catalogs.sh

# example usage
# ./create_cut_catalogs.sh 11.0 12.1
# ./create_cut_catalogs.sh 11.0 12.1 --copy-randoms

# Check if correct number of arguments provided
if [ $# -lt 2 ] || [ $# -gt 3 ]; then
    echo "Usage: $0 <min_mass> <max_mass> [--copy-randoms]"
    echo "Example: $0 11.0 12.1"
    echo "Example: $0 11.0 12.1 --copy-randoms"
    exit 1
fi

# Get mass cut parameters from command line arguments
MIN_MASS=$1
MAX_MASS=$2

# Calculate offset min mass for 3_4 bin
# MIN_MASS_34=$(echo "$MIN_MASS + 0.1" | bc)
MIN_MASS_34=$MIN_MASS

# Check for copy flag
COPY_RANDOMS=false
if [ $# -eq 3 ] && [ "$3" == "--copy-randoms" ]; then
    COPY_RANDOMS=true
fi

# Create BGS_BRIGHT catalogs for different redshift bins with mass cut

echo "Starting catalog creation for BGS_BRIGHT with mass cut ${MIN_MASS}-${MAX_MASS}..."

# Redshift bin 0.1-0.2
echo "Processing redshift bin 0.1-0.2..."
python $LSSDIR/LSS/scripts/mkCat_mass_subsamp.py \
    --outdir $SCRATCH/desi/Y3/LSS/loa-v1/LSScats/v2/mass_cut/1_2/ \
    --input_tracer BGS_BRIGHT \
    --zmin 0.1 \
    --zmax 0.2 \
    --ccut _masscut-${MIN_MASS}-${MAX_MASS}

# Redshift bin 0.2-0.3
echo "Processing redshift bin 0.2-0.3..."
python $LSSDIR/LSS/scripts/mkCat_mass_subsamp.py \
    --outdir $SCRATCH/desi/Y3/LSS/loa-v1/LSScats/v2/mass_cut/2_3/ \
    --input_tracer BGS_BRIGHT \
    --zmin 0.2 \
    --zmax 0.3 \
    --ccut _masscut-${MIN_MASS}-${MAX_MASS}

# Redshift bin 0.3-0.4
echo "Processing redshift bin 0.3-0.4 with offset min mass ${MIN_MASS_34}..."
python $LSSDIR/LSS/scripts/mkCat_mass_subsamp.py \
    --outdir $SCRATCH/desi/Y3/LSS/loa-v1/LSScats/v2/mass_cut/3_4/ \
    --input_tracer BGS_BRIGHT \
    --zmin 0.3 \
    --zmax 0.4 \
    --ccut _masscut-${MIN_MASS_34}-${MAX_MASS}

echo "All catalogs with mass cut ${MIN_MASS}-${MAX_MASS} created successfully!"

# Run add_mass_hp_back.py on clustering catalogs
# this isn't strictly necessary but can help with bookkeeping
# and ensures that the mass and HP columns are added to the catalogs
echo "Running add_mass_hp_back.py on catalogs..."

# Process 1_2 catalog
echo "Processing 1_2 catalog..."
python /global/homes/m/mcdemart/satfrac/catalog_prep/add_mass_hp_back.py \
    --lss-path $SCRATCH/desi/Y3/LSS/loa-v1/LSScats/v2/mass_cut/1_2/ \
    --lss-name BGS_BRIGHT_masscut-${MIN_MASS}-${MAX_MASS}_clustering.dat.fits \
    --fastx-path /global/cfs/cdirs/desi/vac/dr2/fastphot/loa/v1.0/catalogs/ \
    --mode fastphot

# Process 2_3 catalog
echo "Processing 2_3 catalog..."
python /global/homes/m/mcdemart/satfrac/catalog_prep/add_mass_hp_back.py \
    --lss-path $SCRATCH/desi/Y3/LSS/loa-v1/LSScats/v2/mass_cut/2_3/ \
    --lss-name BGS_BRIGHT_masscut-${MIN_MASS}-${MAX_MASS}_clustering.dat.fits \
    --fastx-path /global/cfs/cdirs/desi/vac/dr2/fastphot/loa/v1.0/catalogs/ \
    --mode fastphot

# Process 3_4 catalog (note: using offset min mass)
echo "Processing 3_4 catalog..."
python /global/homes/m/mcdemart/satfrac/catalog_prep/add_mass_hp_back.py \
    --lss-path $SCRATCH/desi/Y3/LSS/loa-v1/LSScats/v2/mass_cut/3_4/ \
    --lss-name BGS_BRIGHT_masscut-${MIN_MASS_34}-${MAX_MASS}_clustering.dat.fits \
    --fastx-path /global/cfs/cdirs/desi/vac/dr2/fastphot/loa/v1.0/catalogs/ \
    --mode fastphot

echo "Mass and HP columns added to all catalogs!"

# # Rename files to remove mass cut information from filename
# echo "Renaming HPMapcut output files..."

# # Rename file in 1_2 directory
# mv $SCRATCH/desi/Y3/LSS/loa-v1/LSScats/v2/mass_cut/1_2/BGS_BRIGHT_masscut-${MIN_MASS}-${MAX_MASS}_full_HPmapcut.dat.fits \
#    $SCRATCH/desi/Y3/LSS/loa-v1/LSScats/v2/mass_cut/1_2/BGS_BRIGHT_full_HPmapcut.dat.fits

# # Rename file in 2_3 directory
# mv $SCRATCH/desi/Y3/LSS/loa-v1/LSScats/v2/mass_cut/2_3/BGS_BRIGHT_masscut-${MIN_MASS}-${MAX_MASS}_full_HPmapcut.dat.fits \
#    $SCRATCH/desi/Y3/LSS/loa-v1/LSScats/v2/mass_cut/2_3/BGS_BRIGHT_full_HPmapcut.dat.fits

# # Rename file in 3_4 directory (note: using offset min mass)
# mv $SCRATCH/desi/Y3/LSS/loa-v1/LSScats/v2/mass_cut/3_4/BGS_BRIGHT_masscut-${MIN_MASS_34}-${MAX_MASS}_full_HPmapcut.dat.fits \
#    $SCRATCH/desi/Y3/LSS/loa-v1/LSScats/v2/mass_cut/3_4/BGS_BRIGHT_full_HPmapcut.dat.fits

# echo "File renaming complete!"

# Copy random files if flag is set
if [ "$COPY_RANDOMS" = true ]; then
    echo "Copying HPmapcut files to output directories..."
    
    # Copy to 1_2 directory
    echo "Copying randoms to 1_2..."
    cd $SCRATCH/desi/Y3/LSS/loa-v1/LSScats/v2/mass_cut/1_2/
    cp -v /global/cfs/cdirs/desi/survey/catalogs/DA2/LSS/loa-v1/LSScats/v2/BGS_BRIGHT_*_full_HPmapcut.*.fits ./
    cp -v /global/cfs/cdirs/desi/survey/catalogs/DA2/LSS/loa-v1/LSScats/v2/BGS_BRIGHT_full_HPmapcut.dat.fits ./
    
    # Copy to 2_3 directory
    echo "Copying randoms to 2_3..."
    cd $SCRATCH/desi/Y3/LSS/loa-v1/LSScats/v2/mass_cut/2_3/
    cp -v /global/cfs/cdirs/desi/survey/catalogs/DA2/LSS/loa-v1/LSScats/v2/BGS_BRIGHT_*_full_HPmapcut.*.fits ./
    cp -v /global/cfs/cdirs/desi/survey/catalogs/DA2/LSS/loa-v1/LSScats/v2/BGS_BRIGHT_full_HPmapcut.dat.fits ./
    
    # Copy to 3_4 directory
    echo "Copying randoms to 3_4..."
    cd $SCRATCH/desi/Y3/LSS/loa-v1/LSScats/v2/mass_cut/3_4/
    cp -v /global/cfs/cdirs/desi/survey/catalogs/DA2/LSS/loa-v1/LSScats/v2/BGS_BRIGHT_*_full_HPmapcut.*.fits ./
    cp -v /global/cfs/cdirs/desi/survey/catalogs/DA2/LSS/loa-v1/LSScats/v2/BGS_BRIGHT_full_HPmapcut.dat.fits ./
    
    echo "HPmapcut file copying complete!"
fi