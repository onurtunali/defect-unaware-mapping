function crossbarGraph = clustering_injection(N, d, alfa)
tic
Nd = 1;
matrix = zeros(N, N);
probMatrix = zeros(N, N);
matrix(floor(rand*N*N)) = 1;

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
disMatrix = [fliplr(temp) temp];
disMatrix(:,N) = [];
disMatrix(N,:) = [];
index = 1:N;
toc
tic
while Nd < N*N*d
    
    for k= 1:N
        for t=1:N
            temp = disMatrix(index + N-k,index+N-t).*matrix;
            temp = temp(temp>0);
            temp = 1./temp;
            
            Pi = sum(sum((temp).^alfa));
            probMatrix(k,t) = Pi;
        end
    end
    
    probMatrix = probMatrix / sum(sum(probMatrix));
    filter = [1 1 1; 1 0 1; 1 1 1];
    cumProbMatrix = conv2(probMatrix, filter, 'same');
    cumProbMatrix = cumProbMatrix.*double(~matrix);
    
    while 1
        r = rand;
        
        %     [~, location] = max(cumProbMatrix(:));
        location = find(cumProbMatrix(:) > r);
        if ~isempty(location)
            matrix(location(1)) = 1;
            break
        end
    end
    Nd = Nd + 1;
end
toc
% crossbarGraph = probMatrix;
crossbarGraph = matrix;
end

