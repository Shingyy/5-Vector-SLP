library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--interface
entity n_bit_multiplier is
    generic(
        N: integer:= 8
    );

    port (
        A: in signed(N-1 downto 0);
        B: in signed(N-1 downto 0);
        AB: out signed(2*N downto 0)
    );
end entity n_bit_multiplier;

--behaviour
architecture rtl of n_bit_multiplier is
    signal absA, absB: unsigned(N-1 downto 0);
begin
    absA<= unsigned(abs(A));
    absB<= unsigned(abs(B));
    multiply: process (A, B, absA, absB) is
        variable temp, add :unsigned(2*N downto 0);
        begin
            temp:= to_unsigned(0,2*N+1);
            add:= resize(absA,2*N+1);
            for i in 0 to N-1 loop
                if absB(i)= '1' then
                    temp:= temp + shift_left(add,i);
                end if;
            end loop;
        if (A(N-1) xor B(N-1))= '1' then 
            AB<= -signed(temp);
        else
            AB<= signed(temp) ;
        end if;
    end process;
end architecture rtl;