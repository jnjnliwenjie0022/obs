1. fejifej
<ol>
	1. 定義了type_id這個變量，每個參數化的類都是不同的類，因此，每一個component類都有與之對應的一個uvm_object_registry類，注意uvm_object_registry內部都是使用static去宣告(靜態成員 (static member))，靜態成員函式是不屬於任何一個實體 (instance)，即不需要任何實體就可以呼叫該類別的成員.  
	2. type_id本質就是在X中定義的uvm_component_registry #(X, "X")這個類,所以調用X::type_id::create("x", this)就是調用了uvm_component_register #(X, "X")中的create方法。
<ol>
> 	type_id在被定義的瞬間，即是local static this_type me = get(); 就被執行，且每個類都有自己的static this_type me