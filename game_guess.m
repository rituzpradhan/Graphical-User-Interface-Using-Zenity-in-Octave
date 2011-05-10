function result,num_guesses = game_guess()
% This file provides the ability to play a guessing game.
% Instructions: 
% 1) Decide on an integer between 1 and 1000. Do not type this number into the computer.
% 2) The computer will make an initial guess of the number
% 3) For each guess the computer makes, the player must indicate if the guess is too high, too low or correct.
% 4) The computer is only allowed 10 chances to guess the player's number.
% 5) If the computer cant guess, the player WINS!

% Return Values:
% result = 0 if game was aborted, 1 if it was succesfull
% num_guesses is the number of moves it took to guess the correct number. Valid only if game wasnt aborted.

% Author: Ritu Pradhan and Varenya Prasad
% Date: 9th May 2011
	
	ub = 1000; #upper bound
	lb = 0; # lower bound
	prev_ub = 1000;
	prev_lb = 0;
	num_guesses = 0;
	
	prompt = "CHALLENGE: Think of a number between 1 and 1000. We will guess the number in a maximum of 10 moves!"
	zenity_message(prompt,info);
	
	signal = zenity_entry("Think of a number between 1 and 1000. Type 'ready' or 'quit'!");
	
	response_num = check_input_str(signal);
	while ((response_num != 4) && (response_num != 5))	
		signal = zenity_entry("I'm sorry, Are you ready to play? Type 'ready' or 'quit'!");
		response_num = check_input_str(signal);		
	endwhile
	
	if (response_num == 5)
		disp "Well I hit quit"

		#Lets give them the first guess i.e number is 500
		guess = ub/2;
		response_num = make_guess(guess);
		
		num_guesses = 1;
		if (response_num == 1) # Right Guess!		
			result = right_guess(num_guesses);		
		end
		
		while ((response_num != 1) && (response_num != 4))
			
			if (response_num == 3) # Our guess was too high
				prev_ub = int32(ub);
				prev_lb = int32(lb);
				ub = (prev_ub+prev_lb)/2;			
				
				guess = (ub+lb)/2;
				response_num = make_guess(guess);			
				num_guesses = num_guesses + 1;
			end
			
			if (response_num == 2) # Our guess was too low		
				prev_ub = int32(ub);
				prev_lb = int32(lb);
				lb = (prev_ub+prev_lb)/2;
				
				guess = (ub+lb)/2;
				response_num = make_guess(guess);			
				num_guesses = num_guesses + 1;
			end
			
			if (response_num == 1) # Right Guess!			
				result = right_guess(num_guesses);			
			end
		end
	end
	
	if (response_num == 4)
		zenity_message("Game Aborted",info);
		result = 0;
		
	end
end

% Function takes in the user response and compares it to check that its a valid response.
% Valid responses are: 'correct', 'high', 'low', 'quit', 'ready'
% If the response is valid, the function also returns a value indicating what the 
% user response was.
% Return Values are as follows:
% 0 - incorrect response
% 1 - correct
% 2 - low
% 3 - high
% 4 - quit
% 5 - ready
function y = check_input_str(r)
	if (vector_string_cmp(r, "correct "))
		y = 1;
	elseif (vector_string_cmp(r, "high "))
		y = 3;
	elseif (vector_string_cmp(r, "low "))
		y = 2;
	elseif(vector_string_cmp(r, "quit "))
		y = 4;
	elseif(vector_string_cmp(r, "ready "))
		y = 5;
	else
		y = 0;
	end
end

% Once the correct guess has been made, the function creates the prompt to 
% print the number of moves it took to make the guess.
function y = right_guess(num_guesses)
	prompt = strcat("Great! I made the right guess in	", int2str(num_guesses), " move(s)");
	zenity_message(prompt,info);
	y = 1;
end

% The function creates the prompt to display the next guess to the user.
% It also checks that the response the user makes is the right one i.e 'low'
% or 'correct' or 'high'
function response_num = make_guess(guess)
	prompt = strcat("Is your number	", int2str(guess), ". Hit 'quit' or 'correct' or 'high' or 'low':");
	response_str = zenity_entry(prompt);
	response_num = check_input_str(response_str);
	
	while (response_num == 0) # The user response is invalid
		prompt = strcat("Wrong Response! Is your number	", int2str(guess), ". Hit 'quit' or 'correct' or 'high' or 'low':");
		response_str = zenity_entry(prompt);
		response_num = check_input_str(response_str);
	end
end
