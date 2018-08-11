x = 0:30;
y = [1.5*cos(x); 4*exp(-.1*x).*cos(x); exp(.05*x).*cos(x)]';
S = stem(x,y);
NameArray = {'Marker','Tag'};
ValueArray = {'o','Decaying Exponential';...
   'square','Growing Exponential';...
   '*','Steady State'};
%set(S,NameArray,ValueArray)