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

![[2020240625161622.png]]

SRAM
1. MBIST_Scaling: 10%
2. Core_Urate: 75%
3. Total Area: primitive \* MBIST_Scaling / Core_Urate

Component
1. Component_Scaling:
2. Core_Urate: 65%
3. Total Area: primitive \* Cell_Scaling / Core_Urate

Register
1. Register_Scaling:
2. Scan_Scaling: (which depend on scan_factor in tech lib)
3. Core_Urate: 65%
4. Total Area: