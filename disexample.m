clc
clear
N = 6;
distance = @(i,j,i1,j1)sqrt((i-i1)^2+(j-j1)^2);


disMatrix = zeros(N,N);
for k=1:N
    for t=1:N
        
        temp = distance(1,1,k,t);
        disMatrix(k,t) = temp;
        
    end
end

temp = flipud(disMatrix);
temp = [temp;disMatrix];
disMatrix = [fliplr(temp) temp]
disMatrix(:,N) = []
disMatrix(N,:) = []