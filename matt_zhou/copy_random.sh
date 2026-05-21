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