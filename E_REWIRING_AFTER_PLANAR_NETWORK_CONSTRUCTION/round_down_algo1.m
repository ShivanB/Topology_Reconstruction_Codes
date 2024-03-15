function modifiedRho = round_down_algo1(rho,x0)
orig_rho=(x0);

modifiedRho = processRho(rho);
transpose(modifiedRho);



l=transpose({'l12', 'l13', 'l14', 'l15', 'l16', 'l17', 'l114', 'l115', 'l116',...
'l117', 'l118', 'l119', 'l23', 'l24', 'l28', 'l29', 'l210', 'l220',...
'l221', 'l222', 'l34', 'l411', 'l412', 'l413','a','bstar',...
'dstar','e','f','gstar','gamma'});
   
disp('Initial_rho Rounded_rho:');
digits(5);
for i=1:length(l)
fprintf('%s %d %d\n',l{i},(orig_rho(i)),(modifiedRho(i)));
end

 
end

