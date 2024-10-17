-- This file lists all bands with Glam rock
SELECT band_name, 
       (2024 - formed) - (CASE WHEN split IS NOT NULL THEN (2024 - split) ELSE (2024 - formed) END) AS lifespan 
FROM metal_bands 
WHERE style = 'Glam rock';
