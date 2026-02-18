library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity neuron_tb is
end entity neuron_tb;

architecture rtl of neuron_tb is
    signal R, CLK: std_logic;
    signal X1, X2, X3, X4, X5: signed(7 downto 0);
    signal ACTVN: signed(16 downto 0);
begin
    my_neuron: entity work.neuron
    generic map(
        W0=> 40,-- 2.5
        W1=> -50,-- -3.125
        W2=> 24, -- 1.5
        W3=> 100,-- 6.25
        W4=> -6,-- -0.375
        B=> -352 -- -1.375
    )
    port map(
        X1=> X1,
        X2=> X2,
        X3=> X3,
        X4=> X4,
        X5=> X5,
        R=>  R,
        CLK=> CLK,
        ACTVN=> ACTVN
    );
    clock_signal: process
    begin
        loop 
            CLK<= '0';
            wait for 5ns;
            CLK<= '1';
            wait for 5ns;
        end loop;
    end process;
    inputs: process
    begin
            X1<= to_signed(0,8);
            X2<= to_signed(0,8);
            X3<= to_signed(0,8);
            X4<= to_signed(0,8);
            X5<= to_signed(0,8);
            R<= '1';
            wait for 15ns;
            X1<= to_signed(16,8);
            X2<= to_signed(32,8);
            X3<= to_signed(48,8);
            X4<= to_signed(64,8);
            X5<= to_signed(80,8);
            R<= '0';
            wait for 10ns;
            X1<= to_signed(-15,8);
            X2<= to_signed(-32,8);
            X3<= to_signed(113,8);
            X4<= to_signed(-87,8);
            X5<= to_signed(80,8);
            wait for 10ns;
            X1<= to_signed(-128,8);
            X2<= to_signed(16,8);
            X3<= to_signed(-80,8);
            X4<= to_signed(96,8);
            X5<= to_signed(32,8);
            wait for 10ns;
            X1<= to_signed(-32,8);
            X2<= to_signed(-80,8);
            X3<= to_signed(16,8);
            X4<= to_signed(48,8);
            X5<= to_signed(-96,8);
            wait for 10ns;
            X1<= to_signed(32,8);
            X2<= to_signed(48,8);
            X3<= to_signed(-96,8);
            X4<= to_signed(96,8);
            X5<= to_signed(-128,8);
            wait for 10ns;
            X1<= to_signed(-16,8);
            X2<= to_signed(-32,8);
            X3<= to_signed(-48,8);
            X4<= to_signed(-96,8);
            X5<= to_signed(48,8);
            wait;
    end process;
end architecture rtl;
