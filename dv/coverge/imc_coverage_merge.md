same file merge with different code content

1. 這個file不會merge，請注意，**merge一定要保證file内的code完全一樣**
2. 即使是不同code，且code内部是不同instance，不同的instance可以被呈現出來
3. 基於第二點，基本上code content不同的話只能處理整合而已，不能出現assign / always，不能改變port

parameter merge on bit width

1. 可以被merge，但primary test model一定要是宇集合

parameter merge on generate if

1. 可以被merge

define merge on IO

1. ??

define merge on bit width

1. ??

define merge on generate if

1. ??
