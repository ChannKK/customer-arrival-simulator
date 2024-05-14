function output = autoPrime();
    isPrime=0;
    while(isPrime==0)
        num = floor(1+100*rand(1));
        i=2;
        prime=1;
        while(num/2>=i || (num<i || prime==0))
                if(mod(num,i)==0 || num == 1)
                prime = 0;
                break;
            end
            i = i+1;
        end
            
        if(prime == 1 & num>1)
            isPrime = 1;
        end
    end
    output = num;