library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity forward_logic is
port( lsma_rr,lsma_exe,lsma_mem : in std_logic_vector(1 downto 0);
      ra_ls_rr,ra_ls_exe,ra_ls_mem : in std_logic;
      rb_ls_rr,rb_ls_exe,rb_ls_mem : in std_logic;
      valid_rr_1, valid_rr_2 : in std_logic;
      valid_exe_1, valid_exe_2 : in std_logic;
      valid_mem_1, valid_mem_2 : in std_logic;
      dest_exe, dest_mem, dest_wb : in std_logic;
      src_rr_1, src_rr_2 : in std_logic;
      src_exe_1, src_exe_2 : in std_logic;
      src_mem_1, src_mem_2 : in std_logic;
      rr_mux1, rr_mux2 : out std_logic_vector(1 downto 0);
      exe_mux1, exe_mux2 : out std_logic_vector(1 downto 0);
      mem_mux1, mem_mux2 : out std_logic
      );
end forward_logic;

architecture FR_arch of forward_logic is 
begin
	--------------------------------------Forward RR----------------------------------------------
	process(valid_rr_1, valid_rr_2, valid_exe_1, valid_exe_2, valid_mem_1, valid_mem_2, 
      		dest_exe, dest_mem, dest_wb, src_rr_1, src_rr_2, src_exe_1, src_exe_2, src_mem_1, src_mem_2) 
      	begin
      		if(lsma_rr(1) = '1') then--------------------implies lsma
      			if(ra_ls_rr='1') then-----------------regardless of load or store ra is required
      				if(dest_exe = src_rr_1) then
      					 rr_mux1 <= "01";
      				elsif(dest_mem = src_rr_1) then
					rr_mux1 <= "10";
				elsif(dest_wb = src_rr_1) then
					rr_mux1 <= "11";
				else
					rr_mux1 <= "00";
				end if;
			else------------------------------------------ else not required
				rr_mux1 <= "00";
			end if;
		elsif(valid_rr_1 ='1') then
			-------------------
				----------------------
					---------------------------Draw diagrams and proceed for forwarding logic
			if(dest_exe = src_rr_1) then
				rr_mux1 <= "01";
			elsif(dest_mem = src_rr_1) then
				rr_mux1 <= "10";
			elsif(dest_wb = src_rr_1) then
				rr_mux1 <= "11";
			else
				rr_mux1 <= "00";
			end if;
		else
			rr_mux1 <= "00";
		end if;
	end process;
		
	process(valid_rr_1, valid_rr_2, valid_exe_1, valid_exe_2, valid_mem_1, valid_mem_2, 
      		dest_exe, dest_mem, dest_wb, src_rr_1, src_rr_2, src_exe_1, src_exe_2, src_mem_1, src_mem_2) 
      	begin
		if(lsma_rr(1) = '1') then--------------------implies lsma
      			if(lsma_rr(0) = '1' and rb_ls_rr='1') then-----------------only store detected
      				if(dest_exe = src_rr_2) then
      					 rr_mux2 <= "01";
      				elsif(dest_mem = src_rr_2) then
					rr_mux2 <= "10";
				elsif(dest_wb = src_rr_2) then
					rr_mux2 <= "11";
				else
					rr_mux2 <= "00";
				end if;
			else
				rr_mux2 <= "00";
			end if;
		elsif(valid_rr_2 ='1') then
			-------------------
				----------------------
					---------------------------Draw diagrams and proceed for forwarding logic
			if(dest_exe = src_rr_2) then
				rr_mux2 <= "01";
			elsif(dest_mem = src_rr_2) then
				rr_mux2 <= "10";
			elsif(dest_wb = src_rr_2) then
				rr_mux2 <= "11";
			else
				rr_mux2 <= "00";
			end if;
		else
			rr_mux2 <= "00";
		end if;
	end process;
	-------------------------------------------end forward RR---------------------------------------------
	
	
	---------------------------------------------Forward Execute------------------------------------------
	process(valid_rr_1, valid_rr_2, valid_exe_1, valid_exe_2, valid_mem_1, valid_mem_2, 
      		dest_exe, dest_mem, dest_wb, src_rr_1, src_rr_2, src_exe_1, src_exe_2, src_mem_1, src_mem_2) 
      	begin
		if(lsma_exe(1) = '1') then--------------------implies lsma
      			if(ra_ls_exe='1') then-----------------regardless of load or store 
      				if(dest_mem = src_exe_1) then
					exe_mux1 <= "01";
				elsif(dest_wb = src_exe_1) then
					exe_mux1 <= "10";
				else
					exe_mux1 <= "00";
				end if;
			else------------------------------------------implies store
				exe_mux1 <= "00";
			end if;
		elsif(valid_exe_1 ='1') then
			-------------------
				----------------------
					---------------------------Draw diagrams and proceed for forwarding logic
			if(dest_mem = src_exe_1) then
				exe_mux1 <= "01";
			elsif(dest_wb = src_exe_1) then
				exe_mux1 <= "10";
			else
				exe_mux1 <= "00";
			end if;
		else
			exe_mux1 <= "00";
		end if;
	end process;
		
	process(valid_rr_1, valid_rr_2, valid_exe_1, valid_exe_2, valid_mem_1, valid_mem_2, 
      		dest_exe, dest_mem, dest_wb, src_rr_1, src_rr_2, src_exe_1, src_exe_2, src_mem_1, src_mem_2) 
      	begin
		if(lsma_exe(1) = '1') then--------------------implies lsma
      			if(lsma_exe(0) = '1' and rb_ls_exe='1') then-----------------only store detected
      				if(dest_mem = src_exe_2) then
					exe_mux2 <= "10";
				elsif(dest_wb = src_exe_2) then
					exe_mux2 <= "11";
				else
					exe_mux2 <= "00";
				end if;
			else------------------------------------------implies store
				rr_mux2 <= "00";
			end if;
		elsif(valid_exe_2 ='1') then
			-------------------
				----------------------
					---------------------------Draw diagrams and proceed for forwarding logic
			if(dest_mem = src_exe_2) then
				exe_mux2 <= "10";
			elsif(dest_wb = src_exe_2) then
				exe_mux2 <= "11";
			else
				exe_mux2 <= "00";
			end if;
		else
			exe_mux2 <= "00";
		end if;
	end process;
	
	---------------------------------------------Forward mem------------------------------------------
	process(valid_rr_1, valid_rr_2, valid_exe_1, valid_exe_2, valid_mem_1, valid_mem_2, 
      		dest_exe, dest_mem, dest_wb, src_rr_1, src_rr_2, src_exe_1, src_exe_2, src_mem_1, src_mem_2) 
      	begin
		if(lsma_mem(1) = '1') then--------------------implies lsma
      			if(ra_ls_mem='1') then-----------------regardless of load or store 
      				if(dest_wb = src_mem_1) then
					mem_mux1 <= '1';
				else
					mem_mux1 <= '0';
				end if;
			else------------------------------------------implies store
				exe_mux1 <= "00";
			end if;
		elsif(valid_mem_1 ='1') then
			-------------------
				----------------------
					---------------------------Draw diagrams and proceed for forwarding logic
			if(dest_wb = src_mem_1) then
				mem_mux1 <= '1';
			else
				mem_mux1 <= '0';
			end if;
		else
			mem_mux1 <= '0';
		end if;
	end process;
		
	process(valid_rr_1, valid_rr_2, valid_exe_1, valid_exe_2, valid_mem_1, valid_mem_2, 
      		dest_exe, dest_mem, dest_wb, src_rr_1, src_rr_2, src_exe_1, src_exe_2, src_mem_1, src_mem_2) 
      	begin
		if(lsma_mem(1) = '1') then--------------------implies lsma
      			if(lsma_mem(0) = '1' and rb_ls_mem='1') then-----------------only store detected
      				if(dest_wb = src_mem_2) then
					mem_mux2 <= '1';
				else
					mem_mux2 <= '0';
				end if;
			else------------------------------------------implies store
				rr_mux2 <= "00";
			end if;
		elsif(valid_mem_2 ='1') then
			-------------------
				----------------------
					---------------------------Draw diagrams and proceed for forwarding logic
			if(dest_wb = src_mem_2) then
				mem_mux2 <= '1';
			else
				mem_mux2 <= '0';
			end if;
		else
			mem_mux2 <= '0';
		end if;
	end process;
end FR_arch; 