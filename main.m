function output = main()
    fprintf('\n');
    voice='doorbell.wav'; sound=wavread(voice); wavplay(sound,'25000','async');
    disp('===== Welcome to the supermarket! =====');
    
    serviceTime();
    interarrival();
    valid = 0;
    while (valid == 0)
        custNum = input('Number of customers (minimum 5): '); % user input no. of customers
        if (custNum >= 5)
            valid = 1;
        elseif (custNum < 5) % check if user input < 5
            valid = 0;
        elseif isempty(custNum) % check if user input (no. of customers) is empty
            valid = 0;
        end
    end
    
    % choosing generator
    fprintf('\nWhich random generator would you choose?\n');
    fprintf('1. Mixed linear congruential generator \n2. Additive linear congruential generator \n3. Multiplicative linear congruential generator \n4. Random variate generator for uniform distribution \n5. Random variate generator for exponential distribution\n');
    valid = 0;
    fprintf('\n');
    while(valid == 0)
        choice = input('Please choose a generator: ');
        if (choice == 1 || choice == 2 || choice == 3 || choice == 4 || choice == 5)
            valid = 1;
        elseif isempty(choice)
        else
            fprintf('Invalid generator!\n');
        end
    end
    
    if (choice == 1) % mixed LCG
        m = 101;
        disp('For inter-arrival time: ');
        disp('Please enter the constant multiplier, a'); 
        a = primeNumber();
        disp('Please enter the constant increment, c'); 
        c = primeNumber();
        randInterarrival = zeros(custNum,1); % store the random numbers generated in the loop
        randService = zeros(custNum,1);
        randInterarrival(1) = 0;
        fprintf('\n');
        for i = 2:custNum
            randInterarrival(i) = mod((a*randInterarrival(i-1) + c),m);
        end
        
    elseif (choice==2) % additive LCG
        m = 101; 
        c_interarrival = autoPrime();
        
        randInterarrival = zeros(custNum, 1);
        randService = zeros(custNum, 1);
        randInterarrival(1) = 0;
        fprintf('\n');
        for i = 2:custNum
            randInterarrival(i) = mod((randInterarrival(i-1) + c_interarrival), m);
        end
        
    elseif (choice==3) % multiplicative LCG
        m = 101;
        a = autoPrime();
        randInterarrival(1) = 0;
        randInterarrival(2) = floor(1+100*rand(1));
        for i = 2:custNum                    
            randInterarrival(i+1) = mod(a * randInterarrival(i), m );
            i = i+1;
        end
       
    elseif (choice==4) % random variate generator - uniform distribution
        upper=100;
        lower=5;
        randInterarrival(1)=0;
        for i=2:custNum
            a(i)=rand();
            randInterarrival(i) = floor(lower +(upper-lower) * a(i));
        end
        
    elseif (choice==5) % random variate generator - exponential distribution
        m=100;
        min=1;
        ld=1;
        for i=2:custNum
            rd(i)=rand(1, custNum-1);
            r(i) = -(1/ld)*log(1-rd(i));
            randInterarrival(i) = mod(floor(r(i)*100), m);  
        end     
    end

    % interarrival, arrival & item number calculations
    ia = zeros(custNum, 1); % interarrival of customers
    arrival = zeros(custNum+1, 1); % arrival of customers
    itemNum=zeros(custNum, 1); % number of items acquired by customers
    ia(1)=0; % interarrival of 1st customer=0
    arrival(1)=0; % arrival of 1st customer=0
    for i=2:custNum
        if (randInterarrival(i)>=1 && randInterarrival(i)<=10)
            ia(i)=1;
        elseif (randInterarrival(i)>=11 && randInterarrival(i)<=30)
            ia(i)=2;
        elseif (randInterarrival(i)>=31 && randInterarrival(i)<=55)
            ia(i)=3;
        elseif (randInterarrival(i)>=56 && randInterarrival(i)<=75)
            ia(i)=4;
        elseif (randInterarrival(i)>=76 && randInterarrival(i)<=100)
            ia(i)=5;
        else
            ia(i)=0;
        end
        arrival(i) = arrival(i-1) + ia(i);
    end

    customerArrivalOverall(1)=0; % all customer arrival time
    serviceEndOverall(1)=0; % all customer service time end
    serviceBegin(1)=0; % all customer service time begin

    % for counter 1
    counter1=1; % current customer in counter 1
    arrivalC1(1)=0; % arrival time of customers 
    totalCustC1=0; % total number of customers in counter 1
    custIndexC1(1)=0; % number of customers in counter 1
    
    % for counter 2
    counter2=1; % current customer in counter 2
    arrivalC2(1)=0; % arrival time of customers 
    totalCustC2=0; % total number of customers in counter 2
    custIndexC2(1)=0; % number of customers in counter 2

    % for counter 3
    counter3=1; % current customer in counter 3
    arrivalC3(1)=0; % arrival time of customers 
    totalCustC3=0; % total number of customers in counter 3
    custIndexC3(1)=0; % number of customers in counter 3

    % generate item num
    for i=1:custNum
        itemNum(i) = floor(1+15*rand());
    end
    
    % determine counter number
    for i=1:custNum
        if (itemNum(i)<=5)
            counterNum(i)=3;
        elseif (itemNum(i)>5)
            counterNum(i)=floor(1+2*rand());
        end
    end
    
    % print overall simulation table
    fprintf('\n                         --- Overall simulation table ---\n');
    fprintf(' ------------------------------------------------------------------------------------- \n');
    fprintf('|  n  |       RN for        | Interarrival   |   Arrival  | Counter | Number of items |\n');
    fprintf('|     |  Interarrival time  |     time       |    time    |  number |    acquired     |\n');
    fprintf('|-------------------------------------------------------------------------------------|\n');
    
    for i=1:custNum
       if(i~=1)
           customerArrivalOverall(i)=customerArrivalOverall(i-1)+ia(i);
       end
       if(counterNum(i)==1)
           totalCustC1=totalCustC1+1;
           arrivalC1(counter1)=customerArrivalOverall(i);
           custIndexC1(counter1)=i;
           counter1=counter1+1;
            
       elseif (counterNum(i)==2)
           totalCustC2=totalCustC2+1;
           arrivalC2(counter2)=customerArrivalOverall(i);
           custIndexC2(counter2)=i;
           counter2=counter2+1;
           
       elseif (counterNum(i)==3)
           totalCustC3=totalCustC3+1;
           arrivalC3(counter3)=customerArrivalOverall(i);
           custIndexC3(counter3)=i;
           counter3=counter3+1;
       end
    end
    for i=1:custNum
        if (counterNum(i)==1)
           fprintf('| %3.0f |         %3.0f         |      %4.0f      |    %4.0f    |   %2.0f    |        %2.0f       |\n',[i randInterarrival(i) ia(i) customerArrivalOverall(i) counterNum(i) itemNum(i)]);
        elseif (counterNum(i)==2)
           fprintf('| %3.0f |         %3.0f         |      %4.0f      |    %4.0f    |   %2.0f    |        %2.0f       |\n',[i randInterarrival(i) ia(i) customerArrivalOverall(i) counterNum(i) itemNum(i)]);
        elseif (counterNum(i)==3)
           fprintf('| %3.0f |         %3.0f         |      %4.0f      |    %4.0f    |   %2.0f    |        %2.0f       |\n',[i randInterarrival(i) ia(i) customerArrivalOverall(i) counterNum(i) itemNum(i)]);
        end
    end
    fprintf(' ------------------------------------------------------------------------------------- \n\n');
    
    % generate RN for service time (counter 1)
    if (totalCustC1~=0)
        for i = 1:totalCustC1
            if (choice==1) % mixed lcg
                m = 101; 
                a = autoPrime();
                c = autoPrime();
                for i=1:totalCustC1
                    randServiceC1(1)=mod(c,m);
                    randServiceC1(i+1)=mod((a*randServiceC1(i) + c),m);
                end
            elseif(choice==2) % additive lcg
                c_service = autoPrime();
                randServiceC1(1) = mod(c_service,m);
                for i = 1:totalCustC1
                    randServiceC1(i+1) = mod((randServiceC1(i) + c_service), m);
                end
            elseif (choice==3) % multiplicative lcg
                a = autoPrime();
                randServiceC1(1) = floor(1+100*rand(1));   
                for i = 1:totalCustC1
                    randServiceC1(i+1) = mod(a * randServiceC1(i), m );
                    i=i+1;
                end
            elseif (choice==4) % random variate - uniform distribution
                upper=100;
                lower=5;
                for i=1:totalCustC1
                    a(i)=rand();
                    randServiceC1(i) = floor(lower +(upper-lower) * a(i));
                end
            elseif (choice==5) % random variate - exponential distribution
                m=100;
                min=1;
                ld=1;
                for i=1:totalCustC1
                    rd(i)=rand(1,custNum-1);
                    r(i) = -(1/ld)*log(1-rd(i));
                    randServiceC1(i) = mod(floor(r(i)*100), m);
                end
            end
        end
    end
    
    % service time counter 1
    arrivalC1 = zeros(totalCustC1,1);
    for i=1:custNum
        if (counterNum(i)==1)
            arrivalC1(i)=arrival(i);
        end
    end
    serviceC1 = zeros(totalCustC1, 1);
    serviceBeginC1 = zeros(totalCustC1, 1);
    serviceEndC1 = zeros(totalCustC1, 1);
    waitingC1 = zeros(totalCustC1, 1);
    timeSpendC1 = zeros(totalCustC1, 1);
    if (custIndexC1(1)~=0)
        serviceBeginC1(1) = arrivalC1(custIndexC1(1)); 
    end
    for i=1:totalCustC1
        if (randServiceC1(i)>=1 && randServiceC1(i)<=10)
           serviceC1(i) = 3;
        elseif (randServiceC1(i)>=11 && randServiceC1(i)<=25)
           serviceC1(i) = 4;
        elseif (randServiceC1(i)>=26 && randServiceC1(i)<=50)
           serviceC1(i) = 5;
        elseif (randServiceC1(i)>=51 && randServiceC1(i)<=80)
           serviceC1(i) = 6;
        elseif (randServiceC1(i)>=81 && randServiceC1(i)<=100)
           serviceC1(i) = 7;
        end
        serviceEndC1(i) = serviceBeginC1(i)+serviceC1(i);
        waitingC1(i) = serviceBeginC1(i)-arrivalC1(custIndexC1(i));
        timeSpendC1(i) = waitingC1(i)+serviceC1(i);
    end 
    for i=2:totalCustC1
        if (arrivalC1(custIndexC1(i)) > serviceEndC1(i-1))
            serviceBeginC1(i) = arrivalC1(custIndexC1(i));
            serviceEndC1(i) = serviceBeginC1(i)+serviceC1(i);
            waitingC1(i) = serviceBeginC1(i)-arrivalC1(custIndexC1(i));
            timeSpendC1(i) = waitingC1(i)+serviceC1(i);
        else
            serviceBeginC1(i) = serviceEndC1(i-1);
            serviceEndC1(i) = serviceBeginC1(i)+serviceC1(i);
            waitingC1(i) = serviceBeginC1(i)-arrivalC1(custIndexC1(i));
            timeSpendC1(i) = waitingC1(i)+serviceC1(i);
        end
    end

    % generate RN for service time (counter 2)
    if (totalCustC2~=0)
        for i = 1:totalCustC2
            if (choice==1) % mixed lcg
                m = 101; 
                a = autoPrime();
                c = autoPrime();
                for i=1:totalCustC2
                    randServiceC2(1)=mod(c,m);
                    randServiceC2(i+1)=mod((a*randServiceC2(i) + c),m);
                end
            elseif(choice==2) % additive lcg
                c_service = autoPrime();
                randServiceC2(1) = mod(c_service,m);
                for i = 1:totalCustC2
                    randServiceC2(i+1) = mod((randServiceC2(i) + c_service), m);
                end
            elseif (choice==3) % multiplicative lcg
                a = autoPrime();
                randServiceC2(1) = floor(1+100*rand(1));   
                for i = 1:totalCustC2
                    randServiceC2(i+1) = mod(a * randServiceC2(i), m );
                    i=i+1;
                end
            elseif (choice==4) % random variate - uniform distribution
                upper=100;
                lower=5;
                for i=1:totalCustC2
                    a(i)=rand();
                    randServiceC2(i) = floor(lower + (upper-lower) * a(i));
                end
            elseif (choice==5) % arndom variate - exponential distribution
                m=100;
                min=1;
                ld=1;
                for i=1:totalCustC2
                    rd(i) = rand(1,custNum-1);
                    r(i) = -(1/ld)*log(1-rd(i));
                    randServiceC2(i) = mod(floor(r(i)*100), m);
                end
            end
        end
    end
    
    
    % service time counter 2
    arrivalC2 = zeros(totalCustC2,1);
    for i=1:custNum
        if (counterNum(i)==2)
            arrivalC2(i)=arrival(i);
        end
    end
    serviceC2 = zeros(totalCustC2, 1);
    serviceBeginC2 = zeros(totalCustC2, 1);
    serviceEndC2 = zeros(totalCustC2, 1);
    waitingC2 = zeros(totalCustC2, 1);
    timeSpendC2 = zeros(totalCustC2, 1);
    if (custIndexC2(1)~=0)
        serviceBeginC2(1)=arrivalC2(custIndexC2(1)); 
    end  
    for i=1:totalCustC2
        if (randServiceC2(i)>=1 && randServiceC2(i)<=15)
           serviceC2(i) = 4;
        elseif (randServiceC2(i)>=16 && randServiceC2(i)<=45)
           serviceC2(i) = 5;
        elseif (randServiceC2(i)>=46 && randServiceC2(i)<=70)
           serviceC2(i) = 6;
        elseif (randServiceC2(i)>=71 && randServiceC2(i)<=80)
           serviceC2(i) = 7;
        elseif (randServiceC2(i)>=81 && randServiceC2(i)<=100)
           serviceC2(i) = 8;
        end
        serviceEndC2(i) = serviceBeginC2(i)+serviceC2(i);
        waitingC2(i) = serviceBeginC2(i)-arrivalC2(custIndexC2(i));
        timeSpendC2(i) = waitingC2(i)+serviceC2(i);
    end 
    for i=2:totalCustC2
        if (arrivalC2(custIndexC2(i)) > serviceEndC2(i-1))
            serviceBeginC2(i) = arrivalC2(custIndexC2(i));
            serviceEndC2(i) = serviceBeginC2(i)+serviceC2(i);
            waitingC2(i) = serviceBeginC2(i)-arrivalC2(custIndexC2(i));
            timeSpendC2(i) = waitingC2(i)+serviceC2(i);
        else
            serviceBeginC2(i) = serviceEndC2(i-1);
            serviceEndC2(i) = serviceBeginC2(i)+serviceC2(i);
            waitingC2(i) = serviceBeginC2(i)-arrivalC2(custIndexC2(i));
            timeSpendC2(i) = waitingC2(i)+serviceC2(i);
        end
    end
    


    % counter 3 service time RN generator
    if (totalCustC3~=0)
        for i = 1:totalCustC3
            if (choice==1) % mixed lcg
                m = 101; 
                a = autoPrime();
                c = autoPrime();
                for i=1:totalCustC3
                    randServiceC3(1)=mod(c,m);
                    randServiceC3(i+1)=mod((a*randServiceC3(i) + c),m);
                end
            elseif(choice==2) % additive lcg
                c_service = autoPrime();
                randServiceC3(1) = mod(c_service,m);
                for i = 1:totalCustC3
                    randServiceC3(i+1) = mod((randServiceC3(i) + c_service), m);
                end
            elseif (choice==3) % multiplicative lcg
                a = autoPrime();
                randServiceC3(1) = floor(1+100*rand(1));   
                for i = 1:totalCustC3
                    randServiceC3(i+1) = mod(a * randServiceC3(i), m );
                    i=i+1;
                end
            elseif (choice==4) % random variate generrator - uniform distribution
                upper=100;
                lower=5;
                for i=1:totalCustC3
                    a(i)=rand();
                    randServiceC3(i) = floor(lower +(upper-lower) * a(i));
                end
            elseif (choice==5) % random variate generator - exponential distribution
                m=100;
                min=1;
                ld=1;
                for i=1:totalCustC3
                    rd(i)=rand(1,custNum-1);
                    r(i) = -(1/ld)*log(1-rd(i));
                    randServiceC3(i) = mod(floor(r(i)*100), m);
                end
            end
        end
    end
    
    % service time counter 3
    arrivalC3 = zeros(totalCustC3,1);
    for i=1:custNum
        if (counterNum(i)==3)
            arrivalC3(i)=arrival(i);
        end
    end
    serviceC3 = zeros(totalCustC3, 1);
    serviceBeginC3 = zeros(totalCustC3, 1);
    serviceEndC3 = zeros(totalCustC3, 1);
    waitingC3 = zeros(totalCustC3, 1);
    timeSpendC3 = zeros(totalCustC3, 1);
        if (custIndexC3(1)~=0)
        serviceBeginC3(1)=arrivalC3(custIndexC3(1)); 
    end

    for i=1:totalCustC3
        if (randServiceC3(i)>=1 && randServiceC3(i)<=35)
            serviceC3(i) = 2;
        elseif (randServiceC3(i)>=36 && randServiceC3(i)<=65)
            serviceC3(i) = 3;
        elseif (randServiceC3(i)>=66 && randServiceC3(i)<=85)
            serviceC3(i) = 4;
        elseif (randServiceC3(i)>=86 && randServiceC3(i)<=95)
            serviceC3(i) = 5;
        elseif (randServiceC3(i)>=96 && randServiceC3(i)<=100)
            serviceC3(i) = 6;
        end
        serviceEndC3(i) = serviceBeginC3(i)+serviceC3(i);
        waitingC3(i) = serviceBeginC3(i)-arrivalC3(custIndexC3(i));
        timeSpendC3(i) = waitingC3(i)+serviceC3(i);
    end 
    for i=2:totalCustC3
        if (arrivalC3(custIndexC3(i)) > serviceEndC3(i-1))
            serviceBeginC3(i) = arrivalC3(custIndexC3(i));
            serviceEndC3(i) = serviceBeginC3(i)+serviceC3(i);
            waitingC3(i) = serviceBeginC3(i)-arrivalC3(custIndexC3(i));
            timeSpendC3(i) = waitingC3(i)+serviceC3(i);
        else
            serviceBeginC3(i) = serviceEndC3(i-1);
            serviceEndC3(i) = serviceBeginC3(i)+serviceC3(i);
            waitingC3(i) = serviceBeginC3(i)-arrivalC3(custIndexC3(i));
            timeSpendC3(i) = waitingC3(i)+serviceC3(i);
        end
    end

% display message for arrival, departure
fprintf('\n     --- Message display for arrival --- \n')
for i=1:custNum
    fprintf('\nArrival of customer %d at minute %d in counter %d\n',i,arrival(i),counterNum(i));
end

fprintf('\n\n Simulation table of Counter 1: \n');
fprintf(' ----------------------------------------------------------------------------------------------------------- \n');
fprintf('|  n  |     RN for     |   Service   |  Arrival  |  Time service  |  Time service  |  Waiting  | Time spends|\n');
fprintf('|     |  Service time  |    time     |   time    |    begins      |      ends      |   time    |  in system |\n');
fprintf('|-----------------------------------------------------------------------------------------------------------|\n');
for i=1:totalCustC1
    fprintf('| %3.0f |       %3.0f      |    %4.0f     |   %4.0f    |      %4.0f      |      %4.0f      |   %4.0f    |    %4.0f    |\n',[custIndexC1(i) randServiceC1(i) serviceC1(i) arrivalC1(custIndexC1(i)) serviceBeginC1(i) serviceEndC1(i) waitingC1(i) timeSpendC1(i)]);
end
fprintf(' ----------------------------------------------------------------------------------------------------------- \n');
fprintf('\n  --- Message display for service & departure on counter 1 ---\n')
for i=1:totalCustC1
    fprintf('\nService for customer %d started at minute %d , departure at minute %d\n',custIndexC1(i), serviceBeginC1(i), serviceEndC1(i));
end


fprintf('\n\n Simulation table of Counter 2: \n');
fprintf(' ----------------------------------------------------------------------------------------------------------- \n');
fprintf('|  n  |     RN for     |   Service   |  Arrival  |  Time service  |  Time service  |  Waiting  | Time spends|\n');
fprintf('|     |  Service time  |    time     |   time    |    begins      |      ends      |   time    |  in system |\n');
fprintf('|-----------------------------------------------------------------------------------------------------------|\n');
for i=1:totalCustC2
    fprintf('| %3.0f |       %3.0f      |    %4.0f     |   %4.0f    |      %4.0f      |      %4.0f      |   %4.0f    |    %4.0f    |\n',[custIndexC2(i) randServiceC2(i) serviceC2(i) arrivalC2(custIndexC2(i)) serviceBeginC2(i) serviceEndC2(i) waitingC2(i) timeSpendC2(i)]);
end
fprintf(' ----------------------------------------------------------------------------------------------------------- \n');
fprintf('\n  --- Message display for service & departure on counter 2 ---\n')
for i=1:totalCustC2
    fprintf('\nService for customer %d started at minute %d , departure at minute %d\n', custIndexC2(i), serviceBeginC2(i), serviceEndC2(i));
end


fprintf('\n\n Simulation table of Counter 3: \n');
fprintf(' ----------------------------------------------------------------------------------------------------------- \n');
fprintf('|  n  |     RN for     |   Service   |  Arrival  |  Time service  |  Time service  |  Waiting  | Time spends|\n');
fprintf('|     |  Service time  |    time     |   time    |    begins      |      ends      |   time    |  in system |\n');
fprintf('|-----------------------------------------------------------------------------------------------------------|\n');
for i=1:totalCustC3
    fprintf('| %3.0f |       %3.0f      |    %4.0f     |   %4.0f    |      %4.0f      |      %4.0f      |   %4.0f    |    %4.0f    |\n',[custIndexC3(i) randServiceC3(i) serviceC3(i) arrivalC3(custIndexC3(i)) serviceBeginC3(i) serviceEndC3(i) waitingC3(i) timeSpendC3(i)]);
end
fprintf(' ----------------------------------------------------------------------------------------------------------- \n');
fprintf('\n  --- Message display for service & departure on counter 3 ---\n')
for i=1:totalCustC3
    fprintf('\nService for customer %d started at minute %d , departure at minute %d\n',custIndexC3(i), serviceBeginC3(i), serviceEndC3(i));
end


% evaluation calculation
totalArrivalC1=0;
totalServiceTimeC1=0;
totalWaitingC1=0;
totalTimeSpendC1=0;
numWaitC1=0;
totalServiceTimeC1=0;

totalArrivalC2=0;
totalServiceTimeC2=0;
totalWaitingC2=0;
totalTimeSpendC2=0;
numWaitC2=0;
totalServiceTimeC2=0;

totalArrivalC3=0;
totalServiceTimeC3=0;
totalWaitingC3=0;
totalTimeSpendC3=0;
numWaitC3=0;
totalServiceTimeC3=0;

totalWaiting=0;
totalArrival=0;
totalTimeSpend=0;
numWait=0;
percentageBusy=0;


for i=1:totalCustC1
    totalWaitingC1=totalWaitingC1+waitingC1(i);
    totalArrivalC1=totalArrivalC1+arrivalC1(custIndexC1(i));
    totalTimeSpendC1=totalTimeSpendC1+timeSpendC1(i);
    totalServiceTimeC1=totalServiceTimeC1+serviceC1(i);
    if (waitingC1(i)~=0)
        numWaitC1=numWaitC1+1;
    end
end

for i=1:totalCustC2
    totalWaitingC2=totalWaitingC2+waitingC2(i);
    totalArrivalC2=totalArrivalC2+arrivalC2(custIndexC2(i));
    totalTimeSpendC2=totalTimeSpendC2+timeSpendC2(i);
    totalServiceTimeC2=totalServiceTimeC2+serviceC2(i);
    if (waitingC2(i)~=0)
        numWaitC2=numWaitC2+1;
    end
end

for i=1:totalCustC3
    totalWaitingC3=totalWaitingC3+waitingC3(i);
    totalArrivalC3=totalArrivalC3+arrivalC3(custIndexC3(i));
    totalTimeSpendC3=totalTimeSpendC3+timeSpendC3(i);
    totalServiceTimeC3=totalServiceTimeC3+serviceC3(i);
    if (waitingC3(i)~=0)
        numWaitC3=numWaitC3+1;
    end
end
fprintf('\n\n  --- Evaluating results of simulation ---\n');
% average waiting time
totalWaiting=totalWaiting+totalWaitingC1+totalWaitingC2+totalWaitingC3;
averageWaiting=totalWaiting/custNum;
fprintf('\nAverage waiting time: %6.6f\n',averageWaiting);

% average arrival time
totalArrival=totalArrivalC1+totalArrivalC2+totalArrivalC3;
averageArrival=totalArrival/(custNum-1);
fprintf('\nAverage arrival time: %6.6f\n',averageArrival);

% average time spent
totalTimeSpend=totalTimeSpendC1+totalTimeSpendC2+totalTimeSpendC3;
averageTimeSpend=totalTimeSpend/custNum;
fprintf('\nAverage time spend: %6.6f\n',averageTimeSpend);

% probability customer has to wait
numWait=numWait+numWaitC1+numWaitC2+numWaitC3;
probWait=numWait/custNum;
fprintf('\nProbability customer has to wait: %6.6f\n',probWait);

% average service time for each counter
% counter 1
averageServiceTimeC1=totalServiceTimeC1/totalCustC1;
fprintf('\nAverage service time for counter 1: %6.6f\n',averageServiceTimeC1);

% counter 2
averageServiceTimeC2=totalServiceTimeC2/totalCustC2;
fprintf('\nAverage service time for counter 2: %6.6f\n',averageServiceTimeC2);

% counter 3
averageServiceTimeC3=totalServiceTimeC3/totalCustC3;
fprintf('\nAverage service time for counter 3: %6.6f\n',averageServiceTimeC3);

% overall average service time (for 3 counters)
averageServiceTimeOverall=(totalServiceTimeC1+totalServiceTimeC2+totalServiceTimeC3)/custNum;
fprintf('\nOverall average service time: %6.6f\n',averageServiceTimeOverall);

% percentage of time counter 1 was busy
percentageBusyC1=100*(totalServiceTimeC1/(max(serviceEndC1(totalCustC1),max(serviceEndC2(totalCustC2), serviceEndC3(totalCustC3)))));
fprintf('\nPercentage of time counter 1 was busy: %6.6f\n',percentageBusyC1);

% percentage of time counter 2 was busy
percentageBusyC2=100*(totalServiceTimeC2/(max(serviceEndC1(totalCustC1),max(serviceEndC2(totalCustC2), serviceEndC3(totalCustC3)))));
fprintf('\nPercentage of time counter 2 was busy: %6.6f\n',percentageBusyC2);

% percentage of time counter 3 was busy
percentageBusyC3=100*(totalServiceTimeC3/(max(serviceEndC1(totalCustC1),max(serviceEndC2(totalCustC2), serviceEndC3(totalCustC3)))));
fprintf('\nPercentage of time counter 3 was busy: %6.6f\n',percentageBusyC3);

fprintf('\n\n');
voice='doorbell.wav'; sound=wavread(voice); wavplay(sound,'25000','async');
disp('Thank you for using our simulator. ');
disp('Goodbye and have a nice day!');