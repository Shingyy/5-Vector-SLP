library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity x_bit_mac is
    generic(
        X: integer:= 8 ;--number of bits of each vector element
        W0: integer:= 16;
        W1: integer:= 32;
        W2: integer:= 48;
        W3: integer:= 64;
        W4: integer:= 80
    );
    port (
        CLK: in std_logic; -- 100MHz clock 
        A0: in signed(X-1 downto 0);-- first element of input vector
        A1: in signed(X-1 downto 0);-- second element of input vector
        A2: in signed(X-1 downto 0);-- third element of input vector
        A3: in signed(X-1 downto 0);-- fourth element of input vector
        A4: in signed(X-1 downto 0);-- last element of input vector
        R: in std_logic;
        DOT_PRODUCT: out signed(2*X downto 0)
    );
end entity x_bit_mac;

architecture rtl of x_bit_mac is
    type weight_array is array(0 to 4) of signed(X-1 downto 0);
    type input_array is array(0 to 4) of signed(X-1 downto 0);
    type product_array is array(0 to 4) of signed(2*X downto 0);
    type reg_array is array(0 to 4) of signed(2*X downto 0);
    type sum_array is array(0 to 4) of signed(2*X downto 0);
    constant weights: weight_array:=(
        0=> to_signed(W0, X),
        1=> to_signed(W1, X),
        2=> to_signed(W2, X),
        3=> to_signed(W3, X),
        4=> to_signed(W4,X)
    );
    signal inputs: input_array;
    signal product: product_array;
    signal sum: sum_array;
    signal reg_product: reg_array;
begin
    inputs(0) <= A0;
    inputs(1) <= A1;
    inputs(2) <= A2;
    inputs(3) <= A3;
    inputs(4) <= A4;
    --multipliers
    gen_multipliers: for i in 0 to 4 generate
        multiplier: entity work.n_bit_multiplier
        generic map(
            N=> X
        )
        port map(
            A=> inputs(i),
            B=> weights(i),
            AB=> product(i)
        );
    end generate;
    gen_regs: for i in 0 to 4 generate
        myregisters: entity work.n_bit_register
        generic map(
            N=> 2*X+1
        )
        port map(
            D=> product(i),
            CLK=> CLK,
            R=> R,
            Q=> reg_product(i)
        );
    end generate;
    sum(0)<= reg_product(0);
    --adders
    gen_adders: for i in 0 to 3 generate
        adder: entity work.n_bit_adder
        generic map(
            N=> 2*X+1 
        )
        port map(
            A=> sum(i),
            B=> reg_product(i+1),
            CIN=> '0',
            SUM=> sum(i+1),
            COUT=> open
        );
    end generate;
    --register 
    my_register: entity work.n_bit_register
    generic map(
        N=> 2*X+1
    )
    port map(
        CLK=> CLK,
        D=> sum(4),
        R=> R,
        Q=> DOT_PRODUCT
        );
end architecture rtl;