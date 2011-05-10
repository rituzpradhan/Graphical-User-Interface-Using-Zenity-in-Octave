function result = vector_string_cmp(v,s)
	% This function takes in a vector and a string and does a character comparison
	% element by element. Returns true if equal, false if not.
	% The first parameter is the vector and the second parameter is the string.
	%
	% Author: Ritu Pradhan and Varenya Prasad
	% Date: 9th May 2011
	
	sa= size(v);
	sb = size(s);
	
	if (sa ==sb) # The vector length equals string length, now to do an char-by-char comparision.
		#disp "Ok to compare"
		n = sa(2) - 1;
		result = true;
		while (n >0 && result == true)
			if (v(n) == s(n))	
				%disp "I came here"
				result = true;
				n--;
			else
				result = false;
			endif
		endwhile		
	else # The vector length does not equal string length.
		#disp "vector and string are not equal"
		result = false;
	endif

endfunction