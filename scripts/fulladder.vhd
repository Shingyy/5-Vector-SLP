library IEEE;
use IEEE.std_logic_1164.all;
--Interface
entity fulladder is
    port (
        a,b,cin : in std_logic;
        sum,cout:out std_logic
    );
end entity fulladder;
--Behaviour
architecture fulladder_behaviour of fulladder is
    --no signals
begin
    sum<= (a xor b) xor cin;
    cout<= (a and b) or (cin and (a xor b));
end architecture fulladder_behaviour;