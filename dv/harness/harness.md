# interface
[[Verification Prowess with the UVM Harness.pdf#page=6&selection=95,0,97,34|Verification Prowess with the UVM Harness, page 6]]
![[Pasted image 20240519232041.png | 1000]]
# force
多個相同module的instance在用force的時候會有問題,相同的port會有相同的行爲
i_data名字相同,會使force下的所有instance的行爲會相同,這不符合預期
![[Pasted image 20240520145541.png]]
i_data名字相同,但因爲中途rename的關係,所以所有instance的行爲會不同,這符合預期,但違反coding style(很尷尬!!)
![[Pasted image 20240520145623.png]]
## conclusion
一對多的信號且相同名字,force會有問題