library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
-- Input/output description
entity top is
    port (
        BTN0: in std_logic;     -- button 0
        BTN1: in std_logic;     -- button 1
        SW0: in std_logic;     -- button 0
        LED: out std_logic_vector(3 downto 0);
        CLK: in std_logic;
        PAN1: out std_logic_vector(7 downto 0);
        PAN2: out std_logic_vector(7 downto 0);
        RAD: out std_logic_vector(2 downto 0);
        RAX: out std_logic_vector(2 downto 0)
         );
end top;
-- Internal structure description
architecture Behavioral of top is
        signal a: std_logic_vector(2 downto 0) := "000";
        signal clk_1: std_logic := '0';
        signal tmp_1: std_logic_vector(15 downto 0) := x"0000"; 
        signal S: std_logic_vector(5 downto 0) := "000000";
        signal M: std_logic_vector(5 downto 0) := "000001";
        signal H: std_logic_vector(5 downto 0) := "001101";
        signal  POM,POM1,POM2,POM3,POM4,POM5,POM6,POM7,POM8,POM9,POM10,
                POM11,POM12,POM13,POM14,POM15,POM16,POM17,POM18,POM19,POM20,
		POM21,POM22,POM23,POM24,POM25,POM26,POM27,POM28,POM29,POM30,
		POM31,POM32,POM33,POM34,POM35,POM36,POM37,POM38,POM39,POM40,
		POM41,POM42,POM43,POM44,POM45,POM46,POM47,POM48,POM49,POM50,
		POM51,POM52,POM53,POM54,POM55,POM56,POM57,POM58,POM59 : std_logic_vector(7 downto 0);
       signal Q1, Q2, Q3, Q_OUT : std_logic;
       signal Q4, Q5, Q6, Q_OUT2, x,y : std_logic;         
begin
    process (CLK)
    begin
       	 if rising_edge(CLK) then
          	tmp_1 <= tmp_1 + 1;
            	if tmp_1 = x"1388" then
                	tmp_1 <= x"0000";		--GENEROVÁNÍ SIGNÁLU S PERIODOU 1 SEKUDA
                	clk_1 <= not clk_1;
            	end if;

            	RAD <= a;
            	RAX <= a;
            	if a = "111" then			-- ČÍTAČ OD 0 DO 7, URČUJÍCI HODNOTU ŘÁDKU
               		a <= "000";
            	end if;
			
			
            	a <= a + "001";  
		if BTN0 = '1' then	
			Q1 <= '0';
			Q2 <= '0';	-- ošetření zákmitu tlačítka BTN0
			Q3 <= '0';
			y <= '0';
		else
			Q4 <= not BTN0;
			Q5 <= Q4;
			Q6 <= Q5;
		end if;
			
		Q_OUT2 <= Q4 AND Q5 AND Q6 AND (NOT x);



		if BTN1 = '1' then	
			Q4 <= '0';
			Q5 <= '0';
			Q6 <= '0';
			x <= '0';		-- ošetření zákmitu tlačítka BTN1
		else
			Q4 <= not BTN1;
			Q5 <= Q4;
			Q6 <= Q5;
		end if;
					
		Q_OUT2 <= Q4 AND Q5 AND Q6 AND (NOT y);
		if Q_OUT = '1' then
			Q1 <= '0';
			Q2 <= '0';
			Q3 <= '0'; 
			x <= '1';
		end if;
		if Q_OUT2 = '1' then
			Q4 <= '0';
			Q5 <= '0';
			Q6 <= '0';
			y <= '1';
			end if;
        end if;
    end process;
    

    
    process (clk_1,Q_OUT2,Q_OUT)
    begin
        if rising_edge(clk_1) then
                S <= S + "000001";
	    
              
                    
                if S = "000000" then
                        S <= "000010";
                end if;				-- ČÍTAČ SEKUND
		if S = "111100" then			
			S <= "000000";
			M <= M + "000001";
		end if;		
			
			
                if M = "000000" then
                        M <= "000001";
                end if;
		if M = "111101" then		--ČÍTAČ MINUT
			H<= H + 1;
                        M<= "000000";
		end if;
			
			
                if H = "000000" then
                        H <= "000001";
                end if;				--ČÍTAČ HODIN
		if H = "011001" then
			H<= "000001";
		end if;    
        end if;

		if Q_OUT2 = '1' then
			H <=H + 1;
		end if;				-- NASTAVOVÁNÍ ČASU POMOCÍ BTN0 A BTN1
		if Q_OUT = '1' then
			M <=M + 1;
		end if;
    end process;



            
        with M select 
                PAN1  <=        POM when  "000001", 
                                POM1 when "000010",
                                POM2 when "000011",   
                                POM3 when "000100",
                                POM4 when "000101",
                                POM5 when "000110",
                                POM6 when "000111",
                                POM7 when "001000",
                                POM8 when "001001",
                                POM9 when "001010",
				POM10 when "001011",
				POM11 when "001100",
				POM12 when "001101",	-- VÝBĚR ZORAZOVANÉHO ČÍSLA NA PANEL 1
				POM13 when "001110",
				POM14 when "001111",
				POM15 when "010000",
				POM16 when "010001",
				POM17 when "010010",
				POM18 when "010011",
				POM19 when "010100",
				POM20 when "010101",
				POM21 when "010110",
				POM22 when "010111",
				POM23 when "011000",
				POM24 when "011001",
				POM25 when "011010",
				POM26 when "011011",
				POM27 when "011100",
				POM28 when "011101",
				POM29 when "011110",
				POM30 when "011111",
				POM31 when "100000",
				POM32 when "100001",
				POM33 when "100010",
				POM34 when "100011",
				POM35 when "100100",
				POM36 when "100101",
				POM37 when "100110",
				POM38 when "100111",								
				POM39 when "101000",
				POM40 when "101001",
				POM41 when "101010",
				POM42 when "101011",
				POM43 when "101100",
				POM44 when "101101",
				POM45 when "101110",
				POM46 when "101111",
				POM47 when "110000",
				POM48 when "110001",
				POM49 when "110010",
				POM50 when "110011",
				POM51 when "110100",
				POM52 when "110101",
				POM53 when "110110",
				POM54 when "110111",
				POM55 when "111000",
				POM56 when "111001",
				POM57 when "111010",
				POM58 when "111011",
				POM59 when "111100",
                                POM   when others;
                        
        with H select 
                PAN2  <=        POM when  "000001", 
                                POM1 when "000010",
                                POM2 when "000011",   
                                POM3 when "000100",
                                POM4 when "000101",
                                POM5 when "000110",
                                POM6 when "000111",
                                POM7 when "001000",
                                POM8 when "001001",
                                POM9 when "001010",
				POM10 when "001011",	-- VÝBĚR ZORAZOVANÉHO ČÍSLA NA PANEL 2
				POM11 when "001100",
				POM12 when "001101",
				POM13 when "001110",
				POM14 when "001111",
				POM15 when "010000",
				POM16 when "010001",
				POM17 when "010010",
				POM18 when "010011",
				POM19 when "010100",
				POM20 when "010101",
				POM21 when "010110",
				POM22 when "010111",
				POM23 when "011000",
				POM24 when "011001",
				POM25 when "011010",
				POM26 when "011011",
				POM27 when "011100",
				POM28 when "011101",
				POM29 when "011110",
				POM30 when "011111",
				POM31 when "100000",
				POM32 when "100001",
				POM33 when "100010",
				POM34 when "100011",
				POM35 when "100100",
				POM36 when "100101",
				POM37 when "100110",
				POM38 when "100111",								
				POM39 when "101000",
				POM40 when "101001",
				POM41 when "101010",
				POM42 when "101011",
				POM43 when "101100",
				POM44 when "101101",
				POM45 when "101110",
				POM46 when "101111",
				POM47 when "110000",
				POM48 when "110001",
				POM49 when "110010",
				POM50 when "110011",
				POM51 when "110100",
				POM52 when "110101",
				POM53 when "110110",
				POM54 when "110111",
				POM55 when "111000",
				POM56 when "111001",
				POM57 when "111010",
				POM58 when "111011",
				POM59 when "111100",
                                POM   when others;
       
       
       
       
		 
       
        with a select                         
                    POM <=   
                           
                            "00011000" when "001",     
                            "01011010" when "010",    
                            "01011010" when "011",    
                            "01011010" when "100",     		-- DEFINICE JEDNOTLIVÝCH SYMBOLŮ(ČÍSEL)
                            "01011010" when "101",    
                            "01011010" when "110",
                            "01011010" when "111",
		            "00011000" when "000",
                            "11111111" when others; 

        with a select                         
                    POM1 <= "00011101" when "001",     
                            "01011101" when "010",    
                            "01011101" when "011",    
                            "01011101" when "100",     
                            "01011101" when "101",    
                            "01011101" when "110",
                            "01011101" when "111",
                            "00011101" when "000",
                            "11111111" when others;
									 
                            
        with a select                         
                    POM2 <= "00011000" when "001",     
                            "01011011" when "010",    
                            "01011011" when "011",    
                            "01011000" when "100",     
                            "01011110" when "101",    
                            "01011110" when "110",
                            "01011110" when "111",
                            "00011000" when "000",                            
                            "11111111" when others;  



									 
       with a select                         
                    POM3 <= "00011000" when "001",     
                            "01011110" when "010",    
                            "01011110" when "011",    
                            "01011100" when "100",     
                            "01011110" when "101",    
                            "01011110" when "110",
                            "01011110" when "111",
                            "00011000" when "000",                            
                            "11111111" when others; 
									 
									 
									 
       with a select                         
                    POM4 <= "00011110" when "001",     
                            "01011110" when "010",    
                            "01011110" when "011",    
                            "01011000" when "100",     
                            "01011010" when "101",    
                            "01011010" when "110",
                            "01011010" when "111",
                            "00011010" when "000",                            
                            "11111111" when others;   

									 
       with a select                         
                    POM5 <= "00011000" when "001",     
                            "01011110" when "010",    
                            "01011110" when "011",    
                            "01011000" when "100",     
                            "01011011" when "101",    
                            "01011011" when "110",
                            "01011011" when "111",
                            "00011000" when "000",                            
                            "11111111" when others;
									 
       with a select                         
                    POM6 <= "00011000" when "001",     
                            "01011010" when "010",    
                            "01011010" when "011",    
                            "01011000" when "100",     
                            "01011011" when "101",    
                            "01011011" when "110",         
                            "01011011" when "111",
                            "00011000" when "000",                            
                            "11111111" when others;

       with a select                         
                    POM7 <= "00011110" when "001",     
                            "01011110" when "010",    
                            "01011110" when "011",    
                            "01011110" when "100",     
                            "01011110" when "101",    
                            "01011110" when "110",
                            "01011110" when "111",
                            "00011000" when "000",                            
                            "11111111" when others;

       with a select                         
                    POM8 <= "00011000" when "001",     
                            "01011010" when "010",    
                            "01011010" when "011",    
                            "01011000" when "100",     
                            "01011010" when "101",    
                            "01011010" when "110",
                            "01011010" when "111",
                            "00011000" when "000",                            
                            "11111111" when others; 

       with a select                         
                    POM9 <= "00011110" when "001",     
                            "01011110" when "010",    
                            "01011110" when "011",    
                            "01011110" when "100",     
                            "01011000" when "101",    
                            "01011010" when "110",
                            "01011010" when "111",
                            "00011000" when "000",                            
                            "11111111" when others;
 with a select                         
                    POM10 <= "11011000" when "001",     
                             "11011010" when "010",    
                             "11011010" when "011",    
                             "11011010" when "100",     
                             "11011010" when "101",    
                             "11011010" when "110",
                             "11011010" when "111",
                             "11011000" when "000",                            
                             "11111111" when others; 

									  
 with a select                         
                    POM11 <= "11011101" when "001",     
                             "11011101" when "010",    
                             "11011101" when "011",    
                             "11011101" when "100",     
                             "11011101" when "101",    
                             "11011101" when "110",
                             "11011101" when "111",
                             "11011101" when "000",                            
                             "11111111" when others;   
 with a select                         
                    POM12 <= "11011000" when "001",     
                             "11011011" when "010",    
                             "11011011" when "011",    
                             "11011000" when "100",     
                             "11011110" when "101",    
                             "11011110" when "110",
                             "11011110" when "111",
                             "11011000" when "000",                            
                             "11111111" when others;   
 with a select                         
                    POM13 <= "11011000" when "001",     
                             "11011110" when "010",    
                             "11011110" when "011",    
                             "11011100" when "100",     
                             "11011110" when "101",    
                             "11011110" when "110",
                             "11011110" when "111",
                             "11011000" when "000",                            
                             "11111111" when others;   
									  
 with a select                         
                    POM14 <= "11011110" when "001",     
                             "11011110" when "010",    
                             "11011110" when "011",    
                             "11011000" when "100",     
                             "11011010" when "101",    
                             "11011010" when "110",
                             "11011010" when "111",
                             "11011010" when "000",                            
                             "11111111" when others;   
 with a select                         
                    POM15 <= "11011000" when "001",     
                             "11011110" when "010",    
                             "11011110" when "011",    
                             "11011000" when "100",     
                             "11011011" when "101",    
                             "11011011" when "110",
                             "11011011" when "111",
                             "11011000" when "000",                            
                             "11111111" when others;   
									  
 with a select                         
                    POM16 <= "11011000" when "001",     
                             "11011010" when "010",    
                             "11011010" when "011",    
                             "11011000" when "100",     
                             "11011011" when "101",    
                             "11011011" when "110",
                             "11011011" when "111",
                             "11011000" when "000",                            
                             "11111111" when others;   
 with a select                         
                    POM17 <= "11011110" when "001",     
                             "11011110" when "010",    
                             "11011110" when "011",    
                             "11011110" when "100",     
                             "11011110" when "101",    
                             "11011110" when "110",
                             "11011110" when "111",
                             "11011000" when "000",                            
                             "11111111" when others;
									  
 with a select                         
                    POM18 <= "11011000" when "001",     
                             "11011010" when "010",    
                             "11011010" when "011",    
                             "11011000" when "100",     
                             "11011010" when "101",    
                             "11011010" when "110",
                             "11011010" when "111",
                             "11011000" when "000",                            
                             "11111111" when others;
									  
 with a select                         
                    POM19 <= "11011110" when "001",     
                             "11011110" when "010",    
                             "11011110" when "011",    
                             "11011110" when "100",     
                             "11011110" when "101",    
                             "11011000" when "110",
                             "11011010" when "111",
                             "11011000" when "000",                            
                             "11111111" when others; 
									  
 with a select                         
                    POM20 <= "00011000" when "001",     
                             "01111010" when "010",    
                             "01111010" when "011",    
                             "00011010" when "100",     
                             "11011010" when "101",    
                             "11011010" when "110",
                             "11011010" when "111",
                             "00011000" when "000",                            
                             "11111111" when others; 
									  
 with a select                         
                    POM21 <= "00011101" when "001",     
                             "01111101" when "010",    
                             "01111101" when "011",    
                             "00011101" when "100",     
                             "11011101" when "101",    
                             "11011101" when "110",
                             "11011101" when "111",
                             "00011101" when "000",                            
                             "11111111" when others; 
									  
 with a select                         
                    POM22 <= "00011000" when "001",     
                             "01111011" when "010",    
                             "01111011" when "011",    
                             "00011000" when "100",     
                             "11011110" when "101",    
                             "11011110" when "110",
                             "11011110" when "111",
                             "00011000" when "000",                            
                             "11111111" when others; 
									  
 with a select                         
                    POM23 <= "00011000" when "001",     
                             "01111110" when "010",    
                             "01111110" when "011",    
                             "00011100" when "100",     
                             "11011110" when "101",    
                             "11011110" when "110",
                             "11011110" when "111",
                             "00011000" when "000",                            
                             "11111111" when others; 
									  
 with a select                         
                    POM24 <= "00011110" when "001",     
                             "01111110" when "010",    
                             "01111110" when "011",    
                             "00011000" when "100",     
                             "11011010" when "101",    
                             "11011010" when "110",
                             "11011010" when "111",
                             "00011010" when "000",                            
                             "11111111" when others; 
									  
 with a select                         
                    POM25 <= "00011000" when "001",     
                             "01111110" when "010",    
                             "01111110" when "011",    
                             "00011000" when "100",     
                             "11011011" when "101",    
                             "11011011" when "110",
                             "11011011" when "111",
                             "00011000" when "000",                            
                             "11111111" when others; 
									  
 with a select                         
                    POM26 <= "00011000" when "001",     
                             "01111010" when "010",    
                             "01111010" when "011",    
                             "00011000" when "100",     
                             "11011011" when "101",    
                             "11011011" when "110",
                             "11011011" when "111",
                             "00011000" when "000",                            
                             "11111111" when others; 
									  
 with a select                         
                    POM27 <= "00011110" when "001",     
                             "01111110" when "010",    
                             "01111110" when "011",    
                             "00011110" when "100",     
                             "11011110" when "101",    
                             "11011110" when "110",
                             "11011110" when "111",
                             "00011000" when "000",                            
                             "11111111" when others; 
									  
 with a select                         
                    POM28 <= "00011000" when "001",     
                             "01111010" when "010",    
                             "01111010" when "011",    
                             "00011000" when "100",     
                             "11011010" when "101",    
                             "11011010" when "110",
                             "11011010" when "111",
                             "00011000" when "000",                            
                             "11111111" when others; 
									  
 with a select                         
                    POM29 <= "00011110" when "001",     
                             "01111110" when "010",    
                             "01111110" when "011",    
                             "00011110" when "100",     
                             "11011000" when "101",    
                             "11011010" when "110",
                             "11011010" when "111",
                             "00011000" when "000",                            
                             "11111111" when others; 
									  
 with a select                         
                    POM30 <= "00011000" when "001",     
                             "11011010" when "010",    
                             "11011010" when "011",    
                             "10011010" when "100",     
                             "11011010" when "101",    
                             "11011010" when "110",
                             "11011010" when "111",
                             "00011000" when "000",                            
                             "11111111" when others; 
									  
 with a select                         
                    POM31 <= "00011101" when "001",     
                             "11011101" when "010",    
                             "11011101" when "011",    
                             "10011101" when "100",     
                             "11011101" when "101",    
                             "11011101" when "110",
                             "11011101" when "111",
                             "00011101" when "000",                            
                             "11111111" when others; 
									  
 with a select                         
                    POM32 <= "00011000" when "001",     
                             "11011011" when "010",    
                             "11011011" when "011",    
                             "10011000" when "100",     
                             "11011110" when "101",    
                             "11011110" when "110",
                             "11011110" when "111",
                             "00011000" when "000",                            
                             "11111111" when others; 
									  
 with a select                         
                    POM33 <= "00011000" when "001",     
                             "11011110" when "010",    
                             "11011110" when "011",    
                             "10011100" when "100",     
                             "11011110" when "101",    
                             "11011110" when "110",
                             "11011110" when "111",
                             "00011000" when "000",                            
                             "11111111" when others; 
									  
 with a select                         
                    POM34 <= "00011110" when "001",     
                             "11011110" when "010",    
                             "11011110" when "011",    
                             "10011000" when "100",     
                             "11011010" when "101",    
                             "11011010" when "110",
                             "11011010" when "111",
                             "00011010" when "000",                            
                             "11111111" when others; 
									  
 with a select                         
                    POM35 <= "00011000" when "001",     
                             "11011110" when "010",    
                             "11011110" when "011",    
                             "10011000" when "100",     
                             "11011011" when "101",    
                             "11011011" when "110",
                             "11011011" when "111",
                             "00011000" when "000",                            
                             "11111111" when others;
 									  
 with a select                         
                    POM36 <= "00011000" when "001",     
                             "11011010" when "010",    
                             "11011010" when "011",    
                             "10011000" when "100",     
                             "11011011" when "101",    
                             "11011011" when "110",
                             "11011011" when "111",
                             "00011000" when "000",                            
                             "11111111" when others; 


 									  
 with a select                         
                    POM37 <= "00011110" when "001",     
                             "11011110" when "010",    
                             "11011110" when "011",    
                             "10011110" when "100",     
                             "11011110" when "101",    
                             "11011110" when "110",
                             "11011110" when "111",
                             "00011000" when "000",                            
                             "11111111" when others; 									  
 with a select                         
                    POM38 <= "00011000" when "001",     
                             "11011010" when "010",    
                             "11011010" when "011",    
                             "10011000" when "100",     
                             "11011010" when "101",    
                             "11011010" when "110",
                             "11011010" when "111",
                             "00011000" when "000",                            
                             "11111111" when others; 									  
 with a select                         
                    POM39 <= "00011110" when "001",     
                             "11011110" when "010",    
                             "11011110" when "011",    
                             "10011110" when "100",     
                             "11011000" when "101",    
                             "11011010" when "110",
                             "11011010" when "111",
                             "00011000" when "000",                            
                             "11111111" when others; 									  
 with a select                         
                    POM40 <= "11011000" when "001",     
                             "11011010" when "010",    
                             "11011010" when "011",    
                             "00011010" when "100",     
                             "01011010" when "101",    
                             "01011010" when "110",
                             "01011010" when "111",
                             "01011000" when "000",                            
                             "11111111" when others; 									  
 with a select                         
                    POM41 <= "11011101" when "001",     
                             "11011101" when "010",    
                             "11011101" when "011",    
                             "00011101" when "100",     
                             "01011101" when "101",    
                             "01011101" when "110",
                             "01011101" when "111",
                             "01011101" when "000",                            
                             "11111111" when others; 									  
 with a select                         
                    POM42 <= "11011000" when "001",     
                             "11011011" when "010",    
                             "11011011" when "011",    
                             "00011000" when "100",     
                             "01011110" when "101",    
                             "01011110" when "110",
                             "01011110" when "111",
                             "01011000" when "000",                            
                             "11111111" when others; 									  
 with a select                         
                    POM43 <= "11011000" when "001",     
                             "11011110" when "010",    
                             "11011110" when "011",    
                             "00011100" when "100",     
                             "01011110" when "101",    
                             "01011110" when "110",
                             "01011110" when "111",
                             "01011000" when "000",                            
                             "11111111" when others; 									  
 with a select                         
                    POM44 <= "11011110" when "001",     
                             "11011110" when "010",    
                             "11011110" when "011",    
                             "00011000" when "100",     
                             "01011010" when "101",    
                             "01011010" when "110",
                             "01011010" when "111",
                             "01011010" when "000",                            
                             "11111111" when others; 									  
 with a select                         
                    POM45 <= "11011000" when "001",     
                             "11011110" when "010",    
                             "11011110" when "011",    
                             "00011000" when "100",     
                             "01011011" when "101",    
                             "01011011" when "110",
                             "01011011" when "111",
                             "01011000" when "000",                            
                             "11111111" when others; 									  
 with a select                         
                    POM46 <= "11011000" when "001",     
                             "11011010" when "010",    
                             "11011010" when "011",    
                             "00011000" when "100",     
                             "01011011" when "101",    
                             "01011011" when "110",
                             "01011011" when "111",
                             "01011000" when "000",                            
                             "11111111" when others; 									  
 with a select                         
                    POM47 <= "11011110" when "001",     
                             "11011110" when "010",    
                             "11011110" when "011",    
                             "00011110" when "100",     
                             "01011110" when "101",    
                             "01011110" when "110",
                             "01011110" when "111",
                             "01011000" when "000",                            
                             "11111111" when others; 									  
 with a select                         
                    POM48 <= "11011000" when "001",     
                             "11011010" when "010",    
                             "11011010" when "011",    
                             "00011000" when "100",     
                             "01011010" when "101",    
                             "01011010" when "110",
                             "01011010" when "111",
                             "01011000" when "000",                            
                             "11111111" when others; 									  
 with a select                         
                    POM49 <= "11011110" when "001",     
                             "11011110" when "010",    
                             "11011110" when "011",    
                             "00011110" when "100",     
                             "01011000" when "101",    
                             "01011010" when "110",
                             "01011010" when "111",
                             "01011000" when "000",                            
                             "11111111" when others; 									  
 with a select                         
                    POM50 <= "00011000" when "001",     
                             "11011010" when "010",    
                             "11011010" when "011",    
                             "00011010" when "100",     
                             "01111010" when "101",    
                             "01111010" when "110",
                             "01111010" when "111",
                             "00011000" when "000",                            
                             "11111111" when others; 									  
 with a select                         
                    POM51 <= "00011101" when "001",     
                             "11011101" when "010",    
                             "11011101" when "011",    
                             "00011101" when "100",     
                             "01111101" when "101",    
                             "01111101" when "110",
                             "01111101" when "111",
                             "00011101" when "000",                            
                             "11111111" when others; 									  
 with a select                         
                    POM52 <= "00011000" when "001",     
                             "11011011" when "010",    
                             "11011011" when "011",    
                             "00011000" when "100",     
                             "01111110" when "101",    
                             "01111110" when "110",
                             "01111110" when "111",
                             "00011000" when "000",                            
                             "11111111" when others; 									  
 with a select                         
                    POM53 <= "00011000" when "001",     
                             "11011110" when "010",    
                             "11011110" when "011",    
                             "00011100" when "100",     
                             "01111110" when "101",    
                             "01111110" when "110",
                             "01111110" when "111",
                             "00011000" when "000",                            
                             "11111111" when others; 									  
 with a select                         
                    POM54 <= "00011110" when "001",     
                             "11011110" when "010",    
                             "11011110" when "011",    
                             "00011000" when "100",     
                             "01111010" when "101",    
                             "01111010" when "110",
                             "01111010" when "111",
                             "00011010" when "000",                            
                             "11111111" when others; 									  
 with a select                         
                    POM55 <= "00011000" when "001",     
                             "11011110" when "010",    
                             "11011110" when "011",    
                             "00011000" when "100",     
                             "01111011" when "101",    
                             "01111011" when "110",
                             "01111011" when "111",
                             "00011000" when "000",                            
                             "11111111" when others;
 									  
 with a select                         
                    POM56 <= "00011000" when "001",     
                             "11011010" when "010",    
                             "11011010" when "011",    
                             "00011000" when "100",     
                             "01111011" when "101",    
                             "01111011" when "110",
                             "01111011" when "111",
                             "00011000" when "000",                            
                             "11111111" when others; 									  
 with a select                         
                    POM57 <= "00011110" when "001",     
                             "11011110" when "010",    
                             "11011110" when "011",    
                             "00011110" when "100",     
                             "01111110" when "101",    
                             "01111110" when "110",
                             "01111110" when "111",
                             "00011000" when "000",                            
                             "11111111" when others;
 									  
 with a select                         
                    POM58 <= "00011000" when "001",     
                             "11011010" when "010",    
                             "11011010" when "011",    
                             "00011000" when "100",     
                             "01111010" when "101",    
                             "01111010" when "110",
                             "01111010" when "111",
                             "00011000" when "000",                            
                             "11111111" when others;
 									  
 with a select                         
                    POM59 <= "00011110" when "001",     
                             "11011110" when "010",    
                             "11011110" when "011",    
                             "00011110" when "100",     
                             "01111000" when "101",    
                             "01111010" when "110",
                             "01111010" when "111",
                             "00011000" when "000",                            
                             "11111111" when others;									  


end Behavioral;
