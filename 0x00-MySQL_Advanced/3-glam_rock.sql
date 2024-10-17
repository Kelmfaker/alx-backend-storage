-- This file lists all bands with Glam rock
SELECT band_name,
       IFNULL(split, 2022) - formed AS lifespan
FROM metal_bands 
WHERE style = 'Glam rock'
ORDER BY
    lifespan DESC;