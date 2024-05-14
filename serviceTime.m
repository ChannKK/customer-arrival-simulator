function output = serviceTime
    for count=1:5
        if (count==1)
           serviceTime(count)=3; 
           prob(count)=0.1;
           CDF(count)=prob(count);
           first_num(count)=1;
           last_num(count)=CDF(count)*100;
           
        elseif(count==2)
           serviceTime(count)=4; 
           prob(count)=0.15;
           CDF(count)=CDF(count-1)+prob(count);
           first_num(count)=last_num(count-1)+1;
           last_num(count)=CDF(count)*100;
           
        elseif(count==3)
           serviceTime(count)=5; 
           prob(count)=0.25;
           CDF(count)=CDF(count-1)+prob(count);
           first_num(count)=last_num(count-1)+1;
           last_num(count)=CDF(count)*100;
   
        elseif(count==4)
           serviceTime(count)=6; 
           prob(count)=0.3;
           CDF(count)=CDF(count-1)+prob(count);
           first_num(count)=last_num(count-1)+1;
           last_num(count)=CDF(count)*100;
           
        elseif(count==5)
           serviceTime(count)=7; 
           prob(count)=0.2;
           CDF(count)=CDF(count-1)+prob(count);
           first_num(count)=last_num(count-1)+1;
           last_num(count)=CDF(count)*100;
        end
     end 
     printf('\n    --- Table of Service Time for 3 Servers ---')
     printf('\n Counter 1\n');
     printf(' -------------------------------------------------- \n');
     printf('| Service Time  |  Probability  |  CDF   | Range   |\n');
     printf('|--------------------------------------------------|\n');
     for count=1:5
         printf('|      %3.0f      |    %1.2f       |  %1.2f  |%3.0f-%3.0f  |\n',[serviceTime(count),prob(count),CDF(count),first_num(count),last_num(count)]);
     end
     
     printf(' -------------------------------------------------- \n');
     for count=1:5
        if (count==1)
           serviceTime(count)=4; 
           prob(count)=0.15;
           CDF(count)=prob(count);
           fNum(count)=1;
           last_num(count)=CDF(count)*100;
           
        elseif(count==2)
           serviceTime(count)=5; 
           prob(count)=0.30;
           CDF(count)=CDF(count-1)+prob(count);
           first_num(count)=last_num(count-1)+1;
           last_num(count)=CDF(count)*100;
           
        elseif(count==3)
           serviceTime(count)=6; 
           prob(count)=0.25;
           CDF(count)=CDF(count-1)+prob(count);
           first_num(count)=last_num(count-1)+1;
           last_num(count)=CDF(count)*100;
   
        elseif(count==4)
           serviceTime(count)=7; 
           prob(count)=0.1;
           CDF(count)=CDF(count-1)+prob(count);
           first_num(count)=last_num(count-1)+1;
           last_num(count)=CDF(count)*100;
           
        elseif(count==5)
           serviceTime(count)=8; 
           prob(count)=0.2;
           CDF(count)=CDF(count-1)+prob(count);
           first_num(count)=last_num(count-1)+1;
           last_num(count)=CDF(count)*100;
        end
     end 
     
     
       printf('\n Counter 2\n');
     printf(' -------------------------------------------------- \n');
     printf('| Service Time  |  Probability  |  CDF   | Range   |\n');
     printf('|--------------------------------------------------|\n');
     for count=1:5
         printf('|      %3.0f      |    %1.2f       |  %1.2f  |%3.0f-%3.0f  |\n',[serviceTime(count),prob(count),CDF(count),first_num(count),last_num(count)]);
     end
     
     printf(' -------------------------------------------------- \n');
     for count=1:5
        if (count==1)
           serviceTime(count)=2; 
           prob(count)=0.35;
           CDF(count)=prob(count);
           first_num(count)=1;
           last_num(count)=CDF(count)*100;
           
        elseif(count==2)
           serviceTime(count)=3; 
           prob(count)=0.30;
           CDF(count)=CDF(count-1)+prob(count);
           first_num(count)=last_num(count-1)+1;
           last_num(count)=CDF(count)*100;
           
        elseif(count==3)
           serviceTime(count)=4; 
           prob(count)=0.20;
           CDF(count)=CDF(count-1)+prob(count);
           first_num(count)=last_num(count-1)+1;
           last_num(count)=CDF(count)*100;
   
        elseif(count==4)
           serviceTime(count)=5; 
           prob(count)=0.1;
           CDF(count)=CDF(count-1)+prob(count);
           first_num(count)=last_num(count-1)+1;
           last_num(count)=CDF(count)*100;
           
        elseif(count==5)
           serviceTime(count)=6; 
           prob(count)=0.05;
           CDF(count)=CDF(count-1)+prob(count);
           first_num(count)=last_num(count-1)+1;
           last_num(count)=CDF(count)*100;
        end
     end 
     
     
     printf('\n Counter 3 (express counter)\n');
     printf(' -------------------------------------------------- \n');
     printf('| Service Time  |  Probability  |  CDF   | Range   |\n');
     printf('|--------------------------------------------------|\n');
     for count=1:5
         printf('|      %3.0f      |    %1.2f       |  %1.2f  |%3.0f-%3.0f  |\n',[serviceTime(count),prob(count),CDF(count),first_num(count),last_num(count)]);
     end
     
     printf(' -------------------------------------------------- \n');
    