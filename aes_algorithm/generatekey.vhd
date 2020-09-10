library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;


entity generatekey is
	port(
		x             : in std_logic_vector(127 downto 0);
		message       : in std_logic_vector(127 downto 0);
		
		--Output:
		
		z1,z2,z3,z4   : out std_logic_vector(31 downto 0)

	);
end generatekey;


architecture generatekey of generatekey is

component shift_rows is
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
end component;


component sboxtransform is
	port(
			
			column_row_sum     : in std_logic_vector(7 downto 0);
			
			--Output:
			y : out std_logic_vector(7 downto 0)
	);
end component;
	

--Rcon Table
signal rcon00 : std_logic_vector(7 downto 0);
signal rcon01 : std_logic_vector(7 downto 0);
signal rcon02 : std_logic_vector(7 downto 0);
signal rcon04 : std_logic_vector(7 downto 0);
signal rcon08 : std_logic_vector(7 downto 0);
signal rcon10 : std_logic_vector(7 downto 0);
signal rcon20 : std_logic_vector(7 downto 0);
signal rcon40 : std_logic_vector(7 downto 0);
signal rcon80 : std_logic_vector(7 downto 0);
signal rcon1B : std_logic_vector(7 downto 0);
signal rcon36 : std_logic_vector(7 downto 0);

	
--Boxes--key
signal x0 : std_logic_vector(7 downto 0);
signal x1 : std_logic_vector(7 downto 0);
signal x2 : std_logic_vector(7 downto 0);
signal x3 : std_logic_vector(7 downto 0);
signal x4 : std_logic_vector(7 downto 0);
signal x5 : std_logic_vector(7 downto 0);
signal x6 : std_logic_vector(7 downto 0);
signal x7 : std_logic_vector(7 downto 0);
signal x8 : std_logic_vector(7 downto 0);
signal x9 : std_logic_vector(7 downto 0);
signal x10 : std_logic_vector(7 downto 0);
signal x11 : std_logic_vector(7 downto 0);
signal x12 : std_logic_vector(7 downto 0);
signal x13 : std_logic_vector(7 downto 0);
signal x14 : std_logic_vector(7 downto 0);
signal x15 : std_logic_vector(7 downto 0);

--Boxes--message
signal message0 : std_logic_vector(7 downto 0);
signal message1 : std_logic_vector(7 downto 0);
signal message2 : std_logic_vector(7 downto 0);
signal message3 : std_logic_vector(7 downto 0);
signal message4 : std_logic_vector(7 downto 0);
signal message5 : std_logic_vector(7 downto 0);
signal message6 : std_logic_vector(7 downto 0);
signal message7 : std_logic_vector(7 downto 0);
signal message8 : std_logic_vector(7 downto 0);
signal message9 : std_logic_vector(7 downto 0);
signal message10 : std_logic_vector(7 downto 0);
signal message11 : std_logic_vector(7 downto 0);
signal message12 : std_logic_vector(7 downto 0);
signal message13 : std_logic_vector(7 downto 0);
signal message14 : std_logic_vector(7 downto 0);
signal message15 : std_logic_vector(7 downto 0);
	


   --Columns
signal c01,c11 : std_logic_vector(31 downto 0);
signal c02,c12 : std_logic_vector(31 downto 0);
signal c03,c13 : std_logic_vector(31 downto 0);
signal c04,c14 : std_logic_vector(31 downto 0);

---------SUBKEYS----------
   --Tempts-subkey1
signal t1,t2,t3,t4,t5,t6,t7,t8,t9,t10,t11,t12,t13,t14,t15,t16,t17,t18,t19,t20 : std_logic_vector(7 downto 0);
signal ssubkey11,ssubkey12,ssubkey13,ssubkey14     : std_logic_vector(31 downto 0);
signal ssubkey21,ssubkey22,ssubkey23,ssubkey24     : std_logic_vector(31 downto 0);
signal ssubkey31,ssubkey32,ssubkey33,ssubkey34     : std_logic_vector(31 downto 0);
signal ssubkey41,ssubkey42,ssubkey43,ssubkey44     : std_logic_vector(31 downto 0);
signal ssubkey51,ssubkey52,ssubkey53,ssubkey54     : std_logic_vector(31 downto 0);
signal ssubkey61,ssubkey62,ssubkey63,ssubkey64     : std_logic_vector(31 downto 0);
signal ssubkey71,ssubkey72,ssubkey73,ssubkey74     : std_logic_vector(31 downto 0);
signal ssubkey81,ssubkey82,ssubkey83,ssubkey84     : std_logic_vector(31 downto 0);
signal ssubkey91,ssubkey92,ssubkey93,ssubkey94     : std_logic_vector(31 downto 0);
signal ssubkey101,ssubkey102,ssubkey103,ssubkey104 : std_logic_vector(31 downto 0);

   --Tempts-subkey2
signal t21,t22,t23,t24,t25,t26,t27,t28,t29,t30,t31,t32,t33,t34,t35,t36,t37,t38,t39,t40 : std_logic_vector(7 downto 0);
   --Tempts-subkey3
signal t41,t42,t43,t44,t45,t46,t47,t48,t49,t50,t51,t52,t53,t54,t55,t56,t57,t58,t59,t60 : std_logic_vector(7 downto 0);
   --Tempts-subkey4
signal t61,t62,t63,t64,t65,t66,t67,t68,t69,t70,t71,t72,t73,t74,t75,t76,t77,t78,t79,t80 : std_logic_vector(7 downto 0);
   --Tempts-subkey5
signal t81,t82,t83,t84,t85,t86,t87,t88,t89,t90,t91,t92,t93,t94,t95,t96,t97,t98,t99,t100 : std_logic_vector(7 downto 0);
   --Tempts-subkey6
signal t101,t102,t103,t104,t105,t106,t107,t108,t109,t110,t111,t112,t113,t114,t115,t116,t117,t118,t119,t120 : std_logic_vector(7 downto 0);
   --Tempts-subkey7
signal t121,t122,t123,t124,t125,t126,t127,t128,t129,t130,t131,t132,t133,t134,t135,t136,t137,t138,t139,t140 : std_logic_vector(7 downto 0);
   --Tempts-subkey8
signal t141,t142,t143,t144,t145,t146,t147,t148,t149,t150,t151,t152,t153,t154,t155,t156,t157,t158,t159,t160 : std_logic_vector(7 downto 0);
   --Tempts-subkey9
signal t161,t162,t163,t164,t165,t166,t167,t168,t169,t170,t171,t172,t173,t174,t175,t176,t177,t178,t179,t180 : std_logic_vector(7 downto 0);
   --Tempts-subkey10
signal t181,t182,t183,t184,t185,t186,t187,t188,t189,t190,t191,t192,t193,t194,t195,t196,t197,t198,t199,t200 : std_logic_vector(7 downto 0);

   --signals, subbyte,shift,mix--
signal rs1,rs2,rs3,rs4,rs5,rs6,rs7,rs8,rs9,rs10,rs11,rs12,rs13,rs14,rs15,rs16,rs17,rs18,rs19 : std_logic_vector(31 downto 0);
signal rs20,rs21,rs22,rs23,rs24,rs25,rs26,rs27,rs28,rs29,rs30,rs31,rs32,rs33,rs34,rs35,rs36,rs37,rs38,rs39,rs40 : std_logic_vector(31 downto 0);
signal rs1_z,rs2_z,rs3_z,rs4_z,rs5_z,rs6_z,rs7_z,rs8_z,rs9_z,rs10_z,rs11_z,rs12_z,rs13_z,rs14_z,rs15_z,rs16_z  :  std_logic_vector(31 downto 0);
signal rs17_z,rs18_z,rs19_z,rs20_z,rs21_z,rs22_z,rs23_z,rs24_z,rs25_z,rs26_z,rs27_z,rs28_z,rs29_z,rs30_z,rs31_z,rs32_z  :  std_logic_vector(31 downto 0);
signal rs33_z,rs34_z,rs35_z,rs36_z,rs37_z,rs38_z,rs39_z,rs40_z  :  std_logic_vector(31 downto 0);


----ENCRYPTION---
--INITIAL--
signal m1,m2,m3,m4,m5,m6,m7,m8,m9,m10,m11,m12,m13,m14,m15,m16  :  std_logic_vector(7 downto 0);
--subbyte--
signal m17,m18,m19,m20,m21,m22,m23,m24,m25,m26,m27,m28,m29,m30,m31,m32  :  std_logic_vector(7 downto 0);


--final round signals--
signal fn1,fn2,fn3,fn4,fn5,fn6,fn7,fn8,fn9,fn10,fn11,fn12,fn13,fn14,fn15,fn16 : std_logic_vector(7 downto 0);
signal f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16 : std_logic_vector(7 downto 0);
signal final1,final2,final3,final4 : std_logic_vector(31 downto 0);

begin
	--Rcon assigned to binary
	rcon00 <= "00000000";
	rcon01 <= "00000001";
	rcon02 <= "00000010";
	rcon04 <= "00000100";
	rcon08 <= "00001000";
	rcon10 <= "00010000";
	rcon20 <= "00100000";
	rcon40 <= "01000000";
	rcon80 <= "10000000";
	rcon1B <= "00011011";
	rcon36 <= "00110110";
	
	--Boxes Seperated--key
	x0 <= x(7 downto 0);
	x1 <= x(15 downto 8);
	x2 <= x(23 downto 16);
	x3 <= x(31 downto 24);
	x4 <= x(39 downto 32);
	x5 <= x(47 downto 40);
	x6 <= x(55 downto 48);
	x7 <= x(63 downto 56);
	x8 <= x(71 downto 64);
	x9 <= x(79 downto 72);
	x10 <= x(87 downto 80);
	x11 <= x(95 downto 88);
	x12 <= x(103 downto 96);
	x13 <= x(111 downto 104);
	x14 <= x(119 downto 112);
	x15 <= x(127 downto 120);
	
	--Boxes Seperated--message
	message0 <= message(7 downto 0);
	message1 <= message(15 downto 8);
	message2 <= message(23 downto 16);
	message3 <= message(31 downto 24);
	message4 <= message(39 downto 32);
	message5 <= message(47 downto 40);
	message6 <= message(55 downto 48);
	message7 <= message(63 downto 56);
	message8 <= message(71 downto 64);
	message9 <= message(79 downto 72);
	message10 <= message(87 downto 80);
	message11 <= message(95 downto 88);
	message12 <= message(103 downto 96);
	message13 <= message(111 downto 104);
	message14 <= message(119 downto 112);
	message15 <= message(127 downto 120);
	
	

	
	
	--key1 generation :
	sboxt1 : sboxtransform port map (column_row_sum => x2 , y => t1);
	sboxt2 : sboxtransform port map (column_row_sum => x1 , y => t2);
	sboxt3 : sboxtransform port map (column_row_sum => x0 , y => t3);
	sboxt4 : sboxtransform port map (column_row_sum => x3 , y => t4);
	
	----------SUBKEY1 BOXES----------
	--First Column of the Subkey1:
	t5 <= x15 xor t1 xor rcon01;
	t6 <= x14 xor t2 xor rcon00;
	t7 <= x13 xor t3 xor rcon00;
	t8 <= x12 xor t4 xor rcon00;
	--Second Column of the Subkey1:
	t9 <= x11 xor t5;
	t10 <= x10 xor t6;
	t11 <= x9 xor t7;
	t12 <= x8 xor t8;
	--Third Column of the Subkey1:
	t13 <= x7 xor t9;
	t14 <= x6 xor t10;
	t15 <= x5 xor t11;
	t16 <= x4 xor t12;
	--Fourth Column of the Subkey1:
	t17 <= x3 xor t13;
	t18 <= x2 xor t14;
	t19 <= x1 xor t15;
	t20 <= x0 xor t16;
	
	ssubkey11 <= t5 & t9 & t13 & t17;
	ssubkey12 <= t6 & t10 & t14 & t18;
	ssubkey13 <= t7 & t11 & t15 & t19;
	ssubkey14 <= t8 & t12 & t16 & t20;
	
	
		--key2 generation :
	sboxt5 : sboxtransform port map (column_row_sum => t18 , y => t21);
	sboxt6 : sboxtransform port map (column_row_sum => t19 , y => t22);
	sboxt7 : sboxtransform port map (column_row_sum => t20 , y => t23);
	sboxt8 : sboxtransform port map (column_row_sum => t17 , y => t24);
	----------SUBKEY2 BOXES----------
	--First Column of the Subkey2:
	t25 <= t5 xor t21 xor rcon02;
	t26 <= t6 xor t22 xor rcon00;
	t27 <= t7 xor t23 xor rcon00;
	t28 <= t8 xor t24 xor rcon00;
	--Second Column of the Subkey2:
	t29 <= t9 xor t25;
	t30 <= t10 xor t26;
	t31 <= t11 xor t27;
	t32 <= t12 xor t28;
	--Third Column of the Subkey2:
	t33 <= t13 xor t29;
	t34 <= t14 xor t30;
	t35 <= t15 xor t31;
	t36 <= t16 xor t32;
	--Fourth Column of the Subkey2:
	t37 <= t17 xor t33;
	t38 <= t18 xor t34;
	t39 <= t19 xor t35;
	t40 <= t20 xor t36;
	
	ssubkey21 <= t25 & t29 & t33 & t37;
	ssubkey22 <= t26 & t30 & t34 & t38;
	ssubkey23 <= t27 & t31 & t35 & t39;
	ssubkey24 <= t28 & t32 & t36 & t40;
	
	
	--key3 generation :
	sboxt9 : sboxtransform port map (column_row_sum => t38 , y => t41);
	sboxt10 : sboxtransform port map (column_row_sum => t39 , y => t42);
	sboxt11 : sboxtransform port map (column_row_sum => t40 , y => t43);
	sboxt12 : sboxtransform port map (column_row_sum => t37 , y => t44);
	----------SUBKEY3 BOXES----------
	--First Column of the Subkey3:
	t45 <= t25 xor t41 xor rcon04;
	t46 <= t26 xor t42 xor rcon00;
	t47 <= t27 xor t43 xor rcon00;
	t48 <= t28 xor t44 xor rcon00;
	--Second Column of the Subkey3:
	t49 <= t29 xor t45;
	t50 <= t30 xor t46;
	t51 <= t31 xor t47;
	t52 <= t32 xor t48;
	--Third Column of the Subkey3:
	t53 <= t33 xor t49;
	t54 <= t34 xor t50;
	t55 <= t35 xor t51;
	t56 <= t36 xor t52;
	--Fourth Column of the Subkey3:
	t57 <= t37 xor t53;
	t58 <= t38 xor t54;
	t59 <= t39 xor t55;
	t60 <= t40 xor t56;
	
	ssubkey31 <= t45 & t49 & t53 & t57;
	ssubkey32 <= t46 & t50 & t54 & t58;
	ssubkey33 <= t47 & t51 & t55 & t59;
	ssubkey34 <= t48 & t52 & t56 & t60;
	
	
	--key4 generation :
	sboxt13 : sboxtransform port map (column_row_sum => t58 , y => t61);
	sboxt14 : sboxtransform port map (column_row_sum => t59 , y => t62);
	sboxt15 : sboxtransform port map (column_row_sum => t60 , y => t63);
	sboxt16 : sboxtransform port map (column_row_sum => t57 , y => t64);
	----------SUBKEY4 BOXES----------
	--First Column of the Subkey4:
	t65 <= t45 xor t61 xor rcon08;
	t66 <= t46 xor t62 xor rcon00;
	t67 <= t47 xor t63 xor rcon00;
	t68 <= t48 xor t64 xor rcon00;
	--Second Column of the Subkey4:
	t69 <= t49 xor t65;
	t70 <= t50 xor t66;
	t71 <= t51 xor t67;
	t72 <= t52 xor t68;
	--Third Column of the Subkey4:
	t73 <= t53 xor t69;
	t74 <= t54 xor t70;
	t75 <= t55 xor t71;
	t76 <= t56 xor t72;
	--Fourth Column of the Subkey4:
	t77 <= t57 xor t73;
	t78 <= t58 xor t74;
	t79 <= t59 xor t75;
	t80 <= t60 xor t76;
	
	ssubkey41 <= t65 & t69 & t73 & t77;
	ssubkey42 <= t66 & t70 & t74 & t78;
	ssubkey43 <= t67 & t71 & t75 & t79;
	ssubkey44 <= t68 & t72 & t76 & t80;
	
	
		--key5 generation :
	sboxt17 : sboxtransform port map (column_row_sum => t78 , y => t81);
	sboxt18 : sboxtransform port map (column_row_sum => t79 , y => t82);
	sboxt19 : sboxtransform port map (column_row_sum => t80 , y => t83);
	sboxt20 : sboxtransform port map (column_row_sum => t77 , y => t84);
	----------SUBKEY5 BOXES----------
	--First Column of the Subkey5:
	t85 <= t65 xor t81 xor rcon10;
	t86 <= t66 xor t82 xor rcon00;
	t87 <= t67 xor t83 xor rcon00;
	t88 <= t68 xor t84 xor rcon00;
	--Second Column of the Subkey5:
	t89 <= t69 xor t85;
	t90 <= t70 xor t86;
	t91 <= t71 xor t87;
	t92 <= t72 xor t88;
	--Third Column of the Subkey5:
	t93 <= t73 xor t89;
	t94 <= t74 xor t90;
	t95 <= t75 xor t91;
	t96 <= t76 xor t92;
	--Fourth Column of the Subkey5:
	t97 <= t77 xor t93;
	t98 <= t78 xor t94;
	t99 <= t79 xor t95;
	t100 <= t80 xor t96;
	
	ssubkey51 <= t85 & t89 & t93 & t97;
	ssubkey52 <= t86 & t90 & t94 & t98;
	ssubkey53 <= t87 & t91 & t95 & t99;
	ssubkey54 <= t88 & t92 & t96 & t100;
	
	
			--key6 generation :
	sboxt21 : sboxtransform port map (column_row_sum => t98 , y => t101);
	sboxt22 : sboxtransform port map (column_row_sum => t99 , y => t102);
	sboxt23 : sboxtransform port map (column_row_sum => t100 , y => t103);
	sboxt24 : sboxtransform port map (column_row_sum => t97 , y => t104);
	----------SUBKEY6 BOXES----------
	--First Column of the Subkey6:
	t105 <= t85 xor t101 xor rcon20;
	t106 <= t86 xor t102 xor rcon00;
	t107 <= t87 xor t103 xor rcon00;
	t108 <= t88 xor t104 xor rcon00;
	--Second Column of the Subkey6:
	t109 <= t89 xor t105;
	t110 <= t90 xor t106;
	t111 <= t91 xor t107;
	t112 <= t92 xor t108;
	--Third Column of the Subkey6:
	t113 <= t93 xor t109;
	t114 <= t94 xor t110;
	t115 <= t95 xor t111;
	t116 <= t96 xor t112;
	--Fourth Column of the Subkey6:
	t117 <= t97 xor t113;
	t118 <= t98 xor t114;
	t119 <= t99 xor t115;
	t120 <= t100 xor t116;
	
	ssubkey61 <= t105 & t109 & t113 & t117;
	ssubkey62 <= t106 & t110 & t114 & t118;
	ssubkey63 <= t107 & t111 & t115 & t119;
	ssubkey64 <= t108 & t112 & t116 & t120;
	
	
				--key7 generation :
	sboxt25 : sboxtransform port map (column_row_sum => t118 , y => t121);
	sboxt26 : sboxtransform port map (column_row_sum => t119 , y => t122);
	sboxt27 : sboxtransform port map (column_row_sum => t120 , y => t123);
	sboxt28 : sboxtransform port map (column_row_sum => t117 , y => t124);
	----------SUBKEY7 BOXES----------
	--First Column of the Subkey7:
	t125 <= t105 xor t121 xor rcon40;
	t126 <= t106 xor t122 xor rcon00;
	t127 <= t107 xor t123 xor rcon00;
	t128 <= t108 xor t124 xor rcon00;
	--Second Column of the Subkey7:
	t129 <= t109 xor t125;
	t130 <= t110 xor t126;
	t131 <= t111 xor t127;
	t132 <= t112 xor t128;
	--Third Column of the Subkey7:
	t133 <= t113 xor t129;
	t134 <= t114 xor t130;
	t135 <= t115 xor t131;
	t136 <= t116 xor t132;
	--Fourth Column of the Subkey7:
	t137 <= t117 xor t133;
	t138 <= t118 xor t134;
	t139 <= t119 xor t135;
	t140 <= t120 xor t136;
	
	ssubkey71 <= t125 & t129 & t133 & t137;
	ssubkey72 <= t126 & t130 & t134 & t138;
	ssubkey73 <= t127 & t131 & t135 & t139;
	ssubkey74 <= t128 & t132 & t136 & t140;
	
	
					--key8 generation :
	sboxt29 : sboxtransform port map (column_row_sum => t138 , y => t141);
	sboxt30 : sboxtransform port map (column_row_sum => t139 , y => t142);
	sboxt31 : sboxtransform port map (column_row_sum => t140 , y => t143);
	sboxt32 : sboxtransform port map (column_row_sum => t137 , y => t144);
	----------SUBKEY8 BOXES----------
	--First Column of the Subkey8:
	t145 <= t125 xor t141 xor rcon80;
	t146 <= t126 xor t142 xor rcon00;
	t147 <= t127 xor t143 xor rcon00;
	t148 <= t128 xor t144 xor rcon00;
	--Second Column of the Subkey8:
	t149 <= t129 xor t145;
	t150 <= t130 xor t146;
	t151 <= t131 xor t147;
	t152 <= t132 xor t148;
	--Third Column of the Subkey8:
	t153 <= t133 xor t149;
	t154 <= t134 xor t150;
	t155 <= t135 xor t151;
	t156 <= t136 xor t152;
	--Fourth Column of the Subkey8:
	t157 <= t137 xor t153;
	t158 <= t138 xor t154;
	t159 <= t139 xor t155;
	t160 <= t140 xor t156;
	
	ssubkey81 <= t145 & t149 & t153 & t157;
	ssubkey82 <= t146 & t150 & t154 & t158;
	ssubkey83 <= t147 & t151 & t155 & t159;
	ssubkey84 <= t148 & t152 & t156 & t160;
	
	
	
						--key9 generation :
	sboxt33 : sboxtransform port map (column_row_sum => t158 , y => t161);
	sboxt34 : sboxtransform port map (column_row_sum => t159 , y => t162);
	sboxt35 : sboxtransform port map (column_row_sum => t160 , y => t163);
	sboxt36 : sboxtransform port map (column_row_sum => t157 , y => t164);
	----------SUBKEY9 BOXES----------
	--First Column of the Subkey9:
	t165 <= t145 xor t161 xor rcon1B;
	t166 <= t146 xor t162 xor rcon00;
	t167 <= t147 xor t163 xor rcon00;
	t168 <= t148 xor t164 xor rcon00;
	--Second Column of the Subkey9:
	t169 <= t149 xor t165;
	t170 <= t150 xor t166;
	t171 <= t151 xor t167;
	t172 <= t152 xor t168;
	--Third Column of the Subkey9:
	t173 <= t153 xor t169;
	t174 <= t154 xor t170;
	t175 <= t155 xor t171;
	t176 <= t156 xor t172;
	--Fourth Column of the Subkey9:
	t177 <= t157 xor t173;
	t178 <= t158 xor t174;
	t179 <= t159 xor t175;
	t180 <= t160 xor t176;
	
	ssubkey91 <= t165 & t169 & t173 & t177;
	ssubkey92 <= t166 & t170 & t174 & t178;
	ssubkey93 <= t167 & t171 & t175 & t179;
	ssubkey94 <= t168 & t172 & t176 & t180;
	
	
							--key10 generation :
	sboxt37 : sboxtransform port map (column_row_sum => t178 , y => t181);
	sboxt38 : sboxtransform port map (column_row_sum => t179 , y => t182);
	sboxt39 : sboxtransform port map (column_row_sum => t180 , y => t183);
	sboxt40 : sboxtransform port map (column_row_sum => t177 , y => t184);
	----------SUBKEY10 BOXES----------
	--First Column of the Subkey10:
	t185 <= t165 xor t181 xor rcon36;
	t186 <= t166 xor t182 xor rcon00;
	t187 <= t167 xor t183 xor rcon00;
	t188 <= t168 xor t184 xor rcon00;
	--Second Column of the Subkey10:
	t189 <= t169 xor t185;
	t190 <= t170 xor t186;
	t191 <= t171 xor t187;
	t192 <= t172 xor t188;
	--Third Column of the Subkey10:
	t193 <= t173 xor t189;
	t194 <= t174 xor t190;
	t195 <= t175 xor t191;
	t196 <= t176 xor t192;
	--Fourth Column of the Subkey10:
	t197 <= t177 xor t193;
	t198 <= t178 xor t194;
	t199 <= t179 xor t195;
	t200 <= t180 xor t196;
	
	     --subkey10 in column(from 1 to 9 in row)--
	ssubkey101 <= t185 & t186 & t187 & t188;
	ssubkey102 <= t189 & t190 & t191 & t192;
	ssubkey103 <= t193 & t194 & t195 & t196;
	ssubkey104 <= t197 & t198 & t199 & t200;
	
	-------ENCRYPTION PROCESS--------
	--INITIAL ROUND--roundkey
	m1 <= message15 xor x15;
	m2 <= message14 xor x14;
	m3 <= message13 xor x13;
	m4 <= message12 xor x12;
	m5 <= message11 xor x11;
	m6 <= message10 xor x10;
	m7 <= message9 xor x9;
	m8 <= message8 xor x8;
	m9 <= message7 xor x7;
	m10 <= message6 xor x6;
	m11 <= message5 xor x5;
	m12 <= message4 xor x4;
	m13 <= message3 xor x3;
	m14 <= message2 xor x2;
	m15 <= message1 xor x1;
	M16 <= message0 xor x0;
	
	rs1 <= m1 & m5 & m9 & m13;
	rs2 <= m2 & m6 & m10 & m14;
	rs3 <= m3 & m7 & m11 & m15;
	rs4 <= m4 & m8 & m12 & m16;
	
	--add round key1--
	sr1 :shift_rows port map(row_n1=>rs1 , row_n2=>rs2 , row_n3=>rs3 , row_n4=>rs4 , row_z1=>rs1_z , row_z2=>rs2_z , row_z3=>rs3_z , row_z4=>rs4_z);
	rs5 <= rs1_z xor ssubkey11;
	rs6 <= rs2_z xor ssubkey12;
	rs7 <= rs3_z xor ssubkey13;
	rs8 <= rs4_z xor ssubkey14;
	
	--add round key2--
	sr2 :shift_rows port map(row_n1=>rs5 , row_n2=>rs6 , row_n3=>rs7 , row_n4=>rs8 , row_z1=>rs5_z , row_z2=>rs6_z , row_z3=>rs7_z , row_z4=>rs8_z);
	rs9  <= rs5_z xor ssubkey21;
	rs10 <= rs6_z xor ssubkey22;
	rs11 <= rs7_z xor ssubkey23;
	rs12 <= rs8_z xor ssubkey24;
	
	--add round key3--
	sr3 :shift_rows port map(row_n1=>rs9 , row_n2=>rs10 , row_n3=>rs11 , row_n4=>rs12 , row_z1=>rs9_z , row_z2=>rs10_z , row_z3=>rs11_z , row_z4=>rs12_z);
	rs13 <= rs9_z xor ssubkey31;
	rs14 <= rs10_z xor ssubkey32;
	rs15 <= rs11_z xor ssubkey33;
	rs16 <= rs12_z xor ssubkey34;
	
	--add round key4--
	sr4 :shift_rows port map(row_n1=>rs13 , row_n2=>rs14 , row_n3=>rs15 , row_n4=>rs16 , row_z1=>rs13_z , row_z2=>rs14_z , row_z3=>rs15_z , row_z4=>rs16_z);
	rs17 <= rs13_z xor ssubkey41;
	rs18 <= rs14_z xor ssubkey42;
	rs19 <= rs15_z xor ssubkey43;
	rs20 <= rs16_z xor ssubkey44;
	
	--add round key5--
	sr5 :shift_rows port map(row_n1=>rs17 , row_n2=>rs18 , row_n3=>rs19 , row_n4=>rs20 , row_z1=>rs17_z , row_z2=>rs18_z , row_z3=>rs19_z , row_z4=>rs20_z);
	rs21 <= rs17_z xor ssubkey51;
	rs22 <= rs18_z xor ssubkey52;
	rs23 <= rs19_z xor ssubkey53;
	rs24 <= rs20_z xor ssubkey54;
	
	
	--add round key6--
	sr6 :shift_rows port map(row_n1=>rs21 , row_n2=>rs22 , row_n3=>rs23 , row_n4=>rs24 , row_z1=>rs21_z , row_z2=>rs22_z , row_z3=>rs23_z , row_z4=>rs24_z);
	rs25 <= rs21_z xor ssubkey61;
	rs26 <= rs22_z xor ssubkey62;
	rs27 <= rs23_z xor ssubkey63;
	rs28 <= rs24_z xor ssubkey64;
	
	--add round key7--
	sr7 :shift_rows port map(row_n1=>rs25 , row_n2=>rs26 , row_n3=>rs27 , row_n4=>rs28 , row_z1=>rs25_z , row_z2=>rs26_z , row_z3=>rs27_z , row_z4=>rs28_z);
	rs29 <= rs25_z xor ssubkey71;
	rs30 <= rs26_z xor ssubkey72;
	rs31 <= rs27_z xor ssubkey73;
	rs32 <= rs28_z xor ssubkey74;
	
	
	--add round key8--
	sr8 :shift_rows port map(row_n1=>rs29 , row_n2=>rs30 , row_n3=>rs31 , row_n4=>rs32 , row_z1=>rs29_z , row_z2=>rs30_z , row_z3=>rs31_z , row_z4=>rs32_z);
	rs33 <= rs29_z xor ssubkey81;
	rs34 <= rs30_z xor ssubkey82;
	rs35 <= rs31_z xor ssubkey83;
	rs36 <= rs32_z xor ssubkey84;
	
	
	--add round key9--
	sr9 :shift_rows port map(row_n1=>rs33 , row_n2=>rs34 , row_n3=>rs35 , row_n4=>rs36 , row_z1=>rs33_z , row_z2=>rs34_z , row_z3=>rs35_z , row_z4=>rs36_z);
	rs37 <= rs33_z xor ssubkey91;
	rs38 <= rs34_z xor ssubkey92;
	rs39 <= rs35_z xor ssubkey93;
	rs40 <= rs36_z xor ssubkey94;
	
	
	---FINAL STEP---
	--seperate boxes--
	fn1 <= rs37(31 downto 24);
	fn2 <= rs38(31 downto 24);
	fn3 <= rs39(31 downto 24);
	fn4 <= rs40(31 downto 24);
	fn5 <= rs37(23 downto 16);
	fn6 <= rs38(23 downto 16);
	fn7 <= rs39(23 downto 16);
	fn8 <= rs40(23 downto 16);
	fn9 <= rs37(15 downto 8);
	fn10 <= rs38(15 downto 8);
	fn11 <= rs39(15 downto 8);
	fn12 <= rs40(15 downto 8);
	fn13 <= rs37(7 downto 0);
	fn14 <= rs38(7 downto 0);
	fn15 <= rs39(7 downto 0);
	fn16 <= rs40(7 downto 0);
	
	--
	sboxt41 : sboxtransform port map (column_row_sum => fn1 , y => f1);
	sboxt42 : sboxtransform port map (column_row_sum => fn2 , y => f2);
	sboxt43 : sboxtransform port map (column_row_sum => fn3 , y => f3);
	sboxt44 : sboxtransform port map (column_row_sum => fn4 , y => f4);
	sboxt45 : sboxtransform port map (column_row_sum => fn5 , y => f5);
	sboxt46 : sboxtransform port map (column_row_sum => fn6 , y => f6);
	sboxt47 : sboxtransform port map (column_row_sum => fn7 , y => f7);
	sboxt48 : sboxtransform port map (column_row_sum => fn8 , y => f8);
	sboxt49 : sboxtransform port map (column_row_sum => fn9 , y => f9);
	sboxt50 : sboxtransform port map (column_row_sum => fn10 , y => f10);
	sboxt51 : sboxtransform port map (column_row_sum => fn11 , y => f11);
	sboxt52 : sboxtransform port map (column_row_sum => fn12 , y => f12);
	sboxt53 : sboxtransform port map (column_row_sum => fn13 , y => f13);
	sboxt54 : sboxtransform port map (column_row_sum => fn14 , y => f14);
	sboxt55 : sboxtransform port map (column_row_sum => fn15 , y => f15);
	sboxt56 : sboxtransform port map (column_row_sum => fn16 , y => f16);
	
	--as columns--
	final1 <= f1 & f6 & f11 & f16;
	final2 <= f5 & f10 & f15 & f4;
	final3 <= f9 & f14 & f3 & f8;
	final4 <= f13 & f2 & f7 & f12;
	
	
	z1 <= final1 xor ssubkey101;
	z2 <= final2 xor ssubkey102;
	z3 <= final3 xor ssubkey103;
	z4 <= final4 xor ssubkey104;
	
	
	

end generatekey; 