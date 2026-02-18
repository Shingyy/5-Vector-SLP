library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Fixed point arithmetic Q4.4
entity neuron is
    generic(
        P: integer := 8; --bit width
        W0: integer:= 16;-- Q4.4 --> 1
        W1: integer:= 32;-- Q4.4 --> 2
        W2: integer:= 48;-- Q4.4 --> 3
        W3: integer:= 64;-- Q4.4 --> 4
        W4: integer:= 80;-- Q4.4 --> 5
        B:  integer:= -512-- Q8.8 --> -2
    );
    port (
        CLK: in std_logic;
        R: in std_logic;
        X1: in signed(P-1 downto 0);-- first element of input vector
        X2: in signed(P-1 downto 0);-- second element of input vector
        X3: in signed(P-1 downto 0);-- third element of input vector
        X4: in signed(P-1 downto 0);-- fourth element of input vector
        X5: in signed(P-1 downto 0);-- last element of input vector
        ACTVN: out signed(2*P downto 0)-- Activation = f(w*x +b) --> RELU activation
    );
end entity neuron;

architecture rtl of neuron is
    signal bias: signed(2*P downto 0) := to_signed(B, 2*P+1);
    signal dot_product: signed(2*P downto 0) ;
    signal y_hat: signed(2*P downto 0);
begin
    dot_mac: entity work.x_bit_mac
    generic map(
        X=> P,
        W0=> W0,
        W1=> W1,
        W2=> W2,
        W3=> W3,
        W4=> W4
    )
    port map(
        CLK=> CLK,
        R=> R,
        A0=> X1,
        A1=> X2,
        A2=> X3,
        A3=> X4,
        A4=> X5,
        DOT_PRODUCT=> dot_product
    );
    bias_adder: entity work.n_bit_adder
    generic map(
        N=> 2*P+1
    )
    port map(
        A=> dot_product,
        B=> bias,
        CIN=> '0',
        SUM=> y_hat,
        COUT=> open
    );
    --RELU Activation
    ACTVN<= y_hat when y_hat> to_signed(0,2*P+1) else
            to_signed(0, 2*P+1 );
end architecture rtl;