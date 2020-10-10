library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;


entity shift_rows is
	port(
		row_n1    :  in std_logic_vector(31 downto 0);
		row_n2    :  in std_logic_vector(31 downto 0);
		row_n3    :  in std_logic_vector(31 downto 0);
		row_n4    :  in std_logic_vector(31 downto 0);
		
		--outputs:
		row_z1    :  out std_logic_vector(31 downto 0);
		row_z2    :  out std_logic_vector(31 downto 0);
		row_z3    :  out std_logic_vector(31 downto 0);
		row_z4    :  out std_logic_vector(31 downto 0)
	);
end shift_rows;


architecture shift_rows of shift_rows is

component sboxtransform is
	port(
			
			column_row_sum     : in std_logic_vector(7 downto 0);
			
			--Output:
			y : out std_logic_vector(7 downto 0)
	);
end component;


--signals for each box--
signal t1,t2,t3,t4,t5,t6,t7,t8,t9,t10,t11,t12,t13,t14,t15,t16  :  std_logic_vector(8 downto 0);
--signals to generate row again--
signal sig_row_n1,sig_row_n2,sig_row_n3,sig_row_n4 : std_logic_vector(31 downto 0);
--signals for round--
signal r00,r01,r02,r03,r04,r05,r06,r07,r08,r09,r10,r11,r12,r13,r14,r15  : std_logic_vector(8 downto 0);
signal r16,r17,r18,r19,r20,r21,r22,r23,r24,r25,r26,r27,r28,r29,r30,r31  : std_logic_vector(8 downto 0);
signal r00_new,r01_new,r02_new,r03_new,r04_new,r05_new,r06_new,r07_new : std_logic_vector(8 downto 0);
signal r08_new,r09_new,r10_new,r11_new,r12_new,r13_new,r14_new,r15_new : std_logic_vector(8 downto 0);
signal r16_new,r17_new,r18_new,r19_new,r20_new,r21_new,r22_new,r23_new : std_logic_vector(8 downto 0);
signal r24_new,r25_new,r26_new,r27_new,r28_new,r29_new,r30_new,r31_new : std_logic_vector(8 downto 0);


--each box signals for subbyte--
signal sb0,sb1,sb2,sb3,sb4,sb5,sb6,sb7,sb8,sb9,sb10,sb11,sb12,sb13,sb14,sb15  : std_logic_vector(7 downto 0);
signal sb16,sb17,sb18,sb19,sb20,sb21,sb22,sb23,sb24,sb25,sb26,sb27,sb28,sb29,sb30,sb31  : std_logic_vector(7 downto 0);


--shift rows foe shift--
signal row_z1_sig : std_logic_vector(31 downto 0);
signal row_z2_sig : std_logic_vector(31 downto 0);
signal row_z3_sig : std_logic_vector(31 downto 0);
signal row_z4_sig : std_logic_vector(31 downto 0);




--each box signals for mix column--
signal bx1   : std_logic_vector(7 downto 0);
signal bx2   : std_logic_vector(7 downto 0);
signal bx3   : std_logic_vector(7 downto 0);
signal bx4   : std_logic_vector(7 downto 0);
signal bx5   : std_logic_vector(7 downto 0);
signal bx6   : std_logic_vector(7 downto 0);
signal bx7   : std_logic_vector(7 downto 0);
signal bx8   : std_logic_vector(7 downto 0);
signal bx9   : std_logic_vector(7 downto 0);
signal bx10  : std_logic_vector(7 downto 0);
signal bx11  : std_logic_vector(7 downto 0);
signal bx12  : std_logic_vector(7 downto 0);
signal bx13  : std_logic_vector(7 downto 0);
signal bx14  : std_logic_vector(7 downto 0);
signal bx15  : std_logic_vector(7 downto 0);
signal bx16  : std_logic_vector(7 downto 0);


begin
   
	sb0  <= row_n1(31 downto 24);
	sb1  <= row_n2(31 downto 24);
	sb2  <= row_n3(31 downto 24);
	sb3  <= row_n4(31 downto 24);
	sb4  <= row_n1(23 downto 16);
	sb5  <= row_n2(23 downto 16);
	sb6  <= row_n3(23 downto 16);
	sb7  <= row_n4(23 downto 16);
	sb8  <= row_n1(15 downto 8);
	sb9  <= row_n2(15 downto 8);
	sb10 <= row_n3(15 downto 8);
	sb11 <= row_n4(15 downto 8);
	sb12 <= row_n1(7 downto 0);
	sb13 <= row_n2(7 downto 0);
	sb14 <= row_n3(7 downto 0);
	sb15 <= row_n4(7 downto 0);
	
	
	--Sub beyte--
	sboxt1 : sboxtransform port map (column_row_sum => sb0 , y => sb16);
	sboxt2 : sboxtransform port map (column_row_sum => sb1 , y => sb17);
	sboxt3 : sboxtransform port map (column_row_sum => sb2 , y => sb18);
	sboxt4 : sboxtransform port map (column_row_sum => sb3 , y => sb19);
	sboxt5 : sboxtransform port map (column_row_sum => sb4 , y => sb20);
	sboxt6 : sboxtransform port map (column_row_sum => sb5 , y => sb21);
	sboxt7 : sboxtransform port map (column_row_sum => sb6 , y => sb22);
	sboxt8 : sboxtransform port map (column_row_sum => sb7 , y => sb23);
	sboxt9 : sboxtransform port map (column_row_sum => sb8 , y => sb24);
	sboxt10 : sboxtransform port map (column_row_sum => sb9 , y => sb25);
	sboxt11 : sboxtransform port map (column_row_sum => sb10 , y => sb26);
	sboxt12 : sboxtransform port map (column_row_sum => sb11 , y => sb27);
	sboxt13 : sboxtransform port map (column_row_sum => sb12 , y => sb28);
	sboxt14 : sboxtransform port map (column_row_sum => sb13 , y => sb29);
	sboxt15 : sboxtransform port map (column_row_sum => sb14 , y => sb30);
	sboxt16 : sboxtransform port map (column_row_sum => sb15 , y => sb31);
	
	
	sig_row_n1 <= sb16 & sb20 & sb24 & sb28;
	sig_row_n2 <= sb17 & sb21 & sb25 & sb29;
	sig_row_n3 <= sb18 & sb22 & sb26 & sb30;
	sig_row_n4 <= sb19 & sb23 & sb27 & sb31;
	--shifted matrix--
	row_z1_sig <= sig_row_n1;
	row_z2_sig <= sig_row_n2(23 downto 0) & sig_row_n2(31 downto 24);
	row_z3_sig <= sig_row_n3(15 downto 0) & sig_row_n3(31 downto 16);
	row_z4_sig <= sig_row_n4(7 downto 0) & sig_row_n4(31 downto 8);
	
	--boxes assignment--
	bx1  <= row_z1_sig(31 downto 24);
	bx2  <= row_z2_sig(31 downto 24);
	bx3  <= row_z3_sig(31 downto 24);
	bx4  <= row_z4_sig(31 downto 24);
	bx5  <= row_z1_sig(23 downto 16);
	bx6  <= row_z2_sig(23 downto 16);
	bx7  <= row_z3_sig(23 downto 16);
	bx8  <= row_z4_sig(23 downto 16);
	bx9  <= row_z1_sig(15 downto 8);
	bx10 <= row_z2_sig(15 downto 8);
	bx11 <= row_z3_sig(15 downto 8);
	bx12 <= row_z4_sig(15 downto 8);
	bx13 <= row_z1_sig(7 downto 0);
	bx14 <= row_z2_sig(7 downto 0);
	bx15 <= row_z3_sig(7 downto 0);
	bx16 <= row_z4_sig(7 downto 0);
	
	
	---MIX COLUMNS--
	--column 0 and row 0--
	r00 <= bx1 & '0';
	p1 : process(r00)
	begin
		if(r00(8) = '1') then 
			r00_new <= r00 xor "100011011";
		else 
			r00_new <= r00;
		end if;
	end process;
	
   r01 <= (bx2 & '0') xor ('0' & bx2);
	p2 : process(r01)
	begin
		if(r01(8) = '1') then 
			r01_new <= r01 xor "100011011";
		else 
			r01_new <= r01;
		end if;
	end process;
	t1 <= ('0' & bx3) xor ('0' & bx4) xor r00_new xor r01_new;
	
	--column 0 and row 1--
	r02 <= bx2 & '0';
	p3 : process(r02)
	begin
		if(r02(8) = '1') then 
			r02_new <= r02 xor "100011011";
		else 
			r02_new <= r02;
		end if;
	end process;
	
   r03 <= (bx3 & '0') xor ('0' & bx3);
	p4 : process(r03)
	begin
		if(r03(8) = '1') then 
			r03_new <= r03 xor "100011011";
		else 
			r03_new <= r03;
		end if;
	end process;
	t2 <= ('0' & bx1) xor ('0' & bx4) xor r02_new xor r03_new;
	
	--column 0 and row 3--
		r04 <= bx3 & '0';
	p5 : process(r04)
	begin
		if(r04(8) = '1') then 
			r04_new <= r04 xor "100011011";
		else 
			r04_new <= r04;
		end if;
	end process;
	
   r05 <= (bx4 & '0') xor ('0' & bx4);
	p6 : process(r05)
	begin
		if(r05(8) = '1') then 
			r05_new <= r05 xor "100011011";
		else 
			r05_new <= r05;
		end if;
	end process;
	t3 <= ('0' & bx1) xor ('0' & bx2) xor r04_new xor r05_new;
	
	--column 0 and row 4--
		r06 <= bx4 & '0';
	p7 : process(r06)
	begin
		if(r06(8) = '1') then 
			r06_new <= r06 xor "100011011";
		else 
			r06_new <= r06;
		end if;
	end process;
	
   r07 <= (bx1 & '0') xor ('0' & bx1);
	p8 : process(r07)
	begin
		if(r07(8) = '1') then 
			r07_new <= r07 xor "100011011";
		else 
			r07_new <= r07;
		end if;
	end process;
	t4 <= ('0' & bx2) xor ('0' & bx3) xor r06_new xor r07_new;	
	
	
	
	
	-------------------COLUMN 2-------------------
	
		--column 1 and row 0--
	r08 <= bx5 & '0';
	p9 : process(r08)
	begin
		if(r08(8) = '1') then 
			r08_new <= r08 xor "100011011";
		else 
			r08_new <= r08;
		end if;
	end process;
	
   r09 <= (bx6 & '0') xor ('0' & bx6);
	p10 : process(r09)
	begin
		if(r09(8) = '1') then 
			r09_new <= r09 xor "100011011";
		else 
			r09_new <= r09;
		end if;
	end process;
	t5 <= ('0' & bx7) xor ('0' & bx8) xor r08_new xor r09_new;
	
	--column 0 and row 1--
	r10 <= bx6 & '0';
	p11 : process(r10)
	begin
		if(r10(8) = '1') then 
			r10_new <= r10 xor "100011011";
		else 
			r10_new <= r10;
		end if;
	end process;
	
   r11 <= (bx7 & '0') xor ('0' & bx7);
	p12 : process(r11)
	begin
		if(r11(8) = '1') then 
			r11_new <= r11 xor "100011011";
		else 
			r11_new <= r11;
		end if;
	end process;
	t6 <= ('0' & bx5) xor ('0' & bx8) xor r10_new xor r11_new;
	
	--column 0 and row 3--
		r12 <= bx7 & '0';
	p13 : process(r12)
	begin
		if(r12(8) = '1') then 
			r12_new <= r12 xor "100011011";
		else 
			r12_new <= r12;
		end if;
	end process;
	
   r13 <= (bx8 & '0') xor ('0' & bx8);
	p14 : process(r13)
	begin
		if(r13(8) = '1') then 
			r13_new <= r13 xor "100011011";
		else 
			r13_new <= r13;
		end if;
	end process;
	t7 <= ('0' & bx5) xor ('0' & bx6) xor r12_new xor r13_new;
	
	--column 0 and row 4--
		r14 <= bx8 & '0';
	p15 : process(r14)
	begin
		if(r14(8) = '1') then 
			r14_new <= r14 xor "100011011";
		else 
			r14_new <= r14;
		end if;
	end process;
	
   r15 <= (bx5 & '0') xor ('0' & bx5);
	p16 : process(r15)
	begin
		if(r15(8) = '1') then 
			r15_new <= r15 xor "100011011";
		else 
			r15_new <= r15;
		end if;
	end process;
	t8 <= ('0' & bx6) xor ('0' & bx7) xor r14_new xor r15_new;
	
	
	
	-------------------COLUMN 3-------------------
	
		--column 2 and row 0--
	r16 <= bx9 & '0';
	p17 : process(r16)
	begin
		if(r16(8) = '1') then 
			r16_new <= r16 xor "100011011";
		else 
			r16_new <= r16;
		end if;
	end process;
	
   r17 <= (bx10 & '0') xor ('0' & bx10);
	p18 : process(r17)
	begin
		if(r17(8) = '1') then 
			r17_new <= r17 xor "100011011";
		else 
			r17_new <= r17;
		end if;
	end process;
	t9 <= ('0' & bx11) xor ('0' & bx12) xor r16_new xor r17_new;
	
	--column 2 and row 1--
	r18 <= bx10 & '0';
	p19 : process(r18)
	begin
		if(r18(8) = '1') then 
			r18_new <= r18 xor "100011011";
		else 
			r18_new <= r18;
		end if;
	end process;
	
   r19 <= (bx11 & '0') xor ('0' & bx11);
	p20 : process(r19)
	begin
		if(r19(8) = '1') then 
			r19_new <= r19 xor "100011011";
		else 
			r19_new <= r19;
		end if;
	end process;
	t10 <= ('0' & bx9) xor ('0' & bx12) xor r18_new xor r19_new;
	
	--column 2 and row 3--
		r20 <= bx11 & '0';
	p21 : process(r20)
	begin
		if(r20(8) = '1') then 
			r20_new <= r20 xor "100011011";
		else 
			r20_new <= r20;
		end if;
	end process;
	
   r21 <= (bx12 & '0') xor ('0' & bx12);
	p22 : process(r21)
	begin
		if(r21(8) = '1') then 
			r21_new <= r21 xor "100011011";
		else 
			r21_new <= r21;
		end if;
	end process;
	t11 <= ('0' & bx9) xor ('0' & bx10) xor r20_new xor r21_new;
	
	--column 2 and row 4--
		r22 <= bx12 & '0';
	p23 : process(r22)
	begin
		if(r22(8) = '1') then 
			r22_new <= r22 xor "100011011";
		else 
			r22_new <= r22;
		end if;
	end process;
	
   r23 <= (bx9 & '0') xor ('0' & bx9);
	p24 : process(r23)
	begin
		if(r23(8) = '1') then 
			r23_new <= r23 xor "100011011";
		else 
			r23_new <= r23;
		end if;
	end process;
	t12 <= ('0' & bx10) xor ('0' & bx11) xor r22_new xor r23_new;
	
	
		-------------------COLUMN 4-------------------
	
		--column 4 and row 1--
	r24 <= bx13 & '0';
	p25 : process(r24)
	begin
		if(r24(8) = '1') then 
			r24_new <= r24 xor "100011011";
		else 
			r24_new <= r24;
		end if;
	end process;
	
   r25 <= (bx14 & '0') xor ('0' & bx14);
	p26 : process(r25)
	begin
		if(r25(8) = '1') then 
			r25_new <= r25 xor "100011011";
		else 
			r25_new <= r25;
		end if;
	end process;
	t13 <= ('0' & bx15) xor ('0' & bx16) xor r24_new xor r25_new;
	
	--column 4 and row 2--
	r26 <= bx14 & '0';
	p27 : process(r26)
	begin
		if(r26(8) = '1') then 
			r26_new <= r26 xor "100011011";
		else 
			r26_new <= r26;
		end if;
	end process;
	
   r27 <= (bx15 & '0') xor ('0' & bx15);
	p28 : process(r27)
	begin
		if(r27(8) = '1') then 
			r27_new <= r27 xor "100011011";
		else 
			r27_new <= r27;
		end if;
	end process;
	t14 <= ('0' & bx13) xor ('0' & bx16) xor r26_new xor r27_new;
	
	--column 4 and row 3--
		r28 <= bx15 & '0';
	p29 : process(r28)
	begin
		if(r28(8) = '1') then 
			r28_new <= r28 xor "100011011";
		else 
			r28_new <= r28;
		end if;
	end process;
	
   r29 <= (bx16 & '0') xor ('0' & bx16);
	p30 : process(r29)
	begin
		if(r29(8) = '1') then 
			r29_new <= r29 xor "100011011";
		else 
			r29_new <= r29;
		end if;
	end process;
	t15 <= ('0' & bx13) xor ('0' & bx14) xor r28_new xor r29_new;
	
	--column 4 and row 4--
		r30 <= bx16 & '0';
	p31 : process(r30)
	begin
		if(r30(8) = '1') then 
			r30_new <= r30 xor "100011011";
		else 
			r30_new <= r30;
		end if;
	end process;
	
   r31 <= (bx13 & '0') xor ('0' & bx13);
	p32 : process(r31)
	begin
		if(r31(8) = '1') then 
			r31_new <= r31 xor "100011011";
		else 
			r31_new <= r31;
		end if;
	end process;
	t16 <= ('0' & bx14) xor ('0' & bx15) xor r30_new xor r31_new;
	
	
	--OUTPUT--
		row_z1 <= (t1(7 downto 0)) & (t5(7 downto 0)) & (t9(7 downto 0)) & (t13(7 downto 0));
		row_z2 <= (t2(7 downto 0)) & (t6(7 downto 0)) & (t10(7 downto 0)) & (t14(7 downto 0));
		row_z3 <= (t3(7 downto 0)) & (t7(7 downto 0)) & (t11(7 downto 0)) & (t15(7 downto 0));
		row_z4 <= (t4(7 downto 0)) & (t8(7 downto 0)) & (t12(7 downto 0)) & (t16(7 downto 0));

	
end shift_rows;