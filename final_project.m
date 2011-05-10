% This is the main file for running our final project application
% Author: Ritu Pradhan and Varenya Prasad
% Date: 9th May 2011

% Loading Zenity
pkg load zenity

%Introductory dialog boxes
prompt = zenity_entry("Welcome, Please Enter Your Name: ");
welcome_message=strcat("Welcome	", prompt,"!");
zenity_message(welcome_message);
game_select=zenity_list("Please Select an Option!",{"Select an Option"},{"Play!","PlotStatistics","Calendar","Quit",});


% The selection menu is provided to the user multiple times.
count=0;
if(vector_string_cmp(game_select, "Play! "))
	confirm=strcat("Are you Ready for the Fun?");
	zenity_message(confirm,"question");
	count=ans;
	if(ans==1)
		zenity_message('GoodBye, Come Back Again.....');
	else	
		while(count!=1)
			[result,num_guesses] = game_guess()
			
			if(result==1)
				fid=fopen("statistics.txt","a");
				fprintf(fid,"%d;",num_guesses);
				fclose(fid);
			endif
			confirm1=strcat("Do you want to play again?");
			zenity_message(confirm1,"question");
			count=ans;
		endwhile	
		zenity_message('Thanks for joining us.GoodBye,Come Back Again.....');
	endif
	
elseif(vector_string_cmp(game_select, "Calendar "))	
	zenity_calendar('Better Check the Dates!');
	

#Plotting average statistics	
elseif(vector_string_cmp(game_select, "PlotStatistics "))	
	data=csvread("statistics.txt");
	total=length(data)-1;
	y=1:total;
	zenity_progress('Plotting Graph....')

	plot(y,data(y),'m');
	
	title ("Game History","FontSize",14);
	ylabel ("Number of moves");
	xlabel ("Players");
else
	zenity_message('Thanks for joining us. GoodBye,Come Back Again.....');
endif