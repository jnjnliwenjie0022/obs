# concept

## from_cf

SRAM
1. MBIST_Scaling: 1.1
2. Core_Urate: 75%
3. Total Area: primitive \* MBIST_Scaling / Core_Urate

Cell
1. Cell_Scaling: 1.25 (which depend on scan_factor in tech lib)
2. Core_Urate: 65%
3. Total Area: primitive \* Cell_Scaling / Core_Urate
## from_andes

![[Pasted image 20240625161622.png]]

SRAM
1. MBIST_Scaling: 10%
2. Core_Urate: 75%
3. Total Area: primitive \* MBIST_Scaling / core_urate

Logic
1. zwl_comb_scaling: 1.21
2. Core_Urate: 65%
3. Total Area: primitive_comb \* zwl_comb_scaling / core_urate

Register
1. zwl_flop_scaling: 1.05
2. scan_facor: (which depend on scan_factor in tech lib)
3. core_urate: 65%
4. Total Area: primitive_flop \* zwl_flop_scaling \* scan_facor / core_urate