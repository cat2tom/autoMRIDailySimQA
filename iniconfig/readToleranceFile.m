function tolDict  = readToleranceFile(tolFileName)

%{  
read tolerance file for a text file 
Input: tolerance file
Output: dictionary containg tolerance 

  
%}

 % make empy dict
 
 tolDict=containers.Map();
 
% initilize the class object
ini = IniConfig();

ini.ReadFile(tolFileName);

sections = ini.GetSections();

% section 1.

[keys, ~] = ini.GetKeys(sections{1});
values=ini.GetValues(sections{1}, keys);

tolDict('snrTol')=values{1};

% secton 2

[keys, ~] = ini.GetKeys(sections{2});
values= ini.GetValues(sections{2}, keys);

tolDict('uniformityTol')=values{1};



% secton 3.
[keys, ~] = ini.GetKeys(sections{3});
values= ini.GetValues(sections{3}, keys);

tolDict('contrastTol')=values{1};

% section 4.

[keys, ~] = ini.GetKeys(sections{4});
values= ini.GetValues(sections{4}, keys);

tolDict('ghostingTol')=values{1};

% section 5. 

[keys, ~] = ini.GetKeys(sections{5});
values= ini.GetValues(sections{5}, keys);

tolDict('d45Tol')=values{1};

% section 6
[keys, ~] = ini.GetKeys(sections{6});
values= ini.GetValues(sections{6}, keys);

tolDict('d135Tol')=values{1};

% section 7

[keys, ~] = ini.GetKeys(sections{7});
values= ini.GetValues(sections{7}, keys);

tolDict('outputTol')=values{1};

% section 8
[keys, ~] = ini.GetKeys(sections{8});
values= ini.GetValues(sections{8}, keys);

tolDict('laserXTol')=values{1};

% section 9
[keys, ~] = ini.GetKeys(sections{9});
values= ini.GetValues(sections{9}, keys);

tolDict('laserYTol')=values{1};
% section 10
[keys, ~] = ini.GetKeys(sections{10});
values= ini.GetValues(sections{10}, keys);

tolDict('laserZTol')=values{1};

end

