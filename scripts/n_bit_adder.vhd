library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity n_bit_adder is
    generic(
        N: integer:= 8
    );
    port (
        A: in signed(N-1 downto 0);
        B: in signed(N-1 downto 0);
        CIN: in std_logic;
        SUM: out signed(N-1 downto 0);
        COUT: out std_logic
    );
end entity n_bit_adder;

architecture rtl of n_bit_adder is
    signal Carry: std_logic_vector(N downto 0);
begin
    Carry(0)<= CIN;
        gen_adders: for i in 0 to N-1 generate
            adder: entity work.fulladder
            port map(
                a=> A(i),
                b=> B(i),
                cin=> Carry(i),
                sum=> SUM(i),
                cout=> Carry(i+1)
            );
        end generate;
    COUT<= Carry(N);
end architecture rtl;