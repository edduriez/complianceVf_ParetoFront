density=0.01:0.0001:1;
m=size(density,2);
complfilename=['complHRr3.txt'];
complfileID=fopen(complfilename,'w');
    
for j =1:m   
    pointfilename=['pointHRr3',num2str(j)];
    pointfileID=fopen(pointfilename);
    pointdata = fscanf(pointfileID,'%f %f %f %f %f',[5 1]);
    
    fprintf(complfileID,'%14.10f %14.10f %14.10f %14.10f %14.10f',pointdata(1),pointdata(2),pointdata(3),pointdata(4),pointdata(5))
    fprintf(complfileID,'\n')
end


fclose('all');
