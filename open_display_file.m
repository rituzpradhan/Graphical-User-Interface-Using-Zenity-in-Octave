function y=open_display_file()
% Author: Ritu Pradhan and Varenya Prasad
% Date: 9th May 2011
	
	%Load the package
	pkg load zenity
	
	% Open and read data from the file
	fid=fopen("words.txt","r");
	tline = fgets(fid);
	data = ""
	
	% Create a string to display the contents of the file.
	while ischar(tline)	
		data = strcat(data,tline);
		
		tline = fgets(fid);
	end	
	
	% Display data in the zenity provided GUi
	y=zenity_text_info('File Content',data)
	
	%Close file.
	fclose(fid);	
end
