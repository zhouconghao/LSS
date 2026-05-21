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
