function output=primeNumber()
    
    isPrime=0;
    while(isPrime==0) 
        num=input('Please enter a prime number: ');
        
        if (num<0)
            isPrime=0;
            disp('Negative numbers are not accepted');
            continue;
        end
        i=2; %lower bound
        prime=1;
        while(num/2 >= i || num<i)
           if(mod(num,i)==0 || num == 1)
                prime=0;
                disp('This is NOT a prime number. ');
                break;
            end
            i=i+1;
        end


        if (prime==1 & num>1)
            isPrime = 1;
        end     
    end
    
    output=num;
  
    