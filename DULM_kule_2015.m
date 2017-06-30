clc
clear all
format short
format compact
global Po
global Pc
global N

Po = 0.45;
Pc = 0;
N = 10;
sampleSize = 1;
timeVectorHeuristic =zeros(1, sampleSize);
sizeVectorHeuristic = zeros(1, sampleSize);

for k=1:sampleSize
    
    tic
    fprintf('\n')
    fprintf(' k = %d\n\n', k)
    PM = true;          % -------- Possible Merging --------------
    NCM = 0;
    NRM = 0;
    
    crossbar= randsrc(N, N, [1 0 ; (1 - Po) Po]);
    
    mergedRows = [];
    mergedCols = [];
    markRows = [1:N; zeros(1,N)];
    markCols = [1:N; zeros(1,N)];
    floatCrossbar = crossbar;
    
    while PM
        
        rowMerg = false;
        colMerg = false;
        
        [markCols, floatCrossbar] = marking(markCols, markRows, 'column' ,floatCrossbar)
        
        
        
        while ( any(markCols(2,:) ==0))
            
            [~, posC] = min(sum(floatCrossbar(:, find(markCols(2,:)==0))))
            
            possMerge= sum(floatCrossbar(:, find(markCols(2,:)==0)))
            [~,index] = sort(possMerge,'descend')
            
            
            for t = index
                
                if all(floatCrossbar(:,posC) + floatCrossbar(:,t) >0)
                    markCols(2,t) = 1;
                    markCols(2,posC) = 1;
                    NCM = NCM + 1;
                    colMerg = true
                    break
                end
                
            end
            
            if colMerg
                break
            end
            
            if  markCols(2,posC) == 0
                markCols(2,posC) = -1
            end
            
        end
        
        [markRows, floatCrossbar] = marking(markCols, markRows, 'row' ,floatCrossbar)
        
        while ( any(markRows(2,:) ==0))
            
            [~, pos] = min((sum(floatCrossbar(find(markRows(2,:)==0), :),2)))
            
            possMerge= sum(floatCrossbar(find(markRows(2,:)==0), :), 2);
            [~,index] = sort(possMerge','descend');
            
            
            
            for t = index
                
                if all(floatCrossbar(pos,:) + floatCrossbar(t,:) >0)
                    markRows(2,t) = 1;
                    markRows(2,pos) = 1;
                    rowMerg = true;
                    NRM = NRM + 1;
                    break
                end
                
            end
            
            if rowMerg
                break
            end
            
            if  markRows(2,pos) == 0
                markRows(2,pos) = -1;
            end
            
        end
        
        
        rowMerg
        colMerg
        if ~rowMerg || ~colMerg
            PM = false;
        end
        
    end
    markRows(2,markRows == -1) = 0
    markCols(2,markCols == -1) = 0
    
    T = toc;
    timeVectorHeuristic(1,k) = T;
    fprintf(' Heuristic Runtime = %0.4f\n',T)
    
    
end

% sizeMean = mean(sizeVectorHeuristic);
% timeMean = mean(timeVectorHeuristic);
%
% fprintf(' Runtime = %f and K-value = %f \n',timeMean,sizeMean)
