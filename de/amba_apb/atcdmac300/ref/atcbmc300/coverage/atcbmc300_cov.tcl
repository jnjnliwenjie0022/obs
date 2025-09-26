#############################
# Block/Expression coverage #
#############################
select_coverage -block -expression -instance system.bmc300...
set_com -on -expression -instance system.bmc300...

set_expr_scoring -control -all 
select_functional

set_assign_scoring
set_branch_scoring
set_implicit_block_scoring -off -if -case

