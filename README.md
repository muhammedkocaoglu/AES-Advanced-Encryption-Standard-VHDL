# AES-Advanced-Encryption-Standard-VHDL

This is the simulation of 128 bit AES encryption.

There are key(128 bit in binary) and message(128 bit in binary) as inputs and cipher text(128 bit in binary) as output.     

I simulated 3 exampes and they are all in hex:     

-------------------------------------------------------------     
 
1)                                                                    
     message : 3243F6A8885A308D313198A2E0370734     
     key     : 2B7E151628AED2A6ABF7158809CF4F3C     
	 
	 OUTPUT  : 3925841D 02DC09FB DC118597 196A0B32     
	 
-------------------------------------------------------------     
	 
2)                                                                          
    message  : 4d5548414d4d45444b4f43414f474c55     
    key      : 45534b49534548495245454531323334     
	      
	output   : 9E65169F BA599F38 3B0DF7A2 98B8CF05     
	
-------------------------------------------------------------     
	
3)                                                                                 
    message  : 00000000000000000000000000000004     
    key      : 00000000000000000000000000000004     
	
	output   : 39F96776 A66D645F 89E04E20 CDFBBD4C     
	
-------------------------------------------------------------     
